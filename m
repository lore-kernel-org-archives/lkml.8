Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C76C7619D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA7A920725
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbgBQIXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 03:23:45 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43345 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbgBQIXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 03:23:45 -0500
Received: by mail-ed1-f67.google.com with SMTP id dc19so19625181edb.10;
        Mon, 17 Feb 2020 00:23:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RCvgYdsJcfvOF7DNGv6F0fWsfl3RWpjn9MSCG6l5nng=;
        b=iHGs99C61VciBC7Q1bnkmUshocl09Ah31eAiy17q0VDfNuLxv5gHgBgCpvNUzSJdbe
         /bwvf4RsuXbmdyP2Dub8qv6kTKkNC7qfwovDnxMOP539tZ7SLcE29XUCO46kGWIuRzFc
         0T/1F8BKfSEeUTiYslf1S02VAbODT8eh6gY+oQ/bNNHWcq2pIV1Ew04Jlv2jo2YCBWTH
         8K88Xbsux/mJChBYYdvyY0slynBbj16uL5ds6N4rrIBaTq2hMJQ6DZM5sFhCdHxKdYUS
         +16X2eOZpCsRPSBXshHEQEeU+B5cILL4wCS1zKcrNK5yjIu6zot120gPegoI0NjmyT8L
         +cbg==
X-Gm-Message-State: APjAAAXpVXizhxlaiKhu/djTD+UHV+GhRz0XaHjN8eclwOphA2d6CNAU
        uIkWWkLSOuOGvOAsWAdP0hrNSH/ewsg=
X-Google-Smtp-Source: APXvYqwyxVAi/FOSdsitAeFh5J21SXf6PLt2xOG/z3I2loykIQ26tf2+KQibZcw0Oik0GzvI35gMeg==
X-Received: by 2002:aa7:db16:: with SMTP id t22mr7907777eds.54.1581927823116;
        Mon, 17 Feb 2020 00:23:43 -0800 (PST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id d9sm452818edp.97.2020.02.17.00.23.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2020 00:23:42 -0800 (PST)
Received: by mail-wr1-f50.google.com with SMTP id k11so18470415wrd.9;
        Mon, 17 Feb 2020 00:23:42 -0800 (PST)
X-Received: by 2002:a5d:6805:: with SMTP id w5mr21282613wru.64.1581927822372;
 Mon, 17 Feb 2020 00:23:42 -0800 (PST)
MIME-Version: 1.0
References: <20200217064250.15516-1-samuel@sholland.org> <20200217064250.15516-7-samuel@sholland.org>
In-Reply-To: <20200217064250.15516-7-samuel@sholland.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 17 Feb 2020 16:23:31 +0800
X-Gmail-Original-Message-ID: <CAGb2v65pow6ufaz=6f8rWMXkmknLL2toYgUj-wM9sqns9Xy-ow@mail.gmail.com>
Message-ID: <CAGb2v65pow6ufaz=6f8rWMXkmknLL2toYgUj-wM9sqns9Xy-ow@mail.gmail.com>
Subject: Re: [RFC PATCH 06/34] ASoC: sun8i-codec: Fix setting DAI data format
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
        linux-kernel <linux-kernel@vger.kernel.org>, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 2:43 PM Samuel Holland <samuel@sholland.org> wrote:
>
> Use the correct mask for this two-bit field. This fixes setting the DAI
> data format to RIGHT_J or DSP_A.
>
> Cc: stable@kernel.org
> Fixes: 36c684936fae ("ASoC: Add sun8i digital audio codec")
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Chen-Yu Tsai <wens@csie.org>
