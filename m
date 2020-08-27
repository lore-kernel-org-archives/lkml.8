Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687BFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E8862054F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/VyZuK6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgH0OtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728094AbgH0Osx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 10:48:53 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35837C061264;
        Thu, 27 Aug 2020 07:48:53 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c15so5635054wrs.11;
        Thu, 27 Aug 2020 07:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AOFWO6hOSuRZQ3JE3lz6nNzyfi0JSc63kfPTYrfcnNA=;
        b=X/VyZuK6gEKrvY/S0fJvysWZTY1bcQbACA+KzQo0uddcob93HHWkY1IkNgbaYPbLDp
         CXRUNEsX95EHocaDwWFHMFfQbuzO49yV2+AbJYEi4lfNwJF2vE6x3ixPBSGtcgktfNFO
         EmAXFR5cAdgLYMbAqisF+MmtHTo4dXlwfbjZnfH79DgJh8CeM4UBLSaio2OLbeL/eqY2
         grYpjcCZo3/KsHRfg5PjoSpFD9j3LWzL/eUyfnRvmvP49UTLArqdfi2rsHrxJgIy5ggl
         1V01H5GpCO4VfB3QV6/N9t4snx1jbRta5/CsGjy5GMWb0uO1eo+vETdXAOy3tdMHm9W/
         3A+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AOFWO6hOSuRZQ3JE3lz6nNzyfi0JSc63kfPTYrfcnNA=;
        b=h57n2PecWQoJ7eQoMIXxxveHtq3EZCzfXUa+JroMtwAW6ht+to10TwNADFDlxv1WPQ
         wIZbr3CbQ1iIa2RrSVxzBzIP+Bm+Svmy84tcrmmCpq5WlD/HplzYcpQ6IoH5NzMMu0vG
         c8KdAjgxCu6I9MyZ0KW6kqsZJCOxeqtGuSE8k6FksWV0JvJHoJlSDx3SZY86rA419K1r
         xjtE1B/IjW10mbF84F754u+Ej1aO4EfuTkv9oF2WAhbcA1Dn53iM6kPEkP2sWCumzmev
         +RtK8F7A0QUMRpp6r9xjILvRtuF0uorT6j33ermcCtKyoneHeHsyoApE+bmR24u5u+Kz
         xsXA==
X-Gm-Message-State: AOAM532tjKl0XthW48YoVdx8rXgnqKOo+rHZMnztwNq89HAJySt0UIB+
        d5X2pqJL3vimW8wZwQOrtFk=
X-Google-Smtp-Source: ABdhPJweHYE0sQb82yaSD/TLNUuNwKlbxXi4RLon3uJ1FLNlrDA6X5tISWP6DDD9/jeU4SMskex5wg==
X-Received: by 2002:adf:cf10:: with SMTP id o16mr19158027wrj.380.1598539731825;
        Thu, 27 Aug 2020 07:48:51 -0700 (PDT)
Received: from lenovo-laptop (92.40.173.114.threembb.co.uk. [92.40.173.114])
        by smtp.gmail.com with ESMTPSA id f17sm7055991wru.13.2020.08.27.07.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 07:48:51 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
X-Google-Original-From: Alex Dewar <alex.dewar@gmx.co.uk>
Date:   Thu, 27 Aug 2020 15:48:46 +0100
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Alex Dewar <alex.dewar90@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        accessrunner-general@lists.sourceforge.net,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: atm: don't use snprintf() for sysfs attrs
Message-ID: <20200827144846.yauuttjaqtxaldxg@lenovo-laptop>
References: <20200824222322.22962-1-alex.dewar90@gmail.com>
 <48f2dc90-7852-eaf1-55d7-2c85cf954688@rasmusvillemoes.dk>
 <20200827071537.GA168593@kroah.com>
 <20200827131819.7rcl2f5js3hkoqj2@lenovo-laptop>
 <def24e9e-018c-9712-0d07-d4cbc84f07d9@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <def24e9e-018c-9712-0d07-d4cbc84f07d9@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 03:41:06PM +0200, Rasmus Villemoes wrote:
