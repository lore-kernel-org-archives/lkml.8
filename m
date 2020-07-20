Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AA4C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 18:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDEEC208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 18:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sdanfMuc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730323AbgGTSca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 14:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgGTSca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 14:32:30 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFF9C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 11:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=HoGrcROsDuFcW0fQ11PlXtvMHOgYzwDunvP1JOcV8PQ=; b=sdanfMuc5tnQdlqxthXRAubDTz
        CT3zBJb9O2ncHQkJuZ7vxecYPcwykfj/WhR4xv8t/KROkeBlW50LHYPJyNAmhMwkNeJsuxeaZ0Hsk
        Pbw7SFGXwEhVevtHGto8/x8sGc1kM2Fs59Bw31MAI9sBaP17Ge+Gc1dzOdsPefsLTtIpJt1VBYQC5
        i8JC7vclNSpf0Dld0TjlY9fYC31qRDUks2NvHE3FJYfP5bZAMowYqgOtJMl5TKUeFhcaNwGfQ6ooi
        jKRKII8xPxzCM7MM6q8h0UnSzCf7F/Ud5sGje9am7CLQEIC9PX4YRNwskGEcw04gKbb86bKhw3DgR
        OiW/Q/Fw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxaaO-0001Ij-8i; Mon, 20 Jul 2020 18:32:24 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        moderated for non-subscribers <alsa-devel@alsa-project.org>,
        Mark Brown <broonie@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] ASoC: ti: fix SND_SOC_J721E_EVM warnings & errors
Message-ID: <e74c690c-c7f8-fd42-e461-4f33571df4ef@infradead.org>
Date:   Mon, 20 Jul 2020 11:32:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

SND_SOC_J721E_EVM should not select SND_SOC_PCM3168A_I2C when I2C
is not enabled. That causes build errors, so make this driver's
symbol depend on I2C.

WARNING: unmet direct dependencies detected for SND_SOC_PCM3168A_I2C
  Depends on [n]: SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && I2C [=n]
  Selected by [m]:
  - SND_SOC_J721E_EVM [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && (DMA_OMAP [=y] || TI_EDMA [=m] || TI_K3_UDMA [=n] || COMPILE_TEST [=y]) && (ARCH_K3_J721E_SOC [=n] || COMPILE_TEST [=y])

../sound/soc/codecs/pcm3168a-i2c.c:59:1: warning: data definition has no type or storage class
 module_i2c_driver(pcm3168a_i2c_driver);
 ^~~~~~~~~~~~~~~~~
../sound/soc/codecs/pcm3168a-i2c.c:59:1: error: type defaults to ‘int’ in declaration of ‘module_i2c_driver’ [-Werror=implicit-int]
../sound/soc/codecs/pcm3168a-i2c.c:59:1: warning: parameter names (without types) in function declaration
../sound/soc/codecs/pcm3168a-i2c.c:49:26: warning: ‘pcm3168a_i2c_driver’ defined but not used [-Wunused-variable]
 static struct i2c_driver pcm3168a_i2c_driver = {
                          ^~~~~~~~~~~~~~~~~~~
cc1: some warnings being treated as errors


Fixes: 6748d0559059 ("ASoC: ti: Add custom machine driver for j721e EVM (CPB and IVI)")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Mark Brown <broonie@kernel.org>
---
 sound/soc/ti/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20200720.orig/sound/soc/ti/Kconfig
+++ linux-next-20200720/sound/soc/ti/Kconfig
@@ -222,6 +222,7 @@ config SND_SOC_DM365_VOICE_CODEC_MODULE
 config SND_SOC_J721E_EVM
 	tristate "SoC Audio support for j721e EVM"
 	depends on ARCH_K3_J721E_SOC || COMPILE_TEST
+	depends on I2C
 	select SND_SOC_PCM3168A_I2C
 	select SND_SOC_DAVINCI_MCASP
 	help

