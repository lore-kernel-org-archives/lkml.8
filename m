Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F68C35242
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 07:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCA6D2072C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 07:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgBQH4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 02:56:11 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46069 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgBQH4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 02:56:11 -0500
Received: by mail-ed1-f66.google.com with SMTP id v28so19552453edw.12;
        Sun, 16 Feb 2020 23:56:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=POZSjnznzGFS7zRQrJFpM+E5CtoyaZYCXz+IRVPYHNw=;
        b=CKRagxX+lmnr4YUePctnV5oHTg4FtKQ/NExcdUKiUzWpQqkzfIRsLFjkp+In7fx45y
         lbElqknH8VJ5vsnmFdrQn78qFfG6xIaFJurK9kQ8dzql96qmGyhPtSa5mkawGPvZQ09N
         wtvi/HSzTr58W1DHKAuCwHokutV/Voeez74EBIkWD2Kl6Y7qNieajVfYOe5ZpIK2VdsK
         wEWUSFgndNccPmaeG1MAPIC8qASK8JmRBp/Fm+EEDqqpk/fKtyyKBpek0jE+/o9qIbb6
         RAa2GnMBL2p6ykqkmJysTWdKEA3I+6JZe0d0gWGttcNH7vvaw3xToVX8k0EgN26aHmfd
         FXjQ==
X-Gm-Message-State: APjAAAWKlpAEsbsl+rbjtEbPrMGqwnWBSyBaWLFOmVGfQw3Md7QRfn9z
        54NvQwwXxQAEDxnCMy+MSiDeRAx52sw=
X-Google-Smtp-Source: APXvYqwp61iBI3qlUQLIi8Vv6z72A0E2LSpxeFkUhMzdXInZHD2Un16J08t3RkfLWGQgoJ+N31VImA==
X-Received: by 2002:a17:906:5604:: with SMTP id f4mr13679538ejq.255.1581926168996;
        Sun, 16 Feb 2020 23:56:08 -0800 (PST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id x10sm841275ejf.77.2020.02.16.23.56.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2020 23:56:07 -0800 (PST)
Received: by mail-wr1-f50.google.com with SMTP id w15so18402309wru.4;
        Sun, 16 Feb 2020 23:56:07 -0800 (PST)
X-Received: by 2002:a5d:484f:: with SMTP id n15mr20409557wrs.365.1581926167590;
 Sun, 16 Feb 2020 23:56:07 -0800 (PST)
MIME-Version: 1.0
References: <20200217064250.15516-1-samuel@sholland.org> <20200217064250.15516-16-samuel@sholland.org>
In-Reply-To: <20200217064250.15516-16-samuel@sholland.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 17 Feb 2020 15:55:56 +0800
X-Gmail-Original-Message-ID: <CAGb2v65ZHb0angmhZwkOA0uvKX1sNW+pERfhp4YiUHVeBB0g3Q@mail.gmail.com>
Message-ID: <CAGb2v65ZHb0angmhZwkOA0uvKX1sNW+pERfhp4YiUHVeBB0g3Q@mail.gmail.com>
Subject: Re: [RFC PATCH 15/34] ASoC: sun8i-codec: Fix ADC_DIG_CTRL field name
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
> This is the enable bit for the "AD"C, no the "DA"C.
>
> Fixes: eda85d1fee05 ("ASoC: sun8i-codec: Add ADC support for a33")
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Chen-Yu Tsai <wens@csie.org>
