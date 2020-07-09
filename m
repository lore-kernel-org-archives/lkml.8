Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A729C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 11:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AEA52076A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 11:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u/XQOJpR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgGILH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 07:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727812AbgGILHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 07:07:15 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3993BC061A0B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 04:07:15 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f2so1879927wrp.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 04:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5ypoS87uaYq5T1Ws5fpzwvYaFzn2rohMM1mgqyify3Q=;
        b=u/XQOJpRlPYAfkZQd67a8cfGanswI8V5QVehHkfbrFzIMDDe0G/ernaRhEM4XLh0VC
         1GK4E3PfbGomGPDfaaJE/ffo/sQHtkVUj8fUdmFGFSDzodzZIke5XoA7TiKcp2kJYn2D
         2p4DEap+OAMeKDUMYLuEfoX0En8TMCKA/YpyjvtsSgnn+UUahU+4zp5q35GbSeSOxAfp
         GZFccHLnYqs0qkaJO8Ja3hOyKS2hr6KbQzU44JNMdkjSIG3RSkwYxKBPTfhUqF7DiwB0
         /T8Gd779ciLnWaVL1UbYzbqDN/dV5O/mmxeJ/QUbZC7sWQp6UTZjp+VEApofs3CSFGQB
         MrLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ypoS87uaYq5T1Ws5fpzwvYaFzn2rohMM1mgqyify3Q=;
        b=V5XFbkCdzhaoJa0i76z7XtNTy2vBbTKjePoUd/dXKXxudN8Hd2S3KKszwlDfI2T6XS
         T/FkmsxhsD6Orj5hlHWRZ4uzKfa9noBHNqYTUg64SuJymtQej8vERrJyBOWn37m8tXyn
         nU61BsXTmrcC7swWvs6AgXPp7DlHH4jJz6dwfZFUqFJE1aUutl7QkDImOHiQcFT6iqqa
         zn/cb+0W3Pgf8UD822QdjIxT9qubp6575kfsjKvw6M3PZn1+66PTfeMuCQk9CSQCdQHB
         4rDYYKJWU6EvfKLweEESxHJQHwYVv6WfgSa8P1YdCme3lGdyzL5MbM2jvaXqblsBqFtA
         PQ2Q==
X-Gm-Message-State: AOAM533f5FymZYYKTCYHoSWU17BeytC9ejLwqQfJFlsOacA4hZWn8IDD
        Q6L2PgyS5heQ+emhvblyRBjHig==
X-Google-Smtp-Source: ABdhPJynWNpStYFUrVfAdO0LvBqdBvKmYX7eIbfu3UeYFpdUQ3gByC7usDKxfX5IOl3P6cYXTes0CA==
X-Received: by 2002:a5d:504b:: with SMTP id h11mr61368817wrt.160.1594292833936;
        Thu, 09 Jul 2020 04:07:13 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id q7sm5375578wrs.27.2020.07.09.04.07.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2020 04:07:13 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     saravanak@google.com, mdtipton@codeaurora.org,
        okukatla@codeaurora.org, bjorn.andersson@linaro.org,
        vincent.guittot@linaro.org, georgi.djakov@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] interconnect: qcom: smd845: Use icc_sync_state
Date:   Thu,  9 Jul 2020 14:07:04 +0300
Message-Id: <20200709110705.30359-4-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200709110705.30359-1-georgi.djakov@linaro.org>
References: <20200709110705.30359-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lowering the bandwidth on the bus might have negative consequences if
it's done before all consumers had a chance to cast their vote. Let's
return the maximum amount of bandwidth as initial value. This bandwidth
level would be maintained until all consumers have probed.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/qcom/sdm845.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
index f6c7b969520d..bfea6a5321b0 100644
--- a/drivers/interconnect/qcom/sdm845.c
+++ b/drivers/interconnect/qcom/sdm845.c
@@ -437,6 +437,13 @@ static const struct qcom_icc_desc sdm845_system_noc = {
 	.num_bcms = ARRAY_SIZE(system_noc_bcms),
 };
 
+static int qcom_get_bw(struct icc_node *node, u32 *bw)
+{
+	*bw = INT_MAX;
+
+	return 0;
+}
+
 static int qnoc_probe(struct platform_device *pdev)
 {
 	const struct qcom_icc_desc *desc;
@@ -469,6 +476,7 @@ static int qnoc_probe(struct platform_device *pdev)
 	provider->set = qcom_icc_set;
 	provider->pre_aggregate = qcom_icc_pre_aggregate;
 	provider->aggregate = qcom_icc_aggregate;
+	provider->get_bw = qcom_get_bw;
 	provider->xlate = of_icc_xlate_onecell;
 	INIT_LIST_HEAD(&provider->nodes);
 	provider->data = data;
@@ -559,6 +567,7 @@ static struct platform_driver qnoc_driver = {
 	.driver = {
 		.name = "qnoc-sdm845",
 		.of_match_table = qnoc_of_match,
+		.sync_state = icc_sync_state,
 	},
 };
 module_platform_driver(qnoc_driver);
