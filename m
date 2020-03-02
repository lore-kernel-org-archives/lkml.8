Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA68C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 16:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52E05217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 16:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbgCBQUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 11:20:35 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42271 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbgCBQUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 11:20:35 -0500
Received: from [5.158.153.55] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j8nnz-0004iZ-E0; Mon, 02 Mar 2020 17:20:31 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 20CF41040A1; Mon,  2 Mar 2020 17:20:26 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jan Kiszka <jan.kiszka@siemens.com>, x86 <x86@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: x2apic_wrmsr_fence vs. Intel manual
In-Reply-To: <783add60-f6c7-c8c6-b369-42e5ebfbf8c9@siemens.com>
References: <783add60-f6c7-c8c6-b369-42e5ebfbf8c9@siemens.com>
Date:   Mon, 02 Mar 2020 17:20:26 +0100
Message-ID: <87lfoienjp.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kiszka <jan.kiszka@siemens.com> writes:
> as I generated a nice bug around fence vs. x2apic icr writes, I studied 
> the kernel code and the Intel manual in this regard more closely. But 
> there is a discrepancy:
>
> arch/x86/include/asm/apic.h:
>
> /*
>  * Make previous memory operations globally visible before
>  * sending the IPI through x2apic wrmsr. We need a serializing instruction or
>  * mfence for this.
>  */
> static inline void x2apic_wrmsr_fence(void)
> {
>         asm volatile("mfence" : : : "memory");
> }
>
> Intel SDM, 10.12.3 MSR Access in x2APIC Mode:
>
> "A WRMSR to an APIC register may complete before all preceding stores 
> are globally visible; software can prevent this by inserting a 
> serializing instruction or the sequence MFENCE;LFENCE before the WRMSR."
>
> The former dates back to ce4e240c279a, but that commit does not mention 
> why lfence is not needed. Did the manual read differently back then? Or 
> why are we safe? To my reading of lfence, it also has a certain 
> instruction serializing effect that mfence does not have.

The 2011 SDM says:

  A WRMSR to an APIC register may complete before all preceding stores
  are globally visible; software can prevent this by inserting a
  serializing instruction, an SFENCE, or an MFENCE before the WRMSR.

Sigh....
