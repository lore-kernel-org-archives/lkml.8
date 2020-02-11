Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DADC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 18:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4082820708
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 18:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="UxHnwRmL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730218AbgBKSQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 13:16:07 -0500
Received: from mail.skyhub.de ([5.9.137.197]:44084 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728951AbgBKSQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 13:16:06 -0500
Received: from zn.tnic (p200300EC2F0955008CA74DB1104365B1.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:5500:8ca7:4db1:1043:65b1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9B57F1EC0C9D;
        Tue, 11 Feb 2020 19:16:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1581444965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=79gSAJuHXd9FQgV8hkDXwq/zTEBL/3eyIbYBMFeVs/c=;
        b=UxHnwRmLLHcobz76VlQXvHRtcPfffcTdGfdsw2thwedsLEEXm3mS1ZhAJ/+e94jSLaK/om
        qbTgtlJ38DZM+jfpORVMmZZqIhOwwKiH8jbLzYIrNVldKUt1UYj1adSsEiBi+6UiHVkwBC
        oUHc2Ey+FWYuE/xEb72fxynDQ71N4wM=
Date:   Tue, 11 Feb 2020 19:15:59 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Michael Matz <matz@suse.de>
Subject: Re: [PATCH v2] x86/boot: Use 32-bit (zero-extended) move for
 z_output_len
Message-ID: <20200211181559.GI32279@zn.tnic>
References: <20200211161739.GE32279@zn.tnic>
 <20200211173333.1722739-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200211173333.1722739-1-nivedita@alum.mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 12:33:33PM -0500, Arvind Sankar wrote:
> z_output_len is the size of the decompressed payload (i.e. vmlinux +
> vmlinux.relocs) and is generated as an unsigned 32-bit quantity by
> mkpiggy.c.
> 
> The current movq $z_output_len, %r9 instruction generates a
> sign-extended move to %r9. Using movl $z_output_len, %r9d will instead
> zero-extend into %r9, which is appropriate for an unsigned 32-bit
> quantity. This is also what we already do for z_input_len, the size of
> the compressed payload.

Yes, thanks.

What I'll also add to this is the fact that

init_size:              .long INIT_SIZE         # kernel initialization size

where z_output_len participates in through INIT_SIZE is a 32-bit
quantity determined by the ".long" so even if something made
z_output_len bigger than 32-bit by explicitly using MOVABS so that it
builds fine, you'd still get:

arch/x86/boot/header.S: Assembler messages:
arch/x86/boot/header.S:568: Warning: value 0x10103b000 truncated to 0x103b000

as a warning.

Btw, while poking at this, we found out that the MOV really remains
MOV and not MOVABS if gas doesn't know what the quantity behind the
z_output_len symbol is, as it is a symbol assignment. Which, AFAIU, with
ELF64 objects, it should be using 8-byte quantities in the symbol table
to accommodate such assignments. But for some reason it doesn't.

Anyway, Michael can correct me if I'm still imprecise here.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
