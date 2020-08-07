Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0176EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 18:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF80220866
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 18:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posk.io header.i=@posk.io header.b="EgVNCBZg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgHGSrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 14:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHGSrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 14:47:49 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1395AC061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 11:47:49 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id di22so1950560edb.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 11:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aZXProWyZZNdEtWRd11hxg4VXPTVSXNGv9LD2yeJz4A=;
        b=EgVNCBZg2R7r8y2NvbqAfOEzNS5vunNe9hTM44kk25z90L2mVvuaVsUcz8ZoTL8EbL
         XVihZOd+mGWo0Xy+7xQXvX5bnNKJRCa5ULDoL4WKpIYpWEcXNAqOUs+OnaiZNVD4owZY
         Ww3F/TWtHOHprR+6hbRpw+3dbIzgoGa9VoJEKWra68PbNUjW1WID6B2svG4pNILLFbqG
         yk84075LV72nb054rZvJBbjOstdszCXGSYm6zgXJOP4ZIVr4bYDcV3kWAhwe32nfWrgk
         6LyslUHEzB2dw+DbKaj5UjBattCpV7pIOrkaV0M0KhYvxzSy6OsN36+3E4mewBxZYU7r
         qsHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aZXProWyZZNdEtWRd11hxg4VXPTVSXNGv9LD2yeJz4A=;
        b=lkouMi1Ne8bniuOtx9oaNn3FHB1vDlOzOOLwdtDSpAi7e5/0yDSMR4RTBxTBWvdM6/
         /G4pOq1r/k7JsbtyCl5NzEBCJf8wyTaVXVNJv4yYOEBWQyBfVnO3aBVg4Pa3omcsnXhu
         N+R7yrf8VcY5BCI17GCDlKr4J+PbOld/L9To8LEJC/SXaMgv00XyQw/S4VcIw8AXMmpd
         HFV/InSEZnGfy6MgaIpUpAmNF/9IYtY65+36GWYRtPsMREyRkVBcuq6J64GUXmIrRyvH
         oYDP3pQgfZ45ZO1YQXtFZ1D1r/LGA0PkAsu/Oh/IVozRIkhD8KrRo9bzv3CkjCR1q1jg
         db1A==
X-Gm-Message-State: AOAM533ib3sDxeUzihaT/5YjaX4s0y7qrnhComNeTZBxt41qsameE6g5
        ulqGFv2+8F7EpIj7atJRasgEFJi7Nz3FX+ASV5d8Nw==
X-Google-Smtp-Source: ABdhPJwe22CtSB9k24YVMSCncUEEEz8j0iGPDUJfTKRycIpiuqskABCo7Klkacb0yZm2wE44xunO6HIlMqCRMwFz0CE=
X-Received: by 2002:a05:6402:a5b:: with SMTP id bt27mr10380437edb.120.1596826067631;
 Fri, 07 Aug 2020 11:47:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200806170544.382140-1-posk@google.com> <20200806170544.382140-2-posk@google.com>
 <20200807002705.GA889@tardis> <CAFTs51VNdN8t79Gr7R6H0rYVYSx1Qyd6YC4P89OYSmHKn_PXLQ@mail.gmail.com>
 <1745833987.2640.1596824715742.JavaMail.zimbra@efficios.com>
In-Reply-To: <1745833987.2640.1596824715742.JavaMail.zimbra@efficios.com>
From:   Peter Oskolkov <posk@posk.io>
Date:   Fri, 7 Aug 2020 11:47:36 -0700
Message-ID: <CAFTs51X_5=Z_Rxyz5NCzjtYTvB9EWWyH4tV=k_CWaRWqjed-6A@mail.gmail.com>
Subject: Re: [PATCH 2/2 v2] rseq/selftests: test MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        Peter Oskolkov <posk@google.com>, paulmck <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Turner <pjt@google.com>,
        Chris Kennelly <ckennelly@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 7, 2020 at 11:25 AM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> ----- On Aug 7, 2020, at 1:55 PM, Peter Oskolkov posk@posk.io wrote:
>
> > On Thu, Aug 6, 2020 at 5:27 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> [...]
> >> What if the manager thread update ->percpu_list_ptr and call
> >> membarrier() here? I.e.
> >>
> >>         CPU0                    CPU1
> >>                                 list_ptr = atomic_load(&args->percpu_list_ptr); // read list_b
> >>
> >>         atomic_store(&args->percpu_list_ptr, list_a);
> >>         sys_membarrier(MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU, 1); // send ipi to
> >>         restart rseq.cs on CPU1
> >>
> >>                                 <got IPI, but not in a rseq.cs, so nothing to do>
> >>                                 cpu = rseq_cpu_start(); // start a rseq.cs and accessing list_b!
> >>
> >> The thing is, atomic_load() is an reference to ->percpu_list_ptr, which
> >> is outside the rseq.cs, simply restarting rseq doesn't kill this
> >> reference.
> >>
> >> Am I missing something subtle?
> >
> > rseq_cmpeqv_cmpeqv_store is used below to make sure the reference is
> > the one that should be used; if it is no longer "active", the
> > iteration is restarted.
>
> I suspect it "works" because the manager thread does not free and
> repurpose the memory where list_a is allocated, nor does it store to
> its list head (which would corrupt the pointer dereferenced by CPU 1
> in the scenario above). This shares similarities with type-safe memory
> allocation (see SLAB_TYPESAFE_BY_RCU).
>
> Even though it is not documented as such (or otherwise) in the example code,
> I feel this example looks like it guarantees that the manager thread "owns"
> list_a after the rseq-fence, when in fact it can still be read by the rseq
> critical sections.
>
> AFAIU moving the atomic_load(&args->percpu_list_ptr) into the critical section
> should entirely solve this and guarantee exclusive access to the old list
> after the manager's rseq-fence. I wonder why this simpler approach is not
> favored ?

I think the test code mimics our actual production code, where the concerns
you outlined are not particularly relevant. I'll see if the test can
be simplified
in v3 along the lines you suggested.

Thanks,
Peter

>
> Thanks,
>
> Mathieu
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
