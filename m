Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3088FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 07:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F00F02073B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 07:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lJoI8UB5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389145AbgEYHim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 03:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388947AbgEYHil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 03:38:41 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA29C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 00:38:41 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id z1so1133150qtn.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 00:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4r0lwsVRl4S0vhS+fSHZmivQY20nyQaqhWtNxq+9aiA=;
        b=lJoI8UB5F5IHZE338Rs+oubjNR4y3WBw+PR57/IyeWUy2JWXJy0Usyyb4UN04T9fif
         lt+biIAibSoPeD7cfXpvc4eXs1MIALUnZkGoacVfkYgSdsS6kQWSkFYH4V2smpQdolGK
         6ng5hzAUwEZNvMxrZRfWFpHQbGyOYVarZcOqL+5+BwgGbCyVNbyOfGHbaBgHXWam6Hkh
         swCdKBGJux5L39Egt0dfPOtsJN753j9CnofjI0/fPPDrga+JTf3/0DNwhFKjmrUKOXpp
         Eb6aU8qeDwEpvUsG0nT78cwDFKHiGa38AppSEJIvi8dHhZb/waHJ2aaz9ILbvSjoSvOp
         fGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4r0lwsVRl4S0vhS+fSHZmivQY20nyQaqhWtNxq+9aiA=;
        b=AXGmpu18OjKIRzwg5qAE2UsY2B/h5WzDDlcguSIVlwGeloUV3cHpSbX/+dqeP34dwv
         th0ehJvIEydhr46JuRJZOVMeYS1YrLOf1AHk5xwXvT14xBbSFqzjvw7GxEEiWtTxvgjQ
         klp8J0d88K8Gn+3Qxb+XmM4APXESFNij3xfAHXCUbzHwo/nbMOWR/oFbRK/0eHPTNghL
         oJocZSXHvfts6m7xTbkKDjeUKonmu6NRxryqtw2rUMpyGGQezuaBR2ubXXiO+mOP4yT8
         lODX3+MBYce2rONzewYa1e9KcvrcJV8ptd2Dona6/helHuSt1R7vtjOTTSf+Uhx//lSu
         11nw==
X-Gm-Message-State: AOAM530yMz0RM3QHG8aBunQvAXMyUUspWpQWpNBD6HTj2jN+M3Ddacby
        m3qfqF66PMX1TJr1Mrjyj8h1vineEe+XyAmBM6qBOg==
X-Google-Smtp-Source: ABdhPJyhySPyxlJ2+s2ci0PlmBqxOHy3F1zzRfXB2pz+38+bzn0pj+fo5SbBLVqwK38qQ9dR5twY4OBlkXiuubmOEcQ=
X-Received: by 2002:ac8:74d9:: with SMTP id j25mr1356921qtr.257.1590392320250;
 Mon, 25 May 2020 00:38:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200524145034.10697-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <d65ee15211aa69a815bdc7cc4fc9e7c2e1bcba43.camel@perches.com>
 <CAFqZXNthJE0a3KkgZFXYSFArwRs0H_20KjT6KfAkiMo6WTp1rw@mail.gmail.com>
 <94f7ce4f-74fb-bccc-2e87-749e0c8da92c@i-love.sakura.ne.jp> <b4d273ef6013069c6a68667a1e02204fc1e3ea39.camel@perches.com>
In-Reply-To: <b4d273ef6013069c6a68667a1e02204fc1e3ea39.camel@perches.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 25 May 2020 09:38:28 +0200
Message-ID: <CACT4Y+auXeBtBPAYA5sLXwbS8BZOMvet9ACya2ghZin4ufecyw@mail.gmail.com>
Subject: Re: [PATCH] twist: allow converting pr_devel()/pr_debug() into printk(KERN_DEBUG)
To:     Joe Perches <joe@perches.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 8:07 AM Joe Perches <joe@perches.com> wrote:
>
> On Mon, 2020-05-25 at 14:03 +0900, Tetsuo Handa wrote:
> > On 2020/05/25 4:18, Ondrej Mosnacek wrote:
> > > I'm also not sure if this is really worth it... It would help localize
> > > the bug in this specific case, but there is nothing systematic about
> > > it. Are there that many debug print statements that dereference
> > > pointers that are later passed to functions, but not dereferenced
> > > otherwise? Maybe yes, but it seems to be quite an optimistic
> > > assumption... I don't consider it such a big problem that a bug in
> > > function X only manifests itself deeper in the callchain. There will
> > > always be such bugs, no matter how many moles you whack.
> >
> > There are about 1400 pr_debug() callers. About 1000 pr_debug() callers seem
> > to pass plain '%p' (which is now likely useless for debugging purpose due to
> > default ptr_to_id() conversion inside pointer()), and about 400 pr_debug()
> > callers seem to pass '%p[a-zA-Z]' (which does some kind of dereference inside
> > pointer()). Thus, we might find some bugs by evaluating '%p[a-zA-Z]'.
> >
> >
> >
> > On Sun, May 24, 2020 at 7:38 PM Joe Perches <joe@perches.com> wrote:
> > > While I think this is rather unnecessary,
> > > what about dev_dbg/netdev_dbg/netif_dbg et al ?
> >
> > Maybe a good idea, for there are about 24000 *dev_dbg() callers, and
> > 479 callers pass '%p[a-zA-Z]'. But we can defer to another patch, in
> > case this patch finds crashes before fuzz testing process starts.
>
> There are a bunch more than that.
> Some use other macros, some are functions.


I think this is a good idea overall and I don't mind enabling it on syzbot.
It's not only about %p, even %d can crash kernel or leak sensitive
info (if it happens after-free/out-of-bounds/uninit). Overall it
increases code coverage and allows to catch more bugs earlier. That
was the reason for enabling dynamic debug, but I wasn't aware that
debug level is not included.
