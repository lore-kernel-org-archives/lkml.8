Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405ADC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 23:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 174062076E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 23:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4bX19X9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgHUXEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 19:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgHUXEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 19:04:40 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B616CC061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 16:04:39 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id t6so1379849qvw.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 16:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JIkYYfWPZx8vu6g44rtUYz/n2J/i7vQ9ofU14VDGPeA=;
        b=X4bX19X9obqm/65OzN8iL2PSenhb4mACkxVlulMvGbvorYkOs1NhxDTWCxuo+8Dk5V
         uIncqA8ShvB3+us0ZldCrgvegpgjAYcFbe/xuN+c/1FsEZBR/QiwFxG8quWf3LVmQ4YP
         09sa0zSu8ZFow0UWqlLMjpqLcOSXo5U9k/8FuDlE7iVYy3f/IR9h+tAcBv28tAdRnsKv
         HoUBi/ZJLUO2iAxnNmL66Cr+aKvmg3itvj+R1VMrTIenplG4t54sOA9QxmsSOHWxHYqm
         hZ3NY2o6WPJtscWNWLwaU+Y9tDNVzwO383zUFPZaGNxBa4nuHcrqCQr7uClEILjTsPJE
         JEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=JIkYYfWPZx8vu6g44rtUYz/n2J/i7vQ9ofU14VDGPeA=;
        b=NROR5qK/Bj/GFa6/60+lJ3B2G+8CeNDf7FcATwF7lzv/i1uhhU+4g2QQdVdCsOc0YN
         bMXxubtMWVqy2KVhGfG4OOFlQTPXGFPqXjfVzpVXlTKcazrPBdDa3Yi/BAdpAa40XZK7
         svv5cbd9bFGdtiTd19pfakcwXpJYT5UoYbx3sC/eCpPMn3aHNopDjNlzbkuJA9fk0/gb
         bKjtAfYt/gA0eUPiyGBtC/2hl1rloizrUh//UlXt9PyKaTJIVFykxU9cWgcyhfhYv/WZ
         6ZJFLoCHTHhgs4z8GlLzxnzhJbza+hsQ6tqpboMkD//FMEPye2H2X2mWkXZPTVALaT3G
         wTCg==
X-Gm-Message-State: AOAM530hwi4snJ4B6/WtU0id4sfZL+xJo7HvvUlfLXKEtvKpyHVevVW2
        98Wp3d4e2w4KhADG7gkdv0A=
X-Google-Smtp-Source: ABdhPJzlwqZ8zRABMqV75BgbBR14zvF85goGXaXhkTA20lsAThzZodgBDL9Oxw4xP6iarolWZ/UYyg==
X-Received: by 2002:a05:6214:1454:: with SMTP id b20mr4509113qvy.35.1598051078892;
        Fri, 21 Aug 2020 16:04:38 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id q126sm2723114qkb.75.2020.08.21.16.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 16:04:38 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 21 Aug 2020 19:04:35 -0400
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] x86: work around clang IAS bug referencing __force_order
Message-ID: <20200821230435.GA56974@rani.riverdale.lan>
References: <20200527135329.1172644-1-arnd@arndb.de>
 <878serh1b9.fsf@nanos.tec.linutronix.de>
 <CAKwvOdnOh3H3ga2qpTktywvcgfXW5QJaB7r4XMhigmDzLhDNeA@mail.gmail.com>
 <87h7t6tpye.fsf@nanos.tec.linutronix.de>
 <20200813173701.GC4295@paulmck-ThinkPad-P72>
 <20200813180933.GA532283@rani.riverdale.lan>
 <875z9dioll.fsf@nanos.tec.linutronix.de>
 <20200820130641.GA536306@rani.riverdale.lan>
 <87zh6ohm03.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87zh6ohm03.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 02:37:48AM +0200, Thomas Gleixner wrote:
> On Thu, Aug 20 2020 at 09:06, Arvind Sankar wrote:
> > I don't think that's an issue, or at least, not one where force_order
> > helps.
> >
> > If the source for foo() is not visible to the compiler, the only reason
> > force_order prevents the reordering is because foo() might have
> > references to it, but equally foo() might have volatile asm, so the
> > reordering isn't possible anyway.
> >
> > If the source is visible, force_order won't prevent any reordering
> > except across references to force_order, but the only references are
> > from the volatile asm's which already prevent reordering.
> >
> > I think force_order can only help with buggy compilers, and for those it
> > should really have been an input-output operand -- it wouldn't currently
> > do anything to prevent cr writes from being reordered.
> 
> Fair enough. Care to provide a patch which has the collected wisdom of
> this thread in the changelog?
> 
> Thanks,
> 
>         tglx

The gcc bug I linked to earlier is only fixed in gcc-6 onwards. Is that
good enough to remove force_order? I can test gcc-4.9 and gcc-5 to check
if it would currently have any impact.

CBL guys, can you confirm that clang also will not reorder volatile asm?

Thanks.
