Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D59C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 13:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8719120658
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 13:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WPUvthuE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731379AbgCPNjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 09:39:24 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51750 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731330AbgCPNjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 09:39:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=BaRGNKQoR/jrhx6/KSsGNdhrEF6jcrpsPC4IKGlhMFI=; b=WPUvthuEug6gpm35QMMqVvEc1P
        DOFr3Fi3AI9FzBrXgn9aseRLFv1dkD8MwN4Bnruv9vw0VRZVnozJfIpCpRcJ2g4gD48zWpT4FFo+6
        0/8vk36awSocJEidgtN/yxqmxOY56+3rhq4N5/+EAlA6gGtqVAFKSxqvlHPVj63cNEmw01IQ2Vmv9
        wNVdyHKuXDUe0L6I5OOR0hsLqeaQB1ar9Tm34kmIOTm07SW2pySxJduV6Qyz7o7PTBdFDzDZ06/Sy
        7VzsmR9kxGluYjdTaI12N7QGXIH+C3opbggU+kP0ORXWzVahSF2NOLpe8zV11iUPFvqYDXpVemHWE
        XlSrNZOA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jDpxe-0006hA-El; Mon, 16 Mar 2020 13:39:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 49A8330110E;
        Mon, 16 Mar 2020 14:39:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F2A4D20B151F2; Mon, 16 Mar 2020 14:39:16 +0100 (CET)
Date:   Mon, 16 Mar 2020 14:39:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ling Ma <ling.ma.program@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        "ling.ma" <ling.ml@antfin.com>, viro@zeniv.linux.org.uk
Subject: Re: [RFC PATCH] locks:Remove spinlock in unshare_files
Message-ID: <20200316133916.GD12561@hirez.programming.kicks-ass.net>
References: <20200313031017.71090-1-ling.ma.program@gmail.com>
 <CAOGi=dNniSgkUtJPfaYLAbR+_8DMFdU59mx7hf8Otj_VjDF_dQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOGi=dNniSgkUtJPfaYLAbR+_8DMFdU59mx7hf8Otj_VjDF_dQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 09:25:42PM +0800, Ling Ma wrote:
> Any comments ?

A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

Also, it probably helps to Cc the right people.

> <ling.ma.program@gmail.com> 于2020年3月13日周五 上午11:09写道：
> >
> > From: Ma Ling <ling.ml@antfin.com>
> >
> > Processor support atomic operation for long/int/short/char type,
> > we use the feature to avoid spinlock, which cost hundreds cycles.
> >
> > Appreciate your comments
> > Ling
> >
> > Signed-off-by: Ma Ling <ling.ml@antfin.com>
> > ---
> >  kernel/fork.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 60a1295..fe54600 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -3041,9 +3041,7 @@ int unshare_files(struct files_struct **displaced)
> >                 return error;
> >         }
> >         *displaced = task->files;
> > -       task_lock(task);
> > -       task->files = copy;
> > -       task_unlock(task);
> > +       WRITE_ONCE(task->files, copy);
> >         return 0;
> >  }

AFAICT this is completely and utterly buggered.

IFF task->files was lockless, like say RCU, then you'd still need
smp_store_release(). But if we look at fs/file.c then everything uses
task_lock() and removing it like the above is actively broken.

