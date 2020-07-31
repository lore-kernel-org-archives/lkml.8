Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFDCC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 08:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A42D82074B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 08:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="paELUECn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731573AbgGaIGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 04:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731436AbgGaIGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 04:06:06 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDCFC061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 01:06:06 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id 88so27113662wrh.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 01:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=fucMGEr5CXFfOMcRe7EoTEOJr1Kr4QCI6uUDYVzs0gU=;
        b=paELUECntKBbuSCyCcBVLOaExS6IKoAliKkoF5FO2Vx4ae1xzSit3j2MPx+WVR+MVK
         zaZ97aVOzr+rKYKirG+gD6cR0v04FzDc6B5ygXWb1JXdKTzDsq1s8YL+kMqlPzHx+uYq
         bDPB70KKa6GlMjDvyz/4JdTWKHxlYVXB9+w7f4k3yTX722eL5WLL+5uMHaCXA9zx6Ujk
         E543xx2Kq/QfbljQhO9bln/Proogp8rAe1XWwfjZ3x9S3wHfY0u+gXUN8JSoUfrC1ORK
         wdXqXbDwIpZ6MS3sThUTAa6zbDEMedNXGowA0RrhSgs4Sd1aQcEIGXCkT3k7ztrH1PH8
         7B7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=fucMGEr5CXFfOMcRe7EoTEOJr1Kr4QCI6uUDYVzs0gU=;
        b=XF4AM5aSj45eLFsjlldt3o8b+7qHebEEk59sZ8jSZSQClA10H7pxlmvrN7sKGBs95e
         Eul9c9Q25qihPo2XUBfv53bPZb8sJ2jnNWM5yjxQiXD5HOZuTWw0k+mbQaezZfO82ssA
         BI3Mio68FovH8sYkQ4KP5ZzJaeYemGwwV14D2AinDzEx9pixxKMVkLCpFrMomTQ9CckA
         SR5kznh/urHJqvr/lIeHgB6622ZAyl4SSsPJEAZuPSNoygPaawNT/4lFLBxqLV8J8m4O
         sPT/Xetbz4rsMpOrQPorRujDnTFl+mPZ/sN4n7nNjtaviPiHksuoqz/1oOIABx58bZiQ
         YVmQ==
X-Gm-Message-State: AOAM532fm27UdQARsu3V6SgbXKRHeU++epAFUN/TDehbnbapipYSacCH
        o5PwQacqfb7N5HQOKLotn5ypqkVbWszYnA==
X-Google-Smtp-Source: ABdhPJzz8HoujDESE97UeMx7i6gLDYDp1lPxuV8yNkRjvFTZsrr0L0KA7Q2WsV9AlEgH/0FFtZL4Pw==
X-Received: by 2002:adf:9e90:: with SMTP id a16mr2541831wrf.40.1596182764941;
        Fri, 31 Jul 2020 01:06:04 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z63sm13311387wmb.2.2020.07.31.01.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 01:06:04 -0700 (PDT)
References: <20200723180533.220312-1-pierre-louis.bossart@linux.intel.com> <20200729154639.1983854-1-jbrunet@baylibre.com> <2ad13f95-434d-376a-bc38-b209623b461e@linux.intel.com> <1jft998jbe.fsf@starbuckisacylon.baylibre.com> <936d6e37-0ad0-b0d7-814a-1ace12087746@linux.intel.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     alsa-devel@alsa-project.org, Stephan Gerhold <stephan@gerhold.net>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, zhangn1985@outlook.com,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH] ASoC: core: restore dpcm flags semantics
In-reply-to: <936d6e37-0ad0-b0d7-814a-1ace12087746@linux.intel.com>
Date:   Fri, 31 Jul 2020 10:06:03 +0200
Message-ID: <1ja6zg85xw.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu 30 Jul 2020 at 18:06, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com> wrote:

> On 7/30/20 4:04 AM, Jerome Brunet wrote:
>>
>> On Wed 29 Jul 2020 at 17:56, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com> wrote:
>>
>>> On 7/29/20 10:46 AM, Jerome Brunet wrote:
>>>> commit b73287f0b0745 ('ASoC: soc-pcm: dpcm: fix playback/capture checks')
>>>> changed dpcm_playback and dpcm_capture semantic by throwing an error if
>>>> these flags are not aligned with DAIs capabilities on the link.
>>>>
>>>> The former semantic did not force the flags and DAI caps to be aligned.
>>>> The flag previously allowed card drivers to disable a stream direction on
>>>> a link (whether or not such feature is deemed useful).
>>>>
>>>> With change ('ASoC: core: use less strict tests for dailink capabilities')
>>>> an error is thrown if the flags and and the DAI caps are not aligned. Those
>>>> parameters were not meant to aligned initially. No technical reason was
>>>> given about why cards should now be considered "broken" in such condition
>>>> is not met, or why it should be considered to be an improvement to enforce
>>>> that.
>>>>
>>>> Forcing the flags to be aligned with DAI caps just make the information
>>>> the flag carry redundant with DAI caps, breaking a few cards along the way.
>>>>
>>>> This change drops the added error conditions and restore the initial flag
>>>> semantics.
>>>
>>> or rather lack thereof.
>>
>> Again, why ? All there is so far is your personal preference. no facts.
>
> What would be the meaning/purpose of a dailink with .dpcm_capture set, with
> only dais that support playback only?
>
> What would be the meaning/purpose of a dailink with .capture_only set, but
> with a dai that supports playback?

You get to throw an error in those case

>
> What happens if none of these flags are set?

I think I already suggested to throw an error in the initial review of
your patch

>
> What happens when all these flags are set?

I don't see the problem here

>
> No one seems to know, so my suggestion is to align first on consistent
> configurations, then see what can be removed.
>
>>   * What we had gave capabilities to the link, independent of the DAI
>>     components. ASoC just computes the intersection of all that to
>>     determine which direction needs to be enabled. Seems rather simple
>>     and straight forward.
>
> that's what my last patch did, and when there is no intersection it
> complains. Please clarify what you expect when there is no overlap between
> dai and dailink capabilities. Keep in mind that we have a mix of hard-codec
> configuration and DT-created ones, your case is not the general one.
>
>>   * It worked for every user of DPCM so a far.
>
> Not completely true, when Morimoto-san added snd_soc_dai_stream_valid() it
> exposed tons of cases where the information on direction was not provided
> in a reliable at the DAI level. I will assert that we are still finding out
> cases with broken DAI configurations, and as a result we will also find
> broken dailink configurations. Your picture of DPCM as a perfectly
> functional system that I broke is a distortion of reality.

If it was not working, it was certainly not clear in the changelog.
What's clear is the regression it caused

>
> The reality is that we have to work in steps, first make sure all DAIs are
> properly described, then work on the dailinks and optimize at a later
> point. we will need warnings to find out what the problem cases are, and
> move slowly.

Sure, have it your way
