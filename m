Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB3BC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 03:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 160F321744
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 03:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PRCfvcTK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgCBD0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 22:26:55 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34885 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgCBD0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 22:26:54 -0500
Received: by mail-pl1-f195.google.com with SMTP id g6so3628281plt.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 19:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VeICtnOsZ2C5UP5Em+E/sXna3uaGHm7TKk8BxzBI+6c=;
        b=PRCfvcTKS2HCaAnNmLkIU9dpR+IRiKEYs54u4SfzV8eq05wetWOkMMYjEYBqLw/ZSI
         zrhpJHUnqAljml0yrq25fP+Wcqv0AZ3fQCOpIDBhS3d0S/W9KKFxU+MLyoW28s3h88Ru
         XdeIJs+kwZ2+eZu6KTUvJy7B+uMx6qvyeyucRiG5lvzngBFV7lcP89+iCoPxGnzzXZNx
         SQUqiIEUFc0YbAl0pcvv9x3FXN2r5/jXT1OvZpOnksVaPJaXSocW+VWlBvVBg3KvFBCn
         jFDOb6lq2jS0N91ltnoZ1w5dcSdliX6khAwlvO3XDxJYSFdBU9FaoGPYDb6DMmmf2ITS
         oAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VeICtnOsZ2C5UP5Em+E/sXna3uaGHm7TKk8BxzBI+6c=;
        b=npa7VcxUhL1aa2aQkslYK7CitmkERQ7epItJwEVIdSJUGLQUPpyMWoZrhpYcuQSKxi
         kPY9/EdT40INHdLHJ4ri+YSwJChhioOQkaJ0mokqqoY56ZMmuNcDolQpHT92gDCuN2tA
         4aRe3H9K34F0mf2w2NXZlchOdWsxSPUSYrvDSLV8PYhGnXUJJB4OiVAEcq+WvxNxfvYQ
         fyRu2qBgEbS4Tio+fl4ongOdOiihS9UlwndO0sdQnLGT2nSbRFBI6ry+majfOifw61GG
         PcKCtk/gExVFLhrAFF4TdO/DMW9o6YCaZ/NKwdxlGm1doNIbyF8z0yrS+K+6mKPWnzWc
         TELA==
X-Gm-Message-State: APjAAAVgcp873IYSrWjzg2SxxEKYWa2WEaiwUqdXm8+Xttqx8Kfyqapd
        EZWJMNyG4gAPbv4KEo84tI1k4jT2/QQ=
X-Google-Smtp-Source: APXvYqxz7ZRhAo30RgCJ0M6uHAeTharsKZmdDEpo9bJKkn4vD/2LpuP8aWsjqSxdJvmzQEOiID2aJA==
X-Received: by 2002:a17:902:a715:: with SMTP id w21mr16079228plq.244.1583119613461;
        Sun, 01 Mar 2020 19:26:53 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b133sm18435739pga.43.2020.03.01.19.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 19:26:52 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 1/2] net: qrtr: Respond to HELLO message
Date:   Sun,  1 Mar 2020 19:25:26 -0800
Message-Id: <20200302032527.552916-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200302032527.552916-1-bjorn.andersson@linaro.org>
References: <20200302032527.552916-1-bjorn.andersson@linaro.org>
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
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
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

