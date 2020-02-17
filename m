Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035CEC7619B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 03:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D55E320659
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 03:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbgBQD20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 22:28:26 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44000 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbgBQD20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 22:28:26 -0500
Received: by mail-ed1-f66.google.com with SMTP id dc19so18936309edb.10
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2020 19:28:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Vf+s0xiHFIhPppg6jnzm8oEYQMOnPl6UhM4IxCWOkI=;
        b=d8XrT/PpEFtLqQMcqbVC4lJ9iMsyJ7ucf6yJGe6TJZYc8NunbTG3jLZ0PnYSCF3x7s
         eTba835O7ogTBjrMd18+M8JOcfw30Im4XquH5whRBJ5GSxO6PZOEugpK1N4HPpVkcoEa
         zPIrDnZ/OfGpKOPC92ivZcfeSdhFpZawmWUIeSjYD/m1XG4QgLnxel9IASgz8T/TVxZQ
         qhLnQ7cr8mDtYU4cNpQcgdhCQ5hXxXy4QGe/tcIcwrbI1xfU68usATYmDJh+2J2Be2MW
         q9d6KUdKvyXzDXtPyjicN7sQtSzBrTGu1/eIxGYpYORkJVeoTO2xrivB+n5/uUgqNuBO
         WxTg==
X-Gm-Message-State: APjAAAUeSkw8HMoLYJdx2xlAyMFQ6QZi0jRKePnZ39ZcDwx2ltQUEVz7
        KNIGwr9S05jfui/hJaoOvyx+5G8EqRs=
X-Google-Smtp-Source: APXvYqz2rQdPnVbq6fNRmb0X38e3eVxbG/c+O8PeinhsztwIm01G1YZSi6vaghweWIE1g65NQD8l5A==
X-Received: by 2002:a05:6402:1d28:: with SMTP id dh8mr12066144edb.383.1581910104172;
        Sun, 16 Feb 2020 19:28:24 -0800 (PST)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id qw15sm810379ejb.92.2020.02.16.19.28.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2020 19:28:23 -0800 (PST)
Received: by mail-wm1-f48.google.com with SMTP id a6so16821310wme.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2020 19:28:21 -0800 (PST)
X-Received: by 2002:a1c:dc85:: with SMTP id t127mr20681900wmg.16.1581910101671;
 Sun, 16 Feb 2020 19:28:21 -0800 (PST)
MIME-Version: 1.0
References: <20200217021813.53266-1-samuel@sholland.org> <20200217021813.53266-2-samuel@sholland.org>
In-Reply-To: <20200217021813.53266-2-samuel@sholland.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 17 Feb 2020 11:28:11 +0800
X-Gmail-Original-Message-ID: <CAGb2v67PeKSpzRRQNvUy8PXtLMtv1=PZk99mmGgaL6nwMYMa+w@mail.gmail.com>
Message-ID: <CAGb2v67PeKSpzRRQNvUy8PXtLMtv1=PZk99mmGgaL6nwMYMa+w@mail.gmail.com>
Subject: Re: [PATCH 1/8] ASoC: sun50i-codec-analog: Fix duplicate use of ADC
 enable bits
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
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ondrej Jirman <megous@megous.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 10:18 AM Samuel Holland <samuel@sholland.org> wrote:
>
> The same enable bits are currently used for both the "Left/Right ADC"
> and the "Left/Right ADC Mixer" widgets. This happens to work in practice
> because the widgets are always enabled/disabled at the same time, but
> each register bit should only be associated with a single widget.
>
> To keep symmetry with the DAC widgets, keep the bits on the ADC widgets,
> and remove them from the ADC Mixer widgets.
>
> Fixes: 42371f327df0 ("ASoC: sunxi: Add new driver for Allwinner A64 codec's analog path controls")
> Reported-by: Ondrej Jirman <megous@megous.com>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Chen-Yu Tsai <wens@csie.org>
