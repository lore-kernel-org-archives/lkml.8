Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADF2C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AE532071C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgCRRJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 13:09:48 -0400
Received: from mga17.intel.com ([192.55.52.151]:47863 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726638AbgCRRJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 13:09:47 -0400
IronPort-SDR: OQNm875sGHGJo1GkhcBUt4PmbW5Fu3wp5uKCOlwkTS27mjLV3yK1Uwy2GDYGhTTBfgE0+2jJuh
 OhNhATXCcVXQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2020 10:09:47 -0700
IronPort-SDR: f481HSyPpRKmelyJY/WmmDt+1dK/TzPlXi0k4IiiQ42LSybYx8Elt3v99cWghv3fAev4dnIUPd
 sqTW+JHWkLTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,568,1574150400"; 
   d="scan'208";a="418019258"
Received: from nali1-mobl3.amr.corp.intel.com (HELO [10.255.33.194]) ([10.255.33.194])
  by orsmga005.jf.intel.com with ESMTP; 18 Mar 2020 10:09:45 -0700
Subject: Re: [PATCH 1/2] ASoC: qcom: sdm845: handle soundwire stream
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        linux-kernel@vger.kernel.org, vkoul@kernel.org
References: <20200317095351.15582-1-srinivas.kandagatla@linaro.org>
 <20200317095351.15582-2-srinivas.kandagatla@linaro.org>
 <8daeeb26-851b-8311-30f5-5d285ccbc255@linux.intel.com>
 <69c72f5a-e72e-b7b3-90cb-a7354dcb175d@linaro.org>
 <cbc6cc9b-24f5-8c2a-b60d-b5dab08c128e@linux.intel.com>
 <fcf845bd-9803-ab04-d2a9-c258ddfcc972@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <c8738ecf-727f-2063-8aa0-46fc1c338383@linux.intel.com>
Date:   Wed, 18 Mar 2020 11:53:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <fcf845bd-9803-ab04-d2a9-c258ddfcc972@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/18/20 10:57 AM, Srinivas Kandagatla wrote:
> 
> 
> On 18/03/2020 15:26, Pierre-Louis Bossart wrote:
>>
>> Same comment, how does the notion of cpu_dai come in the picture for a 
>> SoundWire dailink?
>> Would you mind listing what the components of the dailinks are?
> 
> dais that I was referring here are all codec dais from backend-dai.
> 
> Device tree entries from
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/qcom/sdm845-db845c.dts?h=next-20200318#n538 
> 
> 
> 
> Frontend-dai:
>      mm1-dai-link {
>          link-name = "MultiMedia1";
>          cpu {
>              sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA1>;
>          };
>      };
> 
> Backend-dai:
>      slim-dai-link {
>          link-name = "SLIM Playback";
>          cpu {
>              sound-dai = <&q6afedai SLIMBUS_0_RX>;
>          };
> 
>          platform {
>              sound-dai = <&q6routing>;
>          };
> 
>          codec {
>              sound-dai =  <&left_spkr>, <&right_spkr>, <&swm 0>, 
> <&wcd9340 0>;
>          };

Thanks, I didn't realize this and now understand your point.

I guess that means we've officially stretched the limits of the DPCM 
model though, lumping all codec dais from separate devices into the same 
'backend' doesn't seem like a very good path forward, we'd really need a 
notion of domain to represent such bridges.

For now for the series

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
