Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41739C7619B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 07:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 234E920718
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 07:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgBQH5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 02:57:38 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43951 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgBQH5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 02:57:38 -0500
Received: by mail-ed1-f65.google.com with SMTP id dc19so19545254edb.10;
        Sun, 16 Feb 2020 23:57:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RXwH2ZY89QD7QWNaSd/vgTmgRslu6k13i/RLcLVOpys=;
        b=XpdYOuZRGhAf/4f8vjnnHCIE07Jz5cGVcI6Bm2G6dhVA8wQAxVAT9ImxgW/Ls6Whts
         TjbON70KBnnVghC/FaHiKFjjZ618biWA1HabPn+1Rd5SJkmk03FMc6rQ/4nu50sMNHZt
         ZZ5kn7t4O9wLA0IGbx8Fg9PJZq5Ld8vUEIs/Kc54ZyV4X/wFq8uUKrRZ/TNfMWeBEXFH
         qncUPIdxDN1RxAVQIRiQj4pnJPrYsQeeVYosn6OWHY/F5aaTwNemSUi5PpRrBAm4fhYY
         +Kz9eP8HP1WUDmSCtUbaunqwXxf4lHazgGULVjlHounHuqdQpf3xneouST0nn55xwibq
         yq/A==
X-Gm-Message-State: APjAAAXKkxHg6YbNkoHmNeqa1tijD+osxwt4OGkdjafuvrVWhqUGbkAw
        RXsRFGnbTELwtCC/Advna+lopEIEth8=
X-Google-Smtp-Source: APXvYqxkosmKjF5zZkh8J7OI5YNsUYygv0yQ1cZaNwJZDZSMVmC+YVla/O1inpsUlB59cxrGU4nuOA==
X-Received: by 2002:a17:906:eceb:: with SMTP id qt11mr13263474ejb.119.1581926255692;
        Sun, 16 Feb 2020 23:57:35 -0800 (PST)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id i11sm819850ejv.64.2020.02.16.23.57.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2020 23:57:35 -0800 (PST)
Received: by mail-wm1-f48.google.com with SMTP id g1so16069379wmh.4;
        Sun, 16 Feb 2020 23:57:35 -0800 (PST)
X-Received: by 2002:a05:600c:34d:: with SMTP id u13mr21328621wmd.77.1581926254712;
 Sun, 16 Feb 2020 23:57:34 -0800 (PST)
MIME-Version: 1.0
References: <20200217064250.15516-1-samuel@sholland.org> <20200217064250.15516-15-samuel@sholland.org>
In-Reply-To: <20200217064250.15516-15-samuel@sholland.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 17 Feb 2020 15:57:24 +0800
X-Gmail-Original-Message-ID: <CAGb2v67ZtOajmfvoFNfsqWJ4K3pjfW16uoWYnMUcpqi7fg5XAw@mail.gmail.com>
Message-ID: <CAGb2v67ZtOajmfvoFNfsqWJ4K3pjfW16uoWYnMUcpqi7fg5XAw@mail.gmail.com>
Subject: Re: [RFC PATCH 14/34] ASoC: sun8i-codec: Fix AIF1_MXR_SRC field names
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
> Even though they are for the left channel mixer, they are documented as
> "MXR_SRC". This matches the naming scheme used for the main DAC.
>
> Fixes: eda85d1fee05 ("ASoC: sun8i-codec: Add ADC support for a33")
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Chen-Yu Tsai <wens@csie.org>
