Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E677C3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F61206D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zaZ8UEh5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730548AbgCCS5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 13:57:15 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:34482 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730344AbgCCS5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 13:57:14 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 023Is7td050119;
        Tue, 3 Mar 2020 18:57:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=3sx1vwQWdvQ5Z2ZWTgaCbJGjCVKxUP31T5G8RYrSA9g=;
 b=zaZ8UEh5QMzNbdzHE6voY1AIV/S2dUkTMkHhtDcPX1Qrlza/3uIFLPIZIgQBuafC5O5Q
 V8zUGRUjb0mABFgZNtk2YjjYf1uYU3yFqOsnfY8aWV++UxS2HsVpXxYezjG1bEgC7IoZ
 BEp6TsrxrgmgL88szeAZmvztKnlj4VqzZf373eE9o2g6LSJkoIBYKwSL5Yw0753MrIrs
 cKb4ffWwMby8vkCzRHOM0C0MLZT+50sYBAymZ0wPK38jd3dnoxNmkKPMpm4V6qvqJQRg
 D4z/5Sf7emOWDgFmc8wr9dMSBZUafyiduKlATGRiWyPpbu6wosuN9CwlL0e4UTc439Aw sQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2yffwqs991-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Mar 2020 18:57:09 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 023IqTvw072605;
        Tue, 3 Mar 2020 18:57:08 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2yg1p555qm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Mar 2020 18:57:08 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 023Iv6it011726;
        Tue, 3 Mar 2020 18:57:07 GMT
Received: from localhost.localdomain (/10.211.9.80)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Mar 2020 10:57:06 -0800
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     julien@xen.org, boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, joe.jin@oracle.com
Subject: [PATCH v2 2/2] xenbus: req->err should be updated before req->state
Date:   Tue,  3 Mar 2020 10:47:52 -0800
Message-Id: <20200303184752.20821-2-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200303184752.20821-1-dongli.zhang@oracle.com>
References: <20200303184752.20821-1-dongli.zhang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9549 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=980 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003030124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9549 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 phishscore=0 clxscore=1015 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003030124
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

