Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF22C433F7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 13:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64AF420717
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 13:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bpNzeGQ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgGQNys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 09:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbgGQNym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 09:54:42 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4923C0619D6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 06:54:42 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id j18so14942565wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 06:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=St/xAyCtrmRBWfYYcSn7juPr5Poh/NZ3n2rNrUrY394=;
        b=bpNzeGQ2MR4hr80NvQhU98nD3GgSa4EDbYmGyWnchS5R3CJAZ9DaK36qm+qmXP2F+E
         V8YBOYQySCSk1JLCHed2FvU7RP1NEE94M+Kde0STUOJGfkONWj4s0Uc+QjarvN2q4NtN
         AsmqgLlDKAu8qLK16LPIIt5kXHR1qcZnoUFm4pHV/kl5ScEHKkKwzKmyOBCfwPguiP/z
         GSwuDGCDy1Ku3Ybl9ASlfk+YTrI0hfqVKnazspGNqYP19fvdKf5StJnn1HUViiHCURQ2
         0VEZEE2oky80AyF2bpL0dAxjuoS1yacbs+7svgQv8gFOU0JezgrR8a7YMHfLdNtQBFns
         rT6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=St/xAyCtrmRBWfYYcSn7juPr5Poh/NZ3n2rNrUrY394=;
        b=q6BJACaY+6lCToB2BzBP9tyME+2cFtFCLATfB8+IFdjgmU3xiKnZl1Jz3PpH420oqb
         wTZt/uKzaFYfpo7yFABQJw8YUGReRu0YT+flNcZhVU3TLImvemeJZjWK8Cq3Jg1/VQre
         PcUpfyTJcJ2PAhrzs9JsVkWZ9l1QBsmwryDta9qMmiRJpYYiFnTn5gGql6S+cHqYO8zj
         /rNUt8/HEWvVpb7GKimd/k3SsuuCnMKu8ADtaGoGTAgcFXqvbu/LOIggsJunGRgVU9yc
         q8Z2D+WXtr/XmE+ZlJRMx//sxVU50kucltbjPSj7XMaJQjk8/JUsnVoLqRGKWn1x71v7
         ypIw==
X-Gm-Message-State: AOAM5325ngkuTs8BcaoWlzIyhQiFIfNzmTlUJyIEWxebuOsMdA+ozJfC
        Jgxgad+RZRY0JoxclMVso/6TOg==
X-Google-Smtp-Source: ABdhPJwGwZMyZOKEAjKXmjbfGVU0S7+YF4JdD8KyDcLgCtRvve1JosJQWI81wjFZ79tXlavUy9Wvog==
X-Received: by 2002:a1c:31c6:: with SMTP id x189mr8995770wmx.182.1594994081433;
        Fri, 17 Jul 2020 06:54:41 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id w128sm16118356wmb.19.2020.07.17.06.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 06:54:40 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH v2 14/14] spi: spi-amd: Do not define 'struct acpi_device_id' when !CONFIG_ACPI
Date:   Fri, 17 Jul 2020 14:54:24 +0100
Message-Id: <20200717135424.2442271-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717135424.2442271-1-lee.jones@linaro.org>
References: <20200717135424.2442271-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since ACPI_PTR() is used to NULLify the value when !CONFIG_ACPI,
struct 'spi_acpi_match' becomes defined but unused.

Fixes the following W=1 kernel build warning(s):

 drivers/spi/spi-amd.c:297:36: warning: ‘spi_acpi_match’ defined but not used [-Wunused-const-variable=]
 297 | static const struct acpi_device_id spi_acpi_match[] = {
 | ^~~~~~~~~~~~~~

Cc: Sanjay R Mehta <sanju.mehta@amd.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/spi/spi-amd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index d0aacd4de1b9e..7f629544060db 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -294,11 +294,13 @@ static int amd_spi_probe(struct platform_device *pdev)
 	return err;
 }
 
+#ifdef CONFIG_ACPI
 static const struct acpi_device_id spi_acpi_match[] = {
 	{ "AMDI0061", 0 },
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, spi_acpi_match);
+#endif
 
 static struct platform_driver amd_spi_driver = {
 	.driver = {
-- 
2.25.1

