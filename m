Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E344C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 00:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 619F52064C
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 00:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JskvBMyR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgAKAR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 19:17:28 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41013 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbgAKAR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 19:17:28 -0500
Received: by mail-pf1-f194.google.com with SMTP id w62so1905674pfw.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 16:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6jKeWeD5y+GkhgTJIyMUV9GSPEn0NfxLM3Pa9VZ2QXM=;
        b=JskvBMyRQNj60bC9BGBO/leq3hU6SF+FZARMBel8xvh9hqsFODxPiscCwbq524AUJ3
         51h2p9tBW/DgKf2EtVq+N10euWHYzuAW979wXLNNYw7eI4/FftmJ5rIwK5a9KpyYroit
         g8vhNWm47AOTXjbhRGDqAv0sln5Xb+f0yyLWQpS6/d7UBbi06bNRZUp0y8Rp4ZXQcb1x
         Iag78bn+0sp+nok07/WxfiTUo3S9SiwbrNbaX6s1qe+VyY+HLAHoTLVmKODHgn6dYYHT
         CrmPLMvmdjUBK+kxEsdwT3wCkyUGrPXH3KJa23NbAANs1X/Bj0DS8Vm4eUv84zbowZpJ
         3Peg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6jKeWeD5y+GkhgTJIyMUV9GSPEn0NfxLM3Pa9VZ2QXM=;
        b=DythlZhLHx008TSSg/G012rlWQV3v1mZR0bPEQFe9A+BAk7cd9LOjPpN4Xe8NUr2i0
         DYZCcxH690qsN38bVVKqhQZuA2VxP7ZTtyuDHFT9LQboXC3bE+uK+VBxHW7Nmba1WPk3
         9xHFaEbei7jYra07RHR7lvBN2/iNDdfmw1MkcN1JDw+hx21057biye+Aa4fO0ADLiVdP
         wlQW1NiEArTvw/hnqKiBNAXNXjj9quNtsyXONxs3PGcfQn2QQO626jUPrwsttxtO0JKY
         vO6Uuo95ZDxeUcGORcEw7MC5Br+88XaqydnjB2kHFeNOVKHb0s6QXjLUgtQICqTseEal
         vB9Q==
X-Gm-Message-State: APjAAAU5bh5bov7sJfUVFeYeSSJM5ojddqxhZixpvr+nhoogkdRVfuS7
        8mkoGzjNtFWTLUC8LnRAhS8=
X-Google-Smtp-Source: APXvYqwOyc8GRcABPQ9HKi/3r0oNu7a9DKllT9i3t3WKWwcDAQZK2D4NVxCWi+k4boX2maLxiv1NcA==
X-Received: by 2002:aa7:9808:: with SMTP id e8mr7303386pfl.32.1578701847442;
        Fri, 10 Jan 2020 16:17:27 -0800 (PST)
Received: from mail.google.com ([139.180.133.10])
        by smtp.gmail.com with ESMTPSA id c14sm4311437pfn.8.2020.01.10.16.17.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Jan 2020 16:17:27 -0800 (PST)
Date:   Sat, 11 Jan 2020 00:17:23 +0000
From:   Changbin Du <changbin.du@gmail.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, hpa@zytor.com, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/nmi: remove the irqwork from long duration nmi
 handler
Message-ID: <20200111001723.4ygbhfcza2ifrpzn@mail.google.com>
References: <20200101072017.82990-1-changbin.du@gmail.com>
 <877e20bb8o.fsf@nanos.tec.linutronix.de>
 <20200109210225.GK5603@zn.tnic>
 <20200110140549.xqjhrdpxllkvqbuk@mail.google.com>
 <20200110151329.GF19453@zn.tnic>
 <20200110173449.rhr5p4lal3aul43g@mail.google.com>
 <20200110195837.GJ19453@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110195837.GJ19453@zn.tnic>
User-Agent: NeoMutt/20180716-508-7c9a6d
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 08:58:37PM +0100, Borislav Petkov wrote:
> On Fri, Jan 10, 2020 at 05:34:50PM +0000, Changbin Du wrote:
> > Just to move all the check code together and be a standalone function.
> > yes, this somewhat does code refining after the irqwork is removed but
> > I think it is normal.
> 
> But it makes review harder because your patch is removing irq_work,
> *nothing* in the commit message is talking about *why* you're doing
> that additional change. I'd imagine at the end of the commit message
> something like:
> 
> "While at it, repurpose the IRQ work callback into a function which
> concentrates the NMI duration checking."
> 
> This lets a reader know know why that additional change is done instead
> of going back'n'forth and having to ask you why you're doing this.
> 
> Ok?
> 
sure, and thanks for your suggestion. I will send v2 later.

> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

-- 
Cheers,
Changbin Du
