Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60D2C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 04:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8DD02070A
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 04:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GSMgcojL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbgGDEMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 00:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgGDEMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 00:12:08 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B99C061794
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 21:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Y2ZgUgKaIXgGhPIp8kLg05ubcJzNrmK0t36CFq8N0BA=; b=GSMgcojLUdsO4sVyLhSzZjDQr1
        3bRZkHE35qeOTP9c96j3WluBPvd/wwy8iikpS/X4tNB9K5mziDMqQ/lY3Bdri5CYuQ0dMghC80RuN
        cne/mUTV+V1y7QGJe625af1ZP6wHo0y7kK0xHTxfQWsE3dHoz3+ZTBvpQhlN3F96+ybkSAajV5gLC
        9237aDkk2zfixVqiLTn+5mueTG6L6jPl1BQtBEHJerZaGRQFGFt5JIf1LVzz0G314btKYfMCXFq/q
        JtbM8YgD/gZBPLiaZsUbg6ufARN0YipPjub8dhkjvSKyuFDxLN+HpUvEHUGsVzRs3yfWvjB4OJSjx
        xonEQOFw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrZWy-0001P6-0M; Sat, 04 Jul 2020 04:12:00 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        moderated for non-subscribers <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] ASoC: amd: fix Kconfig warning for Renoir
Message-ID: <7849ce3b-e0f0-d28d-cf9d-d0560a5b4bc8@infradead.org>
Date:   Fri, 3 Jul 2020 21:11:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

SND_SOC_DMIC depends on GPIOLIB so this driver should also depend on
GPIOLIB to make kconfig happy.

WARNING: unmet direct dependencies detected for SND_SOC_DMIC
  Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && GPIOLIB [=n]
  Selected by [y]:
  - SND_SOC_AMD_RENOIR_MACH [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_AMD_RENOIR [=y]

Fixes: 1d3776669323 ("ASoC: amd: enable build for RN machine driver")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: Mark Brown <broonie@kernel.org>
---
Found in mmotm.

There are no object file build errors. I suppose that gpiolib stubs
take care of that. Maybe some other patch would be more appropriate.

 sound/soc/amd/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- mmotm-2020-0703-1503.orig/sound/soc/amd/Kconfig
+++ mmotm-2020-0703-1503/sound/soc/amd/Kconfig
@@ -47,5 +47,6 @@ config SND_SOC_AMD_RENOIR_MACH
 	tristate "AMD Renoir support for DMIC"
 	select SND_SOC_DMIC
 	depends on SND_SOC_AMD_RENOIR
+	depends on GPIOLIB
 	help
 	 This option enables machine driver for DMIC

