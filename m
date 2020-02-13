Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F0AC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 17:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC8F7206ED
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 17:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="y4z9797W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbgBMRhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 12:37:45 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36270 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbgBMRho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 12:37:44 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so7721352wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 09:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=Zvz2XeVTIF+ueC8ZSbcXCfTRm4NOaCnXy121PGkk+Yg=;
        b=y4z9797WK5rw61o0bHX20MVMCzpPi8e1XV3NNiGnUzy/usayLB7afqaJPX9RbfFN8d
         DTHjeJKKl0pf+6s56FBO6zp7C85vj8QTq9rii/FdwUiZoqKNj2guPNqtyP8wgQNOtmdv
         UmaS7phuNaxUHCjYa2YlwmNpOzXz4C8VUr6ecOtZfSqBYOmP7+4uubq2yIunsJr3QiXl
         LX8W4qZbMWDrTV7lJnlgFd0vCm3XBm13uk9eSp8VTYshLUJcLJ6P1lfAfGOL5EPZQvVi
         OimW08hzSH5ujRFZxkJhUKNViVxC/yetGRK+uJ2pXq3g+0gHCPA1imWM3FBb0b/dl8fF
         KtLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=Zvz2XeVTIF+ueC8ZSbcXCfTRm4NOaCnXy121PGkk+Yg=;
        b=WiLkS4Ky3mg77xCtFAorkrI7X+GbqkZSpap3FqIi7mWPmszDE5wzR4MH8K1inod1ys
         fbXAdQI4dXihiX6C+aC/iTTM7UbC8t/65w7XmcIfVH8S7Vc2QrNidd/fXVDxe1UKgOP0
         Rc/7pqToFagsipwXG8esVL+Q3QvpiXVI6ce+ahgAIrXteKpvQ9BUdEP6yPSgf3fZXhLJ
         UfI1XT74VprAIovH3gdSTC9tOgz7drpLCuhM8MaIgtUdiFoguMYoy9CvH5PWqli+zm6G
         mHYFNFHKPBPbs335IEXc5ddJhZxcJPe7fLmrORhnUK93I6Nhw2OnnGA+fb3Pry5H9Rro
         eXHg==
X-Gm-Message-State: APjAAAUhXaHl4NjgQNbWr1ZCtFiowePh6sxeqyd/9dMrAIE7Kx45uIjA
        mtUr3LGIkJUHA1HpjTfQ+Zf8dw==
X-Google-Smtp-Source: APXvYqykC+mTy5IPmmZi7PPVz1FJbeRW+wBfOOUQU58sYIdkyHAaUT8ZIB+UlNf0ucjzIZv+uzieOg==
X-Received: by 2002:a05:600c:228f:: with SMTP id 15mr7314496wmf.56.1581615463076;
        Thu, 13 Feb 2020 09:37:43 -0800 (PST)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id y185sm4054871wmg.2.2020.02.13.09.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 09:37:42 -0800 (PST)
References: <20200213155159.3235792-1-jbrunet@baylibre.com> <20200213155159.3235792-2-jbrunet@baylibre.com> <20200213171830.GH4333@sirena.org.uk>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 1/9] ASoC: core: allow a dt node to provide several components
In-reply-to: <20200213171830.GH4333@sirena.org.uk>
Date:   Thu, 13 Feb 2020 18:37:41 +0100
Message-ID: <1j4kvufkwq.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu 13 Feb 2020 at 18:18, Mark Brown <broonie@kernel.org> wrote:

> On Thu, Feb 13, 2020 at 04:51:51PM +0100, Jerome Brunet wrote:
>
>> At the moment, querying the dai_name will stop of the first component
>> matching the dt node. This does not allow a device (single dt node) to
>> provide several ASoC components which could then be used through DT.
>
>> This change let the search go on if the xlate function of the component
>> returns an error, giving the possibility to another component to match
>> and return the dai_name.
>
> My first question here would be why you'd want to do that rather than
> combine everything into a single component since the hardware seems to
> be doing that anyway.  Hopefully the rest of the series will answer this
> but it'd be good in the changelog here.

Hi Mark,

Sorry if I was not clear enough.

This HW is messy. It is indeed one monolithic device which
provides several functions/sub-devices/components

I tried several approaches:

* Just 1 component: This was ugly because the part that is present only on 1
SoC variant, I needed to reconstruct the dai, widget, route and control
table which involved a fair amount of useless copies.

* A lot of devices (and components) with syscon: This ended up being even
  uglier, difficult to work with since it did not really reflected the
  actual HW.

The solution proposed here is just one device with 3 possible
components (groups):
* The CPU producers a associated path
* The HDMI control
* The Internal DAC control

The impact on ASoC is rather small, the driver reflect quite well what
the HW is and, with a sound-dai-cell=2, it fairly simple in DT as well.

Do you think there is something wrong with a linux device providing
several ASoC components ?
