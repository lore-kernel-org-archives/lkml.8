Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5C2C3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F61A21D56
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SxIcil+T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgCCCIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 21:08:16 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:59516 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbgCCCIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 21:08:16 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02327h3I108607;
        Tue, 3 Mar 2020 02:08:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=3sx1vwQWdvQ5Z2ZWTgaCbJGjCVKxUP31T5G8RYrSA9g=;
 b=SxIcil+TzhF+21mvM5EaqrspnmMG4eoA/3iVEixTBt1zn/oc3eCxghJSHWLe5NhaAK7G
 lQYNqgXVojp+VUqbW1wq7/A1p8Oq21OCwsK73ATtOLuALkLHkDrNI1sbq/mNmqB+SZR5
 TjH56yctfiI+B59WZTQhPyM5/yxMA8nC30IeC871clG11yIUfk1RU2i7HaA190dBW+Rf
 Np/bxzTWS9eodxNEh6P8q6RlNySHSKzuXu6xhAN0+WKWuHdkqdv65ndKCPj4HWPplSBA
 ZG4IheREbKyWr4YM9rNZR7D16jWg+eQgnphwyNG30JovaRJMK3zTy8gLj92N2DjUZz7I 4g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2yffcubv6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Mar 2020 02:08:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 023271G6135520;
        Tue, 3 Mar 2020 02:08:10 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2yg1gwbdan-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Mar 2020 02:08:09 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 023288ms023929;
        Tue, 3 Mar 2020 02:08:08 GMT
Received: from localhost.localdomain (/10.211.9.80)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 02 Mar 2020 18:08:08 -0800
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, joe.jin@oracle.com
Subject: [PATCH 2/2] xenbus: req->err should be updated before req->state
Date:   Mon,  2 Mar 2020 17:58:59 -0800
Message-Id: <20200303015859.18813-2-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200303015859.18813-1-dongli.zhang@oracle.com>
References: <20200303015859.18813-1-dongli.zhang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9548 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=976 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003030013
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9548 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003030013
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the barrier to guarantee that req->err is always updated
before req->state.

Otherwise, read_reply() would not return ERR_PTR(req->err) but
req->body, when process_writes()->xb_write() is failed.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 drivers/xen/xenbus/xenbus_comms.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/xen/xenbus/xenbus_comms.c b/drivers/xen/xenbus/xenbus_comms.c
index 852ed161fc2a..eb5151fc8efa 100644
--- a/drivers/xen/xenbus/xenbus_comms.c
+++ b/drivers/xen/xenbus/xenbus_comms.c
@@ -397,6 +397,8 @@ static int process_writes(void)
 	if (state.req->state == xb_req_state_aborted)
 		kfree(state.req);
 	else {
+		/* write err, then update state */
+		virt_wmb();
 		state.req->state = xb_req_state_got_reply;
 		wake_up(&state.req->wq);
 	}
-- 
2.17.1

