Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C61C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D650320722
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tjX3JnTQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbgGAIcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728930AbgGAIbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:31:55 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756EFC061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 01:31:55 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z15so11619833wrl.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 01:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XHXWFB9CtCq3ogRoTXjYaAYG+vDjtwvgXpZpFIdOYUs=;
        b=tjX3JnTQ8DKxNZq+JrN4OfxZ/6mnhHpUFoNYOp7TeW6DqIScMdFFjiqZ8KOcntMoFQ
         JIxBBiO0WG2Ndg4SU7ORNyxXC2D4Mg6SXT+FRiVTV133sBh7VGrm0xMksPARXncP4tHG
         s3g3jJYwnSTaRdqTCfsBV9M1k9uFe/8zKXzQF9jtkvD0OpyviD31vD8P0GTjawnffocT
         l67SsjE3A6N06w9fUcUowmCWXefk/+F07cZEXiT738yw+WXHk+09FAIO9nxj435U74IV
         QnT4JDQEhlOiG2vdaectNNWukK/ilgsYwVCxP2nLl5lW/j/OLPeWruuQgnU2ZlHibvLe
         qn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XHXWFB9CtCq3ogRoTXjYaAYG+vDjtwvgXpZpFIdOYUs=;
        b=Xb1RPLubcK98RqgMEidj068M1R+JH3m+Ir9wdj4VGqlENQFn9zCaBEhHnmIS9IQ41D
         BFkvD+agRYwD5kULW7Ox9V8PHfHLSevSxc4MbbdYLe3nAPFKvEB4QstzlKqPIM5a/5Ya
         SG+kWIBPBw8Bv/C2aFdXkY5k8ymKP0c6uPsqH/iubc016jQW/0NNmgciYvLOGmIqj2xr
         eJmvtPIldRyj4sVK2nD6TGkQqY6L1YAikoc6cHT+ca1KNXwisRvVaGAmR/swHXS+rnj3
         mTJ4njxHs2dPSSGEZ/Lx7z678xWmNZIulwFdex2A3jBmd2Y4QTpyxaoDMEsahNd0ia2A
         8ghA==
X-Gm-Message-State: AOAM530ywTXbD75BfbHNNxMBgA/d0RqcHa1y1MX0y3nUGJdBTtYs7vqX
        BX1capgxg13i6qnXR/xISeaSHQ==
X-Google-Smtp-Source: ABdhPJxZU2ildreuZ4frp8XuE61w5ZsWDOeO2IjNLGqzRBLt9IO4W/rr0JRcAy9OwuvrfiPSPrCA1Q==
X-Received: by 2002:adf:84e2:: with SMTP id 89mr26772538wrg.139.1593592314190;
        Wed, 01 Jul 2020 01:31:54 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id 59sm6717816wrj.37.2020.07.01.01.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 01:31:53 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Wolfram Sang <wsa@kernel.org>
Subject: [PATCH v2 26/30] misc: eeprom: at24: Tell the compiler that ACPI functions may not be used
Date:   Wed,  1 Jul 2020 09:31:14 +0100
Message-Id: <20200701083118.45744-27-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701083118.45744-1-lee.jones@linaro.org>
References: <20200701083118.45744-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

... as is the case when !CONFIG_ACPI.

Fixes the following W=1 kernel build warning:

 drivers/misc/eeprom/at24.c:228:36: warning: ‘at24_acpi_ids’ defined but not used [-Wunused-const-variable=]

Cc: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/eeprom/at24.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 9ff18d4961ceb..2591c21b2b5d8 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -225,7 +225,7 @@ static const struct of_device_id at24_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, at24_of_match);
 
-static const struct acpi_device_id at24_acpi_ids[] = {
+static const struct acpi_device_id __maybe_unused at24_acpi_ids[] = {
 	{ "INT3499",	(kernel_ulong_t)&at24_data_INT3499 },
 	{ "TPF0001",	(kernel_ulong_t)&at24_data_24c1024 },
 	{ /* END OF LIST */ }
-- 
2.25.1

