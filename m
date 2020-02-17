Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AADC35242
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 03:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 175CB20659
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 03:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgBQD3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 22:29:38 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39032 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbgBQD3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 22:29:37 -0500
Received: by mail-ed1-f66.google.com with SMTP id m13so18974102edb.6
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2020 19:29:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=En6qfleyTIxn0Lmliem5wgGqB3laLlmUnkFCgAGehpQ=;
        b=IEIKpAOz8o59Z81Wy4ucc+n7eYC5jJB2duKUtvWd3681CdvdU+Jvcnk+gJ01UwOHzr
         +Y7kN0x8P0CC8M170QMIFlsP40xCj1Q0TKw5S6tnnpG8+QbxOgHN9Ft08ncfVCwDZale
         lYEgsyHxo5rjavEeW9vH+bI8SDxrP/8+qXpjvZPPzaIAzMsH2Kcz+d0Ay44ENy3+hPHI
         5LGQ0C/8LdSj3PVSGAiiBz5HFZBZ09TcXxUEzVdlhSOLFPfkFyaGW3944u6AjubZxobH
         vaEvwgS30Xxm1c6Hgxr2Yz+/8nb8aaeSdGaJeTD12QRH//0j2KkqMetN5IB6zn+sM98N
         UtGg==
X-Gm-Message-State: APjAAAUhokrOtcaQ027lqtWAela5wgXyq7nq2mYPfQlwoj94mlyz3s6+
        mAN7zgJzCrRo0oeMV2SVhnaDEMzHO7Y=
X-Google-Smtp-Source: APXvYqx+TtUgHIv9TSSJ1PWFiAWi9z9EI8656yOaTdYueDKqDTgSHVVYSM9Pu7vr7VKY3W6/5DH4zw==
X-Received: by 2002:a17:907:398:: with SMTP id ss24mr12309058ejb.317.1581910175004;
        Sun, 16 Feb 2020 19:29:35 -0800 (PST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id c19sm842678ejm.47.2020.02.16.19.29.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2020 19:29:34 -0800 (PST)
Received: by mail-wm1-f53.google.com with SMTP id a6so16822969wme.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2020 19:29:34 -0800 (PST)
X-Received: by 2002:a05:600c:34d:: with SMTP id u13mr19909383wmd.77.1581910174069;
 Sun, 16 Feb 2020 19:29:34 -0800 (PST)
MIME-Version: 1.0
References: <20200217021813.53266-1-samuel@sholland.org> <20200217021813.53266-3-samuel@sholland.org>
In-Reply-To: <20200217021813.53266-3-samuel@sholland.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 17 Feb 2020 11:29:23 +0800
X-Gmail-Original-Message-ID: <CAGb2v66w5v6MtLzmZ=C_ApNBktTxwgnzprQ8FKmuCbBwhvum9g@mail.gmail.com>
Message-ID: <CAGb2v66w5v6MtLzmZ=C_ApNBktTxwgnzprQ8FKmuCbBwhvum9g@mail.gmail.com>
Subject: Re: [PATCH 2/8] ASoC: sun50i-codec-analog: Gate the amplifier clock
 during suspend
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
> The clock must be running for the zero-crossing mute functionality.
> However, it must be gated for VDD-SYS to be turned off during system
> suspend. Disable it in the suspend callback, after everything has
> already been muted, to avoid pops when muting/unmuting outputs.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Chen-Yu Tsai <wens@csie.org>
