Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9181BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 20:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66698204EA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 20:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXTypp5L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732350AbgFIUAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 16:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgFIUAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 16:00:09 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA73C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 13:00:08 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id j13so12800045vsn.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 13:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ptZZH4Tq/mH081/wq7if/B8ctnFhJDgUQj+VbhD3D8=;
        b=WXTypp5LdxVQr/U6U62CFuee8ZME7D2SqoSFu3ME0W7iIW3Xf41yfIWOBxUShEMiIy
         X8fvtw/guUSAABsBmhyklUrzEeo840A+lGRu4etEhGk7XJAqX5PDu3RCtlEWynY/A3Wy
         WY0/rxXkEFQDGfqFbFqn+fY/J17BRuSpm56Mgxlq886f9INTy6WS7++cX1VzduPFuntJ
         Hs02I1wGOPj7WN3+/E3uWRXRDZfiERuNJZ7XPXZ6r//RdS9YHWZ+yXxY7pb0wSy9yQcY
         FDSzgUrx1F+UJnEE8DNN1VFQnpkClS+/IjOsw9T0RLAdWMggXRrkj365X1cn1NOXYP6k
         wjHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ptZZH4Tq/mH081/wq7if/B8ctnFhJDgUQj+VbhD3D8=;
        b=Hx7PjfJNfKmprqXELfBlmReT3CAFSiIIcktBPUzlGw4wcS4OGxdZ1vdkuWZc6Rh4YB
         sr7so3v4EEcMLjRFFe2zbcAteVr/30V3McqDo6Rx8SA8AmOHsXKMsgbYxtdu/j8iCOPe
         V50sws5wmS5e41YR96UnEirjCKojyE5Sy6A5qMPo4wqIao2B+u049T9rHodNMPJa/X7/
         vgH6sptbuyDs0QGdS86lu79UFq83G5n3EqV0bjzd/uaGk0vVwl8SqtRpvZd48g3JwNXv
         W7PmSZ6our5UCjh9pNBMTILYyBEK7Rk+Iu3J/xCby1g0H9HzVO8o6Qn7zyppykbeWypY
         Ls9A==
X-Gm-Message-State: AOAM533V3M4SroIpacPTmdS9KLtu2//rb15vBLmhzj82pJCLKlXsE6dN
        P6GVB6+RrF2NdmBS6pDX1zyBvM5TMia7zbfSHFE=
X-Google-Smtp-Source: ABdhPJxRtlqGV6xQoEdp29mqTFc/QIvbgRStbyyQKROmnKh9AWlzMYmDP61HAnIZtn6mEynfSAsBV3ZaxYuhEcg1uzU=
X-Received: by 2002:a67:3211:: with SMTP id y17mr5561549vsy.56.1591732807199;
 Tue, 09 Jun 2020 13:00:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200605162645.289174-1-jim.cromie@gmail.com> <20200605162645.289174-4-jim.cromie@gmail.com>
 <20200608112150.7ohrax6pzpi7ss2l@holly.lan>
In-Reply-To: <20200608112150.7ohrax6pzpi7ss2l@holly.lan>
From:   jim.cromie@gmail.com
Date:   Tue, 9 Jun 2020 13:59:41 -0600
Message-ID: <CAJfuBxwHOyvOcSB8005=z1G_-Hux1UxaLOutOX1SE2wYONSsrg@mail.gmail.com>
Subject: Re: [PATCH 03/16] dyndbg: refine debug verbosity; 1 is basic, 2 more chatty
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Baron <jbaron@akamai.com>,
        LKML <linux-kernel@vger.kernel.org>, akpm@linuxfoundation.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 8, 2020 at 5:21 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Fri, Jun 05, 2020 at 10:26:32AM -0600, Jim Cromie wrote:
> > The verbose/debug logging done for `cat $MNT/dynamic_debug/control` is
> > voluminous (2 per control file entry + 2 per PAGE).  Moreover, it just
> > prints pointer and sequence, which is not useful to a dyndbg user.
> > So just drop them.
>
> I'd assumed these messages where to help the dyndbg implementer rather
> than the dyndbg user.

So I thought I was guilty of adding those noisy pr_info()s in the
ddebug_proc_* functions,
but I have touched them, changing them to vpr_info().
In any case, I dont think theyre useful to the implementer either.

If the verbose messages really are useful to help
> users who (mis)configure .../control then should the enable/disable
> control be shadowed in debugfs to make it easy to find?
>

I would hesitate to change the API, even if this is just an add-on,
without changes to existing.
OTOH, I could see it added as /proc/dynamic_debug/verbose

with this patch, verbose=1 is better focused on showing the parsing process,
to give user more context as to what his query-command is doing
verbose=2 additionally shows callsites that match the query, including
any unchanged (iirc)

>
> Daniel.
>
> >
> > Also require verbose>=2 for several other debug printks that are a bit
> > too chatty for typical needs;
> >
> > ddebug_change() prints changes, once per modified callsite.  Since
> > queries like "+p" will enable ~2300 callsites in a typical laptop, a
> > user probably doesnt need to see them often.  ddebug_exec_queries()
> > still summarizes with verbose=1.
> >
> > ddebug_(add|remove)_module() also print 1 line per action on a module,
> > not needed by typical modprobe user.
> >
> > This leaves verbose=1 better focussed on the >control parsing process.
> >
> > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> > ---
