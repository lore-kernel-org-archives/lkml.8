Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EFBC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45CDC206B2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rhr3f/+d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730503AbgHFRsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728915AbgHFQf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:35:29 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A6DC002171
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 09:12:21 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b14so43721572qkn.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 09:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LNB4XrMfx73bJTHAO2AhrZUygv9EzgmvGK/ZVIbyqWk=;
        b=rhr3f/+dktLBEgzw+MJRXvW/ZFTLTiX0yv0u8nO/IkwCM3Maf5waT00SMNZd4oAu4W
         0hmRWusyqbiGWLyRx/cBtbApYYEpVomBuE/y02SCH7N9l1b5J7xVRMkd4AnYcBYbl7VS
         BHrBPhGtyIncF9DKGqFV51JW0AXJOjyLr3QiNArI+GcZtIvjbQtFiJS2KlhHPtQdNlOI
         heb1pfPvIb0gBuCMmJoHzHH6FGdZUXJmr04FlOkM7fNGkytatxwYr7C+j5HriVYm545k
         8EscbPVENUaVNmBG7oAY2M/2lgrF6muj0o7gZOEHbojGaZQis9TCaVhxkxpvLBYaR5fm
         +p+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=LNB4XrMfx73bJTHAO2AhrZUygv9EzgmvGK/ZVIbyqWk=;
        b=CoFZTOnvErKK7vWPAvCCrlAH4392n4DLeqFe//KyoWbYEvlY++XpQHk+2159eIB6Ad
         ptKp0E6AUlgb7kCgJtzsvk2RrIZMYg9goeTMRUyppWq5DixAINewSi6pyldGmt9J9wvP
         IXPSzeC6ghWu0ZqyNSBQm9Ps7yJxZ1kdhT2ZfdGqdihPOzRzc5fCvuJN0TzcJVbrhksa
         pcK7mzXv4gDrBhxINW4PmdZOK0rPp9p7mmOL7/dScFNjQGAgQX49VgAOzjc7aDtEk681
         Ucs/CMR9KKp6lXthxISdwCogNATP/1nyAisEzVr+I/IAzqRN2NX5M9QNRYvWS2XNhVnn
         L8nQ==
X-Gm-Message-State: AOAM532rdE8QisiAuUmbZk2q2S0E9/YigLfslYFgLmAbHlHKtXo3OvbT
        U/vBY6XfKCCLLchOtymFKiY=
X-Google-Smtp-Source: ABdhPJw04QM3xFHJS5pDtBRTiR9Yg7aRmbMABPh0dZttNj1MZn0oKCHd2GgnvHncOWyKNqP19tH0DA==
X-Received: by 2002:a37:a848:: with SMTP id r69mr8799325qke.58.1596730340541;
        Thu, 06 Aug 2020 09:12:20 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id l11sm5121757qti.59.2020.08.06.09.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 09:12:19 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 6 Aug 2020 12:12:17 -0400
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Fangrui Song <maskray@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] x86/boot: Check that there are no runtime
 relocations
Message-ID: <20200806161217.GA682406@rani.riverdale.lan>
References: <20200524212816.243139-1-nivedita@alum.mit.edu>
 <20200525225918.1624470-5-nivedita@alum.mit.edu>
 <CAMj1kXHc4o91VkaChoyVzr4w-HOaashMPtkCKLaszMGCxhR_2A@mail.gmail.com>
 <20200526151623.GB2190602@rani.riverdale.lan>
 <20200526171340.pdbautbix5ygdvgp@google.com>
 <20200526191411.GA2380966@rani.riverdale.lan>
 <20200806111953.GA1630647@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200806111953.GA1630647@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 02:19:53PM +0300, Andy Shevchenko wrote:
> On Tue, May 26, 2020 at 03:14:11PM -0400, Arvind Sankar wrote:
> 
> Side question: are you going to submit a v3 of this?
> Or i.o.w. what is the status of this series?
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

The latest is v6 [0], which has some minor changes over this version and
is rebased on 5.8-rc7.

I will send out another rebase once the merge window closes.

Thanks.

[0] https://lore.kernel.org/lkml/20200731202738.2577854-1-nivedita@alum.mit.edu/
