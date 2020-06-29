Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C90CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4D8A20776
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hkUBYgGW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390897AbgF2VUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729784AbgF2Swt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:52:49 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA59C00F81A
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 05:32:25 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k6so16377198wrn.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 05:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VyXQmg8USJyJo46Hf1mqBSUzSZO5Ztqa3oyrhxOKqoA=;
        b=hkUBYgGWzJ3wgzTRVRr20Elco1H4dzi9VN2RKURSWYuKkKgyk9iD2TGo9o3LJilNJd
         oKWVnEgFKFJgkE70is9cdKHOQ9Kmmh5+z5QsNB6rt/iBsk3m/MU/hxHKsfeqRBF982be
         d80dF+ITFQGq2O3F4TcZS083DYvtlZboB4Qs9gtcSBsXfEa1kBvGgyg6YRwHXFglSOfy
         AjhsMGe/SvFcOYl5E81A0YHSTLyTTSvWjgFgAe4lwFh+plb++/W3/Oxt454ApXOrR5tQ
         N7p1Hw+HCC0A5AYcOHahDveUf73sgEqmLn7N0zG3bxoU+gE8RQK5NnW7BeWu8yR++Na8
         wW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VyXQmg8USJyJo46Hf1mqBSUzSZO5Ztqa3oyrhxOKqoA=;
        b=qY8x1BB5F2Yv0bv+4xpXcmIUgqpGoPJNZIMmkL09FSFnu6s86X/JuegAb/bV8Hf4Fh
         Bty82VQ9LoLCgNQynOCvLsiT3xs4rnptQ6iyc4ta/I65evVaeyrsLXT0ajToThMlrz4B
         OprBrFinrGcTQw4qN6fjL887doYADYpvQWL8pbRjH9KcQTRYwhfJfadM3q6BkjaZPmdz
         uJoiBAGhrXQlr2/Va900a5FREf4IeUDw8gknu/uOpCVZn0WiOn8OdKSMC1Senwec2tQW
         MkdpUtnsiGHAJuEJKD/Nc0v5k09IL97QkeJMAneNTbs67ejkg+sRM5k4FCJzLndj+MLC
         f9xQ==
X-Gm-Message-State: AOAM531vgSdPKoYJlRnykvDdg4uIk5IYGCl2KbWKtkM7jfhUkfjNO15F
        18orgiW4UseGAVz2SWy59ClHuQ==
X-Google-Smtp-Source: ABdhPJwVE4Hv20bxRXzoNoNnH4NM4GaBNTD55z+C/B8dFoPUP776MXDFvUHix/xRQUgvls2z0lNAlg==
X-Received: by 2002:adf:de8d:: with SMTP id w13mr16612235wrl.129.1593433944677;
        Mon, 29 Jun 2020 05:32:24 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id d201sm28064111wmd.34.2020.06.29.05.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 05:32:24 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>, Carlo Caione <carlo@caione.org>
Subject: [PATCH 5/5] mfd: axp20x-i2c: Do not define 'struct acpi_device_id' when !CONFIG_ACPI
Date:   Mon, 29 Jun 2020 13:32:15 +0100
Message-Id: <20200629123215.1014747-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629123215.1014747-1-lee.jones@linaro.org>
References: <20200629123215.1014747-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since ACPI_PTR() is used to NULLify the value when !CONFIG_ACPI,
struct axp20x_i2c_acpi_match becomes defined by unused.

This squashes the current W=1 kernel builds warning:

 drivers/mfd/axp20x-i2c.c:82:36: warning: ‘axp20x_i2c_acpi_match’ defined but not used [-Wunused-const-variable=]

Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Carlo Caione <carlo@caione.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/axp20x-i2c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/axp20x-i2c.c b/drivers/mfd/axp20x-i2c.c
index 14f9df74f855c..3dd650125c239 100644
--- a/drivers/mfd/axp20x-i2c.c
+++ b/drivers/mfd/axp20x-i2c.c
@@ -79,6 +79,7 @@ static const struct i2c_device_id axp20x_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, axp20x_i2c_id);
 
+#if IS_ENABLED(CONFIG_ACPI)
 static const struct acpi_device_id axp20x_i2c_acpi_match[] = {
 	{
 		.id = "INT33F4",
@@ -87,6 +88,7 @@ static const struct acpi_device_id axp20x_i2c_acpi_match[] = {
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, axp20x_i2c_acpi_match);
+#endif
 
 static struct i2c_driver axp20x_i2c_driver = {
 	.driver = {
-- 
2.25.1

