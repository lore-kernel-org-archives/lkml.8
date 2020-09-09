Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCA0C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 10:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 805F1215A4
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 10:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=axis.com header.i=@axis.com header.b="CSlLrAx2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbgIIKHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 06:07:03 -0400
Received: from smtp1.axis.com ([195.60.68.17]:3045 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbgIIKHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 06:07:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=1544; q=dns/txt; s=axis-central1;
  t=1599646019; x=1631182019;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=IGajUZBa96i/VzPEy7tge28b46RvbWFmOz5Ue/tcm4k=;
  b=CSlLrAx2FnSv1gOENiLBW+7a8+vlz+08AlkCubK+J/LfmXw4DxmO5nIe
   ItFZGEwF5zfx3ScjvLA6MgRh8A8HEgkGJ/kGcjoYkKx1KGnQdrX3kQctv
   CbYU5oFpdrH+VQYJB1mi5hx7/VkAyRjEOKMRsdsZGyEe4uUuuLasm4+c+
   3IHilHuxwa97zvTuBp9wEIGwwcY7RxklPT6L1bCEoM46+w2KDV2N8uf+c
   c+8BWz6ioACeqg176KSOGg9wKh1G5o/f2qmaQmJmS1Hu2UUdcVnkSn/TC
   RAv5fs5zx0iqPBqgQoH+ae8jko0JdXlLtC+CEt9OfWI9hszbU8BXyZZ00
   g==;
IronPort-SDR: /6mEj/gzoUQOdYQvxHD9rdzrF/U/w0nRti7xCvCa1CGoHSfjobjC2E6ngngkG8YM7jSwtZrhvF
 gbkQ1bBMkkIT32d4YHABLl+N28FpDJIxOwbaVUFDV+NiAimefjat8q4xjPTBgGqhkJmrqHBP4e
 pq04iV3tqDus6jidBge+AkEfIJqB5qe4gYwmN6dJuS/rHLN9QaProaE5eUujwXdbtT/B0mMtNS
 i013/ggzub0/hLT48WByU3EBuyvfNecGRFY7aZNBaZq0wCeQC5XyOLdzzz6SgG5vS0jpD2Lrh2
 x6w=
X-IronPort-AV: E=Sophos;i="5.76,409,1592863200"; 
   d="scan'208";a="12709791"
Subject: Re: [PATCH 1/2] ASoC: tlv320adcx140: Avoid accessing invalid
 gpio_reset
To:     Mark Brown <broonie@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "dmurphy@ti.com" <dmurphy@ti.com>, Camel Guo <Camel.Guo@axis.com>,
        "tiwai@suse.com" <tiwai@suse.com>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@axis.com>
References: <20200908083521.14105-1-camel.guo@axis.com>
 <159958562064.16576.7853800514030717096.b4-ty@kernel.org>
From:   Camel Guo <camelg@axis.com>
Message-ID: <1e17f203-7b60-bf97-4515-937e722f5ef7@axis.com>
Date:   Wed, 9 Sep 2020 12:06:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <159958562064.16576.7853800514030717096.b4-ty@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: XBOX04.axis.com (10.0.5.18) To xbox06.axis.com
 (10.0.15.176)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark

On 9/8/20 7:20 PM, Mark Brown wrote:
> On Tue, 8 Sep 2020 10:35:20 +0200, Camel Guo wrote:
>> When gpio_reset is not well defined in devicetree, the
>> adcx140->gpio_reset is an error code instead of NULL. In this case,
>> adcx140->gpio_reset should not be used by adcx140_reset. This commit
>> sets it NULL to avoid accessing an invalid variable.
> 
> Applied to
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

I think it is "ASoC: tlv320adcx140: Wake up codec before register 
setting" that is applied to for next not this one.

> 
> Thanks!
> 
> [1/1] ASoC: tlv320adcx140: Wake up codec before accessing register
>        commit: 1a5ce48fd667128e369fdc7fb87e21539aed21b5
> 
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
> 
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
> 
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
> 
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
> 
> Thanks,
> Mark
