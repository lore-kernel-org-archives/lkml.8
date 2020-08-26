Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98133C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 01:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C7AE2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 01:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgHZBI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 21:08:26 -0400
Received: from mga03.intel.com ([134.134.136.65]:45708 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbgHZBIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 21:08:25 -0400
IronPort-SDR: y4WNCrgXqaTRWAUv4DoITo+oHm9p3/KZ7XmCy4ITA0nTRpWjcFZ3QleqZlSHPVRBxFPwPzT5ju
 nAQshSCzn2ow==
X-IronPort-AV: E=McAfee;i="6000,8403,9724"; a="156208253"
X-IronPort-AV: E=Sophos;i="5.76,354,1592895600"; 
   d="scan'208";a="156208253"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 18:04:46 -0700
IronPort-SDR: ZKh7M1XTZkWJpN4mbKxK1HrCXTXaxCvt64udGJHISyGNeGE0jtcREJbv8HH31lvJcWUdgK9geY
 WURSAr+d3grg==
X-IronPort-AV: E=Sophos;i="5.76,354,1592895600"; 
   d="scan'208";a="443834936"
Received: from yungchua-mobl.ccr.corp.intel.com (HELO [10.252.187.42]) ([10.252.187.42])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 18:04:43 -0700
Subject: Re: [PATCH 3/4] soundwire: SDCA: add helper macro to access controls
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org
Cc:     Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        tiwai@suse.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>, vkoul@kernel.org,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, slawomir.blauciak@intel.com,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
References: <20200825171656.75836-1-pierre-louis.bossart@linux.intel.com>
 <20200825171656.75836-4-pierre-louis.bossart@linux.intel.com>
From:   Bard liao <yung-chuan.liao@linux.intel.com>
Message-ID: <e705b622-5505-51ac-cbf2-cb3c6f317f2c@linux.intel.com>
Date:   Wed, 26 Aug 2020 09:04:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200825171656.75836-4-pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/26/2020 1:16 AM, Pierre-Louis Bossart wrote:
> The upcoming SDCA (SoundWire Device Class Audio) specification defines
> a hierarchical encoding to interface with Class-defined capabilities.
>
> The specification is not yet accessible to the general public but this
> information is released with explicit permission from the MIPI Board
> to avoid delays with SDCA support on Linux platforms.
>
> A block of 64 MBytes of register addresses are allocated to SDCA
> controls, starting at address 0x40000000. The 26 LSBs which identify
> individual controls are set based on the following variables:
>
> - Function Number. An SCDA device can be split in up to 8 independent
>    Functions. Each of these Functions is described in the SDCA
>    specification, e.g. Smart Amplifier, Smart Microphone, Simple
>    Microphone, Jack codec, HID, etc.
>
> - Entity Number.  Within each Function,  an Entity is  an identifiable
>    block.  Up   to  127  Entities   are  connected  in   a  pre-defined
>    graph  (similar to  USB), with  Entity0 reserved  for Function-level
>    configurations.  In  contrast  to  USB, the  SDCA  spec  pre-defines
>    Function Types, topologies, and allowed  options, i.e. the degree of
>    freedom  is not  unlimited to  limit  the possibility  of errors  in
>    descriptors leading to software quirks.
>
> - Control Selector. Within each Entity, the SDCA specification defines
>    48 controls such as Mute, Gain, AGC, etc, and 16 implementation
>    defined ones. Some Control Selectors might be used for low-level
>    platform setup, and other exposed to applications and users. Note
>    that the same Control Selector capability, e.g. Latency control,
>    might be located at different offsets in different entities, the
>    Control Selector mapping is Entity-specific.
>
> - Control Number. Some Control Selectors allow channel-specific values
>    to be set, with up to 64 channels allowed. This is mostly used for
>    volume control.
>
> - Current/Next values. Some Control Selectors are
>    'Dual-Ranked'. Software may either update the Current value directly
>    for immediate effect. Alternatively, software may write into the
>    'Next' values and update the SoundWire 1.2 'Commit Groups' register
>    to copy 'Next' values into 'Current' ones in a synchronized
>    manner. This is different from bank switching which is typically
>    used to change the bus configuration only.
>
> - MBQ. the Multi-Byte Quantity bit is used to provide atomic updates
>    when accessing more that one byte, for example a 16-bit volume
>    control would be updated consistently, the intermediate values
>    mixing old MSB with new LSB are not applied.
>
> These 6 parameters are used to build a 32-bit address to access the
> desired Controls. Because of address range, paging is required, but
> the most often used parameter values are placed in the lower 16 bits
> of the address. This helps to keep the paging registers constant while
> updating Controls for a specific Device/Function.
>
> Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
> Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
> Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Acked-by: Bard Liao <yung-chuan.liao@linux.intel.com>


