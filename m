Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3392FC3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 07:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06CC7246E8
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 07:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i6ObX2rp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgCBHEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 02:04:33 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38572 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbgCBHEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 02:04:33 -0500
Received: by mail-pl1-f194.google.com with SMTP id p7so3833331pli.5
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 23:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rimej0eK2dJXVo8hNQtiL7P62alTIHr1+U1d3Xd79UU=;
        b=i6ObX2rpaj/oijx02CtJi6vEfB840xv1fHG+0y/WyZqLUXTT3kqX9zATmdRCzisJt7
         8AEewooPn6IfHVK2HvTVZx4X+x+qMdXSdoMU4/DnFF/jwHRXoT1vAAlprlyruYLJe1uI
         F4pn+NBZ3f5S9CXTccnq+jh1TlHZQBc0cwKkikVPaZHEqBCKNrNOplF604BKBHk3WkfP
         oKul0TuqPTMXwyDNuh0KrNYjb5QKs/dZCYohcHcO8V7XKiqyw4AxJFyf9IQK49zxTsgB
         N8zE3YvMG+iK+/U698e4UfS3c0bwKD1RCAL9xhcPkn1kDftOZAuW/+PuqPbBF1rPfQMo
         4uGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rimej0eK2dJXVo8hNQtiL7P62alTIHr1+U1d3Xd79UU=;
        b=hLR4xZwNz6BzzZG7udpIWj8cbqMfNSHpSDDyOt84bhfD5fcPVSFczHLqL83lNATw2B
         BcYic98DiDXlJAnHrWWgOAzpm70pSklxRlBjPWkk6u2rvZxxrrfP5vi7Wh80BBdgNleT
         Pje4IDFytD3YGz/Bfa+BSA4cN9rmqVSenckDOHXqxci7KNeloL6WXy19fq731UjZkHY1
         3x92gqTgQ/ejI1VY+kVoe5UIIChAz4g1J6NLBb5LBB6oGe4tpiQcfu5Xlaecv1RZdjN1
         jm6SaghNW4Ete/KGvIQg0cBO5v8ESyJD5ScK6/sNMK8vDZLu0Ad8Y/RiqDWl7miObCfn
         GmRA==
X-Gm-Message-State: APjAAAVG6q489JWWF0n6nyyzalj/QEht1wPvhWkIs2n+YkdSPWLnpJ+w
        Dfj09X8tk1ZsPZwM4fv+8/Qn4g==
X-Google-Smtp-Source: APXvYqzk7MERlzBi587nyfbFx0y0MOSno5NB7TTNRs52oEZlR1i2AoDHo8nSIfvDpFOxAQ/xhtYpPQ==
X-Received: by 2002:a17:902:9b93:: with SMTP id y19mr16565480plp.89.1583132672441;
        Sun, 01 Mar 2020 23:04:32 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b3sm19969551pft.73.2020.03.01.23.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 23:04:31 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 1/2] net: qrtr: Respond to HELLO message
Date:   Sun,  1 Mar 2020 23:03:04 -0800
Message-Id: <20200302070305.612067-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200302070305.612067-1-bjorn.andersson@linaro.org>
References: <20200302070305.612067-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lost in the translation from the user space implementation was the
detail that HELLO mesages must be exchanged between each node pair.  As
such the incoming HELLO must be replied to.

Similar to the previous implementation no effort is made to prevent two
Linux boxes from continuously sending HELLO messages back and forth,
this is left to a follow up patch.

say_hello() is moved, to facilitate the new call site.

Fixes: 0c2204a4ad71 ("net: qrtr: Migrate nameservice to kernel from userspace")
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Picked up Mani's r-b and t-b

 net/qrtr/ns.c | 54 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
index 7bfde01f4e8a..e3f11052b5f6 100644
--- a/net/qrtr/ns.c
+++ b/net/qrtr/ns.c
@@ -286,9 +286,38 @@ static int server_del(struct qrtr_node *node, unsigned int port)
 	return 0;
 }
 
+static int say_hello(struct sockaddr_qrtr *dest)
+{
+	struct qrtr_ctrl_pkt pkt;
+	struct msghdr msg = { };
+	struct kvec iv;
+	int ret;
+
+	iv.iov_base = &pkt;
+	iv.iov_len = sizeof(pkt);
+
+	memset(&pkt, 0, sizeof(pkt));
+	pkt.cmd = cpu_to_le32(QRTR_TYPE_HELLO);
+
+	msg.msg_name = (struct sockaddr *)dest;
+	msg.msg_namelen = sizeof(*dest);
+
+	ret = kernel_sendmsg(qrtr_ns.sock, &msg, &iv, 1, sizeof(pkt));
+	if (ret < 0)
+		pr_err("failed to send hello msg\n");
+
+	return ret;
+}
+
 /* Announce the list of servers registered on the local node */
 static int ctrl_cmd_hello(struct sockaddr_qrtr *sq)
 {
+	int ret;
+
+	ret = say_hello(sq);
+	if (ret < 0)
+		return ret;
+
 	return announce_servers(sq);
 }
 
@@ -566,29 +595,6 @@ static void ctrl_cmd_del_lookup(struct sockaddr_qrtr *from,
 	}
 }
 
-static int say_hello(void)
-{
-	struct qrtr_ctrl_pkt pkt;
-	struct msghdr msg = { };
-	struct kvec iv;
-	int ret;
-
-	iv.iov_base = &pkt;
-	iv.iov_len = sizeof(pkt);
-
-	memset(&pkt, 0, sizeof(pkt));
-	pkt.cmd = cpu_to_le32(QRTR_TYPE_HELLO);
-
-	msg.msg_name = (struct sockaddr *)&qrtr_ns.bcast_sq;
-	msg.msg_namelen = sizeof(qrtr_ns.bcast_sq);
-
-	ret = kernel_sendmsg(qrtr_ns.sock, &msg, &iv, 1, sizeof(pkt));
-	if (ret < 0)
-		pr_err("failed to send hello msg\n");
-
-	return ret;
-}
-
 static void qrtr_ns_worker(struct work_struct *work)
 {
 	const struct qrtr_ctrl_pkt *pkt;
@@ -725,7 +731,7 @@ void qrtr_ns_init(struct work_struct *work)
 	if (!qrtr_ns.workqueue)
 		goto err_sock;
 
-	ret = say_hello();
+	ret = say_hello(&qrtr_ns.bcast_sq);
 	if (ret < 0)
 		goto err_wq;
 
-- 
2.24.0

