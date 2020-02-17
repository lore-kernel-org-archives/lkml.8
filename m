Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149C3C7619B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 07:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB76B206D5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 07:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgBQHhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 02:37:31 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38978 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgBQHhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 02:37:31 -0500
Received: by mail-ed1-f66.google.com with SMTP id m13so19527336edb.6;
        Sun, 16 Feb 2020 23:37:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IFs/wu3fMgnSIGPEioJWp31NAFCMyffCU1mWgEeziQM=;
        b=qDH+tnoOkbIUFk+zvinE3LSMZJHRoM86zKTglqYEdAPekGaFjNSXX5ibEZnjyEJbX5
         1+Ux2VGHLgN0Ssg2uqMC9qF3UFtm8WPUuGk5gFVdZkyfYBVttjreBCIO/QVdYXzT9AR9
         leV5rPAdWN/MvvQIsEiWlwAhMpZ1j23Tw8LUjyoIw0i+NyCWR7+3KSiQJTtDGkyJlu2w
         mJ7ry23P2XnXbCMdZX0FIs0kaohcO+BqyFFwixxRJw33EopeCTAytwHIHkOsLRpDLw2P
         yz54kLexiy6wWI+8q1t/wBPgTic5Ol6fCGGMDnsRSBBylTM0KQFtlvQZrIVKCJLvd7C4
         sP2Q==
X-Gm-Message-State: APjAAAX14AYzAtLC9VmQP2ZKgVBH3V44kSLyR/iHgSR/4wIi4odXY1bk
        RMrwm35jedY2c0AdNCIVaInTvUGyNxI=
X-Google-Smtp-Source: APXvYqzHAYcM04z4CdvlRh/UQdogTUBvquCjA3EgKX6DsLJsC1ZHPlFvYLAK0Iv6WH9MeIXprXb10Q==
X-Received: by 2002:a17:906:5f89:: with SMTP id a9mr13441197eju.267.1581925048808;
        Sun, 16 Feb 2020 23:37:28 -0800 (PST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id v26sm225274edd.78.2020.02.16.23.37.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2020 23:37:28 -0800 (PST)
Received: by mail-wm1-f53.google.com with SMTP id b17so17229064wmb.0;
        Sun, 16 Feb 2020 23:37:27 -0800 (PST)
X-Received: by 2002:a05:600c:34d:: with SMTP id u13mr21218005wmd.77.1581925047487;
 Sun, 16 Feb 2020 23:37:27 -0800 (PST)
MIME-Version: 1.0
References: <20200217064250.15516-1-samuel@sholland.org> <20200217064250.15516-8-samuel@sholland.org>
In-Reply-To: <20200217064250.15516-8-samuel@sholland.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 17 Feb 2020 15:37:16 +0800
X-Gmail-Original-Message-ID: <CAGb2v66gif5urvyRy=Tt-bNvpzL5Te8wne6tEA+KSPH-J7BWrA@mail.gmail.com>
Message-ID: <CAGb2v66gif5urvyRy=Tt-bNvpzL5Te8wne6tEA+KSPH-J7BWrA@mail.gmail.com>
Subject: Re: [RFC PATCH 07/34] ASoC: sun8i-codec: Remove extraneous widgets
To:     Samuel Holland <samuel@sholland.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        =?UTF-8?Q?Myl=C3=A8ne_Josserand?= 
        <mylene.josserand@free-electrons.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 2:43 PM Samuel Holland <samuel@sholland.org> wrote:
>
> This driver is for the digital part of the codec, which has no
> microphone input. These widgets look like they were copied from
> sun4i-codec. Since they do not belong here, remove them.
>
> Cc: stable@kernel.org
> Fixes: eda85d1fee05 ("ASoC: sun8i-codec: Add ADC support for a33")
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
