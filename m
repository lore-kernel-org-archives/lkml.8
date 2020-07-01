Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA99C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E7FA2065D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MLuuKP8c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgGAHAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 03:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgGAHAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 03:00:04 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E80FC061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 00:00:02 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id j18so21209587wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 00:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=NUS8pl2s+F7HyNG9JOdBIIa6cEhGwk+IKrIPH0RpN/Y=;
        b=MLuuKP8cIUJ2iLrriN/WG7L7PGffCGdH8sELwG4cVLyX17fYJ7WSC9hH/48rwC0tS5
         SZJnIRCQSuTsHB4bbjKMf6JnEMwy2EOFqZAkZiwYlWiccHXd9PFalbAjue7hv214KcHD
         qaWvPnfGZMjr0OfEcnundm+FvqJfDzEdzS5Pc7+H542KHHX6CuUYa1PikiEBBhhrBLLm
         qZeIP3vJEMASRYdsmpLFuJCVQr8D64gg87iM5e6l4xfiM8G4Qz89Q47Jb0qdUqTApP3Y
         4LzQqWm2qHieXzsloGFWtrfagySoXL5JxhNGaQfzot3zNneuInvtPvCv8akioLzQfoNj
         Qmjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=NUS8pl2s+F7HyNG9JOdBIIa6cEhGwk+IKrIPH0RpN/Y=;
        b=pDd0ILDilSFpKBvss9tXXV7Am8Dnd9C6csmdDwvBJU5XXpJ5MqYNwoxOQjqwEUzQzQ
         QCJCz3iY8sqCONRFpFF6++XLWvrlDbqSMAiMLBY8wsFqz/h9bjCeo19LKobYDN19jMsP
         DRk6Tae2yoWWepYUGJBulqtCTzN6G0X/wRxNzGZDTR3J3uTkAKuDjbK60uSNHTpeBH0+
         d2ZfJ4hPt8LX4QzDSZUtno6HbUrA/zvD6vo4ADQtizK9ovPKscGC8JdK5QBtSbnaEHAD
         zdNWdqt0K4qQ45qbVQcoqyuhs6cQPH2TURt/oj7R+vMdcAj92VhQmtrG+vIKF4b+7qBy
         kVMA==
X-Gm-Message-State: AOAM532SyHp5KTN2qWoyAxlr1+oYHTjnjNHtQVV/W7HkSX6aajNInUYK
        vrHr0gARYJOYGbldHUKzUQAcOw==
X-Google-Smtp-Source: ABdhPJx7GWQPL4rqfjTwgo0RzWsrPQ+g4flCQxCq0DB3EuwqRGXUI8GhDWAnSrmj7ya7GTSZ+DTKKg==
X-Received: by 2002:a1c:7fd7:: with SMTP id a206mr25103064wmd.104.1593586800732;
        Wed, 01 Jul 2020 00:00:00 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id z16sm6115728wrr.35.2020.06.30.23.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 23:59:59 -0700 (PDT)
Date:   Wed, 1 Jul 2020 07:59:57 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>, Carlo Caione <carlo@caione.org>
Subject: [PATCH v2] mfd: axp20x-i2c: Tell the compiler that ACPI functions
 may not be used
Message-ID: <20200701065957.GO1179328@dell>
References: <20200629123215.1014747-1-lee.jones@linaro.org>
 <20200629123215.1014747-6-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200629123215.1014747-6-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

... as is the case when !CONFIG_ACPI.
    
This squashes the current W=1 kernel builds warning:
    
 drivers/mfd/axp20x-i2c.c:82:36: warning: ‘axp20x_i2c_acpi_match’ defined but not used [-Wunused-const-variable=]
    
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Carlo Caione <carlo@caione.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>

diff --git a/drivers/mfd/axp20x-i2c.c b/drivers/mfd/axp20x-i2c.c
index 14f9df74f855c..7d08c06de7afc 100644
--- a/drivers/mfd/axp20x-i2c.c
+++ b/drivers/mfd/axp20x-i2c.c
@@ -79,7 +79,7 @@ static const struct i2c_device_id axp20x_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, axp20x_i2c_id);
 
-static const struct acpi_device_id axp20x_i2c_acpi_match[] = {
+static const struct acpi_device_id __maybe_unused axp20x_i2c_acpi_match[] = {
        {
                .id = "INT33F4",
                .driver_data = AXP288_ID,
