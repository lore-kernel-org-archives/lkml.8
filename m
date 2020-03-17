Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55808C3F2CE
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33227206EC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbgCQLFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:05:15 -0400
Received: from mga05.intel.com ([192.55.52.43]:55060 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727440AbgCQLFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:05:09 -0400
IronPort-SDR: oqY6EKZMyPAD8CRE5Rrgw38ZEV+/Vh7NBPw8em52bb3eqC2rjWcsEBerCG6/j5RbvnqnqioybZ
 +XjdTC2MrGXA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 04:05:09 -0700
IronPort-SDR: bgfHtvH1a3H3Nhd/LyCgZIcuiaeiG022Nl/oQcRTlKJ75NNSMvbr4tUmFx/gdWLdhOY2c9BbuN
 UXBPXBfwKGxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,564,1574150400"; 
   d="scan'208";a="290962544"
Received: from dasabhi1-mobl.amr.corp.intel.com (HELO [10.255.35.148]) ([10.255.35.148])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Mar 2020 04:05:07 -0700
Subject: Re: [PATCH 0/2] ASoC: sdm845: fix soundwire stream handling
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, vkoul@kernel.org
References: <20200317095351.15582-1-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <a442a21e-47ce-f304-5bfb-06958d078a78@linux.intel.com>
Date:   Tue, 17 Mar 2020 06:05:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200317095351.15582-1-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

On 3/17/20 4:53 AM, Srinivas Kandagatla wrote:
> Recent addition of SoundWire stream state-machine checks in linux-next
> have shown an existing issue with handling soundwire streams in codec drivers.
> 
> In general soundwire stream prepare/enable/disable can be called from either
> codec/machine/controller driver. However calling it in codec driver means
> that if multiple instances(Left/Right speakers) of the same codec is
> connected to the same stream then it will endup calling stream
> prepare/enable/disable more than once. This will mess up the stream
> state-machine checks in the soundwire core.

That's a known issue that we've fixed on the Intel side a  month or two 
ago. Unfortunately the review cycle is so slow that you don't benefit 
immediately from our fixes, what can I say.

> Moving this stream handling to machine driver would fix this issue
> and also allow board/platform specfic power sequencing.

It's fine but that's unnecessary, and if you start having multiple 
machine drivers with the same codecs you'll duplicate the stream 
handling code.

All you need to ensure in a multi-codec or multi-cpu dai case is that 
the stream is allocated once, and yes that's typically done as part of 
the dailink .startup callback.

Then it's fine to call the stream prepare or enable multiple times from 
the individual dai level, and only do the transition for the first call.

See patch "soundwire: stream: only change state if needed" that I just 
shared. We've used it both in 'TDM' mode with two codecs hanging off of 
the same link and in 'aggregated' mode with two codecs on separate links.


> Srinivas Kandagatla (2):
>    ASoC: qcom: sdm845: handle soundwire stream
>    ASoC: codecs: wsa881x: remove soundwire stream handling
> 
>   sound/soc/codecs/wsa881x.c | 44 +-----------------------
>   sound/soc/qcom/Kconfig     |  2 +-
>   sound/soc/qcom/sdm845.c    | 69 ++++++++++++++++++++++++++++++++++++++
>   3 files changed, 71 insertions(+), 44 deletions(-)
> 
