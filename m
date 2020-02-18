Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C01C34031
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 01:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D4EB206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 01:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="fey7V777";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2Z0CbNrX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgBRBzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 20:55:07 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:46325 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726171AbgBRBzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 20:55:06 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id C6BE96244;
        Mon, 17 Feb 2020 20:55:05 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 17 Feb 2020 20:55:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm2; bh=e
        YnIVvK0q9JrGCRBjZx29b4zt5fQgH9zuyMH2krGX/Q=; b=fey7V7774/zbe/0yv
        b3XBejwmgGycVWMsDRgzIdvJyKIIot5v/YayVFxJYkAWynzfkZZi7c40XaSHH679
        kEvUyvFr19eynPZ3uqtY/C5F9R1YLjOqSSuSKOuxLcqi3Tlf/ydffffSZPDDTOdJ
        hbQDU+pkgxYGXNPb4M8PGqc13sEKgPyz6hdZfv49e7ZWbiNkDKDqQHd0vQ7F8JVJ
        LLoP2AFIT8uE69d6ozHP7gFbENWz2QM6LVBfWhnlYwPI1boJCNIdz5/HoArm18E0
        aWlAzmLQ/5zjeZMnLx5ly377rusi7rPSQET/6IDgclbcb5CIm1WuBBw29bVLarYr
        6uQIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=eYnIVvK0q9JrGCRBjZx29b4zt5fQgH9zuyMH2krGX
        /Q=; b=2Z0CbNrXiu1UkDc7K9uMUkCp+5FJWshYrl+YnFiUKBX8LCjzt4JrlkqPV
        U1itbYE8ERgzokozGP4ZXvoJX1QYKHlYLfQtYUMyBgb9Kw2doshmw5mPP9KECg7f
        J9OctR7gPuxWGXEtHMEiE2MDtEaqx0a1h3roC/ZJnqqGMHJv+uZXv3RWBU6XkC0Q
        sA/29i59E0IopUJvuXr/l7nGL4JSn5XxOeN1+9G+deKW+hKcg5RCBecaO/vmMTEB
        2deM4Dh3BN7uUW/yccDWq9wxSGwJSlrSbLPrvwtKUtXiH3JujWd2BEiHXWSRKNM1
        +rBq+KlB1mgHQccXLH8/s+V19aHEw==
X-ME-Sender: <xms:-ENLXp_TURkjTpR1RT4Js6KNp2HxmdctwrZOvbRh59H5JkMNlTgarw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjeejgdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:-ENLXh_qsOVkH-W6KKjsXtdJDWnLWtdjRV58uk-Od9QiX8xVGA4WLg>
    <xmx:-ENLXiB26jZx2AygWC6W1A_zibyhp3hQLRerTwEkV7Uicc3MmsDqTA>
    <xmx:-ENLXhwVdLwMfn9aPDPiaGXaT7cdsrumBN7K00Ou3C36KXtZg8Qkcw>
    <xmx:-UNLXl4A6RAavdbkjdnZFSp2Jwo4x64JEHr3dc0qO6XsEBP8mGyEzw>
Received: from [192.168.50.169] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id EBF8B3060C28;
        Mon, 17 Feb 2020 20:55:03 -0500 (EST)
Subject: Re: [RFC PATCH 10/34] ASoC: sun8i-codec: Advertise only
 hardware-supported rates
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20200217064250.15516-1-samuel@sholland.org>
 <20200217064250.15516-11-samuel@sholland.org>
 <20200217153023.GL9304@sirena.org.uk>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <810f4889-d3ad-3b26-201c-0a237222c06c@sholland.org>
Date:   Mon, 17 Feb 2020 19:55:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200217153023.GL9304@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/20 9:30 AM, Mark Brown wrote:
> On Mon, Feb 17, 2020 at 12:42:26AM -0600, Samuel Holland wrote:
>> The hardware does not support 64kHz, 88.2kHz, or 176.4kHz sample rates,
>> so the driver should not advertise them. The hardware can handle two
>> additional non-standard sample rates: 12kHz and 24kHz, so declare
>> support for them via SNDRV_PCM_RATE_KNOT.
>>
>> Cc: stable@kernel.org
>> Fixes: 36c684936fae ("ASoC: Add sun8i digital audio codec")
>> Fixes: eda85d1fee05 ("ASoC: sun8i-codec: Add ADC support for a33")
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
> 
> The new sample rates are new functionality, they are definitely not
> stable material.   For the sample rates you are removing do we
> understand why they were added - do they work for people, are they
> perhaps supported for some users and not others for example?

I do not know why they were added, but the sample rates I removed do not work
today, for anyone.

The sample rate must be programmed into the hardware, and the removed sample
rates do not map to one of the possible register values, so
sun8i_codec_get_hw_rate(), and thus hw_params, will return -EINVAL if one of
them is used.
