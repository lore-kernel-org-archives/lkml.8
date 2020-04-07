Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64145C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36EE02072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="LLpCAO/n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgDGQaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 12:30:09 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33438 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbgDGQaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 12:30:08 -0400
Received: by mail-lj1-f193.google.com with SMTP id q22so693660ljg.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 09:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5tl3riZQZjnCZAMsjjsPzsXQS5Q108zyxZDM95S3sBI=;
        b=LLpCAO/nsvk8eqKTSqArhGDeOHCQVvyfkYsi86Z9h6ye365+yy0yW8jwpSk1vRZ731
         t/4vqDviS9DW2ZXgGXX6Doq6x6ieUYTKCX5ChG16C2eWRv1L/OUK2SzhRnw98MJHw3se
         ki+W/YtHRunoP6GPxsGaXvYPCxYD2lOdonEpxgGdH68Y5++nCNVDBBYQ8FdvwmzyzEuq
         exRqB5mPwAaCCvsTzg79tELg92t3rjfGhiTxgImoZrCv++/Clba6jvUr5nVmpi/J6fgd
         LRqzv6AFibgouNKVtmaQHjkaml4e7ScXIFHSd6jF/YR/mhbynb9Xo6sj/wtNCCzrXnth
         lHmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5tl3riZQZjnCZAMsjjsPzsXQS5Q108zyxZDM95S3sBI=;
        b=P0W8xxEGQlF7uG5CDx0+nVLz1FKEke/N6R5dLC2TBx7aXBTb22Ce1oeEXnQ4qCPjcg
         +oQhb+VRehbDTxmzh905CpujdkUtYJmKk0eVYxoiXikzj/26GVIC32ALzLdP8SeYelYe
         nXy6/mpohpWAt54d5uA914NIRgEmNmOZ7X29UUldztXfmhTsY9jLHCTCrd0LpChaaM9M
         xbcQY9eGQroDhCCm8qzBrSxSQOP9FiBH4BrofeMlFWw8D4k6ei8czvTeqGktFXKIMzYL
         pfT2haeszh7v7xj41EkOgCt9lvu/opDyWTOu/gW9XismjWbes0LpeZGyw3U6Cj3YDYMg
         Kq/A==
X-Gm-Message-State: AGi0Pubio1MAE5wjKLqayXvi1QhQTs9srRZlZWfwjoGMhuOSi9FNkpBH
        qlEFijYNDTIZqP3NjlZHnNST3pV3qNMP4wu9ajewEA==
X-Google-Smtp-Source: APiQypL1N1/bhNyzt2IcHqj5vALuJDflJPJ05dbRl1HfLKriu1nMqtnSCmWHVXTro8/8Tf1yqzsPsXjnwDwKl0VoRUg=
X-Received: by 2002:a05:651c:549:: with SMTP id q9mr2191233ljp.210.1586277005396;
 Tue, 07 Apr 2020 09:30:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200407011259.GA72735@juliacomputing.com> <20200407122103.GU20730@hirez.programming.kicks-ass.net>
 <a5b07aa9-96ea-a9b5-13db-e5dcbd7760e6@intel.com>
In-Reply-To: <a5b07aa9-96ea-a9b5-13db-e5dcbd7760e6@intel.com>
From:   Kyle Huey <me@kylehuey.com>
Date:   Tue, 7 Apr 2020 09:29:54 -0700
Message-ID: <CAP045AoPTFWw2-5F2GmFf_TTipx6x8Na1eNrGjHJ6xWNruEfqA@mail.gmail.com>
Subject: Re: [RFC PATCH v2] x86/arch_prctl: Add ARCH_SET_XCR0 to set XCR0 per-thread
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Keno Fischer <keno@juliacomputing.com>,
        open list <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andi Kleen <andi@firstfloor.org>,
        Kyle Huey <khuey@kylehuey.com>,
        "Robert O'Callahan" <robert@ocallahan.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 7, 2020 at 7:07 AM Dave Hansen <dave.hansen@intel.com> wrote:
> I'm also trying to think of what kinds of things CPU companies add to
> their architectures that would break this stuff.  I can't recall ever
> having a discussion with folks at Intel where we're designing a CPU
> feature and we say, "Can't do that, it would break record/replay".  I
> suspect there are more of these landmines around and I bet that we're
> building more of them into CPUs every day.

With the ability to control the userspace view of CPUID, which we have
had for a couple years in the kernel now, this is much less of a
concern than you might immediately imagine. Most features that get
added are either entirely deterministic (like all the fancy SIMD
stuff) or can be disabled solely by lying to userspace about the CPUID
flags (like RDRAND or TSX). XGETBV is tricky for rr because it depends
on the kernel state as well, but that is rather unusual.

I lose far more sleep worrying about Intel introducing a new
microarchitecture that breaks our assumptions about performance
counter determinism than I do about new CPU features that are tricky
to handle.

- Kyle
