Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E28C35669
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 05:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E00120707
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 05:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApHzJ6ol"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgBVFIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 00:08:50 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42773 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgBVFIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 00:08:50 -0500
Received: by mail-ot1-f67.google.com with SMTP id 66so4030870otd.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 21:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uchn7QDHgry7WL4opDjcnm9/ECItWnjFnSq+/FMPcGk=;
        b=ApHzJ6ol0Y2Pfnr+OuMGcc0tVv4k0K0fghnCEdXA3P6Cb2Bw1RSJNEFcRN5j/fYW3I
         1f45mAIJcr9HJKRTBFb5FkmHZqq0OEmp5XFZ/TboYBlFU/HrDY5nLM4cMf9XgTdJACw9
         Cp59yawIjbFUGK/ou18Tder72NlqeIzCJ0EHjxdxjpfZai1XS9XR84PkZkho+QG/2/ei
         cN1JiE+TkU1trbPcat0+BN5GsNfNpHF5N3EXEfoInkhthybRDzNN19E3Cb15Fx/eWsgJ
         FfsaX/qEmhXEzKEf25tViLqGVEHe9qM/I7Qd2W7JI/8On4hgPRQfvlORQUGJwL41yh6X
         TNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uchn7QDHgry7WL4opDjcnm9/ECItWnjFnSq+/FMPcGk=;
        b=qDL/kQYQ7+yji76ENdphcsadhVypvJsW92ZJ9f7w1sF00vXffm6fob0nKy9wpdoeff
         zyXkeiBqJmUHLsauJCCDtxFWSqGxQjD+jMqQLIwoyF8g2qWkLryMooVdI/7cCCXmTrEC
         yYqV/lARUvokY+vmFNTWV9NJ2Wc5Pr8DGnD6+CEnkBrPhXq6ne/NHeb2UtIIB3jHitEI
         E51K9JUvOh7biL0MusUQVQ5PhU8QCXW4ePuRyikPNH+X39NEOoZiWSKJbr1iH2B/3NZe
         VQFGy811ND2Ajqpy9HJ7G37+TEPJXhmvZyptrZMCt1YmuHhFbRbZya6ifI3CpEIH9ETj
         ZD4A==
X-Gm-Message-State: APjAAAXS7N+X3JQDnGEzEuhZRM1GnjM0Mpggx0NZtqIT34uqDBT8rsYB
        h8muTRGR8puw1pJUX0TZmBe2dflbeE4=
X-Google-Smtp-Source: APXvYqxiQUwjEtPtatBgZtHpwbokNlibA0M9bLq3DKYGx9Cs+OsIcCjk22txB+uqizkROOtWUHtehg==
X-Received: by 2002:a9d:4d17:: with SMTP id n23mr31648465otf.85.1582348127608;
        Fri, 21 Feb 2020 21:08:47 -0800 (PST)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id s128sm1700328oia.4.2020.02.21.21.08.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Feb 2020 21:08:46 -0800 (PST)
Date:   Fri, 21 Feb 2020 22:08:45 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH 2/2] x86/boot/compressed: Remove unnecessary sections
 from bzImage
Message-ID: <20200222050845.GA19912@ubuntu-m2-xlarge-x86>
References: <20200109150218.16544-1-nivedita@alum.mit.edu>
 <20200109150218.16544-2-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109150218.16544-2-nivedita@alum.mit.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 10:02:18AM -0500, Arvind Sankar wrote:
> Discarding the sections that are unused in the compressed kernel saves
> about 10 KiB on 32-bit and 6 KiB on 64-bit, mostly from .eh_frame.
> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> ---
>  arch/x86/boot/compressed/vmlinux.lds.S | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> index 508cfa6828c5..12a20603d92e 100644
> --- a/arch/x86/boot/compressed/vmlinux.lds.S
> +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> @@ -73,4 +73,9 @@ SECTIONS
>  #endif
>  	. = ALIGN(PAGE_SIZE);	/* keep ZO size page aligned */
>  	_end = .;
> +
> +	/* Discard all remaining sections */
> +	/DISCARD/ : {
> +		*(*)
> +	}
>  }
> -- 
> 2.24.1
> 

This patch breaks linking with ld.lld:

$ make -j$(nproc) -s CC=clang LD=ld.lld O=out.x86_64 distclean defconfig bzImage
ld.lld: error: discarding .shstrtab section is not allowed
...

I am not exactly sure how to keep that section around (or if it is
ABSOLUTELY necessary like ld.lld seems to claim) otherwise I would send
a patch.

It would be nice not to break this tool since it is faster than ld.bfd.

Cheers,
Nathan
