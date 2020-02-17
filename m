Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2C2C7619B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 07:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1F5F20718
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 07:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgBQHSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 02:18:07 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36076 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgBQHSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 02:18:06 -0500
Received: by mail-ed1-f65.google.com with SMTP id j17so19494920edp.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2020 23:18:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dW4Ej8MLzzPbydvCeEmiQskFOW2o/76spt2iKZQxuT0=;
        b=dUJzgAq9Ga6J2b2HEd0fiOAgN52jy4lKacF46HlPxOiP9LI0u0JWl17WW2PeRzZbxy
         8fM2TwlCPhmlzaT5+weTBxamKSG0jMFHLXAENq5O0XiIrsY0i5sYQHj+qCdRo/L5rFms
         sCDTKQ76TWJmqEN+Rsu7cNslcoemvhI4X2BWH76AWx7RXkjc+Dimt2+YRY6aK677QVkh
         tJvkmezS0Gsb1MBydsTLBXu4sP1WPYBej/rb3wRGvDQY3OCEiUAhOeMY3o92ZayEzBGU
         4uZkMgnm7TcR3ig1/j7QO/sR4/yBtNA511wh4PjlbDZpmEtwtKsegBZgcJj5wfpxDxgj
         neVA==
X-Gm-Message-State: APjAAAWZl9cWe5PyrG6guS4nZaez/9U7SU9CwJaW/sQrHsQ8Iq5Lrayj
        T5B/8+S+y7sXaqCDeEWDZtDDi5ZwyMs=
X-Google-Smtp-Source: APXvYqyQFo4/2fDY7IW1idIBKfPGNr9cuLzHeeHyr2hXaa2bMlmMgE1LZl0YfppSg5pINO1Nnuwaag==
X-Received: by 2002:aa7:c591:: with SMTP id g17mr13105538edq.341.1581923884632;
        Sun, 16 Feb 2020 23:18:04 -0800 (PST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id j15sm892718ejy.55.2020.02.16.23.18.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2020 23:18:04 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id b17so17182772wmb.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2020 23:18:04 -0800 (PST)
X-Received: by 2002:a05:600c:34d:: with SMTP id u13mr21111044wmd.77.1581923883938;
 Sun, 16 Feb 2020 23:18:03 -0800 (PST)
MIME-Version: 1.0
References: <20200217021813.53266-1-samuel@sholland.org> <20200217021813.53266-6-samuel@sholland.org>
In-Reply-To: <20200217021813.53266-6-samuel@sholland.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 17 Feb 2020 15:17:53 +0800
X-Gmail-Original-Message-ID: <CAGb2v65v=wPJNxPfOzp2bcevk0qoDiW-+KFBO1MKHz6gE86DPQ@mail.gmail.com>
Message-ID: <CAGb2v65v=wPJNxPfOzp2bcevk0qoDiW-+KFBO1MKHz6gE86DPQ@mail.gmail.com>
Subject: Re: [PATCH 5/8] ASoC: sun50i-codec-analog: Enable DAPM for headphone switch
To:     Samuel Holland <samuel@sholland.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxime Ripard <mripard@kernel.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 10:18 AM Samuel Holland <samuel@sholland.org> wrote:
>
> By including the headphone mute switch to the DAPM graph, both the
> headphone amplifier and the Mixer/DAC inputs can be powered off when
> the headphones are muted.
>
> The mute switch is between the source selection and the amplifier,
> as per the diagram in the SoC manual.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

BTW, have you also considered tying in the headphone volume control?
It also has a mute setting.

ChenYu
