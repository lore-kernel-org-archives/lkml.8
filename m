Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FB6C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 22:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E87020848
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 22:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vONHwh1Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgCCWXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 17:23:47 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:48838 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgCCWXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 17:23:46 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 023MIHxP056840;
        Tue, 3 Mar 2020 22:23:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=RvBME80uuPeWcTzh/WQfzn28mvoGe375BqaUVKtmEqI=;
 b=vONHwh1Q80nSUx9IjGEH/j2TJp2ladGzh047GLgidu+/3VbEgf2fvVrgFd6/lHLdAL69
 avl/05t2qoWdEC1TYk7i2K+b1Ae9gweuQCEooecijAKsI1aExHy4b+h6tKOp5mehS1Fl
 F1HQ92Gso9JYlTISypN7SSME4RPJmuyYdRJuiw02N4Jghq3Qjp5y/l1aD7rrIY1Ay7FW
 lSfljqs0TN+Lz24hdDTsi++ks14vd5/5j/giPWcoFxL15tqKQ8llu1JyvVwQV4wBTztt
 1526ek8ZiyfeVWgaivywnls7EKX5TTQ6dcBfA21uTOo96FHQXjOhO4MDUQJBITbe5e49 Ag== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2yffwqtb57-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Mar 2020 22:23:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 023MMdCJ153226;
        Tue, 3 Mar 2020 22:23:39 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2yg1emx3ra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Mar 2020 22:23:39 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 023MNb1X030999;
        Tue, 3 Mar 2020 22:23:37 GMT
Received: from localhost.localdomain (/10.211.9.80)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Mar 2020 14:23:37 -0800
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     julien@xen.org, boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, joe.jin@oracle.com
Subject: [PATCH v3 1/2] xenbus: req->body should be updated before req->state
Date:   Tue,  3 Mar 2020 14:14:22 -0800
Message-Id: <20200303221423.21962-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9549 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003030144
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9549 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 phishscore=0 clxscore=1015 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003030143
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The req->body should be updated before req->state is updated and the
order should be guaranteed by a barrier.

Otherwise, read_reply() might return req->body = NULL.

Below is sample callstack when the issue is reproduced on purpose by
reordering the updates of req->body and req->state and adding delay in
code between updates of req->state and req->body.

[   22.356105] general protection fault: 0000 [#1] SMP PTI
[   22.361185] CPU: 2 PID: 52 Comm: xenwatch Not tainted 5.5.0xen+ #6
[   22.366727] Hardware name: Xen HVM domU, BIOS ...
[   22.372245] RIP: 0010:_parse_integer_fixup_radix+0x6/0x60
... ...
[   22.392163] RSP: 0018:ffffb2d64023fdf0 EFLAGS: 00010246
[   22.395933] RAX: 0000000000000000 RBX: 75746e7562755f6d RCX: 0000000000000000
[   22.400871] RDX: 0000000000000000 RSI: ffffb2d64023fdfc RDI: 75746e7562755f6d
[   22.405874] RBP: 0000000000000000 R08: 00000000000001e8 R09: 0000000000cdcdcd
[   22.410945] R10: ffffb2d6402ffe00 R11: ffff9d95395eaeb0 R12: ffff9d9535935000
[   22.417613] R13: ffff9d9526d4a000 R14: ffff9d9526f4f340 R15: ffff9d9537654000
[   22.423726] FS:  0000000000000000(0000) GS:ffff9d953bc80000(0000) knlGS:0000000000000000
[   22.429898] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   22.434342] CR2: 000000c4206a9000 CR3: 00000001ea3fc002 CR4: 00000000001606e0
[   22.439645] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   22.444941] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   22.450342] Call Trace:
[   22.452509]  simple_strtoull+0x27/0x70
[   22.455572]  xenbus_transaction_start+0x31/0x50
[   22.459104]  netback_changed+0x76c/0xcc1 [xen_netfront]
[   22.463279]  ? find_watch+0x40/0x40
[   22.466156]  xenwatch_thread+0xb4/0x150
[   22.469309]  ? wait_woken+0x80/0x80
[   22.472198]  kthread+0x10e/0x130
[   22.474925]  ? kthread_park+0x80/0x80
[   22.477946]  ret_from_fork+0x35/0x40
[   22.480968] Modules linked in: xen_kbdfront xen_fbfront(+) xen_netfront xen_blkfront
[   22.486783] ---[ end trace a9222030a747c3f7 ]---
[   22.490424] RIP: 0010:_parse_integer_fixup_radix+0x6/0x60

The virt_rmb() is added in the 'true' path of test_reply(). The "while"
is changed to "do while" so that test_reply() is used as a read memory
barrier.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
Changed since v1:
  - change "barrier()" to "virt_rmb()" in test_reply()
Changed since v2:
  - Use "virt_rmb()" only in 'true' path

 drivers/xen/xenbus/xenbus_comms.c | 2 ++
 drivers/xen/xenbus/xenbus_xs.c    | 9 ++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_comms.c b/drivers/xen/xenbus/xenbus_comms.c
index d239fc3c5e3d..852ed161fc2a 100644
--- a/drivers/xen/xenbus/xenbus_comms.c
+++ b/drivers/xen/xenbus/xenbus_comms.c
@@ -313,6 +313,8 @@ static int process_msg(void)
 			req->msg.type = state.msg.type;
 			req->msg.len = state.msg.len;
 			req->body = state.body;
+			/* write body, then update state */
+			virt_wmb();
 			req->state = xb_req_state_got_reply;
 			req->cb(req);
 		} else
diff --git a/drivers/xen/xenbus/xenbus_xs.c b/drivers/xen/xenbus/xenbus_xs.c
index ddc18da61834..3a06eb699f33 100644
--- a/drivers/xen/xenbus/xenbus_xs.c
+++ b/drivers/xen/xenbus/xenbus_xs.c
@@ -191,8 +191,11 @@ static bool xenbus_ok(void)
 
 static bool test_reply(struct xb_req_data *req)
 {
-	if (req->state == xb_req_state_got_reply || !xenbus_ok())
+	if (req->state == xb_req_state_got_reply || !xenbus_ok()) {
+		/* read req->state before all other fields */
+		virt_rmb();
 		return true;
+	}
 
 	/* Make sure to reread req->state each time. */
 	barrier();
@@ -202,7 +205,7 @@ static bool test_reply(struct xb_req_data *req)
 
 static void *read_reply(struct xb_req_data *req)
 {
-	while (req->state != xb_req_state_got_reply) {
+	do {
 		wait_event(req->wq, test_reply(req));
 
 		if (!xenbus_ok())
@@ -216,7 +219,7 @@ static void *read_reply(struct xb_req_data *req)
 		if (req->err)
 			return ERR_PTR(req->err);
 
-	}
+	} while (req->state != xb_req_state_got_reply);
 
 	return req->body;
 }
-- 
2.17.1

