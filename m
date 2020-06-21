Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D44C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 19:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEF3F2524B
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 19:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592768688;
	bh=abAIR8nTqT0KepVnc4pCQhrXhs6NciM1iqZfby0sODM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=aMWXcptF2iF1m0F3HIB+S7d7XfJILKXhe9k2WhAcjWK8nCbbEg0EK48KQ5P2e0WKy
	 +p+z/y0hvNYoljyJUyUhDJIc8C5Fx++zlr7363hgT5tQgUubNVo3+orw8g0PAs4Xwz
	 EuZzr3teTPHBI38icEGDhzKhUaJ2XnwqDR5jwMDs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730545AbgFUToj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 15:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730181AbgFUToi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 15:44:38 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52ADBC061794
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 12:44:38 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id m26so8381072lfo.13
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 12:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fSLpPxMEz7DxYqE5ffZM/BXJwv/YNcdB/XLkDwuN+BA=;
        b=AWZ2VQ8N8O6rqj1PNwGwf2BvwoUMCwCk4LaNpr+V7Md3ptnDfdsWPgR9Tt3njRDzu+
         EAAte8yrs8pHBp0eWRn2yPCe07Gfhfl2Vv1qyo6LMSWMoMisfXefIVlnq2mtJNZaEkuq
         21wSz352wzUz3QiiKaE70UX/wrDTriZ8JcMLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fSLpPxMEz7DxYqE5ffZM/BXJwv/YNcdB/XLkDwuN+BA=;
        b=mDgv3ql7QzLRHyftlIP0qVoJ/zylqC6y+NasmGmrDHa1NJU+7kEeoKtU4gNqBJDIHY
         NxOc1TX4YI7qFLMszAw78cYZVkwjeBYf3jFWoDZQZTWC4cACAAeqwMUNYeNWWsmnxp6d
         VZm578YTKkTkkkFA1OIvThR5MgxLsxaLifG2wh20AKoiG4iveaNVE36WfbVR3KA8vpUK
         AeUOtSAii576Xqedh7pOPQBT/gU4/a8jgXiWEJrOvxkVLunUcZv3DBuqE46tqOof748M
         xoxvZE6mmhB7dIdEd741xT6XNzIOzj3sJtoWrw1+d0nY5Mx1BUYyKhUP4StX1/ndPzFe
         malQ==
X-Gm-Message-State: AOAM530wvoBHllV0qwz47xt7l98rOCn+2mcui1bWwX77vnS+QiI/2vjk
        WxpRhtZAz1zU0ogEapHIDB8QvVQn5dg=
X-Google-Smtp-Source: ABdhPJwuO8mt0qcgnDrQ0YXE3vtzqqnrnyW+Mrbx5xOuT+pPe4LMcPd008sfiB07r1at7MN+p4UnZg==
X-Received: by 2002:a19:2292:: with SMTP id i140mr7674278lfi.95.1592768676311;
        Sun, 21 Jun 2020 12:44:36 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id a22sm1710753lfg.96.2020.06.21.12.44.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jun 2020 12:44:35 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id n24so16894080lji.10
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 12:44:35 -0700 (PDT)
X-Received: by 2002:a2e:b5d7:: with SMTP id g23mr6448596ljn.70.1592768675067;
 Sun, 21 Jun 2020 12:44:35 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2006181751270.9276@xps-7390>
 <20200619065007.GA3041@lst.de> <alpine.DEB.2.22.394.2006182351090.9276@xps-7390>
 <20200619074233.GA3723@lst.de> <alpine.DEB.2.22.394.2006200640370.2845@xps-7390>
 <CAHk-=whj7YBvNT3FPHc8oUqwRhjbRkJESnUx6bbpA5ys6W9ujw@mail.gmail.com> <alpine.DEB.2.22.394.2006211226240.9484@xps-7390>
In-Reply-To: <alpine.DEB.2.22.394.2006211226240.9484@xps-7390>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 21 Jun 2020 12:44:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjDfQZN8BeM-21vZ=ALa5jaJSRjRei+_0ET9uruwaYwaw@mail.gmail.com>
Message-ID: <CAHk-=wjDfQZN8BeM-21vZ=ALa5jaJSRjRei+_0ET9uruwaYwaw@mail.gmail.com>
Subject: Re: Commit 25f12ae45fc1 ("maccess: rename probe_kernel_address to
 get_kernel_nofault") causing several OOPSes
To:     "Kenneth R. Crudup" <kenny@panix.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 21, 2020 at 12:30 PM Kenneth R. Crudup <kenny@panix.com> wrote:
>
> > Which is the obvious next step: would you mind compiling that file
> > with and without the patch and sending me the two object files?
>
> It looks like you had already, do you still need me to do this?

Yes please. For me that patch makes no difference. With gcc, it
generates the exact same code.

> FWIW, here's my gcc info:
>
> $  gcc --version
> gcc (Ubuntu 9.3.0-13ubuntu1) 9.3.0

Yeah, well, I've got

  gcc version 10.1.1 20200507 (Red Hat 10.1.1-1) (GCC)

but it's not like yours is any known problematic one.

But please compile that probe_roms file with Chrisptoph's patch that
makes things work for you, and without it - but otherwise identically
and with the same config options that work with that patch applied.

> OH- I did change arch/x86/Makefile in my own builds- maybe this could matter?

Doubtful, but who knows. The fact that so far yours seems to be the
only report of this, and it looks inexplicable, maybe it has that
tuning difference that triggers it.

But don't change it now. If it is what triggers the issue, it's still
an interesting datapoint.

You might test (separately) if removing that change from your build
makes a difference, but I'd like to see what the code generation
difference is with the patch and without, since there _shouldn't_ be
any.

          Linus
