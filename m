Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81ADC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 23:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5ADB206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 23:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgD1XAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 19:00:24 -0400
Received: from mga05.intel.com ([192.55.52.43]:58480 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbgD1XAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 19:00:23 -0400
IronPort-SDR: 6sdGjw9GtNtHGDi0WaCTxaoy9SU1q28v6jY5fjnZHDHsQ9gOEMd6clR6De75gykZnnTBRxZkTw
 vPXuW2dVVSBg==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2020 16:00:23 -0700
IronPort-SDR: XdQu1T4O+w7tdYK2qGoB/pje7lUhIhCK+zaZQPZtijPvA6alH1AnAEYXmwSywMks5ISfrR8SCX
 JAGfDdavyxtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,328,1583222400"; 
   d="scan'208,223";a="247840359"
Received: from mdioury-mobl.amr.corp.intel.com (HELO [10.251.153.102]) ([10.251.153.102])
  by fmsmga007.fm.intel.com with ESMTP; 28 Apr 2020 16:00:20 -0700
Subject: Re: [PATCH] ASoC: SOF: sort out Kconfig, again
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        YueHaibing <yuehaibing@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        sound-open-firmware@alsa-project.org,
        Shawn Guo <shawnguo@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        NXP Linux Team <linux-imx@nxp.com>
References: <20200428212752.2901778-1-arnd@arndb.de>
 <6b39fbba-c65d-2c02-14bf-11c2d00547af@linux.intel.com>
 <CAK8P3a24whg2RhJE3Vf5u3EWy+wvFqhXdp7EQZuQx0shPsMARw@mail.gmail.com>
 <f91c9a68-7641-beb8-a23e-bd1b9b8d0acb@linux.intel.com>
Message-ID: <b784c008-7094-05cb-6200-6b246ff39bb8@linux.intel.com>
Date:   Tue, 28 Apr 2020 18:00:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <f91c9a68-7641-beb8-a23e-bd1b9b8d0acb@linux.intel.com>
Content-Type: multipart/mixed;
 boundary="------------83E0C404AAA0BEDB5B37198B"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------83E0C404AAA0BEDB5B37198B
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit



>>> Thanks Arnd, do you mind sharing your config?
>>
>> https://pastebin.com/HRX5xi3R
> 
> will give it a try, thanks!
> 
>>> We noticed last week that
>>> there's a depend/select confusion might be simpler to fix, see
>>> https://github.com/thesofproject/linux/pull/2047/commits
>>>
>>> If I look at the first line I see a IMX_DSP=n which looks exactly like
>>> what we wanted to fix.
>>
>> Yes, I think that fix addresses the build warning as well, but looking
>> more closely I don't think it's what you want: If you do this on
>> a config that has the IMX_DSP disabled, it would appear to the
>> user that you have enabled the drivers, but the actual code is still
>> disabled.
> 
> Are you sure? we added a select IMX_DSP, so not sure how it can be 
> disabled?

I just tested Arnd's config with the patch we came up with for SOF 
(attached) and it makes the unmet dependency go away and builds fine. 
the problem is really using select IMX_DSP if it can be disabled by 
something else. My proposal looks simpler but I will agree it's not 
necessarily super elegant to move the dependency on IMX_BOX into SOF, so 
no sustained objection from me on Arnd's proposal.

Daniel, this is your part of SOF, please chime in.

Thanks
-Pierre



--------------83E0C404AAA0BEDB5B37198B
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-ASoC-SOF-imx-fix-depends-select-IMX_DSP-confusion.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ASoC-SOF-imx-fix-depends-select-IMX_DSP-confusion.patch"

From 208e61ae18d3a4aa93ffa73db01c4e3c24a4979f Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Wed, 22 Apr 2020 06:21:56 -0500
Subject: [PATCH] ASoC: SOF: imx: fix depends/select IMX_DSP confusion

The two IMX targets don't use depends/select in a consistent way and
there's a potential for an unmet dependency. Move the dependency check
to a higher level and select IMX_DSP to avoid builtin/module issues.

Fixes: afb93d716533dd ("ASoC: SOF: imx: Add i.MX8M HW support")
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/imx/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sof/imx/Kconfig b/sound/soc/sof/imx/Kconfig
index f76660e91382..a11ecc1d56db 100644
--- a/sound/soc/sof/imx/Kconfig
+++ b/sound/soc/sof/imx/Kconfig
@@ -21,7 +21,7 @@ config SND_SOC_SOF_IMX_OF
 
 config SND_SOC_SOF_IMX8_SUPPORT
 	bool "SOF support for i.MX8"
-	depends on IMX_SCU
+	depends on IMX_SCU && IMX_MBOX
 	help
 	  This adds support for Sound Open Firmware for NXP i.MX8 platforms
 	  Say Y if you have such a device.
@@ -29,7 +29,6 @@ config SND_SOC_SOF_IMX8_SUPPORT
 
 config SND_SOC_SOF_IMX8
 	tristate
-	depends on IMX_SCU
 	select IMX_DSP
 	help
 	  This option is not user-selectable but automagically handled by
@@ -37,6 +36,7 @@ config SND_SOC_SOF_IMX8
 
 config SND_SOC_SOF_IMX8M_SUPPORT
 	bool "SOF support for i.MX8M"
+	depends on IMX_MBOX
 	help
 	  This adds support for Sound Open Firmware for NXP i.MX8M platforms
 	  Say Y if you have such a device.
@@ -44,7 +44,7 @@ config SND_SOC_SOF_IMX8M_SUPPORT
 
 config SND_SOC_SOF_IMX8M
 	tristate
-	depends on IMX_DSP
+	select IMX_DSP
 	help
 	  This option is not user-selectable but automagically handled by
 	  'select' statements at a higher level
-- 
2.20.1


--------------83E0C404AAA0BEDB5B37198B--
