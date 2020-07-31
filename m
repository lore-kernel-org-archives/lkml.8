Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3A7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5280622BF3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="guQm0pLx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733048AbgGaMQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 08:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732842AbgGaMQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:16:46 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DD1C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 05:16:45 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f18so27812555wrs.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 05:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=xABj9o/+LF58yiAkW0qlTl8H60o66EHmFAlpoGa2r4s=;
        b=guQm0pLxZhuiFMgT/YoFDq1qAQEhYLykNn383MHzp5vyWxpMrZ36YkRNI78Ke5XpUO
         wq1Q16/L+GkWgoNJLEf/o9HsPCU4002b1qrN9oB5YQTivbxhsh1zAj0g5r0ZMwxbvFs1
         txNvI+MFOaQIhzLW6qF79AjMywqpt6i/uYmN/8D2yUkRL2lcCo6Gkf0uBOCa2BbXDEao
         4qz9YkoQ+hEyjr96b5l/hRkD13LxOen7ADjs35KCziHBvXijJ+P1sTq5917Lqjz9Qhls
         GuhtcRBBoFrYjiEniyu6H5zZ+JPnAkF9+FBAarSjzbmGdrE9u2Ki04mtXhJ06YEYcu5m
         yA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=xABj9o/+LF58yiAkW0qlTl8H60o66EHmFAlpoGa2r4s=;
        b=TMLoo+eu+giQfmbwTQD+ecCgafQqzIwzWTt3LKtbyInWL+732ubsCel24H3ur2HD3k
         a3dQnRWJcbMF3PW9YX9MEfnVvA7tlNZ3lwaTFyyogtyylsTrWJEQKGlneIpvS20sGxHO
         lizASIcATIhikpz7EF88v8PHu9MzBN+2EeY1jmiI2cJZY/EXaWZXSWFsyAnyi2uEHyWB
         ihNDBNExFfQ6brXKF1rYpP1Qd1tj3oT4n1J+U/WYbhlGGf2vRMQIiR8NgZ54uKzYqJ/A
         tVj0NqPAVWecCjKbG70iRh8hypdEEH5jYpw2/oLgFJ1zmXt5X8+IpUvRaMvYehzBOhln
         XZZw==
X-Gm-Message-State: AOAM533Lsf03utXmd2mLw4nJgDRsMNxweBpTWvOSuewRctL1nrN2Leqq
        8P253hyihjWjmWGJCVep+FC8UA==
X-Google-Smtp-Source: ABdhPJwnWi9tvSXSrHuqSUu1kDUIIUV324uwyEKL0/F8EHAeFwamGr+7Nm01PLL6fMFhOXcprj35Sg==
X-Received: by 2002:adf:e6cc:: with SMTP id y12mr3266378wrm.391.1596197804388;
        Fri, 31 Jul 2020 05:16:44 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g126sm12527702wme.16.2020.07.31.05.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 05:16:43 -0700 (PDT)
References: <20200723180533.220312-1-pierre-louis.bossart@linux.intel.com> <20200729154639.1983854-1-jbrunet@baylibre.com> <2ad13f95-434d-376a-bc38-b209623b461e@linux.intel.com> <1jft998jbe.fsf@starbuckisacylon.baylibre.com> <936d6e37-0ad0-b0d7-814a-1ace12087746@linux.intel.com> <20200730185229.GH5055@sirena.org.uk>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, zhangn1985@outlook.com,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH] ASoC: core: restore dpcm flags semantics
In-reply-to: <20200730185229.GH5055@sirena.org.uk>
Date:   Fri, 31 Jul 2020 14:16:43 +0200
Message-ID: <1j7duj98wk.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu 30 Jul 2020 at 20:52, Mark Brown <broonie@kernel.org> wrote:

> On Thu, Jul 30, 2020 at 11:06:23AM -0500, Pierre-Louis Bossart wrote:
>> On 7/30/20 4:04 AM, Jerome Brunet wrote:
>> > On Wed 29 Jul 2020 at 17:56, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com> wrote:
>> > > On 7/29/20 10:46 AM, Jerome Brunet wrote:
>
>> > > > The flag previously allowed card drivers to disable a stream direction on
>> > > > a link (whether or not such feature is deemed useful).
>
> Right, and I can see a use case for this if someone has a board that
> for some reason didn't physically connect one of the directions for some
> reason - perhaps they were running out of pins or something.  It's not
> clear if anyone's actually doing that though.
>
>> > > > Forcing the flags to be aligned with DAI caps just make the information
>> > > > the flag carry redundant with DAI caps, breaking a few cards along the way.
>
>> > > > This change drops the added error conditions and restore the initial flag
>> > > > semantics.
>
> I'm not 100% clear, have we actually found cases where the flags are
> used or is this something found through inspection and review?

One last thing I'd like to understand. Is this behavior of throwing an
error going to applied to the non-DPCM case as well ? so at least thing
are consistent between both cases ?

IOW:
 * An error is now throw if dpcm_capture is set on the link and the CPU
 DAI support playback_only
 * on non-DPCM links, will an error be thrown as well if playback_only
 is not set and the CPU on the link happen to not support capture ?
 
>
>> >   * It worked for every user of DPCM so a far.
>
>> Not completely true, when Morimoto-san added snd_soc_dai_stream_valid() it
>> exposed tons of cases where the information on direction was not provided in
>> a reliable at the DAI level. I will assert that we are still finding out
>> cases with broken DAI configurations, and as a result we will also find
>> broken dailink configurations. Your picture of DPCM as a perfectly
>> functional system that I broke is a distortion of reality.
>
>> The reality is that we have to work in steps, first make sure all DAIs are
>> properly described, then work on the dailinks and optimize at a later point.
>> we will need warnings to find out what the problem cases are, and move
>> slowly.
>
> This was all triggered by Morimoto-san's changes like you say.  DPCM has
> quite a lot of problems in general, here IIRC the issues were that we
> had multiple different ways of doing similar things which it wasn't
> quite clear if people were even using.  The intention with the warnings
> was to remove them one way or another, they're mainly intended to flush
> out actual active usage of the flags as opposed to redundant usage of
> them which could be confused/broken.
>
> This could definitely have been clearer in the changelogs though.

