Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635ADC47409
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 03:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B1BC2467E
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 03:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="SephaeDI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sZcjFg93"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgBODTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 22:19:54 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:60643 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727705AbgBODTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 22:19:54 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 096096D88;
        Fri, 14 Feb 2020 22:19:53 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 14 Feb 2020 22:19:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=y
        N2wari2ivX75m26fu/oSYka7THUtcpfjjkTTPAHPEE=; b=SephaeDI1Ip0QZuBm
        UGpm1CDV5osgS67egR/iVM70TqKGNcKnmqAKDYhyA2bv8zqZNJ9YXdrz6KPjl/PR
        xu8Xka831+AZRsv79vKCy+P5kASenm+MOaSrzgxwPNYPCXvgHt22VtMHQTT/pAF0
        wBRXSPpsULHqPUCNYrD6k9b0xas0WQTjCqKaJoOcZ7TSptmZBm+PbaT//jsxFfO2
        A2eUNrqRpFFEOEnYBFU0IU48V6oYFGZP0x4ij7KA18L2QjNqj4+mE/KaSzxqTs6c
        fJu+5EPyhszbZUXhAbGS5Y0rmM3Q5Qcbe5lo/YkUUPKwmjL2G0AVesnUFD8HqAIp
        Qdc+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=yN2wari2ivX75m26fu/oSYka7THUtcpfjjkTTPAHP
        EE=; b=sZcjFg93NS+Zp/mZ1oZhZjyS/JHwNCQM4aHNgHP1Etmr3VL9twfF6oxSE
        cwS9vm5ij4eraGQ8CWb5SakWSKN1j+z1yb1yslvzEil48Y6hJYOGgejKS1tXolde
        BAtgbtXLHBo7noYO4MurFTi2pkF6a+OLlZ11mIpbc+vnApZPHX7Mcei2uL94mkMh
        J+yr7X8ddHoGSgm6tNwNEo229y1mc25lHDl6JuyD9BA3JE9gwEsWqzWEbdAJlLLg
        /OABUaEZ+Bmy4T2IzUIC0GbAKJ98NcWvdwLhgms35p6ilzboQi1MchLiNMipVwjY
        gkFOCYUWtw+j3Cgz0qoaDrFQeot3Q==
X-ME-Sender: <xms:WGNHXrbDFBUwZKF-AquIobiLz8LwhPWwLbjPyv0IW5R2mFLQzwQlhA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjedugdehjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:WGNHXmnGb9ADW47BAzei83fKYHskr1IwlEixVmBlUOaC9DAyo7tADg>
    <xmx:WGNHXg2HRJ3Xd_ghFR1YiePtqG5fLzTJPw9xIaCg0E3Zf0h_O3-tcg>
    <xmx:WGNHXgQxgyngIgx4oMvtQuXVZZfUX0W5OvcIGmQU7RsuQGcdF4oWjg>
    <xmx:WWNHXj3WcfFfPUEw4QeZp1WMl_FQjYQajQaKPKMTFdP9k6FyK-U8ow>
Received: from [192.168.50.169] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8483A3060C21;
        Fri, 14 Feb 2020 22:19:51 -0500 (EST)
Subject: Re: [PATCH 2/4] ALSA: pcm: Make snd_pcm_limit_hw_rates take hw
 directly
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jerome Brunet <jbrunet@baylibre.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20200213061147.29386-1-samuel@sholland.org>
 <20200213061147.29386-3-samuel@sholland.org> <s5ha75nyp6v.wl-tiwai@suse.de>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <f443a53e-e214-481f-fe9c-6fe480d91292@sholland.org>
Date:   Fri, 14 Feb 2020 21:19:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <s5ha75nyp6v.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/20 12:30 AM, Takashi Iwai wrote:
> On Thu, 13 Feb 2020 07:11:45 +0100,
> Samuel Holland wrote:
>>
>> It can be useful to derive min/max rates of a snd_pcm_hardware without
>> having a snd_pcm_runtime, such as before constructing an ASoC DAI link.
>>
>> Since snd_pcm_limit_hw_rates only uses runtime->hw, it does not actually
>> need the snd_pcm_runtime. Modify it to take a pointer to hw directly.
> 
> I prefer adding a new function and change snd_pcm_limit_hw_rates() to
> static inline just calling the new one with &runtime->hw, instead of
> touching so many callers site.

I agree. I will definitely do that for v2.

Thanks,
Samuel

> thanks,
> 
> Takashi
> 
>>
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
