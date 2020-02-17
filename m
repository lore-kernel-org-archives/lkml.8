Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E819C7619B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 07:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58507206D5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 07:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgBQHlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 02:41:44 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46672 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgBQHln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 02:41:43 -0500
Received: by mail-ed1-f65.google.com with SMTP id p14so11383636edy.13;
        Sun, 16 Feb 2020 23:41:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=76WiewyfAQysMsVYcXQkeWLkjiTOOZNh8t0AnmKu14M=;
        b=lqg1TAIE3mMMWfgMrHXFUlYHiwEs6KzOI5RPvLytgfv+dIDrwuR/MLUY0/uTy6Z2oA
         p9OkFEYvhmxQ7i1fx3+RM5/47BnPwneyy9u8XwZ3H3KEGgJZThS9Pe0bdGyM3KtlCslf
         0d8ZhCULpIliDW9/Xo2lUux3xnHE9tEDSk1RWq6RBJezs+K3regj6Y/FetmDWMKS0jc9
         6UAHQmahBslp1YOyLvZ27kXTrcF/7Wv+AHG9O+px7ISDISVqikLGHxwoAHHIURsekDuj
         WPa2vh9OCC2Cl8988391EVOagXXJTBYVSyAZbWMmTUbm5XxhTas6NuSZliOD/zrbSsLF
         Pfhw==
X-Gm-Message-State: APjAAAXGS7Etms5CLxYizd0uy6VpSRFJ3F7ojxxg7lRGAc0r+J0eWp1v
        cjI8VTu0HD2p4MdwAgVcekZbQ78R8tQ=
X-Google-Smtp-Source: APXvYqxNUwWtuzyu3XLYnlq0qag2tmGzszgI1Ec/xqs4MRbkWjAwqvblKHzNX73QxFhI0fj0dlOFgw==
X-Received: by 2002:a05:6402:22c1:: with SMTP id dm1mr12303346edb.21.1581925301367;
        Sun, 16 Feb 2020 23:41:41 -0800 (PST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id r24sm501431edv.69.2020.02.16.23.41.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2020 23:41:40 -0800 (PST)
Received: by mail-wr1-f53.google.com with SMTP id w15so18358543wru.4;
        Sun, 16 Feb 2020 23:41:40 -0800 (PST)
X-Received: by 2002:a5d:484f:: with SMTP id n15mr20324028wrs.365.1581925300705;
 Sun, 16 Feb 2020 23:41:40 -0800 (PST)
MIME-Version: 1.0
References: <20200217064250.15516-1-samuel@sholland.org> <20200217064250.15516-5-samuel@sholland.org>
In-Reply-To: <20200217064250.15516-5-samuel@sholland.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 17 Feb 2020 15:41:29 +0800
X-Gmail-Original-Message-ID: <CAGb2v6543yLuBUi_37DbFdfkOo_OBK8v-rB2hViex_BCzAurPQ@mail.gmail.com>
Message-ID: <CAGb2v6543yLuBUi_37DbFdfkOo_OBK8v-rB2hViex_BCzAurPQ@mail.gmail.com>
Subject: Re: [RFC PATCH 04/34] ASoC: sun8i-codec: Remove unused dev from codec struct
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

On Mon, Feb 17, 2020 at 2:42 PM Samuel Holland <samuel@sholland.org> wrote:
>
> This field is not used anywhere in the driver, so remove it.
>
> Fixes: 36c684936fae ("ASoC: Add sun8i digital audio codec")
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Chen-Yu Tsai <wens@csie.org>
