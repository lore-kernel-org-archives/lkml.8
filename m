Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B57C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 22:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56A90246A8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 22:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ojCXi//c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgB1WF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 17:05:57 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41757 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgB1WF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 17:05:56 -0500
Received: by mail-lf1-f68.google.com with SMTP id y17so3197557lfe.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 14:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C8LpeFRkJkAVGCGFA7ZkDQ8EDfylVrvQYhKNrzB5Agw=;
        b=ojCXi//c/Oh73F5Il6IazTwlBEsFoNfw47/YGyUECYl4dvUC6WgxSI3iyIlBLbz3mZ
         OSWB0BXF+JhGvD/zk+/GTAVNuJymMfHWiE5Sv3OzrtLzD8wvItVwx6Rc09jJQNdTPYzX
         r+nTnXjxGnxb2Xi53R4UsUcTjKMg0E5gsaEkeqNNdoLNPTlR4pZw9KtGmo/qhkaQZY0q
         Ebc8ul2qrGS9XuhqUFeb5gUHcchMPES2yWxB5pCRDT3o5006DzOBQ6kNkjHlHYrGFg3y
         /wC1+1VRU56iKegko8xSykYkKhnvdO+/IIHG94etItcj9WvTOxgl9cgYOkx6IiaBsY6G
         TagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C8LpeFRkJkAVGCGFA7ZkDQ8EDfylVrvQYhKNrzB5Agw=;
        b=i9uPe4sE6nWTQdtGSHcVJb2lBMoxsfCmhxNkvd6sJaCY9FPUN3Zt/rDu36ZWb2NjVg
         xTzhdMRXAXphRpsFzH+T9YT5ST1uXTwrfSbKVGJZK7eJoF+sB3HuZrNbF4i5EhSnqC03
         EIDekHObUidpUsStJ0wqd0W+FFZ7uB0RyoMiXG1xLSbpfsjiNtduuElQwxfku4+J4xaa
         qCyEeyK4ZZUqhhHs0qsHcav0zqHp+Vhd3XRs02uHIKkyhEN5pLaGGY9479bTwSZAhcS2
         GDHRGj88HRVCO4VlgbngqUQDcpBI/XPHBAa5tpwaJ6CAvQ/Dj/xGcM45ZnmIm5iPPdIC
         7n8Q==
X-Gm-Message-State: ANhLgQ0cXQl7wSKWNaG0BCbFuozngPsXr1aaAQ9uLXb035daS2T+SqIB
        vdt0dwnuwQzfXbllZwtSx92MoTsL3FpxPyRTtakzXw==
X-Google-Smtp-Source: ADFU+vsnW+F7X3gpdEz8AQTDqD1Tj7f66W9FTRZOnyRHh9OXBDCJ69RY3C5fHJ4DyNMTzylusEt2hk5oPHgCphc0DMY=
X-Received: by 2002:a19:87:: with SMTP id 129mr3655815lfa.217.1582927553833;
 Fri, 28 Feb 2020 14:05:53 -0800 (PST)
MIME-Version: 1.0
References: <cover.1582913973.git.hns@goldelico.com> <010d6ad3473fb4b1f1041888a071796180cdd838.1582913973.git.hns@goldelico.com>
In-Reply-To: <010d6ad3473fb4b1f1041888a071796180cdd838.1582913973.git.hns@goldelico.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 Feb 2020 23:05:42 +0100
Message-ID: <CACRpkdYSde=6JBBbe3sL3hDHhGAeOfwadT0BvL0n+-F0O2vX0g@mail.gmail.com>
Subject: Re: [RFC v2 5/8] pinctrl: ingenic: add hdmi-ddc pin control group
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Paul Boddie <paul@boddie.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 7:19 PM H. Nikolaus Schaller <hns@goldelico.com> wrote:

> From: Paul Boddie <paul@boddie.org.uk>
>
> Signed-off-by: Paul Boddie <paul@boddie.org.uk>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

This looks good, can I just apply this to the pinctrl tree?

Yours,
Linus Walleij
