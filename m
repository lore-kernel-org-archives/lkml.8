Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E00FC38BFA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 21:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FC9E218AC
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 21:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMh21tWV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgBXVst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 16:48:49 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46263 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbgBXVst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 16:48:49 -0500
Received: by mail-qk1-f196.google.com with SMTP id u124so10077163qkh.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 13:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rwxcsAsN75o6auj6h/UwQ4eouOT0rdFuNimYtBXVVqI=;
        b=EMh21tWVMiKtiMX/15mlFW2bkqdUQzzSFFTAwEgTUc+9dfctVYJVnF2sKau3SsZwyd
         rz9qJ8H6WOhD5TCqnWWhlB2a2KsmTREx1Fn1CKeeia6tqHROYd0RrQzIc4RoASmXTZpE
         TEkdXXtrOjxqJ9Ty9jRFJCNytmMnaToeuugYwoR2CR/hkhR/X4n7HllPU+PTGZ73NdBB
         uccc8HzbvJO3ywnozyzL3S1m7I9yN+uhXIHDuVCwIvVjLsqgV7qpJQO5N0sB3pjuO/VK
         n1MG6Tejq9uTKlBLRW6WfBYZKe0mB1erHdHY9QSveOxTIsm8pzvGD69lrM7IiHx75lFL
         vKQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=rwxcsAsN75o6auj6h/UwQ4eouOT0rdFuNimYtBXVVqI=;
        b=GNkIgcZ6Cm0ZSK9Ek52meN9sRFElm+T9GNGc4F8/U5Sk2jEqFqk+4KBxInWh6yNoMr
         bWnZDr5auO+LcVFSKyZ/+uyyAoUTHq+LkuzIxWImJciAwJXBda1JhOnqWB+rl+4lOYIx
         9vdk8fYO711cgj4tt8dwmpbjbddLgBrJUwmfJyEWkw5UjRMpxUXXkM4lDEhpIZcR2GaW
         Gs+AzQflLZqpEVqx3oPRufXj2OFwmHa2qvpuQposrl8XXJP8zEvJuF8Y2DlSYSl+L0bh
         3nsgpjZFz7zYPv7QIgSCRagLEvRLG165y8g7WxnoGyIx5k+XFH+NOQPVhoZzdgmPiJRn
         3iug==
X-Gm-Message-State: APjAAAVrqUzCOkwpO4tv1pWvP55Da5+QMdbaH9mfg+f+ye99N5QjgMYR
        Ft5uzETj96pUBGeN9CdU2ftHM+xgQno=
X-Google-Smtp-Source: APXvYqyytMHKYCD286xJ3ougS17+qx/IydYF3O2pRQIi7aToLTd9QIRAntsDUW4ZoTWEhicSbubAJg==
X-Received: by 2002:a37:a78d:: with SMTP id q135mr48484895qke.158.1582580928204;
        Mon, 24 Feb 2020 13:48:48 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id m27sm6760596qta.21.2020.02.24.13.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 13:48:47 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 24 Feb 2020 16:48:45 -0500
To:     Fangrui Song <maskray@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Michael Matz <matz@suse.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@alien8.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 2/2] x86/boot/compressed: Remove unnecessary sections
 from bzImage
Message-ID: <20200224214845.GC409112@rani.riverdale.lan>
References: <20200222050845.GA19912@ubuntu-m2-xlarge-x86>
 <20200222065521.GA11284@zn.tnic>
 <20200222070218.GA27571@ubuntu-m2-xlarge-x86>
 <20200222072144.asqaxlv364s6ezbv@google.com>
 <20200222074254.GB11284@zn.tnic>
 <20200222162225.GA3326744@rani.riverdale.lan>
 <CAKwvOdnvMS21s9gLp5nUpDAOu=c7-iWYuKTeFUq+PMhsJOKUgw@mail.gmail.com>
 <alpine.LSU.2.21.2002241319150.12812@wotan.suse.de>
 <CAKwvOd=nCAyXtng1N-fvNYa=-NGD0yu+Rm6io9F1gs0FieatwA@mail.gmail.com>
 <20200224212828.xvxl3mklpvlrdtiw@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200224212828.xvxl3mklpvlrdtiw@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 01:28:28PM -0800, Fangrui Song wrote:
> Hi Michael, please see my other reply on this thread: https://lkml.org/lkml/2020/2/24/47
> 
> Synthesized sections can be matched as well. For example, SECTIONS { .pltfoo : { *(.plt) }} can rename the output section .plt to .pltfoo
> It seems that in GNU ld, the synthesized section is associated with the
> original object file, so it can be written as:
> 
>    SECTIONS { .pltfoo : { a.o(.plt) }}
> 
> In lld, you need a wildcard to match the synthesized section *(.plt)
> 
> .rela.dyn is another example.
> 

With the BFD toolchain, file matching doesn't actually seem to work at
least for .rela.dyn. I've tried playing around with it in the past and
if you try to use file-matching to capture relocations from a particular
input file, it just doesn't work sensibly.
