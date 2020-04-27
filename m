Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A89C4CECC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 18:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DC4720B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 18:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgD0SuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 14:50:15 -0400
Received: from mga11.intel.com ([192.55.52.93]:1575 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726229AbgD0SuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 14:50:15 -0400
IronPort-SDR: Gb7TgvMnL59TXDtLjeBYtR9kV/DYh14hb4U58hYH1V5338xrVFOV9Kk8bEqyMMv+ZyroCFpUEY
 16JZbf56F46w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 11:50:14 -0700
IronPort-SDR: k6fGQjY5zDoVnhEwniGYbb5hHv7BMpYDJiTB4hMuK7siOIKOgQvYOh0kpULwb/lg/JW5wfE90S
 R6n1X0moitBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,325,1583222400"; 
   d="scan'208";a="281866779"
Received: from unknown (HELO [10.254.177.143]) ([10.254.177.143])
  by fmsmga004.fm.intel.com with ESMTP; 27 Apr 2020 11:50:14 -0700
Subject: Re: [PATCH v2 0/3] add channel constraint for BDW machine drivers
To:     Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
Cc:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Ben Zhang <benzh@chromium.org>,
        Mac Chiang <mac.chiang@intel.com>,
        Mark Brown <broonie@kernel.org>
References: <1588007614-25061-1-git-send-email-brent.lu@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <866ef71f-8794-558b-bd4d-c491ab4effc4@linux.intel.com>
Date:   Mon, 27 Apr 2020 12:59:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1588007614-25061-1-git-send-email-brent.lu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/27/20 12:13 PM, Brent Lu wrote:
> The machine driver bdw-rt5650 (for Google buddy) supports 2 or 4-channel
> recording while other two drivers support only 2-channel recording. HW
> constraints are implemented to reflect the hardware limitation on BDW
> platform.
> 
> Changes since v1:
> - Change the patch title.
> - Remove the DUAL_CHANNEL and QUAD_CHANNEL macros which are too obvious.
> - Follow the naming convertion, using 'bdw_rt5650_' and 'bdw_rt5677_' to
>    name startup functions.
> - Refine the comments in startup functions.
> - Redesign the bdw_rt5650_fe_startup() function for readability.
> - Add an assignment to initialize runtime->hw.channels_max variable.

For the series

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> Brent Lu (3):
>    ASoC: bdw-rt5677: add channel constraint
>    ASoC: bdw-rt5650: add channel constraint
>    ASoC: broadwell: add channel constraint
> 
>   sound/soc/intel/boards/bdw-rt5650.c | 29 +++++++++++++++++++++++++++++
>   sound/soc/intel/boards/bdw-rt5677.c | 26 ++++++++++++++++++++++++++
>   sound/soc/intel/boards/broadwell.c  | 26 ++++++++++++++++++++++++++
>   3 files changed, 81 insertions(+)
> 
