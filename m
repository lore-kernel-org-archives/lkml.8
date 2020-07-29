Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67196C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 20:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51CFE2075D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 20:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgG2UhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 16:37:12 -0400
Received: from mga01.intel.com ([192.55.52.88]:10803 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726816AbgG2UhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 16:37:11 -0400
IronPort-SDR: 9eACnjcFibkWVksOgqqAU1yDFQmiMD7NWfqNVuMNbwSA9iywWFd8ktUe7RzD5vG8Yyw4nLcEwq
 jEXG0eqkuBlA==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="169618237"
X-IronPort-AV: E=Sophos;i="5.75,411,1589266800"; 
   d="scan'208";a="169618237"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2020 13:37:09 -0700
IronPort-SDR: AhBbttFInNRymbG7AeDpgZHAm401upJ2/B9J015ZQnLat1qHHvuQgZIhOq1EzVdM9qTLTLovj3
 fodJr0dxeIpA==
X-IronPort-AV: E=Sophos;i="5.75,411,1589266800"; 
   d="scan'208";a="464991564"
Received: from jayeshpa-mobl1.amr.corp.intel.com (HELO [10.209.169.93]) ([10.209.169.93])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2020 13:37:07 -0700
Subject: Re: [PATCH 2/2] ASoC: Intel: Add period size constraint on strago
 board
To:     Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
Cc:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Sam McNally <sammc@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Daniel Stuart <daniel.stuart14@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Damian van Soelen <dj.vsoelen@gmail.com>
References: <1596020585-11517-1-git-send-email-brent.lu@intel.com>
 <1596020585-11517-3-git-send-email-brent.lu@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <4fe97f63-e552-3b2f-803c-53894b196bfd@linux.intel.com>
Date:   Wed, 29 Jul 2020 09:08:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1596020585-11517-3-git-send-email-brent.lu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/29/20 6:03 AM, Brent Lu wrote:
> From: Yu-Hsuan Hsu <yuhsuan@chromium.org>
> 
> The CRAS server does not set the period size in hw_param so ALSA will
> calculate a value for period size which is based on the buffer size
> and other parameters. The value may not always be aligned with Atom's
> dsp design so a constraint is added to make sure the board always has
> a good value.
> 
> Cyan uses chtmax98090 and others(banon, celes, edgar, kefka...) use
> rt5650.

Is this patch required if you've already constrained the period sizes 
for the platform driver in patch1?

