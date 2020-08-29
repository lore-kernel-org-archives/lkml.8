Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19478C433E7
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 21:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED68320665
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 21:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598736039;
	bh=kfNj8QRLAirtdzuyew8TsWDu4G89vg40SrguYLUdq+U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1mmvLwSaHMzmieXwkwBseU2ZJq60rJ5HZQBiLiUdO6BQxY4tkBFEu4W25zchNuOca
	 CbtqR3UdUKtXPf7BFmRr/sZsuxANezJ4csgJ6zv72Xi4PyZsOhF7zt+UIMp6zGOBxq
	 9GHStEpBg83FJgGBJjnOo//drANmg+LZQtmAi76Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbgH2VUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 17:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbgH2VUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 17:20:36 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D834DC061573
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 14:20:33 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id k10so1508271lfm.5
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 14:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tZQqP/9kQfBYLXOwwY2/9XmqjIYfArF6oBpsrKgPoWk=;
        b=AbmLqUhkivcRKLvSZehoY6HsfcHP75SHwBbGTVYqRQmORnoNriFSmxObwU2VmHmy63
         E4Vz99EJMsmm7F9WygW1iy4/YZzTwxsfG/d5H+d6vMGaF7dADK4foWIt+zXy2W9YpTq+
         RCbxEzNzwxpfl9Mn69NXw7mfFaxWWWF27/u6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tZQqP/9kQfBYLXOwwY2/9XmqjIYfArF6oBpsrKgPoWk=;
        b=GWMBkVdBdJCqo3aw07RXaOfkNu+NIVr8v/0QZcDbJ4P5HuTK3R5p4HF+wa+rOYt/Pj
         FylcDspRBAi8G38Fz1Uqlh03Zp/BPTpxepkstPqm3A/tyJSgHLAmmMqwoLZiceD6XyIj
         GlogtIqS6mL8cK2Ezn/AhHhflVU6UcyYLFZcKaYwDSNbTvBKtGahNaGhUhD2U3W92mmY
         B5+VTb346exGnmG5SI2ssgREF+gfL5EepHurD7g8B+OWUw81Z0bnDJU6EBlk7P/Dk/Ai
         A7++jOrdKqDrtr+rri6Nq4kuoH+VG8zwYo460iXmyp9ySR366xn0NjaJxlooskPj+vEE
         iRog==
X-Gm-Message-State: AOAM530+uvHQvddNMWZD5rfKg/pRGg8Knfyzmyz6FcxPpr96bgTWxDoQ
        F46OC8lPTqxtZyzrT6XLOu33SPUb5uYukg==
X-Google-Smtp-Source: ABdhPJxEH4rE+hqz9avgz8WbgltS4V/4PDBOIspUYFEhB3I4eMU9uZo0LEYfgxUeDkfczccX8tdjIg==
X-Received: by 2002:a19:ae0a:: with SMTP id f10mr2255989lfc.100.1598736031860;
        Sat, 29 Aug 2020 14:20:31 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id c4sm679209ljk.70.2020.08.29.14.20.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Aug 2020 14:20:30 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id t6so2598342ljk.9
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 14:20:30 -0700 (PDT)
X-Received: by 2002:a2e:b5a3:: with SMTP id f3mr1027329ljn.70.1598736030159;
 Sat, 29 Aug 2020 14:20:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200829105116.GA246533@roeck-us.net> <20200829124538.7475-1-luc.vanoostenryck@gmail.com>
 <CAHk-=whH0ApHy0evN0q6AwQ+-a5RK56oMkYkkCJtTMnaq4FrNQ@mail.gmail.com> <59cc6c99-9894-08b3-1075-2156e39bfc8e@roeck-us.net>
In-Reply-To: <59cc6c99-9894-08b3-1075-2156e39bfc8e@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 29 Aug 2020 14:20:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjDEiWF_DsCVFPFqNa+JCS5SkOygbqeq8_=ZNOrFt7-rg@mail.gmail.com>
Message-ID: <CAHk-=wjDEiWF_DsCVFPFqNa+JCS5SkOygbqeq8_=ZNOrFt7-rg@mail.gmail.com>
Subject: Re: [PATCH] fsldma: fsl_ioread64*() do not need lower_32_bits()
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <joerg.roedel@amd.com>,
        Li Yang <leoyang.li@nxp.com>, Zhang Wei <zw@zh-kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        dma <dmaengine@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 29, 2020 at 1:40 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Except for
>
> CHECK: spaces preferred around that '+' (ctx:VxV)
> #29: FILE: drivers/dma/fsldma.h:223:
> +       u32 val_lo = in_be32((u32 __iomem *)addr+1);

Added spaces.

> I don't see anything wrong with it either, so
>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>
> Since I didn't see the real problem with the original code,
> I'd take that with a grain of salt, though.

Well, honestly, the old code was so confused that just making it build
is clearly already an improvement even if everything else were to be
wrong.

So I committed my "fix". If it turns out there's more wrong in there
and somebody tests it, we can fix it again. But now it hopefully
compiles, at least.

My bet is that if that driver ever worked on ppc32, it will continue
to work whatever we do to that function.

I _think_ the old code happened to - completely by mistake - get the
value right for the case of "little endian access, with dma_addr_t
being 32-bit". Because then it would still read the upper bits wrong,
but the cast to dma_addr_t would then throw those bits away. And the
lower bits would be right.

But for big-endian accesses or for ARCH_DMA_ADDR_T_64BIT it really
looks like it always returned a completely incorrect value.

And again - the driver may have worked even with that completely
incorrect value, since the use of it seems to be very incidental.

In either case ("it didn't work before" or "it worked because the
value doesn't really matter"), I don't think I could possibly have
made things worse.

Famous last words.

                Linus
