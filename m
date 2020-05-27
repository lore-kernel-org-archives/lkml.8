Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E592C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F423D207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V5kemVCO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730010AbgE0L0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 07:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgE0L01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:26:27 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBE7C061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 04:26:26 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id c21so14248604lfb.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 04:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M2JtMCIr8sBIUg16KPZS8ec0bB7X2FozgIoYxF1MtfE=;
        b=V5kemVCOolx/kfOxTYXM6Z0cmf3lAOmty9c9UjUBaD6qfc5OYQJA3Tdvbo6kmr2avL
         HSHWKkNhszZeSGqH40O7m4UkhwXR4gpHY3alrb7YgsdUrrx2F+Maw5500g325FyAfOJh
         pK3mldXC0fbgHFpH0MXl53/OuoK70faKvyLjjpkXy112Rg85saP3lrFqoP6+nPbYd4Ig
         S3Q7uJ1V9YFyymc5v9p0qxpTx0fQIaFEaYQn/UGStJmpg0AVVl+xIOyhGuSGKSDKqWUo
         kF5HWpHXDGpUEcDMEdL81GW3zKMtkmEqLZ3DpKo/v1KZ2sKupOr3aYDhbeWV63keL7Eh
         T+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M2JtMCIr8sBIUg16KPZS8ec0bB7X2FozgIoYxF1MtfE=;
        b=C/GS0cDy/AwUEBvw7akqBhpviSNwSvJXGLkSBjKjwYJ6//NRlNHzW9t5QF6/hdnPYe
         kgTGtL5+t8oOqwO/KU1aBsKVdq7OgudcFnO4pzhzb6LKZkPMH53jqX0GIxz42WvM0kEC
         MANyDIWVyyWa6D17nwHtJ+fsi5rNMDhRkd3WRq/IbbbaRCEPLQmxEeTJd7hf5HNdFVsv
         1B5PxMTXeqFiRu7tmibWN0gNZCUEu40gKzPgInJyFkUdMD4ihGWpLTZ0XM/Nfyv6YSgP
         /6N/izZaXB8JrzXN7/KonJ6VWUjZnac2M2AvhZKqH69vWUJDqSMtaFkfXQCYNe4u5ruf
         TxHA==
X-Gm-Message-State: AOAM533j/zeBDoSrQfY3EQHT0H0w0V4lj5hObphYR8ko/hR+eKMV3Xe/
        4PlID7FBuC9JCBJrjkn2FZve6g==
X-Google-Smtp-Source: ABdhPJyOCrskqLzjWCjyhSbDwILM9RL2LptnZYxcJGRzQt6UxcV2DTKDtVk02/cPsG/JIPz/FxqV0g==
X-Received: by 2002:a19:4ac5:: with SMTP id x188mr2933305lfa.180.1590578784928;
        Wed, 27 May 2020 04:26:24 -0700 (PDT)
Received: from localhost (c-8c28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.140])
        by smtp.gmail.com with ESMTPSA id a12sm634907ljp.60.2020.05.27.04.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 04:26:24 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, linus.walleij@linaro.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 3/5] Revert "ARM: vexpress: Don't select VEXPRESS_CONFIG"
Date:   Wed, 27 May 2020 13:26:06 +0200
Message-Id: <20200527112608.3886105-4-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527112608.3886105-1-anders.roxell@linaro.org>
References: <20200527112608.3886105-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 848685c25da99d871bbd87369f3c3d6eead661ac.
Due to when I set 'depends on VEXPRESS_CONFOG=Y' in 'config
POWER_RESET_VEXPRESS' to get an allmodconfig build on arm64 to build,
and allmodconfig build on arm fails if this patch isn't reverted.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 arch/arm/mach-vexpress/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index 8391a5b3cd78..065e12991663 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -19,6 +19,7 @@ menuconfig ARCH_VEXPRESS
 	select POWER_SUPPLY
 	select REGULATOR if MMC_ARMMMCI
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
+	select VEXPRESS_CONFIG
 	help
 	  This option enables support for systems using Cortex processor based
 	  ARM core and logic (FPGA) tiles on the Versatile Express motherboard,
-- 
2.26.2

