Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FECC2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 19:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A81362075E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 19:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbgDHTNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 15:13:02 -0400
Received: from mga01.intel.com ([192.55.52.88]:33924 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728195AbgDHTNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 15:13:02 -0400
IronPort-SDR: Skn/W7y41QjVVRK/GUaBL+74yUvYtB2gpl2kwi4PmgdSSD/pPvB1fKVohuEu2nomvaGSC5j75Q
 xvtk3x+HtGrA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2020 12:13:01 -0700
IronPort-SDR: CkKPzE9Tf7VRoIKyHvOi4WoURCzJ6+LDNSQTWiUmjQnyfvFsPfmmWPPxbP7GbrDcwWC1/HwdHT
 uxxveu7ZPHrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,359,1580803200"; 
   d="scan'208";a="254240576"
Received: from maguirre-mobl2.amr.corp.intel.com (HELO [10.212.247.110]) ([10.212.247.110])
  by orsmga008.jf.intel.com with ESMTP; 08 Apr 2020 12:13:00 -0700
Subject: Re: [PATCH] ASoC: rt5682: fix building without I2C
To:     Arnd Bergmann <arnd@arndb.de>, Oder Chiou <oder_chiou@realtek.com>,
        Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, kbuild test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Derek Fang <derek.fang@realtek.com>,
        Shuming Fan <shumingf@realtek.com>
References: <20200408185527.308213-1-arnd@arndb.de>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <08b488ef-91bb-ab66-c2d8-16822f3bf152@linux.intel.com>
Date:   Wed, 8 Apr 2020 14:12:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200408185527.308213-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/8/20 1:55 PM, Arnd Bergmann wrote:
> When I2C is disabled, building rt5682 produces a compile-time error:
> 
> sound/soc/codecs/rt5682.c:3716:1: warning: data definition has no type or storage class
>   3716 | module_i2c_driver(rt5682_i2c_driver);
>        | ^~~~~~~~~~~~~~~~~
> sound/soc/codecs/rt5682.c:3716:1: error: type defaults to 'int' in declaration of 'module_i2c_driver' [-Werror=implicit-int]
> sound/soc/codecs/rt5682.c:3716:1: warning: parameter names (without types) in function declaration
> sound/soc/codecs/rt5682.c:3706:26: error: 'rt5682_i2c_driver' defined but not used [-Werror=unused-variable]
>   3706 | static struct i2c_driver rt5682_i2c_driver = {
>        |                          ^~~~~~~~~~~~~~~~~
> 
> Move the i2c specific entry points into an #ifdef section so
> it can actually be built standalone.
> 
> Fixes: 5549ea647997 ("ASoC: rt5682: fix unmet dependencies")

it's already fixed by [PATCH -next] ASoC: rt5682: Fix build error 
without CONFIG_I2C



