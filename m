Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC61EC54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 10:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6168206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 10:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjPE4jm3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbgELKsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 06:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729620AbgELKsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 06:48:02 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F157AC061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 03:48:01 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id t40so9179027pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 03:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wx1X8iNuCSGQdwmyumR8C36ztcjWhzzV8K++lJgo8hU=;
        b=QjPE4jm33jKmxgwOIt7p/necO5ARxg92dLx8nJOnQpNPFKRSk8OdjS7NAn9aZFWqbC
         uHjMJ1DfN38KlTHpwW67PTGOAsI/2yWrcyKZVrFRU3GUwc7RC2VrWDyMW5IxdG639yM8
         5Xi40NvaGfGzcMUJ2OHrtQDiz/6HxF74UYCI0HHqcmNX9Yn9tsZCIlvCb3HStJJd3Pq/
         ahPOjflzkgs/gcEGXqyK9ccqgee2PtyQYDMLTqyFb9csmo/zOYOdtqxx0weUXYeu/9XN
         n4Jxnj0yspqBXPX8ygoZwPaKZTwjX5wmtDpkzmULGr5ZrVw8SgJTJ4RfmA3UvcjUAVxl
         13Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wx1X8iNuCSGQdwmyumR8C36ztcjWhzzV8K++lJgo8hU=;
        b=k1U+jsKPK+VJmRQIsWKy/PFw4XdZ3MuQenS0lxxzVuKr064JFi29HkBe2qcMD1S0RH
         UUKGyuG4mrDEPwweqRQLDFZdEOw8T6Vuxocow/SFFNn6mRaeXKPZZS88ejxLdIbBPwM2
         1/Fl/ic86GjDE//3bn3U2m/SJYflEEdkVzGfsB3XH+mY4d181rl/hhZKM1Jnl1oRcsk0
         AVM7hz0ufNccaciwYnoFJ5usqS2ad1PGnY9NZnbxE1Ca/z9BNrzR+kusK2uiXA41/625
         M0H9gL/8YX8Cwl45z2Byw13iNIkYZS5vzxrmHtDoF8zyXgAYbDmgOnrUr6JIxpppnN37
         6l0w==
X-Gm-Message-State: AGi0PubUBFv+kRGDvazv9JY7U4JMK2FSMv1DXBCiLlJ0J/lL+XWPWpHc
        JvI8r8W9BM4ngA64QYXrte4Ki/rMzKg=
X-Google-Smtp-Source: APiQypJ8n7vl3UmuVLMMPmxQfPkg634RcA7SzDDIjIaR/NI/XMDi54GNxiWnAUW7l0Tigt8jHQPcrw==
X-Received: by 2002:a17:90a:266c:: with SMTP id l99mr25541280pje.186.1589280481202;
        Tue, 12 May 2020 03:48:01 -0700 (PDT)
Received: from localhost ([183.82.181.65])
        by smtp.gmail.com with ESMTPSA id a196sm11832283pfd.184.2020.05.12.03.48.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 May 2020 03:48:00 -0700 (PDT)
Date:   Tue, 12 May 2020 16:17:58 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: ARM: static kernel in vmalloc space
Message-ID: <20200512104758.GA12980@afzalpc>
References: <CAK8P3a1JS3_2fWrhNTZx0eTWjJa-GTb4AscTPqydpSP5EB15Yw@mail.gmail.com>
 <20200414151748.GA5624@afzalpc>
 <CAK8P3a0JW9x-Wk9Ec3+zLjPHbWAvPQx8MF-xe-PnWUgEjRAuTg@mail.gmail.com>
 <20200415135407.GA6553@afzalpc>
 <20200503145017.GA5074@afzalpc>
 <CAK8P3a3OC5UO72rTDWi6+XgmExJmkATEjscq8hns8Bng06OpcQ@mail.gmail.com>
 <20200504091018.GA24897@afzalpc>
 <CAK8P3a25sZ9B+AE=EJyJZSU91CkBLLR6p2nixw_=UAbczg3RiQ@mail.gmail.com>
 <20200511142113.GA31707@afzalpc>
 <CAK8P3a0=+aBJLTvHOskTv=tba_s5b5MzWrYG8mxH3iLNy4hfBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0=+aBJLTvHOskTv=tba_s5b5MzWrYG8mxH3iLNy4hfBw@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, May 11, 2020 at 05:29:29PM +0200, Arnd Bergmann wrote:

> What do you currently do with the module address space?

In the current setup, module address space was untouched, i.e. virtual
address difference b/n text & module space is far greater than 32MB, at
least > (2+768+16)MB and modules can't be loaded unless ARM_MODULE_PLTS
is enabled (this was checked now)

> easiest way is to just always put modules into vmalloc space, as we already
> do with CONFIG_ARM_MODULE_PLTS when the special area gets full,
> but that could be optimized once the rest works.

Okay

Regards
afzal
