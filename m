Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95085C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 15:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 731DC2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 15:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729919AbgG3Poy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 11:44:54 -0400
Received: from mga01.intel.com ([192.55.52.88]:64857 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729484AbgG3Pox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 11:44:53 -0400
IronPort-SDR: TIR6l2DGrofJF3PaleNR+Vt77Ae4qR4Cdp4TlpZruvf2aPV75wDaAgQoHvBoAr5eXt5bWYm4a2
 uV6cgeXNVPQg==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="169741992"
X-IronPort-AV: E=Sophos;i="5.75,414,1589266800"; 
   d="scan'208";a="169741992"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2020 08:44:52 -0700
IronPort-SDR: BaDDVqq1GqCh5P3//G0SQJkoDZ+wJwOxaBVXR86DpT6KgejRLnM2kmkD5ysie2SG0I1YNg4Dog
 CTWy6xxIrUcw==
X-IronPort-AV: E=Sophos;i="5.75,414,1589266800"; 
   d="scan'208";a="465284728"
Received: from jrwang2-mobl.amr.corp.intel.com (HELO [10.212.82.25]) ([10.212.82.25])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2020 08:44:49 -0700
Subject: Re: [PATCH 2/2] ASoC: Intel: Add period size constraint on strago
 board
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     "Lu, Brent" <brent.lu@intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Sam McNally <sammc@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Stuart <daniel.stuart14@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Damian van Soelen <dj.vsoelen@gmail.com>
References: <1596020585-11517-1-git-send-email-brent.lu@intel.com>
 <1596020585-11517-3-git-send-email-brent.lu@intel.com>
 <4fe97f63-e552-3b2f-803c-53894b196bfd@linux.intel.com>
 <DM6PR11MB36421D9A808D401416B72D2D97710@DM6PR11MB3642.namprd11.prod.outlook.com>
 <f1386a05-8866-9251-c751-21c9109aa35f@linux.intel.com>
Message-ID: <c00c47ad-abd7-d6e7-e3c5-a25a6a4f7f68@linux.intel.com>
Date:   Thu, 30 Jul 2020 10:44:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f1386a05-8866-9251-c751-21c9109aa35f@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/30/20 10:27 AM, Pierre-Louis Bossart wrote:
> 
> 
>>> Is this patch required if you've already constrained the period sizes 
>>> for the
>>> platform driver in patch1?
>>
>> Yes or alsa will select 320 as default period size for it.
> 
> ok, then that's a miss in your patch1. 320 samples is a multiple of 1ms 

typo: is NOT

> for 48kHz rates. I think it was valid only for the 16kHz VoIP paths used 
> in some versions of Android, but that we don't support in the upstream 
> code.
> 
> To build on Takashi's answer, the real ask here is to require that the 
> period be a multiple of 1ms, because that's the fundamental 
> design/limitation of firmware. It doesn't matter if it's 48, 96, 192, 
> 240, 480, 960 samples.
