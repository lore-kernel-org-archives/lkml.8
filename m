Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC49AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 16:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B85E420723
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 16:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593536015;
	bh=oCNpiZU8K1IJkfkI0vUV7jtEqXgvc1CovtyRJmUUCcw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QnNw2d4hPUR8VMY6kQXdHpz4uOnNnpDTP5effO9iEOZy8V8E95mABjcDDE3+alsNP
	 s/s21yngvCIlaoNFNL9LPIRH4C0nmIDuzUusl9V7p0ZFHb5NDEVRrBuzMZEANpbzq4
	 Dq80Nhs4meqerrJQ/Yj40MT2M8wvERKUqbBj196g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389879AbgF3Qxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 12:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389637AbgF3Qxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 12:53:33 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA797C03E979
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 09:53:32 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id y13so11795830lfe.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 09:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HXhwNHUbt6390YwktKffDdYHBSIVcgUbNP65DA7M3A0=;
        b=YMxx5tmKReY0G4VCKq7dPV+KYWq8YMTtgf6DfgbvR0/q13+4ttOunbsr+WSE+ofeb/
         r3a0G5HpoHjV5n3v6+nWCRNTnxYHJcu8FXl7c/4/iRgcSKImTR4CfCW4aybv77HLiBJo
         rAox9lSf8Z1KnYQLFVFltvKxte2/w24THOXww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HXhwNHUbt6390YwktKffDdYHBSIVcgUbNP65DA7M3A0=;
        b=qvJe3k+jI9aAjDgktorrT0yIMO7N/SuHVueCeLgGk4dOpeljHzqc41lMvvi1w1XbER
         HFZJvdzVzpCynWywR9rUAoads+vPSBPd9sab8tPo1jqoglEs9LNs5zU/j9TFYKij3zjU
         47VNZRDiOO+J1cCvNBvvpW02Oa5cCbUCcxEPTv23bWmSXB1BWIsuLBJO+EzyOaYxXy+n
         R6lrlckQJcuQR73UX0A+Bz9ZQewW/ZEX3oWNfU6b4j2KeKrOIyscqKFaIaDhK6/pHr8U
         RiOcoc9Nj0ysNbYM++3XFq9AXufBCtkJTavldEaZVSBQj/tyeBhgkHR3ZqG4ELeGFC6p
         GGlg==
X-Gm-Message-State: AOAM531F6pg6CX3nt5Fx8hkzYJJwAxCB7A0m67FfIplS82M1iVy/LeHh
        sWtJ+7jWGdmHiDbkxPlF19WnpQLAieA=
X-Google-Smtp-Source: ABdhPJzbGbuMN0nBIkLgmNVAGxwuBO8IXP4sL6DT+3VgpzQyisL7pc+r4FcFO6d+faMVWMWGtkaEhQ==
X-Received: by 2002:a19:691c:: with SMTP id e28mr12608618lfc.131.1593536010841;
        Tue, 30 Jun 2020 09:53:30 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id f13sm997291lfs.29.2020.06.30.09.53.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2020 09:53:30 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id s16so6359021lfp.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 09:53:29 -0700 (PDT)
X-Received: by 2002:ac2:5a5e:: with SMTP id r30mr12519698lfn.30.1593536009235;
 Tue, 30 Jun 2020 09:53:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200629182349.GA2786714@ZenIV.linux.org.uk> <20200629182628.529995-1-viro@ZenIV.linux.org.uk>
 <20200629182628.529995-18-viro@ZenIV.linux.org.uk> <CAHk-=wjd5HML-EuPGH7J8CjWJrbnMhst3NJbcUyt-P0RV649nA@mail.gmail.com>
 <20200629203028.GB2786714@ZenIV.linux.org.uk> <20200630132508.GF2786714@ZenIV.linux.org.uk>
In-Reply-To: <20200630132508.GF2786714@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 30 Jun 2020 09:53:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=whAuAEXw1s2jF01nmT7iPWEeRv+ggKgCJ1U96-6KGgCmg@mail.gmail.com>
Message-ID: <CAHk-=whAuAEXw1s2jF01nmT7iPWEeRv+ggKgCJ1U96-6KGgCmg@mail.gmail.com>
Subject: Re: [PATCH 18/41] regset: new method and helpers for it
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 6:25 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> How about ->regset_get()?

Sounds good to me. And if you ever do something similar for 'set', you
have a natural name to pick.

No need to repost as far as I'm concerned if it's just the name change
and some minor nots found by the bots.

                     Linus
