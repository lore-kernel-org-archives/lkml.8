Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B0AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 00:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65A9A206F2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 00:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vdHaaaa9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbgGVAJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 20:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgGVAJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 20:09:31 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B95FC0619DB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 17:09:30 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id u6so67161uau.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 17:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mK85RUGmwRYffliq+MRSbfx2SUtfwZmJnFiHDQarqLA=;
        b=vdHaaaa9IE2S38rf1OOdBGMCtcqKWiiXSSoVcwkPuAA/Op7k48Xcv5bIHUGHrNaSO+
         /EoDVOzVWw/2+fyMgxyh4ZHq/JGxvQAckTOQKU/CCZTN4zMs+UJYqaoIkXVU1aZZ0hDF
         /iya58oVKtmixWpxPy0oyt5p2E98nDspu/ULCEbd0lE95lR/cQId1MURVaH9c+R5MSuq
         MfQMswQfTa8am4zkexMwcDniT3sQgxtnAp7DQCK9o96gXD9gDtJi/U1xdPnf2+ShZ1r0
         zBvH4PilGuGoTO6TStVIxyq+/V6KGki/CBSPyF5XRTtY9q+wyTIAemS6kjc3VSj3K7Bn
         NQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mK85RUGmwRYffliq+MRSbfx2SUtfwZmJnFiHDQarqLA=;
        b=FZ7Y7DgOHu8wXNTSe5QYsPyKi2RPkZfu+OWRkqsjTVJaE5RW5widBWbXHhSLgadi8t
         05aAceGhs1Q+28b4kWWH6syHFGmZCWFXb1wNYS39DeZKolDya6D8elhGdNf9Iuo3PDh9
         CFQCjnIh9GDfQpQkMMjRCeT3toe6KBoaIHSrSyYeQx7oB2yrKq3Ax6YSYQH/5z3C5wP8
         Pzcx2sfqzshg9R4x+H/4ofOVHOsWGj9yzInJK9yflRAoG1cwfF/3HGNmWljVtCLJeB19
         G+XVlv2xBxKxrIWh0eDQglezf02ESurhl1mB7EZGV6//l7MD7p9D3K5ZHdz7aO9G+qgB
         2rLg==
X-Gm-Message-State: AOAM530RZ9hllZyZgJr48B1EYb+qmkQVSYZw8ps95jCcZbFjkWr67qZ/
        LzYGT/OGmxFaH2VrTqBELwHWbr0jkkHt0kSF+mMucg==
X-Google-Smtp-Source: ABdhPJx6Jec9MJG+B1or+S03mhb/8U2LGhCRDecxPuzNvED8pDeuKCizZaXpCWHX7Dv3A6yU5IdcVtZJ30CJ7grHfYU=
X-Received: by 2002:ab0:7182:: with SMTP id l2mr22366441uao.13.1595376569751;
 Tue, 21 Jul 2020 17:09:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200714161203.31879-1-yanfei.xu@windriver.com>
 <e3cbdb26-9bfb-55e7-c9a7-deb7f8831754@windriver.com> <20200719165746.GJ2786714@ZenIV.linux.org.uk>
 <021ffaaa-daa4-8d80-c5bd-3a6c816d4703@windriver.com>
In-Reply-To: <021ffaaa-daa4-8d80-c5bd-3a6c816d4703@windriver.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 21 Jul 2020 17:09:18 -0700
Message-ID: <CAJuCfpHUcnEr1duHDjWTRDhpscE6=FWKvjid1eWiMObYY0bL4A@mail.gmail.com>
Subject: Re: [PATCH] userfaultfd: avoid the duplicated release for userfaultfd_ctx
To:     "Xu, Yanfei" <yanfei.xu@windriver.com>,
        Lokesh Gidra <lokeshgidra@google.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 19, 2020 at 6:34 PM Xu, Yanfei <yanfei.xu@windriver.com> wrote:
>
>
>
> On 7/20/20 12:57 AM, Al Viro wrote:
> > On Sun, Jul 19, 2020 at 09:58:34PM +0800, Xu, Yanfei wrote:
> >> ping Al Viro
> >>
> >> Could you please help to review this patch? Thanks a lot.
> >
> > That's -next, right?  As for the patch itself...  Frankly,
> Yes, it's -next.
> > Daniel's patch looks seriously wrong.
> Get it.
>
> Regards,
> Yanfei
> >       * why has O_CLOEXEC been quietly smuggled in?  It's
> > a userland ABI change, for fsck sake...
> >       * the double-put you've spotted
> >       * the whole out: thing - just make it
> >       if (IS_ERR(file)) {
> >               userfaultfd_ctx_put(ctx);
> >               return PTR_ERR(file);
> >       }
> >       and be done with that.
> >

Adding Lokesh to take a look.
