Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707A4C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AC8D2177B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="PoP10f4t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbgHERWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728787AbgHERTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:19:49 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80480C06179E
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 10:19:48 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id bs17so14360555edb.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 10:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ggWm0T5pBn7JnigTAPRbmUTfRdvzxQl+mpQ72rR0fUs=;
        b=PoP10f4tjqT5dS5d/uwUo+sqOTBfpYa07l9Dp61aeW+rv082Wx5BtKN+1bCLsTJF1U
         nUbzGtQNIwu2lxwjJRDipJ2qANYW9dxqDIcqBjZ++7ZQUP3W/BTxTY/e3PVATg5z5PlD
         fovDZooeuStLnEv4MVI4Zsu2xoFIEnyOrC3BQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ggWm0T5pBn7JnigTAPRbmUTfRdvzxQl+mpQ72rR0fUs=;
        b=SySxZlpCA7agqkNIJQhdPhliit9cq1TjTiVDgnirMcAbf8K/RZUQFogtTiDPkQ2CeB
         OPGt3tR1r2rATtDCHqD6lfwnqI+m3Gnx8TKH0x6tRtXd6IzyrYCYTOqxgoSSd8MDN1BV
         j/GZKuCllge5lk2M1OofG3fsSlOxBw4MtnbzNEujDnM29vYYisZUQ2pnHsf7OMScst79
         DUebqOvRBFYKAE23RdbsLuLmLvXb+Kx0XjGQMAiH2zefRw5syX2f1wAOHBXdFQJhXGDK
         ayzr/V1fuCDisms7lo7lcr3/Zq2sjVHviwQW3hs2mUnAVIbv2LCNrYEmP1QyDY4mnTGQ
         vVgg==
X-Gm-Message-State: AOAM532wFhjnD63Kv0gOmHqeGNjc1TJ/KW4axkbzIWx5ghs7NVevv8R6
        n8a+H6jdHL3Nnl0XZrt4vpDYdD5h8tfdZNW9K9xzXw==
X-Google-Smtp-Source: ABdhPJxDf4TG2ZDbOcy/ueJc/nhD6cuCUKJp/4SEeu6p3T512+TCDX0Q15WYk1mR9VBwMmf6ImGgphnQt/h+li9HEKQ=
X-Received: by 2002:a05:6402:12c4:: with SMTP id k4mr288635edx.358.1596647986830;
 Wed, 05 Aug 2020 10:19:46 -0700 (PDT)
MIME-Version: 1.0
References: <159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk>
 <159646185371.1784947.14555585307218856883.stgit@warthog.procyon.org.uk>
 <20200804133817.GD32719@miu.piliscsaba.redhat.com> <2316806.1596641851@warthog.procyon.org.uk>
In-Reply-To: <2316806.1596641851@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 5 Aug 2020 19:19:35 +0200
Message-ID: <CAJfpegvZqZBFb2--W315CXX40F=jLNxYK1EpVRRnn8crGUuLDw@mail.gmail.com>
Subject: Re: [PATCH 08/18] fsinfo: Allow mount topology and propagation info
 to be retrieved [ver #21]
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ian Kent <raven@themaw.net>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Karel Zak <kzak@redhat.com>, Jeff Layton <jlayton@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 5, 2020 at 5:37 PM David Howells <dhowells@redhat.com> wrote:
>
> Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> > > +   __u32   shared_group_id;        /* Shared: mount group ID */
> > > +   __u32   dependent_source_id;    /* Dependent: source mount group ID */
> > > +   __u32   dependent_clone_of_id;  /* Dependent: ID of mount this was cloned from */
> >
> > Another set of ID's that are currently 32bit *internally* but that doesn't
> > mean they will always be 32 bit.
> >
> > And that last one (apart from "slave" being obfuscated)
>
> I had "slave" in there.  It got objected to.  See
> Documentation/process/coding-style.rst section 4.
>
> > is simply incorrect.  It has nothing to do with cloning.  It's the "ID of
> > the closest peer group in the propagation chain that has a representative
> > mount in the current root".
>
> You appear to be in disagreement with others that I've asked.

Read the code.

Thanks,
Miklos