> On 27/08/2020 15.18, Alex Dewar wrote:
> > On Thu, Aug 27, 2020 at 09:15:37AM +0200, Greg Kroah-Hartman wrote:
> >> On Thu, Aug 27, 2020 at 08:42:06AM +0200, Rasmus Villemoes wrote:
> >>> On 25/08/2020 00.23, Alex Dewar wrote:
> >>>> kernel/cpu.c: don't use snprintf() for sysfs attrs
> >>>>
> >>>> As per the documentation (Documentation/filesystems/sysfs.rst),
> >>>> snprintf() should not be used for formatting values returned by sysfs.
> >>>>
> >>>
> >>> Can we have a sysfs_sprintf() (could just be a macro that does sprintf)
> >>> to make it clear to the next reader that we know we're in a sysfs show
> >>> method? It would make auditing uses of sprintf() much easier.
> >>
> >> Code churn to keep code checkers quiet for pointless reasons?  What
> >> could go wrong with that...
> 
> I did not (mean to) suggest replacing existing sprintf() calls in sysfs
> show methods. But when changes _are_ being made, such as when replacing
> snprintf() calls for whatever reasons, can we please not make it harder
> for people doing manual audits (those are "code checkers" as well, I
> suppose, but they do tend to only make noise when finding something).
> 
> >> It should be pretty obvious to any reader that you are in a sysfs show
> >> method, as almost all of them are trivially tiny and obvious.
> 
> git grep doesn't immediately show that, not even with a suitable -C
> argument, as you can't really know the potential callers unless you open
> the file and see that the function is only assigned as a .show method.
> And even that can be a pain because it's all hidden behind five levels
> of magic macros that build identifiers with ##.
> 
> > Perhaps I should have mentioned this in the commit message, but the problem
> > is that snprintf() doesn't return the number of bytes written to the
> > destination buffer,
> 
> I'm perfectly well aware of that, TYVM (you may want to 'git log
> --author Villemoes lib/vsprintf.c').
> 
>  but the number of bytes that *would have been written if
> > they fitted*, which may be more than the bounds specified [1]. So "return
> > snprintf(...)" for sysfs attributes is an antipattern. If you need bounded
> > string ops, scnprintf() is the way to go. Using snprintf() can give a
> > false sense of security, because it isn't necessarily safe.
> 
> Huh? This all seems utterly irrelevant WRT a change that replaces
> PAGE_SIZE by INT_MAX (because that's what sprintf() is going to pretend
> you passed). You get the same return value.
> 
> But I'm not at all concerned about whether one passes the proper buffer
> size or not in sysfs show methods; with my embedded hat on, I'm all for
> saving a few bytes of .text here and there. The problem, as far as I'm
> concerned, is merely that adding sprintf() callers makes it harder to
> find the problematic sprintf() instances.
> 

Apologies, I think I might have expressed myself poorly, being a kernel noob
;-). I know that this is a stylistic change rather than a functional
one -- I meant that I was hoping that it would be helpful to get rid of bad
uses of snprintf().

I really like your idea of helper methods though :-). If in show()
methods we could have something like:
	return sysfs_itoa(buf, i);
in place of:
	return sprintf(buf, "%d\n", i);

... then we wouldn't be introducing any new calls to sprintf() as you
say, but we'd still be removing a call to snprintf() (which also may be
problematic). Plus we'd have type checking on the argument.

For returning strings, we could have a bounded and unbounded variant of
the function. As it seems like only single values should be returned via
sysfs, if we did things this way then it would only be these
string-returning functions which could cause buffer overflow problems
and kernel devs could focus their attention accordingly...

What do people think? I'm happy to have a crack, provided this is
actually a sensible thing to do! I'm looking for a newbie-level project
to get started with.

Thanks for the feedback all,
Alex
> 
> >> Anyway, we've had this for 20 years,
> 
> My bad, for a moment I forgot that code and patterns of that vintage
> cannot have bugs.
> 
> Rasmus
