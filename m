Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D24C35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 19:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F26AE20870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 19:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8I1B8bQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731660AbgBKT1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 14:27:44 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34820 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728202AbgBKT1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 14:27:43 -0500
Received: by mail-qt1-f196.google.com with SMTP id n17so8898499qtv.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 11:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Li/4t3rWpOJsO39OQHX9FJXAU3jc67B61wTAR8MmF0k=;
        b=O8I1B8bQOO8iZqdWfbuoMMB9Ioa6te/eprtlRpRSiGWgH0ZxUJJKZG0qzM1OcHWoKt
         ceanH/wioA1gVchCLr9jk+sU3hJ1KvaKGxGIUCKIakCWN31tA/zGuV95xEvAnYiih0AG
         a+EiUHbopmk3N9NvMwaaDW4wfN2grufAEtE9e/oOdwv+xpH3lJcj+X3Z1fQ0RZcQ9w9J
         dVYDoFp7QoGkFN1EAt0EEVprGAgcbl94460VMw7rg98pD7JsB8dQ29ZbrrlcizNY5nHd
         zkBX0kHjQJ8brQXs7V00m3unug5ThcJfSHV33E76CmMmDwmJwOCWIh6etBBOXUzbdM2B
         64Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Li/4t3rWpOJsO39OQHX9FJXAU3jc67B61wTAR8MmF0k=;
        b=PeHKlb9eDeSTZxi3B601hgnQRUOCRszQTEdBe0fcaqbbi6A/USAzRmR2n17EJVs+OS
         3aeNcxcGWuhyirLdaUz7kGYTmOVqZMFkDQEKpEr/G1Yx4v25Dg3qkYJKoaJtvmgZ/qnH
         oQcu+k8aQrUNa5rd/OfxaoqP7DH2mBIbC8kHQGjA1Ae1TbbkPQa54HsPrsvldapbCEiN
         w+0FVH99VUeRlABboGR9OlZXJZT3tpjbPnLMEKwHWC49jmAJj2ugpAJHDguZ1Ix1S3bn
         gpbl9+Q7l/xi37XDIYKNJEr53N1AipWDLHm2P+1F7flZZNL5IiJsZxk1Sz1kMSZh6Y7j
         yYgQ==
X-Gm-Message-State: APjAAAVaJ2n+p/vrltONA8lA162t1Us/u9tZ/8WIzvoXYYPCgoY5rHvl
        JZrJ4TiCucYJgxMiDIRe0DE=
X-Google-Smtp-Source: APXvYqxJe5VgrXcrX1y6fGSxS6IPV/Z6ysTe1ZYGbFAsZiy94KfVTPtXt+qa1HmqYHdT0IBUHR2mzg==
X-Received: by 2002:ac8:7b24:: with SMTP id l4mr3873167qtu.3.1581449261689;
        Tue, 11 Feb 2020 11:27:41 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id v78sm2518767qkb.48.2020.02.11.11.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 11:27:41 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 11 Feb 2020 14:27:39 -0500
To:     Borislav Petkov <bp@alien8.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Michael Matz <matz@suse.de>
Subject: Re: [PATCH v2] x86/boot: Use 32-bit (zero-extended) move for
 z_output_len
Message-ID: <20200211192739.GA1761914@rani.riverdale.lan>
References: <20200211161739.GE32279@zn.tnic>
 <20200211173333.1722739-1-nivedita@alum.mit.edu>
 <20200211181559.GI32279@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200211181559.GI32279@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 07:15:59PM +0100, Borislav Petkov wrote:
> On Tue, Feb 11, 2020 at 12:33:33PM -0500, Arvind Sankar wrote:
> > z_output_len is the size of the decompressed payload (i.e. vmlinux +
> > vmlinux.relocs) and is generated as an unsigned 32-bit quantity by
> > mkpiggy.c.
> > 
> > The current movq $z_output_len, %r9 instruction generates a
> > sign-extended move to %r9. Using movl $z_output_len, %r9d will instead
> > zero-extend into %r9, which is appropriate for an unsigned 32-bit
> > quantity. This is also what we already do for z_input_len, the size of
> > the compressed payload.
> 
> Yes, thanks.
> 
> What I'll also add to this is the fact that
> 
> init_size:              .long INIT_SIZE         # kernel initialization size
> 
> where z_output_len participates in through INIT_SIZE is a 32-bit
> quantity determined by the ".long" so even if something made
> z_output_len bigger than 32-bit by explicitly using MOVABS so that it
> builds fine, you'd still get:
> 
> arch/x86/boot/header.S: Assembler messages:
> arch/x86/boot/header.S:568: Warning: value 0x10103b000 truncated to 0x103b000
> 
> as a warning.

Yes, this is just a "neatening" patch to use a more appropriate
instruction. There would have to be a lot of work to allow kernels to be
bigger than 2Gb, they're currently limited to at most 1Gb (or even 0.5Gb
if KASLR is disabled) by KERNEL_IMAGE_SIZE definition in
asm/page_64_types.h and there are checks in the linker script and a
bunch of other places, so the decompressed length can't be much bigger
than that.

> 
> Btw, while poking at this, we found out that the MOV really remains
> MOV and not MOVABS if gas doesn't know what the quantity behind the
> z_output_len symbol is, as it is a symbol assignment. Which, AFAIU, with
> ELF64 objects, it should be using 8-byte quantities in the symbol table
> to accommodate such assignments. But for some reason it doesn't.
> 
> Anyway, Michael can correct me if I'm still imprecise here.

For absolute symbols that it sees in the same file it does use 64-bit
immediate move for movq if necessary, but otherwise seems to need the
explicit opcode.

> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
