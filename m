Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDFFC54FCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E559220781
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oo9AZI4l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbgCWPA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 11:00:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38905 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727301AbgCWPA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 11:00:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id s1so17493515wrv.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 08:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2HWDKGe7o0RlZ1ycFAcKhMfPvSlYOOFb4fX4iFyPE34=;
        b=oo9AZI4lqQKOxCjlxcgQ/ZLomfS7BzOwzi+HQe9wTh5URTFBgqhHp7x+vUDENsUfKv
         iOoKHs7GQzR3W+ybS191kq/2l61gyEIMXfmtvvtFQ+wDMQsfIIacWIBc/c1VpANTevS5
         ittY5NdkIhkfdon3piHQLsuAQDZWDmwkQygR7TEjNtdjM2r8wPe61v2cQ1uKbw8GZK+f
         xyBSHn7CXf9w4WNb80lBkMrE9DNxG61Ia9ft0QKroBZ6ZkKVXjuoQWcijqHagVm1zid8
         rSDlmW3FkmiKhIpwad6y6Z5JerPKOFL+/fPClAEOIMBy+egOGK7wEW/RJBQECDsIF5w2
         +TdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2HWDKGe7o0RlZ1ycFAcKhMfPvSlYOOFb4fX4iFyPE34=;
        b=X0w4POPx12xdWLqFf/zmfFTLtCziuSb8jzXwPFvOlpukI0o+v2+gpBH5YRkS+eX1av
         gCZtKuHr8W5OSgQrHIKX/u/fscy0vwAD8yUgQ8WIISY0ZBnKo1Q+1m8q+RJNQCpbL/2X
         9/Q9wUqWnUgBSMjD0M4l7aRGQ7k2v3C7QxG1XKkvwX8p6mTMxqzy5Afw3IAb4eKlSErP
         RygLd+yhoZ3ofOqCveVvMljFbCWXp1e2xyhCXauaLRwKUpTFY3lJRgrL5oyqPsHE9dOh
         Z/GLuacaHQuEOGw0AbsoIMKSEbsYzjaEzcvx6msPGJcQkDTkAuMJqTQXwrVHOXkr1CKc
         qcJA==
X-Gm-Message-State: ANhLgQ2Wot2AQ8Vjq97JSeemDy6VU6e3WOPzgFp9GdVW2jCGWj4HVExN
        XzsiStm9qd2YmTwpQIgF8iGFVZKmSS8=
X-Google-Smtp-Source: ADFU+vtl7Eu/KjNNT/XI4pKBLLj18KZm9PMLF4AcEflkTz4wKA99zG+podxlZv3udjZXn2QwUmZwtQ==
X-Received: by 2002:a5d:45c7:: with SMTP id b7mr2708426wrs.44.1584975624987;
        Mon, 23 Mar 2020 08:00:24 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id k15sm1084196wrm.55.2020.03.23.08.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 08:00:24 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Anson Huang <Anson.Huang@nxp.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 4/5] nvmem: mxs-ocotp: Use devm_add_action_or_reset() for cleanup
Date:   Mon, 23 Mar 2020 15:00:06 +0000
Message-Id: <20200323150007.7487-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200323150007.7487-1-srinivas.kandagatla@linaro.org>
References: <20200323150007.7487-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

Use devm_add_action_or_reset() for cleanup to call clk_unprepare(),
which can simplify the error handling in .probe, and .remove callback
can be dropped.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/mxs-ocotp.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/nvmem/mxs-ocotp.c b/drivers/nvmem/mxs-ocotp.c
index 8e4898dec002..588ab56d75b7 100644
--- a/drivers/nvmem/mxs-ocotp.c
+++ b/drivers/nvmem/mxs-ocotp.c
@@ -130,6 +130,11 @@ static const struct of_device_id mxs_ocotp_match[] = {
 };
 MODULE_DEVICE_TABLE(of, mxs_ocotp_match);
 
+static void mxs_ocotp_action(void *data)
+{
+	clk_unprepare(data);
+}
+
 static int mxs_ocotp_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -160,39 +165,26 @@ static int mxs_ocotp_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = devm_add_action_or_reset(&pdev->dev, mxs_ocotp_action, otp->clk);
+	if (ret)
+		return ret;
+
 	data = match->data;
 
 	ocotp_config.size = data->size;
 	ocotp_config.priv = otp;
 	ocotp_config.dev = dev;
 	otp->nvmem = devm_nvmem_register(dev, &ocotp_config);
-	if (IS_ERR(otp->nvmem)) {
-		ret = PTR_ERR(otp->nvmem);
-		goto err_clk;
-	}
+	if (IS_ERR(otp->nvmem))
+		return PTR_ERR(otp->nvmem);
 
 	platform_set_drvdata(pdev, otp);
 
-	return 0;
-
-err_clk:
-	clk_unprepare(otp->clk);
-
-	return ret;
-}
-
-static int mxs_ocotp_remove(struct platform_device *pdev)
-{
-	struct mxs_ocotp *otp = platform_get_drvdata(pdev);
-
-	clk_unprepare(otp->clk);
-
 	return 0;
 }
 
 static struct platform_driver mxs_ocotp_driver = {
 	.probe = mxs_ocotp_probe,
-	.remove = mxs_ocotp_remove,
 	.driver = {
 		.name = "mxs-ocotp",
 		.of_match_table = mxs_ocotp_match,
-- 
2.21.0

