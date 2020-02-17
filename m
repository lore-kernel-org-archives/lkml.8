Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72317C7619B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 07:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5496A2064C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 07:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgBQH6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 02:58:32 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34354 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbgBQH6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 02:58:31 -0500
Received: by mail-ed1-f66.google.com with SMTP id r18so19620545edl.1;
        Sun, 16 Feb 2020 23:58:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qAkDAKXcgCBrOdSb/zgNyHSfr/RVZZb04YTPxwkLXA0=;
        b=B3eF+N02k7VwUkfLnH2qxhHQ9ZMDlFzRw6teDz8izk8Ot2aOdBqyRKpui2xo2GYhcY
         8gB7eiFWfv2sWTF0kZd7ZT0FRX4IaWD5zaQIuwVg3gTdjgrVhxhK9GrSC5GV3umsOLzB
         GqlQ77iSXysLAJlcdjgDV0JGvGisZzVhcjXQ+sMXaCpqQj6P5iMbjBz1GCDqfvTVoG9t
         OqcBncoVcZ4f+pH74emlQAvQNeq7G5bL5Dpns0wZnKElFiOdpfK0KrYriuTOuQcDs7EW
         KMVMM/LCe2m/m+ZMDPaBzaKsSAcIP8Wn3ExlNUdLohELOfF97Q3e3XbZwvYdsKtGan4V
         bEuw==
X-Gm-Message-State: APjAAAUsXfSKuuaRJBoNXgdqFOE75PFqGxI/Wi6c6uDWoGqimBa8OG+K
        2vvxcJbCNMPShAkcldFY2QUNvzdMrYg=
X-Google-Smtp-Source: APXvYqzWyvAJ00Xm4v5p11IJ/b+NZja63RU1ZUKX6t+oAqQcGTb28hAvi74Pp/jtHRQp6krZSKpPFw==
X-Received: by 2002:a17:906:7f02:: with SMTP id d2mr13010924ejr.261.1581926308218;
        Sun, 16 Feb 2020 23:58:28 -0800 (PST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id n10sm802208ejc.58.2020.02.16.23.58.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2020 23:58:27 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id p17so17271632wma.1;
        Sun, 16 Feb 2020 23:58:27 -0800 (PST)
X-Received: by 2002:a1c:dc85:: with SMTP id t127mr22154598wmg.16.1581926307557;
 Sun, 16 Feb 2020 23:58:27 -0800 (PST)
MIME-Version: 1.0
References: <20200217064250.15516-1-samuel@sholland.org> <20200217064250.15516-14-samuel@sholland.org>
In-Reply-To: <20200217064250.15516-14-samuel@sholland.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 17 Feb 2020 15:58:17 +0800
X-Gmail-Original-Message-ID: <CAGb2v649-ZJZfnOoNtsRuQXFOsZLg69Bizz+vZbB6yML-T8z2g@mail.gmail.com>
Message-ID: <CAGb2v649-ZJZfnOoNtsRuQXFOsZLg69Bizz+vZbB6yML-T8z2g@mail.gmail.com>
Subject: Re: [RFC PATCH 13/34] ASoC: sun8i-codec: Fix AIF1_ADCDAT_CTRL field names
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
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 2:43 PM Samuel Holland <samuel@sholland.org> wrote:
>
> They are controlling "AD0" (AIF1 slot 0), not "DA0".
>
> Fixes: eda85d1fee05 ("ASoC: sun8i-codec: Add ADC support for a33")
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Chen-Yu Tsai <wens@csie.org>
