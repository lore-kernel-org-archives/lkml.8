Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313F7C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AA76208D6
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ot3OCpEt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbgEGTTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 15:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726515AbgEGTTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 15:19:41 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BACC05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 12:19:41 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d22so3247853pgk.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 12:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mB3v+OVcFtBZ7ZxmBQPRfPvGnWMyHqtj7wSU+ZXJm/Y=;
        b=ot3OCpEta1bUGj7Eyn/O2BM3DsKQSlfuMJA0kfWjwta8wQItirdklq4ghFKJtmG5D+
         tqhEah0MMH9Y7EUmZlL0zvlUaAgXCc54VBnexdTL6xeTSjrMLEqZjLyesOtnn5M24XY5
         MMMaeJgNx4pIdqR58iZZK84+fVcbfbW6PVJCqvEP/s8Lm3Rbo6zb9Yh6Mbi1UjxsAa6I
         QKy5btjVyumIOTJs+2LESxx92KAaDF8ohkvVgrklotjnOoE1W8mm2CD5YP94A5vrn1Bw
         YVmmjLVNoGMNdY1mhSyfsRaFkHkLZvkA4l04C27gesBHsdKuMmfarNQqcQFAd82vY6Fu
         XTeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mB3v+OVcFtBZ7ZxmBQPRfPvGnWMyHqtj7wSU+ZXJm/Y=;
        b=FMWxTkzLnLTVgsOZJxIHaDQbYU+nFjrRWO6JPd+IrKZ1nSZBIM9XvclWYlnE+6HpWR
         MdHAPfFM7WgS/xry7X6wiCFqRwxF4Rs1/FhBesZah3XhEbPU3xXjR3nM57mdyIGfzCeQ
         p8anUBm8N/AljAJNw3EOcKw4beS9bHoaT5U2jK1LgoiOB9JRzLoOLzp+ETiwVTbWctnc
         5cN1VDiT3Mpu6IjtXBWxfQ+f7nKK4UXS7rt6DHaXCd4kB1MFHSFe820UW7a/Qs26qC38
         ITBEUpNGcroQJ7PxD8suKoBHoOKesFIIRq1to8rsfYslPWgBSqcUdZj+ZSimkWZh+O0o
         m/7A==
X-Gm-Message-State: AGi0PuYWDKpEXKGVBw36NmI4VbPL/PCQrwegrC2UaH84C2wm5AbbIRIU
        ZkpSRkUINe8CRDRhLHqt2wbxbUDl+ESlwrTEh0jQhw==
X-Google-Smtp-Source: APiQypJwDIl+NGSGeTeV9dzXBlAr5vo7snEgRhPkTUModDNer2LwguSt79l/UTDkVHvA/eFy0BCX/S1m9RhMme3bqlo=
X-Received: by 2002:a62:146:: with SMTP id 67mr15430634pfb.169.1588879180828;
 Thu, 07 May 2020 12:19:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200505174423.199985-1-ndesaulniers@google.com>
 <8A776DBC-03AF-485B-9AA6-5920E3C4ACB2@zytor.com> <20200507113422.GA3762@hirez.programming.kicks-ass.net>
 <CAMzpN2hXUYvLuTA63N56ef4DEzyWXt_uVVq6PV0r8YQT-YN42g@mail.gmail.com>
In-Reply-To: <CAMzpN2hXUYvLuTA63N56ef4DEzyWXt_uVVq6PV0r8YQT-YN42g@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 7 May 2020 12:19:30 -0700
Message-ID: <CAKwvOd=a3MR7osKBpbq=d41ieo7G9FtOp5Kok5por1P5ZS9s4g@mail.gmail.com>
Subject: Re: [PATCH] x86: bitops: fix build regression
To:     Brian Gerst <brgerst@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        stable <stable@vger.kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        "kernelci . org bot" <bot@kernelci.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Daniel Axtens <dja@axtens.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 7, 2020 at 7:00 AM Brian Gerst <brgerst@gmail.com> wrote:
>
> This change will make sparse happy and allow these cleanups:
> #define CONST_MASK(nr)                 ((u8)1 << ((nr) & 7))

yep, this is more elegant, IMO.  Will send a v3 later with this
change.  Looking at the uses of CONST_MASK, I noticed
arch_change_bit() currently has the (u8) cast from commit
838e8bb71dc0c ("x86: Implement change_bit with immediate operand as
"lock xorb""), so that instance can get cleaned up with the above
suggestion.

-- 
Thanks,
~Nick Desaulniers
