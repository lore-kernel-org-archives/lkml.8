Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F66DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 15:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 437FD20729
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 15:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbgG0PcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 11:32:00 -0400
Received: from mga11.intel.com ([192.55.52.93]:15774 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730297AbgG0Pb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 11:31:59 -0400
IronPort-SDR: zr9c0HMWZ8XuiQkwoN2lj0hdNp/xeHFN1jQb9NEFvoqZnTCUgjKr3tVKiy1iTkbMBu6b/3GOLb
 vrIZot9UCM1A==
X-IronPort-AV: E=McAfee;i="6000,8403,9694"; a="148915970"
X-IronPort-AV: E=Sophos;i="5.75,402,1589266800"; 
   d="scan'208";a="148915970"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2020 08:31:59 -0700
IronPort-SDR: Kym2xbdqrRFyklcNQIA6wGe9KaMBLbQw4shEg/IB13YOgTm3UFBoLS/wxAhlBYTD01Izv8f6mk
 WgPFz2caVWGg==
X-IronPort-AV: E=Sophos;i="5.75,402,1589266800"; 
   d="scan'208";a="464099679"
Received: from pdewan-mobl1.amr.corp.intel.com (HELO [10.255.228.220]) ([10.255.228.220])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2020 08:31:58 -0700
Subject: Re: [PATCH v3 00/10] ASoC: qdsp6: add gapless compressed audio
 support
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org
Cc:     vkoul@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, ckeepax@opensource.cirrus.com
References: <20200727093806.17089-1-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <5f3e6f81-965e-d7e2-bd93-edb54f72e478@linux.intel.com>
Date:   Mon, 27 Jul 2020 10:24:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727093806.17089-1-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/27/20 4:37 AM, Srinivas Kandagatla wrote:
> This patchset adds gapless compressed audio support on q6asm.
> Gapless on q6asm is implemented using 2 streams in a single q6asm session.
> 
> First few patches such as stream id per each command, gapless flags
> and silence meta data are for preparedness for adding gapless support.
> Last patch implements copy callback to allow finer control over buffer offsets,
> specially in partial drain cases.
> 
> This patchset is tested on RB3 aka DB845c platform.
> 
> This patchset as it is will support gapless however QDSP can also
> support switching decoders on a single stream. Patches to support such feature
> are send in different patchset which involves adding generic interfaces.
> 
> Thanks,
> srini

I've run out of comments :-)

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> Changes since v2:(mostly suggested by Pierre)
> - removed unnessary kernel style comments,
> - moved TIMESTAMP flag to respective patch.
> - move preparatory code from gapless support patch to new one.
> - fix subject prefix of one patch.
> - add comments to clarify valid stream_ids
> 
> Srinivas Kandagatla (10):
>    ASoC: q6asm: rename misleading session id variable
>    ASoC: q6asm: make commands specific to streams
>    ASoC: q6asm: use flags directly from q6asm-dai
>    ASoC: q6asm: add length to write command token
>    ASoC: q6asm: add support to remove intial and trailing silence
>    ASoC: q6asm: add support to gapless flag in q6asm open
>    ASoC: q6asm-dai: add next track metadata support
>    ASoC: q6asm-dai: prepare set params to accept profile change
>    ASoC: q6asm-dai: add gapless support
>    ASoC: q6asm-dai: add support to copy callback
> 
>   sound/soc/qcom/qdsp6/q6asm-dai.c | 414 +++++++++++++++++++++++--------
>   sound/soc/qcom/qdsp6/q6asm.c     | 169 +++++++++----
>   sound/soc/qcom/qdsp6/q6asm.h     |  49 ++--
>   3 files changed, 469 insertions(+), 163 deletions(-)
> 
