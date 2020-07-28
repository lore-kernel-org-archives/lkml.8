Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFD7C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 14:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7A44206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 14:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="oXeGPn+K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730384AbgG1OLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 10:11:49 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:52541 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730333AbgG1OLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 10:11:48 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BGJWh4sw9z9sVb;
        Wed, 29 Jul 2020 00:11:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1595945505;
        bh=Jr1H6AmsOFd6wTE49i8eBM9OqNwxXtvoMSicvum3Wvo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=oXeGPn+KVCSQFACUnb2GXogPgbHjKrsSt0TsKxBJyKHYiMPL1s/86Yga4cFrQN9HS
         //9iBGFHmZOw97SSVu+3JOVYUeYTnsIPcr2d4EsrpagQzKCRdVfWa39PWCgfNbXOjN
         SQYRNCtM+EF9evN9kMgecsSmIVXH1SYnJbpHa2kE1I18JTtFPjCnR+J/o/z+5319zJ
         h/iqffcIA1XoHRg7WD40C58vA3RDgwTO5sEfo5Bmj0uNZiW9fYKgAYSxpxsHQ1aK4S
         t/nsfraMM2C6O0i7eFT4keDyCoDI1Uxsloy/h77l7BeUE/Ln0L9jQLuFSF32j2iW6t
         dL9BJrYyRRwvA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Hari Bathini <hbathini@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        Pingfan Liu <piliu@redhat.com>,
        linuxppc-dev <linuxppc-dev@ozlabs.org>,
        Kexec-ml <kexec@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Pingfan Liu <piliu@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: Re: [RESEND PATCH v5 08/11] ppc64/kexec_file: setup backup region for kdump kernel
In-Reply-To: <159579235754.5790.5203600072984600891.stgit@hbathini>
References: <159579157320.5790.6748078824637688685.stgit@hbathini> <159579235754.5790.5203600072984600891.stgit@hbathini>
Date:   Wed, 29 Jul 2020 00:11:43 +1000
Message-ID: <87y2n36868.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hari Bathini <hbathini@linux.ibm.com> writes:
> diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
> index a5c1442590b2..88408b17a7f6 100644
> --- a/arch/powerpc/kexec/file_load_64.c
> +++ b/arch/powerpc/kexec/file_load_64.c
> @@ -697,6 +699,69 @@ static int update_usable_mem_fdt(void *fdt, struct crash_mem *usable_mem)
>  	return ret;
>  }
>  
> +/**
> + * load_backup_segment - Locate a memory hole to place the backup region.
> + * @image:               Kexec image.
> + * @kbuf:                Buffer contents and memory parameters.
> + *
> + * Returns 0 on success, negative errno on error.
> + */
> +static int load_backup_segment(struct kimage *image, struct kexec_buf *kbuf)
> +{
> +	void *buf;
> +	int ret;
> +
> +	/* Setup a segment for backup region */
> +	buf = vzalloc(BACKUP_SRC_SIZE);

This worried me initially, because we can't copy from physically
discontiguous pages in real mode.

But as you explained this buffer is not used for copying.

I think if you move the large comment below up here, it would be
clearer.


> diff --git a/arch/powerpc/purgatory/trampoline_64.S b/arch/powerpc/purgatory/trampoline_64.S
> index 464af8e8a4cb..d4b52961f592 100644
> --- a/arch/powerpc/purgatory/trampoline_64.S
> +++ b/arch/powerpc/purgatory/trampoline_64.S
> @@ -43,14 +44,38 @@ master:
>  	mr	%r17,%r3	/* save cpu id to r17 */
>  	mr	%r15,%r4	/* save physical address in reg15 */
>  
> +	bl	0f		/* Work out where we're running */
> +0:	mflr	%r18

I know you just moved it, but this should use:

	bcl	20, 31, $+4
	mflr	%r18

Which is a special form of branch and link that doesn't unbalance the
link stack in the chip.

> +	/*
> +	 * Copy BACKUP_SRC_SIZE bytes from BACKUP_SRC_START to
> +	 * backup_start 8 bytes at a time.
> +	 *
> +	 * Use r3 = dest, r4 = src, r5 = size, r6 = count
> +	 */
> +	ld	%r3,(backup_start - 0b)(%r18)
> +	cmpdi	%cr0,%r3,0

I prefer spaces or tabs between arguments, eg:

	cmpdi	%cr0, %r3, 0

> +	beq	80f		/* skip if there is no backup region */

Local labels will make this clearer I think. eg:

	beq	.Lskip_copy

> +	lis	%r5,BACKUP_SRC_SIZE@h
> +	ori	%r5,%r5,BACKUP_SRC_SIZE@l
> +	cmpdi	%cr0,%r5,0
> +	beq	80f		/* skip if copy size is zero */
> +	lis	%r4,BACKUP_SRC_START@h
> +	ori	%r4,%r4,BACKUP_SRC_START@l
> +	li	%r6,0
> +70:

.Lcopy_loop:

> +	ldx	%r0,%r6,%r4
> +	stdx	%r0,%r6,%r3
> +	addi	%r6,%r6,8
> +	cmpld	%cr0,%r6,%r5
> +	blt	70b

	blt	.Lcopy_loop

> +

.Lskip_copy:

> +80:
>  	or	%r3,%r3,%r3	/* ok now to high priority, lets boot */
>  	lis	%r6,0x1
>  	mtctr	%r6		/* delay a bit for slaves to catch up */
>  	bdnz	.		/* before we overwrite 0-100 again */


cheers
