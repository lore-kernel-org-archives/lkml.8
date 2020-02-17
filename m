Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7DA9C7619B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 07:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A144720718
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 07:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgBQHVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 02:21:02 -0500
Received: from mail-ed1-f53.google.com ([209.85.208.53]:33655 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgBQHVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 02:21:01 -0500
Received: by mail-ed1-f53.google.com with SMTP id r21so19518595edq.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2020 23:21:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=scxVOt7vJ8XADBjS9Kw7nULEogoDx5VlxsaehXEQC7Q=;
        b=ez67O2HqJ+LMuQqwWz6nK/3SUnucclpF2OUQFalx3gy4yG/6DXYq+Qfp7KYJ9zUDpZ
         4Aj2CzJSqIx8p0q/oLdlDN0HHVkO19F9qtO+Toftnf96xpfINJWKrm2T/dcwKQUfIWhr
         9F0ROtB/dph3Hs1qCeXbpbMruSdoWQf/MQzkbfxP35+00dJV9/1iuJUK0yMQl/9OLUgR
         QNM99efYlQ7mOXzdvRII9mAGtNeYVfk4cERNq7vCyydLeBKxeS84BkAcQfc8dN5UXvO1
         v1NwRdUjHRAxLoS0kSNngXl0SWpJPArAeEt/bt0tynepj+itM6B2J6iASWKQ/v31H4KA
         rYvA==
X-Gm-Message-State: APjAAAW+PoxuBr/SHgZ+I9OPsGreHSFIq2/Z8D7GgUky2+bMeJ2PBqZ3
        rf3MAVWJNLAeBDCvRwKxwZm2Qjk2r50=
X-Google-Smtp-Source: APXvYqxYYOA0pDXLI/osi6vPWqWLyiF6Q4xMCEQNrLnvASliyqlqjR6niXSZLh7ngSbnrErEjLYzDw==
X-Received: by 2002:a05:6402:3129:: with SMTP id dd9mr13157428edb.356.1581924059175;
        Sun, 16 Feb 2020 23:20:59 -0800 (PST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id s12sm777744eja.79.2020.02.16.23.20.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2020 23:20:59 -0800 (PST)
Received: by mail-wm1-f50.google.com with SMTP id t14so17165570wmi.5
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2020 23:20:58 -0800 (PST)
X-Received: by 2002:a1c:7915:: with SMTP id l21mr19642112wme.112.1581924058371;
 Sun, 16 Feb 2020 23:20:58 -0800 (PST)
MIME-Version: 1.0
References: <20200217021813.53266-1-samuel@sholland.org> <20200217021813.53266-8-samuel@sholland.org>
In-Reply-To: <20200217021813.53266-8-samuel@sholland.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 17 Feb 2020 15:20:47 +0800
X-Gmail-Original-Message-ID: <CAGb2v67R7ObOSnU3o400PWNtnSFouNUait9ULP_1NQs4YnDccA@mail.gmail.com>
Message-ID: <CAGb2v67R7ObOSnU3o400PWNtnSFouNUait9ULP_1NQs4YnDccA@mail.gmail.com>
Subject: Re: [PATCH 7/8] ASoC: sun50i-codec-analog: Enable DAPM for line out switch
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
> By including the line out mute switch in the DAPM graph, the
> Mixer/DAC inputs can be powered off when the line output is muted.
>
> The line outputs have an unusual routing scheme. The left side mute
> switch is between the source selection and the amplifier, as usual.
> The right side source selection comes *after* its amplifier (and
> after the left side amplifier), and its mute switch controls
> whichever source is currently selected. This matches the diagram in
> the SoC manual.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
