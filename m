Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40B6C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 21:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98916207CD
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 21:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmOc7Bz7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbgHVVRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 17:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728729AbgHVVRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 17:17:10 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3163DC061573
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 14:17:10 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id s15so2174256qvv.7
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 14:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yH1SIT4I5zLgF08JR3jAcoSi73lF2BBLmlCMe56jsJo=;
        b=WmOc7Bz7Ll32cJhJcDO8Amc0lOJNVGAQOmwCLqbShhlht+9RXiGjKwioLIQm2VxblT
         oVSNEzdtWuoETaf32KrZjilxTsTacWAyu5BGiAO3MlccJihCcpI1RS5xZYvJv37rENtT
         v2q0DcJQmQtGk2Y8NHalFQnTTO1h4vL62tpUE7VUIjgkQI7Xu4JJMBtdY19AleMXhaJ2
         s4x/L2mSKiNBuIYOeOVaIV0oJsd9YagzCvrmeximBMRYaRxD550EpJ5NqSNwSan16Xq2
         7HaF+iLSuU0VJMR9C5gwNEd839GWAe2vESnQfyI9bOfumJq5qdGRJkBrBgAdqUXLXP7R
         4TSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=yH1SIT4I5zLgF08JR3jAcoSi73lF2BBLmlCMe56jsJo=;
        b=N5dhRWt1Hj5/BYYYSgjg97JKUTs+lmQf2oQ8pg/ges8ZfdQpG5RB2fecL8zdDDm2A9
         NuQFYRMgCCnu/ev5Au71rBz/LSb0zDmviJLLvz5kHGgkL3WZpT2OuLTWZL51UCojdw1m
         iYLQEaUWw2o7lbhG54wlWVCZ6buUim8vrjivIh62JjkxYJKXAJbLss5rVFHGkbNPi7Lw
         Oq+VXAr3pQeP8m6QWVrg5DL7qxo5K/w0HmsddETci4bErCdJ7In1LVy/YjvTG32r/pHG
         aD4z6Qd+pDTRMe+405Ab0b+9YkjWOCH8Lw68ha0QaJ3B+iewoXLfqgeE9dhXnPO48kDU
         9www==
X-Gm-Message-State: AOAM530RfBQebtZGNl5C0fGULlWm/yj5aiFkglsFiSqmHgUor5d3rfDN
        4EbudGC+8jjDDI+Y7BMx21A=
X-Google-Smtp-Source: ABdhPJwjNi+ES1CrZ733NWVLYu1PbPaQ6BDXUBNDcLu79c+WXJGoazGsBsPoD55tvoqSD3OHmyOl2A==
X-Received: by 2002:ad4:576c:: with SMTP id r12mr7992606qvx.232.1598131028339;
        Sat, 22 Aug 2020 14:17:08 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id j31sm6736810qtb.63.2020.08.22.14.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2020 14:17:07 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sat, 22 Aug 2020 17:17:05 -0400
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
Message-ID: <20200822211705.GA1382515@rani.riverdale.lan>
References: <20200820130641.GA536306@rani.riverdale.lan>
 <87zh6ohm03.fsf@nanos.tec.linutronix.de>
 <20200821230435.GA56974@rani.riverdale.lan>
 <CAKwvOdkoB+fT9tt7vgg1R6J-NEr77EWP5X8nFat_L-HvEzWGzA@mail.gmail.com>
 <87eenzqzmr.fsf@nanos.tec.linutronix.de>
 <20200822035552.GA104886@rani.riverdale.lan>
 <20200822084133.GL28786@gate.crashing.org>
 <CA+icZUVf9a8LC2Mf0cFymYQfALWs6bVfR1v1nRbxKaLAyU6NkQ@mail.gmail.com>
 <CA+icZUWGHo3mkN4=ZYeU37p8KJhxTXS5QKcAvq_HaqTHmFkw2g@mail.gmail.com>
 <CANiq72=3iOh5Z_rboZf-_GUpBE2LUUv3yPKOVNN_XmaNswdNSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANiq72=3iOh5Z_rboZf-_GUpBE2LUUv3yPKOVNN_XmaNswdNSw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 22, 2020 at 08:17:32PM +0200, Miguel Ojeda wrote:
> On Sat, Aug 22, 2020 at 11:52 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > I am asking myself who is using such ancient compilers?
> 
> There are many users/companies using older versions of compilers,
> kernels and everything. GCC <= 4.9 will still be used/supported (by
> third parties) for a handful of years at least.
> 
> However, the important question is whether those users/companies care
> about running the latest kernels. Many of those definitely do not want
> to touch their kernel either. For those that do, there are several
> longterms to pick from that still support 4.9, as well as other
> workarounds.
> 
> Thus I am usually in favor of raising the minimum whenever new hacks
> are required to be added. On the other hand, we already raised the
> version twice this year and it is not clear to me what is the minimum
> version we would need to go for to ensure this does not bite us.
> 
> > If this is a real problem with GCC version <= 5, so can this be moved
> > to a GCC specific include header-file?
> > Thinking of include/linux/compiler-gcc.h or
> > include/linux/compiler_types.h with a GCC-VERSION check?
> 
> That would be better if it can be done, yes.
> 
> Cheers,
> Miguel

The fix landed in gcc 6.5, 7.3 and 8.1. The bug is presumably quite
difficult to actually trigger. As a sample data point, I verified that
7.1 vs 7.1+fix have no differences on 32-bit and 64-bit x86 defconfigs,
on current mainline.

Assuming we don't want to risk removing force_order, I'd suggest
- make it an input/output operand, so it enforces ordering fully.
- either restrict it to gcc < 8, or just provide a proper definition in
  some file (maybe arch/x86/kernel/cpu/common.c)?

Thanks.
