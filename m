Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729E9C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 04:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4495220767
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 04:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="prZEkPzb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgEPExA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 00:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725803AbgEPEw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 00:52:59 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8575DC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 21:52:59 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id f3so4979921ioj.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 21:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=93TbX2lkjB8K+Ei3cAmwENlMqxtrV35xuDT4xtUKL8A=;
        b=prZEkPzbzg1rWpEFs5E9u7ygp0ADIdxtxLqNu9YjuOlxDf5X60bMessaWgAPsc/5Gd
         yy9sUJJYKoOxQiqK+jnpUaE2FK6zMkLrJr9VzPi3Of0Li/ad68SqnMwSVbmlxLp8PHEa
         tlunFa6ysceNjAsoMadWMe3Sp8xuh92DtXOIRyHFdzx7aRloW+Kq8sVFh9OZfHLsJ/fT
         KR2sAEykoTT/R3Orx2ugQzZrbWyZSuTUXcrSRMX9VCx+yF82iIfCVmdBqeCo2vkfPrnx
         D1PjkmO5dN3dGu1u/qppQCLzxrIt7ClX+s1ZaKswKcYRnzgYSEJRoVIAKvIzZCR3L9dg
         16Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=93TbX2lkjB8K+Ei3cAmwENlMqxtrV35xuDT4xtUKL8A=;
        b=dwh+etSMLXDW8myXlDyvlId92OpAVUHYlN01FEgxWn41sShPwpDJvzWaRTlDQ65eQy
         dOzt08VaHVKGRFX6Lzy84I0yv3YXTmgPrUrQXr8zhbEJUCS3B05XbAJ/2vfSFyeGb5Ko
         yGvvHLvnKoK/4Xhs0I/5bYJ74TzjjI6BmE0HwF+DOv9FmnwGbhj+P5A+JSRDOmoWCIa7
         goMv1hkY4NChOt+4pFQLN5d+q/oVJmFmoqvjDhRROrwQcHI2tb2nPcA/ovO+I7ryo6MB
         Wa8M6Ix8gvYI4//n6ETJ+767qtH3pFsr+rY/XeqW+l9PEjrcEYg8KeJ6jKumTMiUHR9r
         Jq2g==
X-Gm-Message-State: AOAM530rcC2zp5v3zHbvrEkrN24Ff7pP2RborlIEU53r8sb+QNcFG9Jh
        uQ+Cdfmkoh48wg53dOIhhtsVCBMFdGiczNiSFRc=
X-Google-Smtp-Source: ABdhPJwfuixZDOnoJe1/cDkA/cL/2Avw3gZQFQ/hfLtSahMuOG/g7f1cBhGk+k5A59LM5O0RRo7uGwsVYMVSaRlYdM8=
X-Received: by 2002:a02:ac1:: with SMTP id 184mr6362721jaw.137.1589604778464;
 Fri, 15 May 2020 21:52:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200515150122.GY2957@hirez.programming.kicks-ass.net>
 <20200515155912.1713-1-laijs@linux.alibaba.com> <20200515155912.1713-2-laijs@linux.alibaba.com>
 <20200516042705.GA82414@google.com>
In-Reply-To: <20200516042705.GA82414@google.com>
From:   Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Date:   Sat, 16 May 2020 12:52:47 +0800
Message-ID: <CAJhGHyB5BAR2k8OALutExW-Z1iOqjA1s5_vtsU2p2QNa2tE9eg@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] rbtree_latch: don't need to check seq when it
 found a node
To:     Michel Lespinasse <walken@google.com>
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 16, 2020 at 12:28 PM Michel Lespinasse <walken@google.com> wrote:
>
> On Fri, May 15, 2020 at 03:59:09PM +0000, Lai Jiangshan wrote:
> > latch_tree_find() should be protected by caller via RCU or so.
> > When it find a node in an attempt, the node must be a valid one
> > in RCU's point's of view even the tree is (being) updated with a
> > new node with the same key which is entirely subject to timing
> > anyway.
>
> I'm not sure I buy this. Even if we get a valid node, is it the one we
> were searching for ? I don't see how this could be guaranteed if the
> read raced with a tree rebalancing.

It is valid because ops->comp() returns 0 and it should be
the one we were searching for unless ops->comp() is wrong.
The searched one could be possible just deleted, but it is still
a legitimate searched result in RCU's point's of view.

A tree rebalancing can cause a searching fails to find
an existing target. This is the job of read_seqcount_retry()
to tell you to retry.

>
> --
> Michel "Walken" Lespinasse
> A program is never fully debugged until the last user dies.
