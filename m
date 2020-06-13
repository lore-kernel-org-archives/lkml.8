Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E9FC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 02:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1F6D206F5
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 02:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKR6k6zc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgFMCTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 22:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbgFMCTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 22:19:47 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D870C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 19:19:47 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id l10so6377462vsr.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 19:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PoSyBWpYIo5Xcz7POYh0GUIlE3/sg6xh/54qcpWui50=;
        b=nKR6k6zc2Y3THS7lmihX+WSQzgzy+fOJzO6VB/G88FHtI4LjjjkkGZoWjLDB+L2SyL
         NU4l6heFs+K5zoKcX4vVbF/ID5aFrkFDfnyL6N/4oZNZ8R8mxLuuG611in/FTTmGxCJb
         Y8qCZn0QIc7SPTJmOwIG9if1NtUiOdQbrbyC0C+pFsV4x66d3aj7/PPotRiH6NddKSpQ
         560xCidfM3+vna8kLyC66RYoDeFDLdTxdBNb7NFqJX3F5DG9TzMqhMe7M7oSWF0cAkeJ
         lE5hphTrjzrpT/DFF7M4YFDnEZQKDyh/BPomYLimQN0xOQyJJiOtyPBiYjs+n9ty9R2c
         yAOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PoSyBWpYIo5Xcz7POYh0GUIlE3/sg6xh/54qcpWui50=;
        b=VdL4iXHVRuUTHBzzuNmX/1iD2T8Xu2fEsLjKBEg0WCoqNHZkxyfSiZzQgpOMmuuMCt
         i4Z168ZLjf9Amk9JZiX1gLrK1FfKsuL8s4c2u+fqRfCR645NZfbXBSkEwaBshSos6aps
         u7j9Oo5vTCmM/vHDO8LSecOJPYChfRsz9/p7FbYc1aGoKiT2+kRP9exT/3G0EpTd6laq
         Hc00+DpOtbPMRtuhJLWRjtGRDYbwV3HtNyaejkrh8tjCok7P+UpLyha/eLKHRH4Tbq4O
         s/k3M+rn9gU6tfz/nocUNcrEFq9/Wf7xqwAdpbytuIY3FnlU0n+bf5azyJ/oixn55/I6
         NX9Q==
X-Gm-Message-State: AOAM531M3uWTepM43/PBUcwbUVZUsNWZqOy224n97hvRyJENX/qoBjI5
        xHPUiYd++NjCG68YJHIH8cS5OYf8QnhjmERXxkqj5YLR
X-Google-Smtp-Source: ABdhPJxs0CRYID6vseMalw4OdaoKGXGg19EdEmR4GyDOGvTTrzxumx4HYixgWfrRkpUcpvEXeF1zWJ3+em/fpT4uWoU=
X-Received: by 2002:a67:f918:: with SMTP id t24mr12956461vsq.18.1592014782233;
 Fri, 12 Jun 2020 19:19:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200605162645.289174-1-jim.cromie@gmail.com> <8f106309-8d7b-5bfc-6f8b-7223a3a1c72c@akamai.com>
In-Reply-To: <8f106309-8d7b-5bfc-6f8b-7223a3a1c72c@akamai.com>
From:   jim.cromie@gmail.com
Date:   Fri, 12 Jun 2020 20:19:16 -0600
Message-ID: <CAJfuBxy0YZuPHRhEn4rG4poKv3te9vJRDpJY1AvtMzGH7O9gMw@mail.gmail.com>
Subject: Re: [PATCH 00/16] dynamic_debug: cleanups, 2 features
To:     Jason Baron <jbaron@akamai.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, akpm@linuxfoundation.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 3:31 PM Jason Baron <jbaron@akamai.com> wrote:
>
>
>
> On 6/5/20 12:26 PM, Jim Cromie wrote:
> > Patchset starts with 7 "cleanups";
> > - it changes section name from vague "__verbose" to "__dyndbg"
> > - cleaner docs, drop obsolete comment & useless debug prints, refine
> >   verbosity, fix a BUG_ON, ram reporting miscounts.
> >
> > It adds a few query parsing conveniences;
> > accept combined file:line & file:func forms
> >
> >   file inode.c:100-200                # file & line-range
> >   file inode.c:start_*                # file & function
> >
>
> So I like the shortened notation there.
>
> > Then it expands flags:
> >
> > Adds 'u' user flag, allowing user to compose an arbitrary set of
> > callsites by marking them with 'u', without altering current
> > print-modifying flags.
> >
> > Adds 'PFMLTU' flags, which negate their lower-case counterparts.
> >
> > Extends flags-spec with filter-flags, which select callsites for
> > modification based upon their current flags.  This lets user activate
> > the set of callsites marked with 'u' in a batch.
> >
> >   echo 'u+p' > control
> >
>
> I'm wondering if users are really going to use these and how much they
> simplify things? Do you find them useful while debugging issues?
>
> Especially now that now that we are looking to let people define
> groupings.
>
> Thanks,
>
> -Jason

so we have
1- u flag - in modflags, allows marking of sets
2- filterflags - constrain matching sites to those marked
    plus any other subcondition you might want on your marked set

3- negating flags

in filters, they allow complete match to all the bits.
dont want to touch callsites marked with Pt ?
(marked with t, without printing)  now you can.

filters let you use current flagstate to select subsets of " +p >control"
+negations gives complete selectivity on that flagstate

in modflags theyre more convenience,
but setting and clearing 2+ bits atomically
lets you both use the u bit to enable printing
(inc module name filename) and retire that use of u,
or to change the logging output subtly (by dropping threads display,
or module-name)

I cant say its essential, but its so cheap (last patch) once negating
flags are in place,
which are needed for full selectivity filtering.

thanks
Jim
