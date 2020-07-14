Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2E6C433EA
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 639902076C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfJX8RRg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730398AbgGNUQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 16:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730371AbgGNUQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 16:16:09 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9631C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 13:16:09 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id m9so8070795pfh.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 13:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=isacsWKlY2hogV7o0KRbs8AppWDN/iG8vIZCQlmiM8c=;
        b=kfJX8RRgL3w39hgg+eFWjqDIkMxIHuOqN9XY3bPq9N9g+jinxvkDkmvu10fWdrWzkF
         rlj0sh1ktttzaUUvdLHwZoHH8IsKgZjFLqMeEeI72DXuRmmKzacsqISPv9e4Z0DGiya2
         mAgSMVnRa6E8vJkyxMhwo1YRkEzY/NJo77QgqcmssBC3+psgls0rwCkY24T/u8BD5MRY
         LHJFfsPB235oyZYh8fmjQHMy6cHGfVaKoXFiYDJSWwgWT1OidYj1sc86fvR5OZS4ThuF
         7pZv+3xlydLI2ndjEph9mpL+1mEeas9+CnOaEMlwyjiIiyEmWdjyzYVjn8GgGH1T9Ec/
         OB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=isacsWKlY2hogV7o0KRbs8AppWDN/iG8vIZCQlmiM8c=;
        b=L7g4DmnzkEsGMUbZNfW1dg010j2WdPeWT1PsPN+HbTSYqsiFdEvQZESoQg+9cvvDf4
         XE0YltMg+D4q9qQHumXKPHb0j7+DaKXow40pz+jTQuEzRLmjtqfGYTsedtouwGlu0yUC
         7Oy23e2RFRHszU2YDNTlU3RCkP3cjf1LFvNG5aHSEH1Cf4SCptzKvR8CHbc3xY5PqYvv
         gsgSp1yWXJjaka6FTn2Wx/ndeWlbdMElgc8m6D6wByEhjagPpUfuVs3b/J6lyin1mDao
         WeR/4QlTGgsjuXj+i5owS87ArZBXZE2OLHwSsMsd1f4UIeuKA9fyYkpyBnpyToOrD6hz
         Lbqw==
X-Gm-Message-State: AOAM530Zc3pMR67BqyrnMVEAP0IaX1dCdVmV4PZC5iwpeHETeeWXYKEi
        7CawGD7Mv/PQzt04Re3Etsc=
X-Google-Smtp-Source: ABdhPJz4mHhE+EWHl0+c9gi56UeWi3Y28r21XTa3JlYyq0tBKwdN2h5M4l6Qs7kLwtkNK5cOaciEWQ==
X-Received: by 2002:a63:1a44:: with SMTP id a4mr4796308pgm.281.1594757769130;
        Tue, 14 Jul 2020 13:16:09 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id e28sm37314pfm.177.2020.07.14.13.16.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Jul 2020 13:16:08 -0700 (PDT)
Date:   Tue, 14 Jul 2020 13:15:45 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Arnaud Ferraris <arnaud.ferraris@collabora.com>
Cc:     alsa-devel@alsa-project.org, Timur Tabi <timur@kernel.org>,
        Xiubo Li <Xiubo.Lee@gmail.com>, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>, kernel@collabora.com,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 0/4] ASoC: fsl_asrc: allow selecting arbitrary clocks
Message-ID: <20200714201544.GA10501@Asurada-Nvidia>
References: <20200702142235.235869-1-arnaud.ferraris@collabora.com>
 <20200702184226.GA23935@Asurada-Nvidia>
 <3f39a0bb-a766-f646-28b3-a51cf9983c6b@collabora.com>
 <3fea8912-63df-ff27-0c29-6284a85107ab@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fea8912-63df-ff27-0c29-6284a85107ab@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 06:20:32PM +0200, Arnaud Ferraris wrote:
> >>> The current ASRC driver hardcodes the input and output clocks used for
> >>> sample rate conversions. In order to allow greater flexibility and to
> >>> cover more use cases, it would be preferable to select the clocks using
> >>> device-tree properties.
> >>
> >> We recent just merged a new change that auto-selecting internal
> >> clocks based on sample rates as the first option -- ideal ratio
> >> mode is the fallback mode now. Please refer to:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20200702&id=d0250cf4f2abfbea64ed247230f08f5ae23979f0

> I finally got some time to test and debug clock auto-selection on my
> system, and unfortunately couldn't get it to work.
> 
> Here's some background about my use case: the i.MX6 board acts as a
> Bluetooth proxy between a phone and a headset. It has 2 Bluetooth
> modules (one for each connected device), with audio connected to SSI1 &
> SSI2. Audio sample rate can be either 8 or 16kHz, and bclk can be either
> 512 or 1024kHz, all depending of the capabilities of the headset and phone.
> In our case we want SSI2 to be the input clock to the ASRC and SSI1 the
> output clock, but there is no way to force that with auto-selection:
> both clocks are multiples of both 8k and 16k, so the algorithm will
> always select the SSI1 clock.

Anything wrong with ASRC selecting SSI1 clock for both cases? The
driver calculates the divisors based on the given clock rate, so
the final internal rate should be the same. If there's a problem,
I feel that's a separate bug.
