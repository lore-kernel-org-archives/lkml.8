Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3198C54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 16:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C25E20728
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 16:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1yAor3A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbgDWQEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 12:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729257AbgDWQEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 12:04:01 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F8AC09B040;
        Thu, 23 Apr 2020 09:04:01 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x15so3180130pfa.1;
        Thu, 23 Apr 2020 09:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QRRSRzv3ELZyPDBdtIE45poUqjMQaq7ox4Jm7P7/zG8=;
        b=R1yAor3At9e+xtBhUr6dlgl7zNXUVenScXyHMgcn6IEG2US+/UvODrE8lbtPt/gLs/
         fbWEVj/JWvpO34kH3WTmFqm02fkOHuQ7PhIiONd8EUu3SW3XtYCNPbk92Xa4fdfbrRE1
         PXQd0r0F2W4Fp10i4ld1cmfne4gSHWf8NyMjtGLwvuq4GJmQJABiDyvshdytsc4Dk0Rx
         e//SCLAP6/rdoNEqY0IdCqIT3FibTx1vI72kTE3eLnhpUYI2ZreFg08S9YtkGEs0zhOt
         WX9FXySSlDXshp0yLq17w2rYTW0o1mmx/y55DH11xOJlY8NmfYyv7tfqjERP5kVDnBrD
         Eccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QRRSRzv3ELZyPDBdtIE45poUqjMQaq7ox4Jm7P7/zG8=;
        b=TVIeVzzejAOOiRRSoz4/GvNBmr5n75ABs+uF/NIo/cF4b3z+CngP+2xcfu0HXoPN4O
         gw3GWY1e5GxoaCfNEHMIxVlcDrZuNx464YMIY6HTgDL3jT8r55Mgq1IYOujjzo3zXf5X
         iMgry4kzJyhwxE03G5YmSpIVIT2XtMuA8aakiZ7/YpNUUtbo+FPTbL7le01odsE39v4S
         mVYyiSMapgsvQvAUZyvrhDTbiKgPrGTM/YvyByT9Ao8+bqywZX/jMhKXTO3kUPmRFpC9
         cfh+vKW4gKHw/kxpPhCxagCPzHKg7I7BIzM48OUR0KiTAjH4J6Ub7syT1sBfGHKjyo0w
         fSLQ==
X-Gm-Message-State: AGi0Pua+3BR7Q1XoCz2myIeaDcqmDzHUuyfJn6MeyNrAbwM+d1lB3mJM
        A0NH/FWcDNXqArm9nKELxg0=
X-Google-Smtp-Source: APiQypJNoUyWvf19ibvNaStq1WA8/4V2tFh9qQrvtbqG8Us89/iEAV2d0p9Nj6pt/PJyn6r+TTHe8Q==
X-Received: by 2002:aa7:82d4:: with SMTP id f20mr4501737pfn.253.1587657840767;
        Thu, 23 Apr 2020 09:04:00 -0700 (PDT)
Received: from localhost (176.122.158.71.16clouds.com. [176.122.158.71])
        by smtp.gmail.com with ESMTPSA id a200sm2867954pfa.201.2020.04.23.09.03.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Apr 2020 09:04:00 -0700 (PDT)
Date:   Fri, 24 Apr 2020 00:03:56 +0800
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, FlorianSchandinat@gmx.de,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] console: console: Complete exception handling in
 newport_probe()
Message-ID: <20200423160356.GA2538@nuc8i5>
References: <20200423142627.1820-1-zhengdejin5@gmail.com>
 <CAHp75Vf1_SMk=_WDUrB97BGR6K6EXOdtgQ92=hTyMdVUoyWQiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vf1_SMk=_WDUrB97BGR6K6EXOdtgQ92=hTyMdVUoyWQiw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 05:52:09PM +0300, Andy Shevchenko wrote:
> On Thu, Apr 23, 2020 at 5:26 PM Dejin Zheng <zhengdejin5@gmail.com> wrote:
> >
> > A call of the function do_take_over_console() can fail here.
> > The corresponding system resources were not released then.
> > Thus add a call of the function iounmap() together with the check
> > of a failure predicate.
> 
> ...
> 
> > CC: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> Use Cc: Better to read.
>
I will pay attention to the next submission, thanks.

> ...
> 
> > v1 -> v2:
> >         - modify the commit comments by Markus'suggestion.
> 
> What suggestion? You need to be clear in changelog what exactly has
> been done without looking to any previous mail.
>
The commit comments have some more appropriate instructions by
Markus'suggestion. here is my first version commit comments:

if do_take_over_console() return an error in the newport_probe(),
due to the io virtual address is not released, it will cause a leak.

Thnaks!

> ...
> 
> >         console_lock();
> >         err = do_take_over_console(&newport_con, 0, MAX_NR_CONSOLES - 1, 1);
> >         console_unlock();
> > +
> > +       if (err)
> > +               iounmap((void *)npregs);
> >         return err;
> >  }
> 
> I have briefly looked at the code (it is actually quite old one!), and
> I think this is half-baked solution, besides the fact of missed
> __iomem annotation and useless explicit casting.
> The proper one seems to switch to memremap() and do memunmap() here.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
