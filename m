Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C088C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 18:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08A4320732
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 18:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592850819;
	bh=59XEdP4OJOA001GIDb7mDGFieLVBIamDQavdly4pK7A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZWjjFqbFr+ABmKMCZLis1urPI+PWIofZ5p6d30+H7n/22zbL/wCstw+1A1tnCKwuI
	 +fASId/bYGnKk9Ip7vAZtC24mO0Wji9/5UAsEhkZHXJPrN+/r16kY5q+ckFWIdsNAR
	 8R9DWLGoC+fOFgwBrpv1ePFY0j3O87q5fJgbur4Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730329AbgFVSdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 14:33:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:41290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730139AbgFVSdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 14:33:37 -0400
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABBB320768
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 18:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592850817;
        bh=59XEdP4OJOA001GIDb7mDGFieLVBIamDQavdly4pK7A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=anpsJxdxhC2ZfmXBKaD1RhCgu1LcM3cg9ZDyoacYqpFUp5sEF6Sg2D/a4Jgxnfbmy
         15pssc8oJ0Yayl5gzZZFWpKBbjHfWCBOhSxl8Oe1oGMzMwU6QVtC/cGUJQaPG9Q1nk
         7yEBveMLs3mDZyECb4jkwrbgV3SPD1yjbMZVUdLA=
Received: by mail-wr1-f42.google.com with SMTP id r12so399497wrj.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 11:33:36 -0700 (PDT)
X-Gm-Message-State: AOAM533GKpFVJG0lEkVjUGVNcyWAUBBOnHXFxE5KaGyE8SP1vDl6Sm+C
        Okk0VyeXfKvuehap5yizRpkokmugUogIAzDiPYVmhQ==
X-Google-Smtp-Source: ABdhPJwMOWCs7f1SNzuxPUORfevvHvfuyoYy+qTQ2aDC8jYotnbw0UsH7MFIMkG/K9FiJYPXyf8Si6Dez5OPvxtQj0U=
X-Received: by 2002:adf:a111:: with SMTP id o17mr20328122wro.257.1592850815300;
 Mon, 22 Jun 2020 11:33:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200619174127.22304-1-bp@alien8.de> <20200619174127.22304-2-bp@alien8.de>
 <CALCETrXZhFJGJA2h4zP743KYTtni-rQSUME8mtSYUdk1-ZTauQ@mail.gmail.com> <20200622170908.GH32200@zn.tnic>
In-Reply-To: <20200622170908.GH32200@zn.tnic>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 22 Jun 2020 11:33:23 -0700
X-Gmail-Original-Message-ID: <CALCETrU0C5yVwfAOj+v1RqNBZY+phXrdvCBZMKdOXOExBgMbVg@mail.gmail.com>
Message-ID: <CALCETrU0C5yVwfAOj+v1RqNBZY+phXrdvCBZMKdOXOExBgMbVg@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/fpu: Reset MXCSR to default in kernel_fpu_begin()
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        jpa@kernelbug.mail.kapsi.fi, Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 10:09 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Jun 19, 2020 at 11:01:44AM -0700, Andy Lutomirski wrote:
> > On Fri, Jun 19, 2020 at 10:41 AM Borislav Petkov <bp@alien8.de> wrote:
> > >
> > > From: Petteri Aimonen <jpa@git.mail.kapsi.fi>
> > >
> > > Previously, kernel floating point code would run with the MXCSR control
> > > register value last set by userland code by the thread that was active
> > > on the CPU core just before kernel call. This could affect calculation
> > > results if rounding mode was changed, or a crash if a FPU/SIMD exception
> > > was unmasked.
> > >
> > > Restore MXCSR to the kernel's default value.
> > >
> > >  [ bp: Carve out from a bigger patch by Petteri, add feature check, add
> > >    FNINIT call too (amluto). ]
> >
> > Acked-by: Andy Lutomirski <luto@kernel.org>
> >
> > but:
> >
> > shouldn't kernel_fpu_begin() end with a barrier()?
>
> the "fninit" thing is already asm volatile or do you want the explicit
> memory clobber of barrier?
>
> If so, why?
>
> The LDMXCSR and FNINIT have effect only on hardware state...
>

Suppose you do:

double x = 1.0;

kernel_fpu_begin();

x += 2.0;

We want to make sure that GCC puts things in the right order.  I
suppose that even a memory clobber is insufficient here, though.
