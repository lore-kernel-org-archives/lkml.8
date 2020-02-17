Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013BBC7619B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84C420726
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbgBQIG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 03:06:56 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40984 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727259AbgBQIGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 03:06:54 -0500
Received: by mail-ed1-f68.google.com with SMTP id c26so19606356eds.8;
        Mon, 17 Feb 2020 00:06:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H7HNmg9K88memoV4mQIdFTzsV1B2vI42lPI0r8PIbeg=;
        b=dL8b1/I9N18AwkXpOjnUyzKOq+IVYoMmhzFajQZOyfD4oLYirOk3kg3DPaOqJczuaR
         avKv7set26LKlMqmhlUFB3SONJZ9hLWrMDy4SJudTcWPOtcKQLjKEd3+R8KJ0YuS3csb
         5sUlOk1trZ0jGFbdEdkQx4ZJrQdSJd+TJQQkGefGn/Jk/OWUG5QdPyNj63ab3/36maKX
         PrF479Z/v3tWmiVIA6giL04eb3HsgNwKi1qnWBAlWSRDlgPyKQTlWrNJwxkyJPxcmRwI
         6Z6CE45ZXgVrArhr3yCYnPNgUBPuE4+s52FqqStj+/YZZZLnbq4DShdWtNQmH9mcqMwW
         2SGw==
X-Gm-Message-State: APjAAAXgvKJmE+j3RsMjFa2z25GRcu35IK5M+vEjheUI6QBziQmQ7hE8
        T+sb9oAqpVjmG1WYeK94R8aM1g2qtcw=
X-Google-Smtp-Source: APXvYqzNwaq0yuvhJm5GWsQg1Xyaym5Z/x3W5k4Nu6x8N9admJqi8HPwKL3bZP5pepMOXs98idtb2A==
X-Received: by 2002:a17:906:a444:: with SMTP id cb4mr13414956ejb.42.1581926811793;
        Mon, 17 Feb 2020 00:06:51 -0800 (PST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id m27sm425467eda.96.2020.02.17.00.06.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2020 00:06:51 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id g1so16093850wmh.4;
        Mon, 17 Feb 2020 00:06:51 -0800 (PST)
X-Received: by 2002:a1c:dc85:: with SMTP id t127mr22204730wmg.16.1581926810934;
 Mon, 17 Feb 2020 00:06:50 -0800 (PST)
MIME-Version: 1.0
References: <20200217064250.15516-1-samuel@sholland.org> <20200217064250.15516-13-samuel@sholland.org>
In-Reply-To: <20200217064250.15516-13-samuel@sholland.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 17 Feb 2020 16:06:40 +0800
X-Gmail-Original-Message-ID: <CAGb2v65e3dwji4cwRh6uTryjXq=0qmeggEjrMgL9KtB+JTWCVg@mail.gmail.com>
Message-ID: <CAGb2v65e3dwji4cwRh6uTryjXq=0qmeggEjrMgL9KtB+JTWCVg@mail.gmail.com>
Subject: Re: [RFC PATCH 12/34] ASoC: sun8i-codec: Fix AIF1 MODCLK widget name
To:     Samuel Holland <samuel@sholland.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 2:43 PM Samuel Holland <samuel@sholland.org> wrote:
>
> It should be "AIF1", not "AFI1".
>
> Fixes: 36c684936fae ("ASoC: Add sun8i digital audio codec")
> Fixes: eda85d1fee05 ("ASoC: sun8i-codec: Add ADC support for a33")
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Chen-Yu Tsai <wens@csie.org>
