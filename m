Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624C8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4585820772
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729243AbgGHNGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 09:06:31 -0400
Received: from mga17.intel.com ([192.55.52.151]:52885 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728677AbgGHNGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 09:06:31 -0400
IronPort-SDR: IcDcEqQvdnqjpkT3TfhxldoXxc1KeFpSZUM6fy/3SYAymJf5r4AD3qPKlM+AwrwHAlXHVcruIz
 wNCxQ2lVqNjw==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="127868589"
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="127868589"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 06:06:31 -0700
IronPort-SDR: P5qtq4WPAKu4Jcv7EbkTrZYVMsTvHhoAMjb7Hcm8yODViPeHgSoGywF3dW4kqb/58IvCXubQ3O
 wc9ryDf15Pow==
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="323873323"
Received: from sare-mobl.amr.corp.intel.com (HELO [10.251.7.246]) ([10.251.7.246])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 06:06:30 -0700
Subject: Re: [PATCH] regmap: add missing dependency on SoundWire
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org,
        "open list:REGISTER MAP ABSTRACTION" <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20200707202628.113142-1-pierre-louis.bossart@linux.intel.com>
 <20200708071428.GA353107@kroah.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <dda765be-b252-98ff-f339-f226a42f4093@linux.intel.com>
Date:   Wed, 8 Jul 2020 08:06:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200708071428.GA353107@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/8/20 2:14 AM, Greg Kroah-Hartman wrote:
> On Tue, Jul 07, 2020 at 03:26:28PM -0500, Pierre-Louis Bossart wrote:
>> CONFIG_REGMAP is not selected when no other serial bus is supported.
>> It's largely academic since CONFIG_I2C is usually selected e.g. by
>> DRM, but still this can break randconfig so let's be explicit.
>>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>>   drivers/base/regmap/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/regmap/Kconfig b/drivers/base/regmap/Kconfig
>> index 0fd6f97ee523..1d1d26b0d279 100644
>> --- a/drivers/base/regmap/Kconfig
>> +++ b/drivers/base/regmap/Kconfig
>> @@ -4,7 +4,7 @@
>>   # subsystems should select the appropriate symbols.
>>   
>>   config REGMAP
>> -	default y if (REGMAP_I2C || REGMAP_SPI || REGMAP_SPMI || REGMAP_W1 || REGMAP_AC97 || REGMAP_MMIO || REGMAP_IRQ || REGMAP_SCCB || REGMAP_I3C)
>> +	default y if (REGMAP_I2C || REGMAP_SPI || REGMAP_SPMI || REGMAP_W1 || REGMAP_AC97 || REGMAP_MMIO || REGMAP_IRQ || REGMAP_SOUNDWIRE || REGMAP_SCCB || REGMAP_I3C)
> 
> Any reason you didn't add it to the end of the list instead of adding it
> to the middle?

yes, I followed the config order in the same file:

grep config Kconfig
config REGMAP
config REGCACHE_COMPRESSED
config REGMAP_AC97
config REGMAP_I2C
config REGMAP_SLIMBUS
config REGMAP_SPI
config REGMAP_SPMI
config REGMAP_W1
config REGMAP_MMIO
config REGMAP_IRQ
config REGMAP_SOUNDWIRE
config REGMAP_SCCB
config REGMAP_I3C
