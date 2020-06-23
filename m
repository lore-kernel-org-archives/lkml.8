Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39750C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 10:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A2CD20738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 10:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H9tF1WoM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732293AbgFWK7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 06:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732205AbgFWK7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 06:59:38 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7446EC061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 03:59:38 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b6so20028764wrs.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 03:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lGrEtcs91+dxyWalZ+ucVAHOrATgVM2zxSzA1+acQg4=;
        b=H9tF1WoMJP6k1NhpjSlDkwABW022ARCBuOHBY6yhnzmiwSYAqbykNym7cUXNasMT6u
         SYH/QYLJSJCrr7CUmwv3aXRdFcmgJW2Gwwoo/xASmrm9OFhDpLub4rC2K+bd74NpkQHq
         lWG+gh76ybsLiaR1BwWhYVJXsHOk/KBdAQs8UIbricQv/yRTIZiqpSFXfBkzvln0Ctsb
         vjT2M8VyzVD2irhFN8vj2aPW6c+IpWbO1W4GpbeTJFqmbP06pguKaskv3AIOztQz348D
         c9NoaAF07LRY9pUNskKiCKuBa9lFmPvxYUuAcis9DMEgOz9pkcw6Q3JdBRixAwi3DGOE
         Sgmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lGrEtcs91+dxyWalZ+ucVAHOrATgVM2zxSzA1+acQg4=;
        b=gwxkHUdbfvcDiatnEv/jVjjIumz8PUruUmcw6TXH9xF6xY6aFMROcYmIQ3Qq7bqvpq
         qcnpNWl9TQUt7eDWVIpeHGD+o0dIE8ykqhIhY0qEaeX2rfqTOdFz9YKJuLZNTSMq9zml
         GoEKwfZg7gNwjzwkrDbjG7gTRe188Cn3Q9e+TKCdg1DNqflnV895/sQC6O/k6RtFO0Ty
         SWhEMt4COGO8dBaIaMHqXOt7YtYpvH61P4ICosM4sF8GyLAPAzkAEkZg3V5Cn3HKxjqG
         2mgeh3JwJRM53jQysjfCoOIJoLqE9PONVtrhuPS3/l+xCttOyUMvtNqCmPeG7T5hPLd+
         8L3Q==
X-Gm-Message-State: AOAM5319dcmS/f/G1ZBDiQgzXvUccA4v6GmfrJvFIIksQy6Gt/vsKqnw
        BYDlBvNvNuUZLeLkmdLViHRifA==
X-Google-Smtp-Source: ABdhPJw9T61gaiAi8WHXVsX1Hu7GiUkKfr66i1wj6/L+0fQWDmHApgO8RTikF4aEEn2dwEAj+42rEA==
X-Received: by 2002:adf:e2ce:: with SMTP id d14mr24896468wrj.415.1592909976531;
        Tue, 23 Jun 2020 03:59:36 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id n19sm3176388wmi.33.2020.06.23.03.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 03:59:35 -0700 (PDT)
Date:   Tue, 23 Jun 2020 11:59:34 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Jiri Slaby <jslaby@suse.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/7] kgdb: Add request_nmi() to the io ops table for
 kgdboc
Message-ID: <20200623105934.wvyidi3xgqgd35af@holly.lan>
References: <1592835984-28613-1-git-send-email-sumit.garg@linaro.org>
 <1592835984-28613-4-git-send-email-sumit.garg@linaro.org>
 <20200622160300.avgfhnfkpqzqqtsr@holly.lan>
 <CAFA6WYOmQT-OQvjpy1pVPq2mx5S264bJPd-XfwnDY2BjeoWekg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYOmQT-OQvjpy1pVPq2mx5S264bJPd-XfwnDY2BjeoWekg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 02:07:47PM +0530, Sumit Garg wrote:
> On Mon, 22 Jun 2020 at 21:33, Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> > > +     irq_set_status_flags(irq, IRQ_NOAUTOEN);
> > > +     res = request_nmi(irq, fn, IRQF_PERCPU, "kgdboc", dev_id);
> >
> > Why do we need IRQF_PERCPU here. A UART interrupt is not normally
> > per-cpu?
> >
> 
> Have a look at this comment [1] and corresponding check in
> request_nmi(). So essentially yes UART interrupt is not normally
> per-cpu but in order to make it an NMI, we need to request it in
> per-cpu mode.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/irq/manage.c#n2112

Thanks! This is clear.

> > > +     if (res) {
> > > +             res = request_irq(irq, fn, IRQF_SHARED, "kgdboc", dev_id);
> >
> > IRQF_SHARED?
> >
> > Currrently there is nothing that prevents concurrent activation of
> > ttyNMI0 and the underlying serial driver. Using IRQF_SHARED means it
> > becomes possible for both drivers to try to service the same interrupt.
> > That risks some rather "interesting" problems.
> >
> 
> Could you elaborate more on "interesting" problems?

Er... one of the serial drivers we have allowed the userspace to open
will, at best, be stone dead and not passing any characters.


> BTW, I noticed one more problem with this patch that is IRQF_SHARED
> doesn't go well with IRQ_NOAUTOEN status flag. Earlier I tested it
> with auto enable set.
> 
> But if we agree that both shouldn't be active at the same time due to
> some real problems(?) then I can rid of IRQF_SHARED as well. Also, I
> think we should unregister underlying tty driver (eg. /dev/ttyAMA0) as
> well as otherwise it would provide a broken interface to user-space.

I don't have a particular strong opinion on whether IRQF_SHARED is
correct or not correct since I think that misses the point.

Firstly, using IRQF_SHARED shows us that there is no interlocking
between kgdb_nmi and the underlying serial driver. That probably tells
us about the importance of the interlock than about IRQF_SHARED.

To some extent I'm also unsure that kgdb_nmi could ever actually know
the correct flags to use in all cases (that was another reason for the
TODO comment about poll_get_irq() being a bogus API).


Daniel.
