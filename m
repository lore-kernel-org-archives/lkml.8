Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBAAC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 17:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E669E207DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 17:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgHZRAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 13:00:19 -0400
Received: from mga06.intel.com ([134.134.136.31]:43102 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726745AbgHZRAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 13:00:17 -0400
IronPort-SDR: G3E16OhVHNcg63lZGo67r4fG4UXnRco4spt2NGTEz0LcQkbhBL1Qk/cw+WHIMxk4e44DIfpVrP
 9m0nZ5gmY+HA==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="217886456"
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="217886456"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 10:00:16 -0700
IronPort-SDR: 9r0Qvx3VEZeWklGWG5/T7Y6mQEQBgTNCLq7GNVIQ37d5n0hf3nXr7BdLATpWnMectnhj5Pf0QP
 XNcdGoFWQxBg==
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="336884978"
Received: from kberke-mobl1.amr.corp.intel.com (HELO [10.209.43.169]) ([10.209.43.169])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 10:00:14 -0700
Subject: Re: [PATCH v2 0/5] ASoC: Fix return check for devm_regmap_init_sdw()
To:     Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>
Cc:     Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org,
        Ryan Lee <ryans.lee@maximintegrated.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Shuming Fan <shumingf@realtek.com>,
        Naveen Manohar <naveen.m@intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
References: <20200826163340.3249608-1-vkoul@kernel.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <5a7f6edc-3eac-7603-35a2-71e85cfc0975@linux.intel.com>
Date:   Wed, 26 Aug 2020 12:00:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200826163340.3249608-1-vkoul@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/26/20 11:33 AM, Vinod Koul wrote:
> This series attempts to fix return check for devm_regmap_init_sdw()
> 
> Changes in v2:
>   - Add missing patch for rt711
>   - Add patch for rt700
> 
> Vinod Koul (5):
>    ASoC: max98373: Fix return check for devm_regmap_init_sdw()
>    ASoC: rt1308-sdw: Fix return check for devm_regmap_init_sdw()
>    ASoC: rt711: Fix return check for devm_regmap_init_sdw()
>    ASoC: rt715: Fix return check for devm_regmap_init_sdw()
>    ASoC: rt700: Fix return check for devm_regmap_init_sdw()

Thanks for the fix.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
