Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68748C7619D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49A432067D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbgBQIWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 03:22:48 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42400 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgBQIWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 03:22:48 -0500
Received: by mail-ed1-f67.google.com with SMTP id e10so19641396edv.9;
        Mon, 17 Feb 2020 00:22:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TGqR9iwqEEPoAOlQ581BXw8F7VHSOXMBtuvI7O8A+Jo=;
        b=jwxTxTeDDtPNK1DUAGO8rR6/vXCkqfzIBW+w2rqUkBhdgvOszem8iLG0A2+aqLMT/k
         ZYIvkqYRrSslF3j2y9Fw6HshXE6Ms/T3B7yV8Esr1Xjs8IbFd3SYxf9MWlkJBaHo628+
         2DNCFpF3THVLfz8tx3xLwOpnVbMLUQjLxh+swwIbFhgXd7yH65VjEi+1MNzL4DY+ZXra
         jTGE4ZP4+QJevTqNnrvwRl5G3Zgfkmrr3IdzjFRDG+4YL7QDqNJrv/syrwx4GjcuHRZK
         mb5x73eFwxkTf+3htipOf+afkiiYeuRzm/0MI8NM8vqV41sIwg0vUC67IyhKBVfm8/KS
         lMAQ==
X-Gm-Message-State: APjAAAVDo5f3xkq4YzxTGXPn1kBk2HEt9bpc5K7kvJEoWi2j7w3ZW+G1
        paz2tAMMr4qbnQn4r2DkNfNUAak/g+Q=
X-Google-Smtp-Source: APXvYqxZVTgBoYbx5aYxovaXJqQpIrZdWW34I4Vji6sRLS9nh+REkw7isNLypMqq05p95PabIpeCeQ==
X-Received: by 2002:a50:fb02:: with SMTP id d2mr13061346edq.270.1581927764571;
        Mon, 17 Feb 2020 00:22:44 -0800 (PST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id k12sm448894edq.27.2020.02.17.00.22.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2020 00:22:43 -0800 (PST)
Received: by mail-wr1-f52.google.com with SMTP id w12so18486334wrt.2;
        Mon, 17 Feb 2020 00:22:43 -0800 (PST)
X-Received: by 2002:a5d:4a04:: with SMTP id m4mr20971822wrq.104.1581927763057;
 Mon, 17 Feb 2020 00:22:43 -0800 (PST)
MIME-Version: 1.0
References: <20200217064250.15516-1-samuel@sholland.org> <20200217064250.15516-9-samuel@sholland.org>
In-Reply-To: <20200217064250.15516-9-samuel@sholland.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 17 Feb 2020 16:22:32 +0800
X-Gmail-Original-Message-ID: <CAGb2v67TfTN6_wRgbLswEr_ShvL7Zb2-tgj7bS7oA6UfLvc0GA@mail.gmail.com>
Message-ID: <CAGb2v67TfTN6_wRgbLswEr_ShvL7Zb2-tgj7bS7oA6UfLvc0GA@mail.gmail.com>
Subject: Re: [RFC PATCH 08/34] ASoC: sun8i-codec: Fix direction of AIF1 outputs
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
> The naming convention for AIFs in this codec is to call the "DAC" the
> path from the AIF into the codec, and the ADC the path from the codec
> back to the AIF, regardless of if there is any analog path involved.
>
> The output from AIF 1 used for capture should be declared as such.
>
> Cc: stable@kernel.org
> Fixes: eda85d1fee05 ("ASoC: sun8i-codec: Add ADC support for a33")
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Chen-Yu Tsai <wens@csie.org>
