Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD05C7619B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 03:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9EB422B48
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 03:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgBQDc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 22:32:27 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41161 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbgBQDc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 22:32:27 -0500
Received: by mail-ed1-f66.google.com with SMTP id c26so18975807eds.8
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2020 19:32:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q4CIHpVJIc8tieFYml9JRz0BGCHMsI2BF3krPygp1zU=;
        b=V5/21ToGix/QBBgnF9u1B1kPWTlyz1F3H1lt6j3EQfXtOr+DC0Cv9wkBrNkXIOkbnM
         BNdVj6FsVxiwMBrNyNgoAMRWMd/t7Sd0d8CVy/5WiiWeV8lGek6jOiLD6I9+i27ShMLh
         5Z11V70xuKup1YATr6WFafOJgoRD4Wt0+N3+wmECCd4g2aQ07gOzeJfg7zzxRZ2O2pdn
         784YMeX4lB2XUpcMa+QfPbLQIEQClhAg+1fC2lRZKDBiThoetwNOOukVU94b7qMQo6tt
         5nL3TCqk3aUGO8du+MPE8YsJoI0CEs9HucQZDYrF4gtimWl+EcaDwoHYm19CWjjV5k4m
         xbPw==
X-Gm-Message-State: APjAAAV9IGS22CynhNz5hUAEwzugAXgRtwDgSvD8H+6xkCXcxvEpN9Ww
        dZDwkmCLlHNngUQkevv0jVJZpYj72Vw=
X-Google-Smtp-Source: APXvYqwqDsSmP9mFlYkPpM4+AQrpltEt57PV43I66zYSoXG+KDwQv6fIFFKBjGAuSFMdOfGBshSXxQ==
X-Received: by 2002:a17:906:a84c:: with SMTP id dx12mr13068359ejb.342.1581910344896;
        Sun, 16 Feb 2020 19:32:24 -0800 (PST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id k11sm805282ejq.24.2020.02.16.19.32.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2020 19:32:24 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id a9so16813319wmj.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2020 19:32:24 -0800 (PST)
X-Received: by 2002:a1c:7915:: with SMTP id l21mr18520158wme.112.1581910344064;
 Sun, 16 Feb 2020 19:32:24 -0800 (PST)
MIME-Version: 1.0
References: <20200217021813.53266-1-samuel@sholland.org> <20200217021813.53266-4-samuel@sholland.org>
In-Reply-To: <20200217021813.53266-4-samuel@sholland.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 17 Feb 2020 11:32:13 +0800
X-Gmail-Original-Message-ID: <CAGb2v662ugC4R3KDZfP3VJV8WHSWOCqAEveM0R_PLDa69Haffg@mail.gmail.com>
Message-ID: <CAGb2v662ugC4R3KDZfP3VJV8WHSWOCqAEveM0R_PLDa69Haffg@mail.gmail.com>
Subject: Re: [PATCH 3/8] ASoC: sun50i-codec-analog: Group and sort mixer routes
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
> Sort the controls in the same order as the bits in the register. Then
> group the routes by sink, and sort them in the same order as the
> controls. This makes it much easier to verify that all mixer inputs are
> accounted for.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Chen-Yu Tsai <wens@csie.org>
