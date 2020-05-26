Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97782C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 04:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7025F2087D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 04:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590466667;
	bh=x1WAXI2MxxnLa4yFnZKA0idaQEQ3kvC3jplhuJpq+Gg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZlPzDi6O8H/TKUrtuHPX5nl8UaqThZyt2hThZsXbQEJYVE4zXe7R130+3sYAhdh3J
	 OKDpizNdbJO3+dpQtAAMetoueRHRMeSnveFe8cDYe4/h/6FIoBq29qNzj+30R3bDBT
	 /cNBpjrVIxb+kLoEb3mT87uRtNzxNDxcgbYmeeks=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgEZERq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 00:17:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:37226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725271AbgEZERq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 00:17:46 -0400
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C8AA208A7
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 04:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590466665;
        bh=x1WAXI2MxxnLa4yFnZKA0idaQEQ3kvC3jplhuJpq+Gg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CkJNgSWspGqG+zaxQZ+W/RVZ0+lyQy4xHJ/F/ea1z9YYkY4tLlJW265/socMYUrY8
         VWT6rzvAKyCjKdoqQQt46fRKpzrSf6tOCo8gxNYnlz1gcl5P4aVK6834J7LSL+XyFU
         ti05uGY+z0cbUYoLQxCwgkgKP20z9CIZD/UDijNU=
Received: by mail-wm1-f48.google.com with SMTP id c71so1823845wmd.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 21:17:45 -0700 (PDT)
X-Gm-Message-State: AOAM5328dz7YWHeFcsscOpKOwEEaM2//s9SAfPEEOw2URh82FqGFFwf0
        Umi1e/oYz+Hee6GjinBwGVNxUjjlc8FKLVfKUXppCg==
X-Google-Smtp-Source: ABdhPJxoSKfl0wLy1PGLUAYJSGayeMvkqz+7rtpj8a/C3XPWp7v4VscBOW71yibIv8x1Vq81BlZsKdJWI0tHr39eA6Q=
X-Received: by 2002:a1c:7f96:: with SMTP id a144mr22008255wmd.176.1590466664042;
 Mon, 25 May 2020 21:17:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200525152517.GY325280@hirez.programming.kicks-ass.net>
 <20200526014221.2119-1-laijs@linux.alibaba.com> <20200526014221.2119-5-laijs@linux.alibaba.com>
In-Reply-To: <20200526014221.2119-5-laijs@linux.alibaba.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 25 May 2020 21:17:32 -0700
X-Gmail-Original-Message-ID: <CALCETrWyMY-0Z_NJ7DnF4PsSnhnbNsgt14X1GWkajcms-ZUSQA@mail.gmail.com>
Message-ID: <CALCETrWyMY-0Z_NJ7DnF4PsSnhnbNsgt14X1GWkajcms-ZUSQA@mail.gmail.com>
Subject: Re: [RFC PATCH V2 4/7] x86/hw_breakpoint: Prevent data breakpoints on user_pcid_flush_mask
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 6:42 PM Lai Jiangshan <laijs@linux.alibaba.com> wrote:
>
> The percpu user_pcid_flush_mask is used for CPU entry
> If a data breakpoint on it, it will cause an unwanted #DB.
> Protect the full cpu_tlbstate structure to be sure.
>
> There are some other percpu data used in CPU entry, but they are
> either in already-protected cpu_tss_rw or are safe to trigger #DB
> (espfix_waddr, espfix_stack).

How hard would it be to rework this to have DECLARE_PERCPU_NODEBUG()
and DEFINE_PERCPU_NODEBUG() or similar?
