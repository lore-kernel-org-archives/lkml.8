Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B125C4CECC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 20:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 048B6206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 20:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgD0UAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:00:46 -0400
Received: from mga18.intel.com ([134.134.136.126]:2770 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbgD0UAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 16:00:45 -0400
IronPort-SDR: PfijgNdUHcSx3LHfjH7W4Y5MKYky/SuzcUVvgsiEbxPCcMNS7YDwsircfSWebmwh5OdJSlvjDs
 fn4q2gDYUGjw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 13:00:44 -0700
IronPort-SDR: fDtLeEuP3sSVa4mdzkBv3R8A6qi93TSOKes1DtKZNN8Vm0Vc+BkZ8YybBpysPl6vVv0r90cxIR
 dKNt5Ylspu/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,325,1583222400"; 
   d="scan'208";a="281888165"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.213.7.127]) ([10.213.7.127])
  by fmsmga004.fm.intel.com with ESMTP; 27 Apr 2020 13:00:41 -0700
Subject: Re: [PATCH v2 0/3] add channel constraint for BDW machine drivers
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
References: <1588007614-25061-1-git-send-email-brent.lu@intel.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <4d4b8978-88b3-9d54-8812-85fe35456ead@intel.com>
Date:   Mon, 27 Apr 2020 22:00:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1588007614-25061-1-git-send-email-brent.lu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-27 19:13, Brent Lu wrote:
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
> 

Thank you for addressing all listed issues.
I'll recheck hw constraints on my end just to be sure but this series 
looks good already, so:

Acked-by: Cezary Rojewski <cezary.rojewski@intel.com>
