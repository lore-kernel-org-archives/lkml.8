Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7A2C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 05:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 329142074B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 05:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVHUW/P7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgE2FdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 01:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgE2FdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 01:33:23 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72C3C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 22:33:22 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id j8so1005129iog.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 22:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LYrDPQw19NrlnBb2tQ/1l9SMA0MS/m0/5RMsv3VyV4I=;
        b=DVHUW/P7y+C0ofJ+zUNfI0nr4E0FVg9QxWq76x/n/AitAP0RrtjMtp4bYbCegl3D90
         tv45PseXrAQIWmUeeAx6tV3utPjksIpNkqMRYwv+3qA6JQCmzSjgkfXyYbypJ8N3d7Tx
         mJxnlPxz1aV4twZ2qsWFDMmNC2+f5sS5K/bWF6nuXWkVUySGpZsL204reqEzaqZoypVg
         3ym3bQEZY0NvarF43ELkJ+5Ql26UEtjY2Y0flPLJBXLnNXeDHxx/yrXXQXiDjljNyClz
         FX3LdUxMXBuoaS9gawKhp0dJKD3pxT8u9et6WwNn3TzMkjSaD7cdOLiBiLQruvgDVmcE
         OmmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LYrDPQw19NrlnBb2tQ/1l9SMA0MS/m0/5RMsv3VyV4I=;
        b=jHhprUxE5UDoSYav8Qg5D/I3WBueuPF4JCSDaLdAU4gj8BLOIasdm4LBRmHj41Fh/W
         uYfdrhyIw9qe/9JB3AnMWXfHaxDacoRo798IHE78vncpYjA0NJ3cstPsu3Bf884S3FJA
         2d2nm/WGtGVsy4ubkoevtaq1tYrG2LslUwZENM0ObSmSHM1nhSIqj7ABALdmp0U9eN8C
         LxXUzbPhQ9P25uruUpVZmH0KfPG5sn8cEqsHHbBH7W5GS9dp/gCVHpd3nFz+Pxt2MuOY
         LyBBope3MDANTskhTgIVa28/Ur7qelP//wuC0brtAM1GATSR7ippyCYxM1ZMLqyE8tmZ
         Z1Mg==
X-Gm-Message-State: AOAM532kHW2/689T0zz58eQZDJt7CHLSOMbkT8AVpV7zwOUHCd/Becou
        lDd6uyEslhdbD0FnTycfuvxyiTB5ePkVdaqH8WpqkQ==
X-Google-Smtp-Source: ABdhPJwFxpEDwfylZnwmfA67YW8HhbtDjKFbV7jp6uekopVYxgCpQsPqv4UeM2YomEXyaEqpQSeuxo363w4KNEKB8kk=
X-Received: by 2002:a5e:a61a:: with SMTP id q26mr5158506ioi.207.1590730402218;
 Thu, 28 May 2020 22:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200527194633.1660952-2-bigeasy@linutronix.de>
 <20200528030657.1690-1-laijs@linux.alibaba.com> <20200528143519.GN83516@mtj.thefacebook.com>
In-Reply-To: <20200528143519.GN83516@mtj.thefacebook.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Fri, 29 May 2020 13:33:11 +0800
Message-ID: <CAJhGHyDVkyouuNpSDiJ9nwxZAwKd7uGWf4PN6GXE2Y+3zENz0Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] workqueue: pin the pool while it is managing
To:     Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 10:35 PM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Thu, May 28, 2020 at 03:06:55AM +0000, Lai Jiangshan wrote:
> > @@ -2129,10 +2128,21 @@ __acquires(&pool->lock)
> >  static bool manage_workers(struct worker *worker)
> >  {
> >       struct worker_pool *pool = worker->pool;
> > +     struct work_struct *work = list_first_entry(&pool->worklist,
> > +                                     struct work_struct, entry);
>
> I'm not sure about this. It's depending on an external condition (active
> work item) which isn't obvious and when that condition breaks the resulting
> bug will be one which is difficult to reproduce. Adding to that, pwq isn't
> even the object this code path is interested in, which is the cause of the
> previous problem too.

Ok, I agree with you.

Thanks
Lai
