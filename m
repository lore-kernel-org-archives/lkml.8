Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1824AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 21:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E16EE20782
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 21:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VlkQ2snH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgGCVUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 17:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgGCVUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 17:20:52 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B674FC061794
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 14:20:51 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id f5so22622157ljj.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 14:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c/MbgL1LaNESZUToz3uJlzJ2ui/ekBMYL4fZtBX3Egc=;
        b=VlkQ2snH17Nx8tnyUUXS8aJlif+f+BBvhgd4z0f+MxldVnreE3EP4CYW4LA7EGIDhj
         dXR2vpysrFON09qIoMq/aWgH26InLa4wn3ZLYAHa5xG6I4JAIJsr67zY53oXd7CtFNSa
         Gr9OWH9O7DOqKywXNgY47QnwBblDn7mAFTgzEJPIvfmFzgQWrDZHPnRHLDeTbwODV1Jh
         hFUSPX8GvUG+KgWG9olWcw4+6QZFslJSZAu3xWRKupugaVXePFw2tr2X47Rjk3NSh3f3
         y64L9XEcrxtHCVRUurhM9WBELBrWHL9UisKH+BROgkkwPbJFssoprgSLhnjUidSZbbJm
         +FpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c/MbgL1LaNESZUToz3uJlzJ2ui/ekBMYL4fZtBX3Egc=;
        b=cKhF8pX55FmLv9dQ4d2JO6GBtjZWW2KzaCeQ5sk1+Iuqkc5LT7kVt3JQ5or8x8nsKG
         RuhKVKbuPt8X545XJScvXP/sHtTeFKpBSDypRBH59l9WkmLxA9ytsgyxKuSC/yl0/G9i
         Y8xkE+xiq6Ii4ARdGCzRRY1KrNvrfUjqYrKc0rxrvF3cpVdi/X5Du6JBPdNhzoiIu0DT
         0/+26dl0/wUNQm92wSbCvlboDTJfhdkTLZwQxRAt1X1XK25JtPXEayY8sKWV1IVJKIgw
         i08zk2Qf6HgZiOUjSMGplwrv2ozhF4crQUnBWP77KYQIkMaQMYToKFAAW6NsgxPvzIlw
         ZeMQ==
X-Gm-Message-State: AOAM5320yU7/4SbrvHsmVxDdC+oLmuQUwFMn44x7G+Py/cZ2mtNfHTjB
        Ef1DItuZYgOadeglu4flG/g=
X-Google-Smtp-Source: ABdhPJz7APU8pkcq+8yZ4qEdXTT4WoMK1+FIo4Mt4B//td9fvanPBxvtv3k39NVoKUOsOF8IcgyCVw==
X-Received: by 2002:a05:651c:1aa:: with SMTP id c10mr16560900ljn.260.1593811250132;
        Fri, 03 Jul 2020 14:20:50 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id f14sm5085801lfa.35.2020.07.03.14.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 14:20:49 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 3 Jul 2020 23:20:47 +0200
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        peter enderborg <peter.enderborg@sony.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        GregKroah-Hartmangregkh@linuxfoundation.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: nr_cpu_ids vs AMD 3970x(32 physical CPUs)
Message-ID: <20200703212047.GA6856@pc636>
References: <20200703155749.GA6255@pc636>
 <8a2a55e6-6087-e4bf-3d35-ed4b4c216369@sony.com>
 <20200703192807.GB5207@pc636>
 <CAHk-=wiagrzJs9OBe_6bHK+Cc6RdoCOV85CiJAd3MhYnc8idfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiagrzJs9OBe_6bHK+Cc6RdoCOV85CiJAd3MhYnc8idfw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Jul 3, 2020 at 12:28 PM Uladzislau Rezki <urezki@gmail.com> wrote:
> >
> > I have MSI TRX40 with latest BIOS.
> 
> I think it's just that the BIOS is set for the max possible, in case
> you'd have a 3990X.
> 
3990x is the top one in this series, so indeed it can be a case and
explanation why nr_cpu_ids is set to 128.

>
> I compile my kernel with CONFIG_NR_CPUS's set to 64. That works around
> the issue.
> 
> Lots of distros seem to set CONFIG_MAXSMP to true, which I guess is
> the most generic thing to do, but the problem with that is not just
> the silly problem with the BIOS, but it also means that the kernel
> does dynamic allocation for cpumasks even if you _don't_ have that
> problem, because at compile-time you don't know how big the cpumask
> will be.
> 
> With CONFIG_NR_CPUS's set to 64, the kernel will just use a "unsigned
> long" on the stack (and in various data structures) and be done with
> it, and not do unnecessary dynamic allocations.
> 
Thanks for proposed workaround! I will update the CONFIG_NR_CPUS with
proper value in my .config

Some background:
Actually i have been thinking about making vmalloc address space to
be per-CPU, i.e. divide it to per-CPU address space making an allocation
lock-less. It will eliminate a high lock contention. When i have done
a prototype i noticed and realized that there is a silly issue with
nr_cpu_ids on some systems.

Therefore i reported about it.

Thanks, Linus!

--
Vlad Rezki
