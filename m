Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A3CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 11:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 214C02072F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 11:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MA3pd6T+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbgFHLJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 07:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729310AbgFHLJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 07:09:08 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B69C08C5C2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 04:09:06 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o8so8589220pgm.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 04:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=182l15KqndSA3GLGbIwigWBz5qaMbKVubBPH6bU+XdA=;
        b=MA3pd6T+stPKqP6XIFF5RUOsPh1OVnY6tmlTlRtbD2Y2fTRerrN60aUrzf7wkDjdHw
         OXaOQEkAzu+AR4bGLEOh0hGO0BN567wfs+0mWAcKNFT1F/9hQpngMTvDFLFvcprFqEOl
         Z7W3DNh0zdCLk1rlvl0509CDLvqyAoD3P2dWHcK9ADcdZAeyVpGvYdouUaB2wq3hYw23
         NV25UHl40C0Blm2jbek0/OUG/at2Tn5OdfPpvbgJwwmWgHF5SI52cZviWhcMFN6Vw0iO
         qyI6YslneWoVXT2QaTQji/B9AJzpYDSLcZiBw19MosZV22sVBpMwuP9zyFM8rTjFJ/TI
         ISlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=182l15KqndSA3GLGbIwigWBz5qaMbKVubBPH6bU+XdA=;
        b=sYo9kuuHnhVHhAf8OXZNLpjpzGpikxrI0ruGBTVhZkQKjV8xnWFeHkvG591KPUhzrg
         0NOOUI0TOX/rOzDU1zukzcW/TF0bZ5pdmVX/R06eMHlU8Kh24yHMtVwTbqXY8gecmtvN
         ry2eBxItYQNIC2iPfG3BUkPiUdviL1iEet7oZc4B4o6qSQtyhxsLYrnddkGdt8JUD3sA
         b5LNHtgcMuea81XFYz9XAlKKpbliD7ypHtu7dv+DXsaxcli6nRBI3K6PsBl0PJb6FeKZ
         xp7fduK2CjFWnoqZiICzzW2Cfn/IReyHmJCLIYc0B5XwCfDfcpjrRsff9klI15rxUB2P
         LdkQ==
X-Gm-Message-State: AOAM531SAeG0PlawWOWzpaoLof3gdCc9h9JMifAhqS4sagHA6ZviyuFg
        tOg+AH2Vm5Rpgp0j3DzOmBA=
X-Google-Smtp-Source: ABdhPJzx5s1mT6/uQ0P3CpEcBqAdaBGGuhQQTp6roWUYQ9vKJkrUUJjF4nuxbCmhbgEZPe1u6ZNI7A==
X-Received: by 2002:a63:305:: with SMTP id 5mr19162489pgd.74.1591614545531;
        Mon, 08 Jun 2020 04:09:05 -0700 (PDT)
Received: from localhost ([49.207.55.212])
        by smtp.gmail.com with ESMTPSA id s21sm3096152pgg.8.2020.06.08.04.09.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Jun 2020 04:09:04 -0700 (PDT)
Date:   Mon, 8 Jun 2020 16:39:02 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: ARM: vmsplit 4g/4g
Message-ID: <20200608110902.GA5736@afzalpc>
References: <20200512104758.GA12980@afzalpc>
 <CAK8P3a1DQWG1+ab2+vQ2XCAKYxPUjJk5g3W3094j-adDXSQfzQ@mail.gmail.com>
 <20200514111755.GA4997@afzalpc>
 <CAK8P3a2PNZY-9L9+SFDLtrp731ZGo6Nbs-7jY6E2PwWXa0kfKw@mail.gmail.com>
 <20200514133545.GA5020@afzalpc>
 <CAK8P3a1PVwkAi8ycUAB-7EMk4nQ_qOu0rC5vJAQk_q9j5xvOJw@mail.gmail.com>
 <20200516060624.GA6371@afzalpc>
 <CAK8P3a01FYoWY9sZKU1q=UQ3ut4srwXXUeGRzW6APi+GpoKo1w@mail.gmail.com>
 <20200607125932.GA4576@afzalpc>
 <20200607161116.GN1551@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200607161116.GN1551@shell.armlinux.org.uk>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[ my previous mail did not make into linux-arm-kernel mailing list,
 got a  mail saying it has a suspicious header and that it is waiting
 moderator approval ]

On Sun, Jun 07, 2020 at 05:11:16PM +0100, Russell King - ARM Linux admin wrote:
> On Sun, Jun 07, 2020 at 06:29:32PM +0530, afzal mohammed wrote:

> > get_user_pages_fast() followed by kmap_atomic() & then memcpy() seems
> > to work in principle for user copy.
> 
> Have you done any performance evaluation of the changes yet? I think
> it would be a good idea to keep that in the picture. If there's any
> significant regression, then that will need addressing.

Not yet. Yes, i will do the performance evaluation.

i am also worried about the impact on performance as these
[ get_user_pages() or friends, kmap_atomic() ] are additionally
invoked in the copy_{from,to}_user() path now.

Note that this was done on a topic branch for user copy. Changes for
kernel static mapping to vmalloc has not been merged with these.
Also having kernel lowmem w/ a separate asid & switching at kernel
entry/exit b/n user & kernel lowmem by changing ttbr0 is yet to be
done. Quite a few things remaining to be done to achieve vmsplit 4g/4g

Regards
afzal
