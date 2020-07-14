Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75AAC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB25A2065D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Brx1k54T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgGNUvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 16:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgGNUvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 16:51:12 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA32C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 13:51:12 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id k5so2235339pjg.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 13:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xc9LWzDOKXS+ptBDNm2XPIAMDBTbm1M4WRBHaQH5FR8=;
        b=Brx1k54T6yHFWb/2X8L1OQE3az9QDKKYU1Duv8KOMrAQ+M4SJgaGsXLrp8XtrwgjYu
         hmtLTd5usxFXaQe5+XTthKKgvt5nSR+0yjhUhxY9KI+R+kUJlP7Z8yFvXyBGkknER5H3
         +HQpE4iymvg5dJ5zjEb3C2G/dg0GzjxVu2NjuUdgpEU1WT0gJ35f1a+++DdhP89Dd4V4
         2aJ5CHplHYPon1hvuXDNWcPyzINcBh0NxXfGMklD/7Vp4KzjykYtQ2RIF6EKiFDpNlQq
         2VD/Ey26RItC6eTx+Kp0z/EHwRD5/AyjwCV0dBY6VhEYkFL4vQE2pqqMt0j42m4tk7Fq
         yKOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xc9LWzDOKXS+ptBDNm2XPIAMDBTbm1M4WRBHaQH5FR8=;
        b=DMXRrw92/RNUehIvJKnBJaIdHYsl297cLH8mgUQz+bqW5O8wBvlMLwLWg1RD3nNMnZ
         3ean0yyekumbEnVTQNXuh5BHzTEzjuVPMrMgyJpeW/lESFy1SC80oD7h9X47Jpfnskuc
         iYdZ6BK2NjliUm5FdC9SYD6td68swxg5HOXZMaPLbo8aw5iEy0ZsHJIFCHXN+tfBNwMO
         f0Yf1XzlRBR1ChzGZ3xcj+9PSSRBaWYwmdOiUfdY+ukGNSR9A0eawDVnhDxhSFqumuqz
         qNuuqL4rhCiV1jvZlCXR0uCHFDR0uZknsPKGEJic48MPSuraQ21WSSA8tT6T6IfYDc9u
         FjoA==
X-Gm-Message-State: AOAM530KhpJo+M5hiyD1D8ctxKYndn1S9acvHcaBq3EEXkju+hUmLYxX
        xp0IkmI5BgbATymuD+IkoIM=
X-Google-Smtp-Source: ABdhPJxrDpJYpxIlmMfrnFwHOkB5UdB1bS6nF30tG0+uGvzhexgooTEBRVrrV+Vd9KDRkT6vEYQqOw==
X-Received: by 2002:a17:90b:94f:: with SMTP id dw15mr6644250pjb.199.1594759871930;
        Tue, 14 Jul 2020 13:51:11 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id m31sm3608860pjb.52.2020.07.14.13.51.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Jul 2020 13:51:11 -0700 (PDT)
Date:   Tue, 14 Jul 2020 13:50:50 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        alsa-devel@alsa-project.org, Timur Tabi <timur@kernel.org>,
        Xiubo Li <Xiubo.Lee@gmail.com>, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, kernel@collabora.com,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 0/4] ASoC: fsl_asrc: allow selecting arbitrary clocks
Message-ID: <20200714205050.GB10501@Asurada-Nvidia>
References: <20200702142235.235869-1-arnaud.ferraris@collabora.com>
 <20200702184226.GA23935@Asurada-Nvidia>
 <3f39a0bb-a766-f646-28b3-a51cf9983c6b@collabora.com>
 <3fea8912-63df-ff27-0c29-6284a85107ab@collabora.com>
 <20200714201544.GA10501@Asurada-Nvidia>
 <20200714202753.GM4900@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714202753.GM4900@sirena.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Tue, Jul 14, 2020 at 09:27:53PM +0100, Mark Brown wrote:
> On Tue, Jul 14, 2020 at 01:15:45PM -0700, Nicolin Chen wrote:
> > On Tue, Jul 14, 2020 at 06:20:32PM +0200, Arnaud Ferraris wrote:
> 
> > > Here's some background about my use case: the i.MX6 board acts as a
> > > Bluetooth proxy between a phone and a headset. It has 2 Bluetooth
> > > modules (one for each connected device), with audio connected to SSI1 &
> > > SSI2. Audio sample rate can be either 8 or 16kHz, and bclk can be either
> > > 512 or 1024kHz, all depending of the capabilities of the headset and phone.
> > > In our case we want SSI2 to be the input clock to the ASRC and SSI1 the
> > > output clock, but there is no way to force that with auto-selection:
> > > both clocks are multiples of both 8k and 16k, so the algorithm will
> > > always select the SSI1 clock.
> 
> > Anything wrong with ASRC selecting SSI1 clock for both cases? The
> > driver calculates the divisors based on the given clock rate, so
> > the final internal rate should be the same. If there's a problem,
> > I feel that's a separate bug.
> 
> The nominal rate might be the same but if they're in different clock
> domains then the actual rates might be different (hence the desire for
> an ASRC I guess).  I can see the system wanting to choose one clock or
> the other on the basis of some system specific property (quality of the
> clock sources, tolerances of the devices involved or something) though
> it's a rather fun edge case configuration :/ .

Thanks for the input. Fox i.MX6, I don't feel it would be that
drastically different though. And both SSI1 and SSI2 can simply
select the same root clock source to avoid that happen.

Yet, in case that we need to support such an edge case, what's
a relatively common practice to allow system select the clock
source now?
