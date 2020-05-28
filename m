Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870F2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 23:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6370D207F9
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 23:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="vVcmRy+d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391547AbgE1XGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 19:06:07 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:56113 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391530AbgE1XGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 19:06:01 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590707161; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=OFnRFdGdwOdlT6++yGr8Uhb6YcmrXqckJ/J0OHf9bY4=; b=vVcmRy+dBPvLM/EWgflaV0WP6afbEG7XtLA4+kWlkr6T2mLbYe1ZFZJngXK0Sha9kgks4kG7
 uStevzPn/u+WxqKrz6Cn5R56MKThMWpTySXU/fFNry1Z6gpDLpsbtSfEYBAL5IZ5/OCxlFpT
 hJMqQGAFIMnCBhs0DPECjrwCnOo=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5ed043d150867324810c4e4c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 28 May 2020 23:05:53
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 261DEC433C6; Thu, 28 May 2020 23:05:53 +0000 (UTC)
Received: from clew-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: clew)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4D20DC433C9;
        Thu, 28 May 2020 23:05:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4D20DC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=clew@codeaurora.org
From:   Chris Lew <clew@codeaurora.org>
To:     davem@davemloft.net, bjorn.andersson@linaro.org
Cc:     manivannan.sadhasivam@linaro.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        clew@codeaurora.org
Subject: [PATCH] net: qrtr: Allocate workqueue before kernel_bind
Date:   Thu, 28 May 2020 16:05:26 -0700
Message-Id: <1590707126-16957-1-git-send-email-clew@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A null pointer dereference in qrtr_ns_data_ready() is seen if a client
opens a qrtr socket before qrtr_ns_init() can bind to the control port.
When the control port is bound, the ENETRESET error will be broadcasted
and clients will close their sockets. This results in DEL_CLIENT
packets being sent to the ns and qrtr_ns_data_ready() being called
without the workqueue being allocated.

Allocate the workqueue before setting sk_data_ready and binding to the
control port. This ensures that the work and workqueue structs are
allocated and initialized before qrtr_ns_data_ready can be called.

Fixes: 0c2204a4ad71 ("net: qrtr: Migrate nameservice to kernel from userspace")
Signed-off-by: Chris Lew <clew@codeaurora.org>
---
 net/qrtr/ns.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
index e7d0fe3f4330..c5b3202a14ca 100644
--- a/net/qrtr/ns.c
+++ b/net/qrtr/ns.c
@@ -712,6 +712,10 @@ void qrtr_ns_init(void)
 		goto err_sock;
 	}
 
+	qrtr_ns.workqueue = alloc_workqueue("qrtr_ns_handler", WQ_UNBOUND, 1);
+	if (!qrtr_ns.workqueue)
+		goto err_sock;
+
 	qrtr_ns.sock->sk->sk_data_ready = qrtr_ns_data_ready;
 
 	sq.sq_port = QRTR_PORT_CTRL;
@@ -720,17 +724,13 @@ void qrtr_ns_init(void)
 	ret = kernel_bind(qrtr_ns.sock, (struct sockaddr *)&sq, sizeof(sq));
 	if (ret < 0) {
 		pr_err("failed to bind to socket\n");
-		goto err_sock;
+		goto err_wq;
 	}
 
 	qrtr_ns.bcast_sq.sq_family = AF_QIPCRTR;
 	qrtr_ns.bcast_sq.sq_node = QRTR_NODE_BCAST;
 	qrtr_ns.bcast_sq.sq_port = QRTR_PORT_CTRL;
 
-	qrtr_ns.workqueue = alloc_workqueue("qrtr_ns_handler", WQ_UNBOUND, 1);
-	if (!qrtr_ns.workqueue)
-		goto err_sock;
-
 	ret = say_hello(&qrtr_ns.bcast_sq);
 	if (ret < 0)
 		goto err_wq;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

