Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4ADC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 15:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B580520738
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 15:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591027061;
	bh=Zyr2z8ZGCJyccsVIOQJpyoC3X2N4M3M099fHdvE5f5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LbHGGeiz7jLlEzsVt1+gqJ+Sm3YnylXQ4JUOqP7bmVUymRpDh8kzedqA6AiONpfEn
	 fmRpjhHX1MgQNWWof0x/G3U9DpxDnAVYHQ/dw/bA9txzPxDfZiyQXfkb7d6T7/b/IA
	 iFqFYQREZ3hEjr6huR9xVumBhglovPJXOmJGUNVs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgFAP5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 11:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbgFAP5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 11:57:40 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AAC1C05BD43
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 08:57:40 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id j198so294015wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 08:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=trNZBbz3zJJbyAjn3/he6DtdhTM/y9W04rrvoCnUZ74=;
        b=gTY9Q51xv7pfrQuLRtJRS+I1OgkWNWrTh1dnu9hz25eUPPOv7Ay3QR4ZPd2VzCJQVg
         cLmhE6PWpYM5CT3/uGljsX/j+IoiKrEsiFH3jiE6TDvHmDx9J+KAvS8hL2R2KchUfVV/
         P1RiF91WrCgu1ywuka7pUw7ZOLOParfIOacWCSWst4ss4OCKanyAoZYc1UuEy2isAh4v
         UdGvIV83iTUspLnbT4oyPqGJjBpaBXDewibwj6rwq9xhF5qcSfXSKXZMw6lkJNdL27fU
         CWfRB+wQahbDZ3xmsnmif7RGulIN+MN2lsLojN2FBHxp8cQ/X3czd9BYpZIGlRUIDS3V
         wWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=trNZBbz3zJJbyAjn3/he6DtdhTM/y9W04rrvoCnUZ74=;
        b=YAKgRZ5tZCYSfe2w4xTyRRUZQgbG25s7VFGQ+Bnxbz0aONkdMbfgykd7VQph3WLQEJ
         ZMs3Sh0Rupc6/Xjn1BJGxIopAuQ7aBtl8RAVeNmMxFsFzdGrU2nd8x6viAoJAQdlKzqX
         iagDi4huFadAFHAyZw03/GCnhAw45cvA+iHOhCUQuJCRpOOPRSRvJ4hBxj2tKHNk2xd7
         ipMFSt32GCWAHsa9TR+BLYVp20h6NpH9zVPdrrMgxU8akFUOjTdadlq5lBHbc5+Uo47U
         Ut4sQB8Z5zD+EhHGLkPL+W2VtE0vMi1onryDu8rco1N1q3bpoVEVYJXnCIl1m3VZ+yMN
         XkWg==
X-Gm-Message-State: AOAM533f+03j27jXu6ZJVdWA1oDzAtvSFM5c3V1EYhFKYO2nltDpWfrV
        zbWpRX//YfPmL3Avckh7hc6drywI
X-Google-Smtp-Source: ABdhPJxRvjz/C1WKq8vFhNyPU2qLtrTpj3R+9u6VZuJz9LJ+38j9lNdGn2V5Ut4OBqmQsATAIS+1Iw==
X-Received: by 2002:a1c:2e16:: with SMTP id u22mr37127wmu.168.1591027059072;
        Mon, 01 Jun 2020 08:57:39 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id d5sm22089081wrb.14.2020.06.01.08.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 08:57:38 -0700 (PDT)
Date:   Mon, 1 Jun 2020 17:57:36 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] EFI changes for v5.8
Message-ID: <20200601155736.GA1698764@gmail.com>
References: <20200601132443.GA796373@gmail.com>
 <CAMj1kXEH+M6j0W8GbwmJ6B2g1Kxoj01XW0P2a5_1OBVFoiF7ZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEH+M6j0W8GbwmJ6B2g1Kxoj01XW0P2a5_1OBVFoiF7ZA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ard Biesheuvel <ardb@kernel.org> wrote:

> On Mon, 1 Jun 2020 at 15:24, Ingo Molnar <mingo@kernel.org> wrote:
> >
> > Linus,
> >
> > Please pull the latest efi/core git tree from:
> >
> >    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-core-2020-06-01
> >
> >    # HEAD: e9524fb97ab5b41b85e1d3408f8e513433798f3c efi/x86: Don't blow away existing initrd
> >
> > The EFI changes for this cycle are:
> >
> >  - preliminary changes for RISC-V
> >  - Add support for setting the resolution on the EFI framebuffer
> >  - Simplify kernel image loading for arm64
> >  - Move .bss into .data via the linker script instead of relying on symbol
> >    annotations.
> >  - Get rid of __pure getters to access global variables
> >  - Clean up the config table matching arrays
> >  - Rename pr_efi/pr_efi_err to efi_info/efi_err, and use them consistently
> >  - Simplify and unify initrd loading
> >  - Parse the builtin command line on x86 (if provided)
> >  - Implement printk() support, including support for wide character strings
> >  - Simplify GDT handling in early mixed mode thunking code
> >  - Some other minor fixes and cleanups
> >
> >  Thanks,
> >
> >         Ingo
> >
> 
> Please note that Stephen reported a conflict with the ARM32 tree, due
> to the replacement of all instances of pr_efi_err() with efi_err(),
> including a couple in some ARM code that is being modified.
> 
> https://lore.kernel.org/linux-next/20200529152907.2205a298@canb.auug.org.au/

Indeed!

Since these semantic conflicts and build failures would not trigger on 
Linus's test builds normally, it might make sense to double check that 
this comes up empty after both the EFI and the arm32 merge:

  thule:~/tip> git grep -w pr_efi_err
  thule:~/tip> 

Thanks,

	Ingo
