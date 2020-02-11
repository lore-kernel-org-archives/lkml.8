Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFB0C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 22:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B95020842
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 22:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581460901;
	bh=po7kqC7Pvn8ouUFSjitvJdsV90ZhZQbIOK4MtOWD+4c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=z6s1HaeKge6xBIW4FgTTL2uLzUPsVyNCrPG11BdJz1ADqhuc/Hu1FJJ7nbtWGjWyJ
	 dJlg185XFf4+ht6JOw0YminHlErRWTItDZ7Lf5Xmd6mwx0IT1DzPLi15e2pQ/GCOsU
	 e+zHi4eqZOdCPfKc1x4S1rc1+RVQfvuDkdN6Fu2E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbgBKWlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 17:41:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:59160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727330AbgBKWlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 17:41:39 -0500
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF53C215A4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 22:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581460899;
        bh=po7kqC7Pvn8ouUFSjitvJdsV90ZhZQbIOK4MtOWD+4c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=A9SjsBEnM3jsARVQH6Vr8mTRFYVGhigujF6r85gkGJDQV5NSgyXGAldP+bLnXh/9J
         3m3NtP+kcfOzMI6mAYyqirz9/jX0YVwfQ8kfmP5qG/FH5JKPQCzOSv87B8D9c6/iCa
         ssCsOD+3rbZeEUyj8gwWEpLOQGnncSrhXwJy9lZ0=
Received: by mail-wr1-f47.google.com with SMTP id z3so14608478wru.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 14:41:38 -0800 (PST)
X-Gm-Message-State: APjAAAX8x7oWabU+hM97mFj015xh8NrMtWgAyllnH3lxqTvOKGxzzDqE
        Pm7sLLM0/UfPOMXN6MoNzsG6hLKt85vA9I2xlB8kvQ==
X-Google-Smtp-Source: APXvYqwUKxKnR3eGbA73IwMOx/C58CVPpQncokUat63UmXlmSlb5cTd+e+rYF11OC5oIS9uMBg3BBmcyseI9oUikD18=
X-Received: by 2002:a5d:5305:: with SMTP id e5mr11103645wrv.18.1581460897210;
 Tue, 11 Feb 2020 14:41:37 -0800 (PST)
MIME-Version: 1.0
References: <20200211135256.24617-1-joro@8bytes.org> <20200211135256.24617-24-joro@8bytes.org>
In-Reply-To: <20200211135256.24617-24-joro@8bytes.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 11 Feb 2020 14:41:25 -0800
X-Gmail-Original-Message-ID: <CALCETrXswGgGoNaZigboUn3-amTyCY2Ft_JaMMvXchLDDkhJfw@mail.gmail.com>
Message-ID: <CALCETrXswGgGoNaZigboUn3-amTyCY2Ft_JaMMvXchLDDkhJfw@mail.gmail.com>
Subject: Re: [PATCH 23/62] x86/idt: Move IDT to data segment
To:     Joerg Roedel <joro@8bytes.org>
Cc:     X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Jiri Slaby <jslaby@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 5:53 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> From: Joerg Roedel <jroedel@suse.de>
>
> With SEV-ES, exception handling is needed very early, even before the
> kernel has cleared the bss segment. In order to prevent clearing the
> currently used IDT, move the IDT to the data segment.

Ugh.  At the very least this needs a comment in the code.

I had a patch to fix the kernel ELF loader to clear BSS, which would
fix this problem once and for all, but it didn't work due to the messy
way that the decompressor handles memory.  I never got around to
fixing this, sadly.
