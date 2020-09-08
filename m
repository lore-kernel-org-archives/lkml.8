Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC49BC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26FFF2098B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="nCSLpNb+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731283AbgIHTjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:39:08 -0400
Received: from mail1.perex.cz ([77.48.224.245]:41508 "EHLO mail1.perex.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730951AbgIHPzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:55:36 -0400
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 74EBDA003F;
        Tue,  8 Sep 2020 14:05:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 74EBDA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1599566727; bh=9b5Fqq5fU5wOYJ08GzQClBq0X5a2Ysj/PnRr3hJV/Bc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=nCSLpNb+FHy8GvG62T86k1W+ona5zG0+IxqnC3fhMaBBcNgEzZcEH/DgVCNc7N0Y9
         a7Wq5U1Gbje/+2hPO1vHYBMustZQq8fhy00UaKVidmRWis5Q/4QiEkkwZsuVVxMB+f
         ZlkzkKw6BnpkO79CL00Q0fyMshTh0oz9kaHov2Io=
Received: from p1gen2.perex-int.cz (unknown [192.168.100.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Tue,  8 Sep 2020 14:05:11 +0200 (CEST)
Subject: Re: [PATCH 1/7] soundwire: bus: use property to set interrupt masks
To:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>, broonie@kernel.org
Cc:     pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        tiwai@suse.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, srinivas.kandagatla@linaro.org,
        jank@cadence.com, mengdong.lin@intel.com, sanyog.r.kale@intel.com,
        rander.wang@linux.intel.com, bard.liao@intel.com
References: <20200818140656.29014-1-yung-chuan.liao@linux.intel.com>
 <20200818140656.29014-2-yung-chuan.liao@linux.intel.com>
 <20200828065125.GI2639@vkoul-mobl>
From:   Jaroslav Kysela <perex@perex.cz>
Message-ID: <ec5fe867-f2e4-4278-0376-e54bcdd7f94d@perex.cz>
Date:   Tue, 8 Sep 2020 14:05:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200828065125.GI2639@vkoul-mobl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne 28. 08. 20 v 8:51 Vinod Koul napsal(a):
> Hi Mark,
> 
> On 18-08-20, 22:06, Bard Liao wrote:
>> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>>
>> Add a slave-level property and program the SCP_INT1_MASK as desired by
>> the codec driver. Since there is no DisCo property this has to be an
>> implementation-specific firmware property or hard-coded in the driver.
>>
>> The only functionality change is that implementation-defined
>> interrupts are no longer set for amplifiers - those interrupts are
>> typically for jack detection or acoustic event detection/hotwording.
>>
>> Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
>> Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
>> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
>> ---
>>  drivers/soundwire/bus.c         | 12 ++++++------
>>  include/linux/soundwire/sdw.h   |  2 ++
>>  sound/soc/codecs/max98373-sdw.c |  3 +++
>>  sound/soc/codecs/rt1308-sdw.c   |  2 ++
>>  sound/soc/codecs/rt5682-sdw.c   |  4 ++++
>>  sound/soc/codecs/rt700-sdw.c    |  4 ++++
>>  sound/soc/codecs/rt711-sdw.c    |  4 ++++
>>  sound/soc/codecs/rt715-sdw.c    |  4 ++++
>>  sound/soc/codecs/wsa881x.c      |  1 +
> 
> This touches codecs, can you Ack it please

Mark, could you ack the ASoC change to accept this patch via the soundwire repo?

> 
> Ideally this should have been split up to header, the codec updates and
> finally the bus change!

I don't think that the split is ideal in this case. I tested the code and it
looks straight enough.

Acked-by: Jaroslav Kysela <perex@perex.cz>

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
