Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7828C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 11:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B74692063A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 11:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgD0LBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 07:01:19 -0400
Received: from mga01.intel.com ([192.55.52.88]:40725 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726504AbgD0LBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 07:01:18 -0400
IronPort-SDR: gq+ZXT1esErZxXnN2882pCdbo7+xEWANqlu3NWaBWe6/8GBZX2e4FLYD9yTEOVGWiAi6Ye3fQh
 K/nFmBX6npWg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 04:01:18 -0700
IronPort-SDR: MWGPKE2LfyupxpqM1+pDGLkX2OftspcC8m2J3vn7tkq7q2JkA04hpyxaogOBIZP6x4OOVTOT0g
 vQWWsRvS9LyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,323,1583222400"; 
   d="scan'208";a="302341415"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.213.7.127]) ([10.213.7.127])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Apr 2020 04:01:14 -0700
Subject: Re: [PATCH 0/3] add channel constraint for BDW machine drivers
To:     Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Ben Zhang <benzh@chromium.org>,
        Mac Chiang <mac.chiang@intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-kernel@vger.kernel.org
References: <1587976638-29806-1-git-send-email-brent.lu@intel.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <1375d0b1-fafa-95b5-9a06-eefb1897ca42@intel.com>
Date:   Mon, 27 Apr 2020 13:01:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1587976638-29806-1-git-send-email-brent.lu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-27 10:37, Brent Lu wrote:
> The machine driver bdw-rt5650 (for Google buddy) supports 2 or 4-channel
> recording while other two drivers support only 2-channel recording. HW
> constraints are implemented to reflect the hardware limitation on BDW
> platform.
> 

Message body relates to bdw-rt5650 while the series touches every of BDW 
boards.

Apart from review given for each and every patch (although most issues 
are shared so there is not as much to address) my question is:
- are these hw limitations or software (machine board) limitations?

Czarek

> Brent Lu (3):
>    ASoC: bdw-rt5677: channel constraint support
>    ASoC: bdw-rt5650: channel constraint support
>    ASoC: broadwell: channel constraint support
> 
>   sound/soc/intel/boards/bdw-rt5650.c | 34 ++++++++++++++++++++++++++++++++++
>   sound/soc/intel/boards/bdw-rt5677.c | 33 +++++++++++++++++++++++++++++++++
>   sound/soc/intel/boards/broadwell.c  | 33 +++++++++++++++++++++++++++++++++
>   3 files changed, 100 insertions(+)
> 
