Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E34C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 18:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61A4D20716
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 18:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580322256;
	bh=8TXf3aW9vzuW54Eio51i0XsGtf0KNJL9N8dXw2pLFZE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ikRI+tzytq5oGlXi17aTap9OoBPVXX5gKJq9svLEUepfh3E3Omwzg2mtTzjlNg1u/
	 xhbqcFbG5c2biUKDWgFOLlPAqQHdwQE90ImdxWZlTnHhGAW+sOGF4TaguACexoAXxT
	 631USWG2lykCBRwKzsDRPlCv7XQgXPyTyGTgWCD4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbgA2SYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 13:24:15 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43612 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbgA2SYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 13:24:15 -0500
Received: by mail-lj1-f195.google.com with SMTP id a13so377470ljm.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 10:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NX2pG5BX85VkfelsTQdQ5JSd3AKoTwJ5pQ15xJEg30w=;
        b=ft/bm56u/CHiacuUMpJVmiZTRiwYgPTGIFMn1KyMwkwFHcceIQDeEuHCQVcP0XkAkb
         GRbhwtph7yBEfVt8vH0xT458zagqsZ+cjaUICagYsOP8yTXD9a7Rkj6TVmnBfEmzreuQ
         /pULlOVyxrpWNkJJSL79mlPSddOb4L7DMs0as=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NX2pG5BX85VkfelsTQdQ5JSd3AKoTwJ5pQ15xJEg30w=;
        b=Km7yqetyuYw6mD/5GCUD6qsV1ogC9rkV750sdmwb/Er5oFiEtNy+wwStXWgXpySHdM
         7bda4cfgKe5GDNG63uvWQvAC3OFF3WY8VSSTTH2os9obzbRlJXF0XT+gAUj48BMM2dAj
         0+fA3luA6hA47jLj6WSvoM0/Prcnmq8ja/UbEKlKCdVBM3NrfI7uHN4J/G6RtdLG7bdB
         8ikbXl0Smx06PYiSetESW4cn2GF51TaArfaOuoXlDngwyLwdXi9weV7HJ6CSCxVY1FfY
         E+gU9tgkB+XPSNk1+V5my0G6N7HOgr/8p4UiuXHbYyoF3WNUKSjswG1bISeiYoLqcp/o
         baOw==
X-Gm-Message-State: APjAAAUjnjnVE/ZsJKMb5po/DgezzS327u3u/kbX353fxxsgobiEXE1p
        TnXr12p+OzjN8DaxFsh0S/EQfIQ2ZSQ=
X-Google-Smtp-Source: APXvYqxCdrzkJk2nV5yLb/sVpBfibn2GulD8ymChcO5P+IB4v0OPl3nlq8xPE/0ZQDGGR04UURLbQw==
X-Received: by 2002:a2e:8758:: with SMTP id q24mr255432ljj.157.1580322252445;
        Wed, 29 Jan 2020 10:24:12 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id a11sm1456954lfb.34.2020.01.29.10.24.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2020 10:24:11 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id d10so382623ljl.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 10:24:11 -0800 (PST)
X-Received: by 2002:a2e:97cc:: with SMTP id m12mr235022ljj.241.1580322250961;
 Wed, 29 Jan 2020 10:24:10 -0800 (PST)
MIME-Version: 1.0
References: <20200129101401.GA3858221@kroah.com> <CAHk-=wgwBfz0CtAFZMDy=A_Wz0+=dzrfWWiHESUD9CxnV=Xyjw@mail.gmail.com>
 <20200129182027.GA13142@kozik-lap>
In-Reply-To: <20200129182027.GA13142@kozik-lap>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 29 Jan 2020 10:23:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg67HWkPawJRFffOS25CL0tjzF7tbk-mJot9oT8siqPfg@mail.gmail.com>
Message-ID: <CAHk-=wg67HWkPawJRFffOS25CL0tjzF7tbk-mJot9oT8siqPfg@mail.gmail.com>
Subject: Re: [GIT PULL] USB/Thunderbolt/PHY patches for 5.6-rc1
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 10:20 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> The I2C fix for this is in Wolfram's tree already:

It was never an i2c error.

It was an error in that commit that made a change that introduced a new warning.

It is *not* acceptable to break things and say "somebody else will fix
it up later".

If it's broken in the PHY tree, then the PHY tree is broken. It's that simple.

We don't enable compile testing that causes warnings.

                  Linus
