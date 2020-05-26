Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7D4C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 01:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B744920723
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 01:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pcHbFjbA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388447AbgEZBtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 21:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388233AbgEZBtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 21:49:03 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2DFC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 18:49:03 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id 18so18913794iln.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 18:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MGYKLcbEt7m2YIDYMN8JCaamuunZ45FwWzCg5naykCg=;
        b=pcHbFjbAR/13cPCIavCp6zL/sdqk2Gv0nXa6knCrexYjRLfJ6+brlHNX0hPwyglgXh
         0CTzZOtgp/M4Tq4RNdjVBtK6m1AaXbh+LEugRq/vqbASQJjmWHUf0YAPNN7C1awCh+qv
         2bsSSXyD55gXSxVnm7GMF5rX3wfs+pEBoDqZAj8aJ+QqVC1cVC0nmw15KF91Ai5m1/wb
         rYtKVbdAn+EWVcuZufPVmhvyB/GPmZmz4sghEXOt1/keN9HQAf9y9E0t6ZGDCfRhbqDU
         lEE3GEW3FlmgOOoG48EX+MwZYEy/RCC0OjY7vZ69GOFblwaWFf/c6z4szLYxkbLTjKNJ
         iQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MGYKLcbEt7m2YIDYMN8JCaamuunZ45FwWzCg5naykCg=;
        b=bzGZAvR/Yr5agrcqOQpTHdwkM7MvlJ+Z/FRakPlHQhYfbtm17G3Xst4MZO6YeovAbu
         +/1ebQuopqxaNYgWob/Dw/+qy+Ok5o9xDKCjI1+mcGv5ugQ7GxnMLmzgGzJH8CeUrOwz
         nm32z6nbLXdBUzHWAfiweIu9u9vzpUas14j3YpRsMjFhjkuSY9TC3toPmBZ6KT0rbg4Q
         mkijNPB4FwGUmOCig8n8FiE/N61DW4O4/dDdX60ZB+cWlZ2kGBskHxXImyvJuM7PHWAL
         5XAwqRXesQ3XcbdjhpOyYjf9sp9/7cTD06K4Oh5GlU3p5xOfXypyGprA0Aw3joU7FW8Y
         x8jQ==
X-Gm-Message-State: AOAM533UsmnFmat+nvgFZ2oFGY0YisNMsfN+AYB2rtgJYWI3Ml8CWQ4w
        /youI4/VW+xE6nv+ja2AAd8BFMLh0K4w4FMhwoI=
X-Google-Smtp-Source: ABdhPJxxR9HGc1RumFlDgbPAh5xidpDFqidmrzO69UpPY8cBxJHX8PPVYlALW6sjLLAEf6pgqhWQwbvmkP/zXLFj9kI=
X-Received: by 2002:a92:d182:: with SMTP id z2mr27149013ilz.47.1590457741697;
 Mon, 25 May 2020 18:49:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200525145102.122557-1-laijs@linux.alibaba.com> <20200525152517.GY325280@hirez.programming.kicks-ass.net>
In-Reply-To: <20200525152517.GY325280@hirez.programming.kicks-ass.net>
From:   Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Date:   Tue, 26 May 2020 09:48:50 +0800
Message-ID: <CAJhGHyBPrgvY-HimMYvTcjHXNYgV_XLPddxe6AuBKRKt5Bd0Hw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] x86/hw_breakpoint: protects more cpu entry data
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 11:27 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, May 25, 2020 at 02:50:57PM +0000, Lai Jiangshan wrote:
> > Hello
> >
> > The patchset is based on (tag: entry-v9-the-rest, tglx-devel/x86/entry).
> > And it is complement of 3ea11ac991d
> > ("x86/hw_breakpoint: Prevent data breakpoints on cpu_entry_area").
> >
> > After reading the code, we can see that more data needs to be protected
> > against hw_breakpoint, otherwise it may cause
> > dangerous/recursive/unwanted #DB.
> >
> >
> > Lai Jiangshan (5):
> >   x86/hw_breakpoint: add within_area() to check data breakpoints
> >   x86/hw_breakpoint: Prevent data breakpoints on direct GDT
> >   x86/hw_breakpoint: Prevent data breakpoints on per_cpu cpu_tss_rw
>
> I think we can actually get rid of that #DB IST stack frobbing, also see
> patches linked below.

Hi, Peter

I reviewed that patchset before. It is all what I want, but it still
didn't remove IST-shifting. I remove it in V2.

>
> >   x86/hw_breakpoint: Prevent data breakpoints on user_pcid_flush_mask
>
> Should we disallow the full structure just to be sure?

Sure, just did it as you suggested, thanks!

>
> >   x86/hw_breakpoint: Prevent data breakpoints on debug_idt_table
>
> That's going away, see:

Yes, so I added a note in the patch, saying "Please drop this patch
when Peter's work to remove debug_idt_table is merged."

I directly drop the patch in V2.

Thank you.
Lai


>
> https://lkml.kernel.org/r/20200522204738.645043059@infradead.org
>
> But yes, nice!
>
