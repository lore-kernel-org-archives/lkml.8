Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B769CC282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 01:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87C8320721
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 01:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="njJ3fqs6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgAKBOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 20:14:51 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:45606 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbgAKBOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 20:14:51 -0500
Received: by mail-io1-f67.google.com with SMTP id i11so4016557ioi.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 17:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=jxhHO7TnUt5CFGxVXLp4PUaAlysstA2E9WFkNf6HeEw=;
        b=njJ3fqs69ekKsCewD9b3mom64w15+ISwWIy/ODiGAXKNvHUgcfSg1JJuQZ5tnEPics
         f1yeJT8BbjZC6k0+66TTJT6oMkR5ceOQSjs1GM+KbwOoXMIxCwyFNTeIc6v1jbvekuKb
         bQ53zRrQaMBhyANsyVNsfIdvnUC43QZ5l1StqXlzEj6TTokCxg9glGd5aBvb+BCzGo5h
         oI+sZyAh/lgeg54K4rdaYfEIfw27T8OWtCrLFqTUmH0spYweujD/lTMmnuIzWJ191EM1
         x3UgIsYCIZ6U4KM5NO1Ta2jJ77bTEMnGgvjwZtDt54YjMEY08pNvHlvWJaie8qQArhJR
         gWnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=jxhHO7TnUt5CFGxVXLp4PUaAlysstA2E9WFkNf6HeEw=;
        b=ojywIzN0T1d8AnCy4vCIEHF2BxJsF8NJsW+aC3ZZ57WFNY95AwNSxI41PbA9B0yRNn
         Y8uqRrffjOhff5Aj+BBWtWSo49R53zWCHPxsoAsd8tVocQgTBksYUgJam+wIpAFEAKIG
         s/t8D+h0fjSNWK9wmWvkvCZhOLxK3fMQRHPi5DB19w4IJ3F4LjpMezJWPh8daAfts6DU
         GryxUGQ3VGDT/zYnWSuHOTyxoAPRetrvu8WizFOPKVuqR3RbVCsDZ+6rROB6aPddpfSy
         EqiY6/oAu0CQG+YZO9b1t2qichOKvn+yi4NdFoL2cBCbuS7BhZHdo6na3+xxJsV/L7YZ
         O0hQ==
X-Gm-Message-State: APjAAAXSJw/7/M8U9OFIobteiV1+0nE9DIvIWKNZHUY56+v3v5FTmFyS
        2K3cKH7HFnRTPGpS2v1VZN0xGw==
X-Google-Smtp-Source: APXvYqz1rr2BqNNcAIUBymdzx5yCkz75wNEsxLMCAEkRabGthYkaNySJoF9RhlWykCmMx/ULGKNU4w==
X-Received: by 2002:a6b:e30e:: with SMTP id u14mr4919205ioc.242.1578705289216;
        Fri, 10 Jan 2020 17:14:49 -0800 (PST)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id f7sm950752ioo.27.2020.01.10.17.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 17:14:48 -0800 (PST)
Date:   Fri, 10 Jan 2020 17:14:46 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Palmer Dabbelt <palmerdabbelt@google.com>
cc:     Olof Johansson <olof@lixom.net>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] riscv: keep 32-bit kernel to 32-bit phys_addr_t
In-Reply-To: <mhng-d39bd2da-7e27-484a-b8f8-a96edf1336c0@palmerdabbelt-glaptop>
Message-ID: <alpine.DEB.2.21.9999.2001101709090.2113@viisi.sifive.com>
References: <20200106232024.97137-1-olof@lixom.net> <20200106231611.10169-1-olof@lixom.net> <mhng-d39bd2da-7e27-484a-b8f8-a96edf1336c0@palmerdabbelt-glaptop>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2020, Palmer Dabbelt wrote:

> On Mon, 06 Jan 2020 15:20:24 PST (-0800), Olof Johansson wrote:
> > While rv32 technically has 34-bit physical addresses, no current platforms
> > use it and it's likely to shake out driver bugs.
> > 
> > Let's keep 64-bit phys_addr_t off on 32-bit builds until one shows up,
> > since other work will be needed to make such a system useful anyway.
> > 
> > PHYS_ADDR_T_64BIT is def_bool 64BIT, so just remove the select.
> > 
> > Signed-off-by: Olof Johansson <olof@lixom.net>
> > ---
> > 
> > v2: Just remove the select, since it's set by default if CONFIG_64BIT
> > 
> >  arch/riscv/Kconfig | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index a31169b02ec06..569fc6deb94d6 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -12,8 +12,6 @@ config 32BIT
> > 
> >  config RISCV
> >  	def_bool y
> > -	# even on 32-bit, physical (and DMA) addresses are > 32-bits
> > -	select PHYS_ADDR_T_64BIT
> >  	select OF
> >  	select OF_EARLY_FLATTREE
> >  	select OF_IRQ
> 
> I gave 5.5-rc5 a quick test on a 32-bit QEMU with 8GiB of RAM and the system
> wouldn't boot, so we've got at least some bugs floating around somewhere.
> Given that this doesn't work I don't see any reason to keep it around as an
> option, as if someone wants to make it work there's a lot more to do than make
> things compile.
> 
> I've put this on for-next.  If anyone cares about 34-bit physical addresses on
> rv32 then now is the right time to speak up... ideally by fixing it :)

You know, if, according to 

https://freenode.logbot.info/riscv/20200106

the main reason for doing this is to avoid autobuilder warnings, I'd be 
tempted to suggest we leave it in there so people have some incentive to 
go fix the real bugs ;-)

(that said, the patch is basically okay by me until at least QEMU is 
fixed or hardware appears)

- Paul
