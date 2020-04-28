Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B15C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 22:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B0932072A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 22:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgD1WPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 18:15:49 -0400
Received: from mga18.intel.com ([134.134.136.126]:26457 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbgD1WPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 18:15:49 -0400
IronPort-SDR: QXDiYcWFGOR6StZHNbw/Rqk1qJoNGY6rWV+iMOFpuFrsF2vygLmKfzLza9scJvXtyD6UxB8ny6
 4npapGxDhJGQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2020 15:15:48 -0700
IronPort-SDR: eRV6iaBNmKKuN9h0cUBLeme0Sl6sh7Bxij2kPN/7HSwyuHGDVtHBvl9TUo5UT2VOlL6q4wkR8Y
 IizTU+otdEww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,328,1583222400"; 
   d="scan'208";a="249293993"
Received: from asehgal-mobl.amr.corp.intel.com (HELO [10.254.29.183]) ([10.254.29.183])
  by fmsmga008.fm.intel.com with ESMTP; 28 Apr 2020 15:15:41 -0700
Subject: Re: [PATCH] ASoC: SOF: sort out Kconfig, again
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Fabio Estevam <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Takashi Iwai <tiwai@suse.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        sound-open-firmware@alsa-project.org
References: <20200428212752.2901778-1-arnd@arndb.de>
 <6b39fbba-c65d-2c02-14bf-11c2d00547af@linux.intel.com>
 <CAK8P3a24whg2RhJE3Vf5u3EWy+wvFqhXdp7EQZuQx0shPsMARw@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <f91c9a68-7641-beb8-a23e-bd1b9b8d0acb@linux.intel.com>
Date:   Tue, 28 Apr 2020 17:15:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a24whg2RhJE3Vf5u3EWy+wvFqhXdp7EQZuQx0shPsMARw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




>> Thanks Arnd, do you mind sharing your config?
> 
> https://pastebin.com/HRX5xi3R

will give it a try, thanks!

>> We noticed last week that
>> there's a depend/select confusion might be simpler to fix, see
>> https://github.com/thesofproject/linux/pull/2047/commits
>>
>> If I look at the first line I see a IMX_DSP=n which looks exactly like
>> what we wanted to fix.
> 
> Yes, I think that fix addresses the build warning as well, but looking
> more closely I don't think it's what you want: If you do this on
> a config that has the IMX_DSP disabled, it would appear to the
> user that you have enabled the drivers, but the actual code is still
> disabled.

Are you sure? we added a select IMX_DSP, so not sure how it can be disabled?
