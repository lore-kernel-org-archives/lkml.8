Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E60C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 21:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC53C208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 21:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbgE0V5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 17:57:50 -0400
Received: from mga17.intel.com ([192.55.52.151]:15506 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgE0V5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 17:57:49 -0400
IronPort-SDR: V4owjd/M3cVjBwMfIXEtmRRgErIn6+fOVYeFHLzDANqGrljkcJ9yOKIT/WIEEttBabY7I02Kxm
 gbu2ByOgkVRw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 14:57:49 -0700
IronPort-SDR: Dn6Nms0lbpwzDVjf1y1V182yGLNUKnB/z6J3wwYmISMjOh/yb/HE810zjdkcIVv0NMWoedQxOu
 gUXTc13nIEjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,442,1583222400"; 
   d="scan'208";a="376161975"
Received: from truongmi-mobl1.amr.corp.intel.com (HELO [10.255.229.101]) ([10.255.229.101])
  by fmsmga001.fm.intel.com with ESMTP; 27 May 2020 14:57:48 -0700
Subject: Re: [PATCH] ASoC: rt5682: split i2c driver into separate module
To:     Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Oder Chiou <oder_chiou@realtek.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, Akshu Agrawal <akshu.agrawal@amd.com>
References: <20200527193730.930412-1-arnd@arndb.de>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <d4b437f7-f078-3b56-b405-82a31e2ef00d@linux.intel.com>
Date:   Wed, 27 May 2020 16:57:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200527193730.930412-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/27/20 2:34 PM, Arnd Bergmann wrote:
> With SND_SOC_AMD_RV_RT5682_MACH using the i2c version of the
> driver, we can easily get a build failure when I2C is built-in
> but soundwire is not:
> 
>   WARNING: unmet direct dependencies detected for SND_SOC_RT5682
>     Depends on [m]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && (I2C [=y] || SOUNDWIRE [=m]) && (SOUNDWIRE [=m] || !SOUNDWIRE [=m]) && (I2C [=y] || !I2C [=y])
>     Selected by [y]:
>     - SND_SOC_AMD_RV_RT5682_MACH [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_AMD_ACP3x [=y] && I2C [=y] && CROS_EC [=y]
>     Selected by [m]:
>     - SND_SOC_RT5682_SDW [=m] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SOUNDWIRE [=m] && (I2C [=y] || !I2C [=y])
> 
> Rework the driver to have three separate modules, with the
> main driver just dealing with the common bits and the actual
> initialization as part of i2c and sdw specific modules.
> 
> The conversion is fairly mechanical to keep it easy to review,
> i.e. it moves code around with the minimal required renaming
> and changes.
> 
> Fixes: 6b8e4e7db3cd ("ASoC: amd: Add machine driver for Raven based platform")
> Fixes: fd443a20c2f0 ("ASoC: rt5682: fix I2C/Soundwire dependencies")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Thanks for this cleanup.
