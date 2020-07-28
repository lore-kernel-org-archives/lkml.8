Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEB7C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D48FB206D8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729329AbgG1MSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 08:18:30 -0400
Received: from mga03.intel.com ([134.134.136.65]:11199 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728846AbgG1MS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:18:26 -0400
IronPort-SDR: 0m+YyNqtoVQrnSGCg8HR/mwiEpwUGL2Q2x2jUBs35CJuhJcPLOjnxB73/IOD51LhXCwcAjZk9u
 xU4Ath4jKPsw==
X-IronPort-AV: E=McAfee;i="6000,8403,9695"; a="151182775"
X-IronPort-AV: E=Sophos;i="5.75,406,1589266800"; 
   d="scan'208";a="151182775"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2020 05:18:24 -0700
IronPort-SDR: a8UodahD6j6XK60cgHegeoyLiYxT2aRBRzuPKFtuVsSmnRHmoSDfkIPOm0QMST2rd8K7Pegr44
 Pf2+TD9hM6zw==
X-IronPort-AV: E=Sophos;i="5.75,406,1589266800"; 
   d="scan'208";a="312597141"
Received: from caradool-mobl.amr.corp.intel.com (HELO [10.251.24.77]) ([10.251.24.77])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2020 05:18:23 -0700
Subject: Re: [PATCH 3/6] ASoC: amd: SND_SOC_RT5682_I2C does not build rt5682
To:     Mark Brown <broonie@kernel.org>,
        "RAVULAPATI, VISHNU VARDHAN RAO" 
        <Vishnuvardhanrao.Ravulapati@amd.com>
Cc:     "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, Arnd Bergmann <arnd@arndb.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Takashi Iwai <tiwai@suse.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
References: <20200727145840.25142-1-Vishnuvardhanrao.Ravulapati@amd.com>
 <20200727145840.25142-3-Vishnuvardhanrao.Ravulapati@amd.com>
 <c467e2ee-727d-4bf5-8ceb-90c784245a43@linux.intel.com>
 <20200727160941.GE6275@sirena.org.uk>
 <DM5PR1201MB01393D93D69F1552408BFE79E7730@DM5PR1201MB0139.namprd12.prod.outlook.com>
 <20200728120700.GA5055@sirena.org.uk>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <44e86246-516f-3a32-af66-e1c23f560e77@linux.intel.com>
Date:   Tue, 28 Jul 2020 07:18:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728120700.GA5055@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/28/20 7:07 AM, Mark Brown wrote:
> On Tue, Jul 28, 2020 at 06:59:50AM +0000, RAVULAPATI, VISHNU VARDHAN RAO wrote:
> 
>> So Actually for rt5682 codec Now in 5.8 there are three flags :
>> SND_SOC_RT5682
>> SND_SOC_RT5682_I2C
>> SND_SOC_RT5682_SDW
> 
>> But till 5.7.8 we have
>> SND_SOC_RT5682
>> SND_SOC_RT5682_SDW
> 
>> So in our design we were using SND_SOC_RT5682 which build snd_soc_rt5682.ko
>> Creates the respective codec_dais as defined in that .ko
> 
>> If we use SND_SOC_RT5682_I2C we get snd_soc_rt5682_I2c.ko , it is not creating the expected codec_dai links.
> 
> Could you be more specific about the way in which "it is not creating
> the expected codec_dai links" please?  What are you expecting to happen
> and what happens instead?  Do you see any error messages for example?
> 
>> As there are three flags defined in codecs, I expect that previous one which we were using(SND_SOC_RT5682) is not a wrong flag and I expect to use
>> SND_SOC_RT5682 as it is still available.
> 
> Given that the core module does not register with any bus it is
> difficult to see how that could possibly work - the core module doesn't
> contain a driver at all.  Have you tested this change?

I share Mark's point. Have you tested this change on top of Mark's tree, 
or only on top of the stable kernel?
