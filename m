Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419FCC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 19:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A426B22B45
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 19:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yDsb61D0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VVXBx0Zb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgHCT1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 15:27:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39108 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgHCT1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 15:27:39 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596482857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bIfZVkgl4VVuKMo3PbC45J6WLkq9PVh31LMaoA7XSuQ=;
        b=yDsb61D0T2KVHL5+3IJvxPV7KgR6nyu3+1ZZpStsvdyU1xJv1JFNg4N12sumVDtBD4kD6s
        uVBbtCic+cw+eomU0RRogZYEhEkbyHpiwkjRVxv0gHs1s70xgh5iOG6okre1hOerCbzxZq
        GvlYAJFoJsRFO7/mSyW6OqVOusIaceUbAssm6IGADpx3fl9xrRtEfbBnjoHzWjhEUUQTXA
        yCFXTiucU7Il6u6SKWDIaKdzQPwrK0eU0u1/uJaD6KUrkKgxbiqbUb2M4Fb3dQW1fhSIx2
        cNKI4ITsRE0rxj5g6nZclUHtmzHxRsDR+06GMAdDMVo4TsRHZ1WyaB/8FwHxWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596482857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bIfZVkgl4VVuKMo3PbC45J6WLkq9PVh31LMaoA7XSuQ=;
        b=VVXBx0Zb0yel+Ld4MM02i6YTCyXdJqnmQzhhpnM8prGzxCuogsjeeG9TmCKzR+cvd0kY6Y
        vcH55OKZuzzX+vCQ==
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 2/2] s390: convert to GENERIC_VDSO
In-Reply-To: <20200803184428.GA3973@osiris>
References: <20200803055645.79042-1-svens@linux.ibm.com> <20200803055645.79042-3-svens@linux.ibm.com> <87ft93ncaa.fsf@nanos.tec.linutronix.de> <yt9dmu3b3jo3.fsf@linux.ibm.com> <87a6zbn29n.fsf@nanos.tec.linutronix.de> <20200803184428.GA3973@osiris>
Date:   Mon, 03 Aug 2020 21:27:36 +0200
Message-ID: <873653mswn.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Heiko Carstens <hca@linux.ibm.com> writes:

> On Mon, Aug 03, 2020 at 06:05:24PM +0200, Thomas Gleixner wrote:
>> +/**
>> + * vdso_update_begin - Start of a VDSO update section
>> + *
>> + * Allows architecture code to safely update the architecture specific VDSO
>> + * data.
>> + */
>> +void vdso_update_begin(void)
>> +{
>> +	struct vdso_data *vdata = __arch_get_k_vdso_data();
>> +
>> +	raw_spin_lock(&timekeeper_lock);
>> +	vdso_write_begin(vdata);
>> +}
>
> I would assume that this only works if vdso_update_begin() is called
> with irqs disabled, otherwise it could deadlock, no?

Yes.

> Maybe something like:
>
> void vdso_update_begin(unsigned long *flags)
> {
> 	struct vdso_data *vdata = __arch_get_k_vdso_data();
>
> 	raw_spin_lock_irqsave(&timekeeper_lock, *flags);
> 	vdso_write_begin(vdata);

Shudder. Why not returning flags?

> }
>
> void vdso_update_end(unsigned long *flags)

Ditto, why pointer and not value?

> {
> 	struct vdso_data *vdata = __arch_get_k_vdso_data();
>
> 	vdso_write_end(vdata);
> 	__arch_sync_vdso_data(vdata);
> 	raw_spin_unlock_irqrestore(&timekeeper_lock, *flags);
> }
>
> ? Just wondering.

Thought about that briefly, but then hated the flags thing and delegated
it to the caller. Lockdep will yell if that lock is taken with
interrupts enabled :)

But aside of the pointer vs. value thing, I'm fine with doing it in the
functions.

Thanks,

        tglx
