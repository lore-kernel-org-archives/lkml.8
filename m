Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C259C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 19:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53A6F20768
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 19:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d+8whJ+C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgF3T0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 15:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbgF3T0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 15:26:11 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71275C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 12:26:11 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id c11so12063006lfh.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 12:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zp5IF5vcvuCu2gwgY+TzliRbsIBW1Igf4k0wqLGBZVA=;
        b=d+8whJ+CDvQp9gSztOTjyISsxB6w/oE1k0dTkyIrGpYzlrO1923v7B0bIv+IZMVGtc
         dHtFpgYgpYYUSlaPoDeUP9I94LkopNHp2EZ+iFMcvnZA4TB+3hgToQ7S6eDAA1muI9o/
         5UKWmPsC+oibSBac8iv2DnroNKr+dyZkRFHQoQobMflsbEJEscezjSQAYg7aCCfsIWmo
         8ykwdNfJY0VYnbwzdHOOUJYRpzDOPDGitc8zLOW5XmPuGnMxgwRcq2xbU59NbAfZY16z
         8ffEaE3N2dArYpSp4EMqD4MWE80Fiqpts6cMXsAL+Ke2DDnJAtLKGEeg2ZHlntLKE+Q/
         K0nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zp5IF5vcvuCu2gwgY+TzliRbsIBW1Igf4k0wqLGBZVA=;
        b=GUK1PNk/I9QqlN/2O1zwPaydHJ1cfmJ3qsbhSIJ9h63M1ZS8qRJP/5V/SOIj4ZUWSJ
         B2btYtitKvbHreOMX2TXVh6y/eorpWrY9nsFxV78B2y3aRd5LCwpOabTxoywiZpGiGmF
         qN/p4nQ+uXQKnTXUnjuWfmeAe1nJM9NfOt3TjwZdXV5bhOzUbsyXIhQgTiayIjtQHuz0
         kZTxeADTdUGjbHQPuyGsmhdTva3NzGD/8Og2VJ3lwelBDUYPJDIIi+r82s8480bZRBmZ
         l9DbGT9jCz4UumIMmqoZR3+Z22BSb/EHeM2mgnXx/+IWTxRZ6Tku9PAABXI+sJSe3gad
         Slkw==
X-Gm-Message-State: AOAM531mjA38s1Kda8/YqJLrniJDPBizZa9AdTWPsEqzh7BuVScekL3g
        vsbpDY3cSe8elLX3+uwWL0nXMzr/eTxYbdQdSCLkYg==
X-Google-Smtp-Source: ABdhPJw6Oa8Vk19NEDCPKZSad/tRxr0zgylemKX4mDPL8U6NR6qoINtpwhEq2uZrbweXXWRp9WjWNi5OPRzeVRhOvsk=
X-Received: by 2002:a05:6512:482:: with SMTP id v2mr12596062lfq.3.1593545167726;
 Tue, 30 Jun 2020 12:26:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200629234503.749E5340@viggo.jf.intel.com> <CALvZod55OFzOozsDbyTkUh1uZEobo4CZ=+8JgrJJHw8QuWh0hw@mail.gmail.com>
 <654d785f-3fe5-d8bd-86bf-bf7431527184@intel.com>
In-Reply-To: <654d785f-3fe5-d8bd-86bf-bf7431527184@intel.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 30 Jun 2020 12:25:56 -0700
Message-ID: <CALvZod5-YuMC8b6rs=a_ahh0WF14wgKJBW18CARJtGa_bYUn0Q@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/8] Migrate Pages in lieu of discard
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 11:51 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 6/30/20 11:36 AM, Shakeel Butt wrote:
> >> This is part of a larger patch set.  If you want to apply these or
> >> play with them, I'd suggest using the tree from here.  It includes
> >> autonuma-based hot page promotion back to DRAM:
> >>
> >>         http://lkml.kernel.org/r/c3d6de4d-f7c3-b505-2e64-8ee5f70b2118@intel.com
> >>
> >> This is also all based on an upstream mechanism that allows
> >> persistent memory to be onlined and used as if it were volatile:
> >>
> >>         http://lkml.kernel.org/r/20190124231441.37A4A305@viggo.jf.intel.com
> >>
> > I have a high level question. Given a reclaim request for a set of
> > nodes, if there is no demotion path out of that set, should the kernel
> > still consider the migrations within the set of nodes?
>
> OK, to be specific, we're talking about a case where we've arrived at
> try_to_free_pages()

Yes.

> and, say, all of the nodes on the system are set in
> sc->nodemask?  Isn't the common case that all nodes are set in
> sc->nodemask?

Depends on the workload but for normal users, yes.

> Since there is never a demotion path out of the set of
> all nodes, the common case would be that there is no demotion path out
> of a reclaim node set.
>
> If that's true, I'd say that the kernel still needs to consider
> migrations even within the set.

In my opinion it should be a user defined policy but I think that
discussion is orthogonal to this patch series. As I understand, this
patch series aims to add the migration-within-reclaim infrastructure,
IMO the policies, optimizations, heuristics can come later.

BTW is this proposal only for systems having multi-tiers of memory?
Can a multi-node DRAM-only system take advantage of this proposal? For
example I have a system with two DRAM nodes running two jobs
hardwalled to each node. For each job the other node is kind of
low-tier memory. If I can describe the per-job demotion paths then
these jobs can take advantage of this proposal during occasional
peaks.
