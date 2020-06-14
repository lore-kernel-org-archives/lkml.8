Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF629C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 13:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC0B1207DD
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 13:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="onBIBYT4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgFNNGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 09:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbgFNNGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 09:06:38 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E22C05BD43
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 06:06:38 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 10so6586848pfx.8
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 06:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tbNPHbcJdd9Zy5vpitc4It2x0QhJhg6ckwY09//qr6Y=;
        b=onBIBYT4ViSU7ygp5zYYYBkpUleSF5iOdLkVHxQBdUzs6HwG5FPU2AJIL94jiO1/3q
         e611vI3yaKJGxZt2s4y6snRpXKvWJq8OqYUJjwVNmgfG7HHqxMRpPNskzZb5sxAjWHjY
         xnRzeKS3IREF5B9/QGpTyAwqFLQY/nYBHWJAnL9xC8VVruuUd86ny7YZy0CwYO06X5JA
         S87sPGgfHf0Of2/wEO3Lf7D81x16zacDo1gKx/WP3icE0P4D0ZRLXudAyfnGbhm2eAFX
         FoESIv6H9gYq4R8Kg1xRHUcUxg6EpkTgR8UX8haSscXC6Q7aRYqatXBg5s4wlT6QdIlv
         AbXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tbNPHbcJdd9Zy5vpitc4It2x0QhJhg6ckwY09//qr6Y=;
        b=QLnB8mKHCRFyB7jYz2fReiUJCi/xq62JBBs+Ljaxtc2I8cHr13AlYztdh/HiP7P+/C
         q8K4ZKUOyHfN7c0GoQ96BsvTZbA5RZlBG50U6V836hzwuiYjTEp02GhKWFVnAgbYmfO1
         pef3ROmdJfG9Yp/XY0JhyZwG75TzFSD6Agx6WGtvPaIPgpWckW6anHm0mDKkzOOCcoEa
         u8JgHhaLWtOU0JMKyvbcuyfwJgdq44pFvBFTi+poXMNey9TxvbgoQh3GCIunTMfeBhdx
         oiKpp/D2AGbabBIMzgv3Bn5rGSGu+1bdsMM11T/jPM91CC+VHCEqD6iRP7Z/QjZ6TptU
         MO+w==
X-Gm-Message-State: AOAM531FNUA6cyDPx9VsNLtp8KLlJjunlMSEkmvJQIQYj0h39qHFoQ5i
        FT8h1y3wvXNskk4O2mH7muM=
X-Google-Smtp-Source: ABdhPJzSwp75HDSJw1OL5kd4Rpdjmi7CLAzvE7VPRCs+dMV7al78Ke9fy4XDN78px0l2mL6bUhjXnw==
X-Received: by 2002:a63:4861:: with SMTP id x33mr109880pgk.448.1592139997958;
        Sun, 14 Jun 2020 06:06:37 -0700 (PDT)
Received: from localhost ([49.207.199.244])
        by smtp.gmail.com with ESMTPSA id y10sm9811760pgi.54.2020.06.14.06.06.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Jun 2020 06:06:37 -0700 (PDT)
Date:   Sun, 14 Jun 2020 18:36:35 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC 1/3] lib: copy_{from,to}_user using gup & kmap_atomic()
Message-ID: <20200614130635.GA5037@afzalpc>
References: <cover.1591885760.git.afzal.mohd.ma@gmail.com>
 <9e1de19f35e2d5e1d115c9ec3b7c3284b4a4e077.1591885760.git.afzal.mohd.ma@gmail.com>
 <CAK8P3a1XUJHC0kG_Qwh4D4AoxTgCL5ggHd=45yNSmzaYWLUWXw@mail.gmail.com>
 <20200612135538.GA13399@afzalpc>
 <CAK8P3a25ffh_2Y1xKDbkL2xU9nLpGbEq7j6xHdODEwUtavgdwA@mail.gmail.com>
 <20200613120432.GA5319@afzalpc>
 <20200613131552.GL1551@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200613131552.GL1551@shell.armlinux.org.uk>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Jun 13, 2020 at 02:15:52PM +0100, Russell King - ARM Linux admin wrote:
> On Sat, Jun 13, 2020 at 05:34:32PM +0530, afzal mohammed wrote:

> > i think C
> > library cuts any size read, write to page size (if it exceeds) &
> > invokes the system call.

> You can't make that assumption about read(2).  stdio in the C library
> may read a page size of data at a time, but programs are allowed to
> call read(2) directly, and the C library will pass such a call straight
> through to the kernel.  So, if userspace requests a 16k read via
> read(2), then read(2) will be invoked covering 16k.
> 
> As an extreme case, for example:
> 
> $ strace -e read dd if=/dev/zero of=/dev/null bs=1048576 count=1
> read(0, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 1048576) = 1048576

Okay. Yes, observed that dd is passing whatever is the 'bs' to
Kernel and from the 'dd' sources (of busybox), it is invoking read
system call directly passing 'bs', so it is the tmpfs read that is
splitting it to page size as mentioned by Arnd.

Regards
afzal
