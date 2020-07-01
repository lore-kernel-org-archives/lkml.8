Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E9AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D987120702
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yk+r9H6l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730635AbgGAMrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 08:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730544AbgGAMrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 08:47:10 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8FDC03E979
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 05:47:10 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l17so22275301wmj.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 05:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x8xCKIw9Ld5Xa//V32cpz9QyqhlFaWmoKz6kDT+w1CQ=;
        b=yk+r9H6lX2Cc5i0dlDYZHeHh6IaafXhdA3+cx+ukukxwN0QSjnW3v7AJbxYJahc1rJ
         It9z0lJpzuNfcP/Ch9oXRsRIl0RTjxEwgK1d4Xrlul48VRVT2oRTZEMpcxQchBYCm4Hf
         0hSQ5kknJI7Gvwga0UCeFY1HqgqXDCC3WO9BLFuinxIrTAniduRmJTwp79YNdRxttxsp
         lbNiJkrLQOfUSvm+Ogb6yMaDLjrp8D6Ycy+5+Va5hhDZ7wVSQS8LKtRXxnBYkXXx5Q62
         zR8Wan38GVVfXHBnLw8enlCYUQGkcw2kVwfFXLl8d7WTBo9JwwfLavhTIdmUIsfz6ql3
         DZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x8xCKIw9Ld5Xa//V32cpz9QyqhlFaWmoKz6kDT+w1CQ=;
        b=cA4+kGxVLsRwh7KXpl84eMKQ50if76OlqXgM/oy8UONBuSe2wHNDTAeEYZaLW3o90A
         PlwPBsr/oZoNOSIV2sUGCT5mB/MpMWr8fjg8ksBqxjNLIRbG0d7r2GrjbQ8J6B+dHWsW
         gKV/fQQxiAb8VX4xsXPtg3lt7jZUdWI3p/BqABjzMW/HMDjYwrUWTSCL5KRS4dmNlxWu
         XlfUFU0krd9doH7/hv412LYbTmmotWjJeCQ66ClGzFbJxK0n9eevYlnPGpiiWtJ+W753
         Al01Qr5lkJSY3jcD52TGcTxbGPt8MHrdT681RNFMhcbhWBqwFj+M21uuEFdzR2bhJZrN
         YtBg==
X-Gm-Message-State: AOAM531HmZrRZDwu9faPhDWatwImImzplHlPv7oUY6JfYp/IILGiQgCT
        v26M5tuEmIIy8CgLa4SlHqSe4g==
X-Google-Smtp-Source: ABdhPJxQ+Yg6i9TIajip46TH3pID9Y8RjLR+RANFA+2ocxzD+PQpg4Nb+WF2voDLYQGI8AIzZdylRg==
X-Received: by 2002:a1c:7209:: with SMTP id n9mr26663783wmc.150.1593607628056;
        Wed, 01 Jul 2020 05:47:08 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id o29sm7817862wra.5.2020.07.01.05.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 05:47:07 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     ulf.hansson@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Andrei Warkentin <andreiw@motorola.com>,
        Martin Mares <mj@ucw.cz>
Subject: [PATCH 01/15] mmc: core: quirks: Mark fixups as __maybe_unused
Date:   Wed,  1 Jul 2020 13:46:48 +0100
Message-Id: <20200701124702.908713-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701124702.908713-1-lee.jones@linaro.org>
References: <20200701124702.908713-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all source files which include quirks.h make use of the all of
the available fixup information.  When this happens the compiler
complains that some constant variables are defined by never used.
We can fix this by telling the compiler that this intentional by
simply marking them as __maybe_unused.

Fixes the following W=1 kernel build warnings:

 In file included from drivers/mmc/core/sdio.c:22:
 drivers/mmc/core/quirks.h:105:31: warning: ‘mmc_ext_csd_fixups’ defined but not used [-Wunused-const-variable=]
 105 | static const struct mmc_fixup mmc_ext_csd_fixups[] = {
 | ^~~~~~~~~~~~~~~~~~
 drivers/mmc/core/quirks.h:17:31: warning: ‘mmc_blk_fixups’ defined but not used [-Wunused-const-variable=]
 17 | static const struct mmc_fixup mmc_blk_fixups[] = {
 | ^~~~~~~~~~~~~~
 In file included from drivers/mmc/core/mmc.c:25:
 drivers/mmc/core/quirks.h:123:31: warning: ‘sdio_fixup_methods’ defined but not used [-Wunused-const-variable=]
 123 | static const struct mmc_fixup sdio_fixup_methods[] = {
 | ^~~~~~~~~~~~~~~~~~
 drivers/mmc/core/quirks.h:17:31: warning: ‘mmc_blk_fixups’ defined but not used [-Wunused-const-variable=]
 17 | static const struct mmc_fixup mmc_blk_fixups[] = {
 | ^~~~~~~~~~~~~~

Cc: Andrei Warkentin <andreiw@motorola.com>
Cc: Martin Mares <mj@ucw.cz>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mmc/core/quirks.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index 472fa2fdcf139..d68e6e513a4f4 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -14,7 +14,7 @@
 
 #include "card.h"
 
-static const struct mmc_fixup mmc_blk_fixups[] = {
+static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
 #define INAND_CMD38_ARG_EXT_CSD  113
 #define INAND_CMD38_ARG_ERASE    0x00
 #define INAND_CMD38_ARG_TRIM     0x01
@@ -102,7 +102,7 @@ static const struct mmc_fixup mmc_blk_fixups[] = {
 	END_FIXUP
 };
 
-static const struct mmc_fixup mmc_ext_csd_fixups[] = {
+static const struct mmc_fixup __maybe_unused mmc_ext_csd_fixups[] = {
 	/*
 	 * Certain Hynix eMMC 4.41 cards might get broken when HPI feature
 	 * is used so disable the HPI feature for such buggy cards.
@@ -120,7 +120,7 @@ static const struct mmc_fixup mmc_ext_csd_fixups[] = {
 };
 
 
-static const struct mmc_fixup sdio_fixup_methods[] = {
+static const struct mmc_fixup __maybe_unused sdio_fixup_methods[] = {
 	SDIO_FIXUP(SDIO_VENDOR_ID_TI_WL1251, SDIO_DEVICE_ID_TI_WL1251,
 		   add_quirk, MMC_QUIRK_NONSTD_FUNC_IF),
 
-- 
2.25.1

