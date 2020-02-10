Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743EEC35254
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449972080C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LKQ+bF5Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbgBJR7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 12:59:35 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:37035 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbgBJR7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 12:59:34 -0500
Received: by mail-pj1-f68.google.com with SMTP id m13so71634pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 09:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=1YAISQFqnpA305vPq84f3VxvtWWF0p2xaxU8lpBMW/M=;
        b=LKQ+bF5ZQDqEApmHseTtuNoyhWSosj7Am0frnkoZOUJq+UxW1hL1A6AeQKv+W2jXMH
         0sGcnymJQDqhTJwmbXrjDtLPo7oMgx6v5OfewS0GsDvnrwBiIzTnzzEnr0gDt6oQkg06
         MRuWrEqGuWye1cLT5MnkKAD4cNi8amzI3pGmYk9wTBEvcBK3Q7eF/XlM0eY7zGOw6/23
         KfJesdlZVtA1PrcNYt2g8gZFBVPkeU/6dng2W2VzCxmio5uWr71v0fgHmBMdHc+9V6e7
         EaYHajMEQYggi7hkr7GRobvEVCVQ4ELeW3CIGQ+Zu+mJEf+Aii9oQe/i71JsgItv4apN
         J1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=1YAISQFqnpA305vPq84f3VxvtWWF0p2xaxU8lpBMW/M=;
        b=ctHV5yMO+m7kHL7SOwq+2luy+YRW/bBAdbC50Ax2w/H21elY2pzq5prduMJf7Wg1gB
         XZwsNqx1k++nOAkrS3x0LAq+BquPjkB6+IokuizJ3FthHztEaN/kzJEstaeImPWLKFjY
         GOEgJiLJE+f6YUqus0CipFoyJAZCBkGMg2MRYfDJcC58GZLEcAyyMwGt9gew0JvDDNJf
         XTvI3hPyPmMxtsK56ckosZ1qNcl3njRtSsCtGwxzg40yk/vA8URu2ddThke95sxWItC/
         VLNMAVplTFfVqYNGPAsd3f8RL9tlFWBX4fhRhcUqgYMT0r/qmHWpU31/kwYiZH7VAZc0
         y99Q==
X-Gm-Message-State: APjAAAW3ro7/gGJFZLL2WZE9rQJZn3kBKYro4wKUHTfUYcbmDKzc3w5B
        D4ks0OvhhMzIrYQ9/PysCJ/Knw==
X-Google-Smtp-Source: APXvYqxD4zsNJxOw0UXfC6ay8JKxpVMuJ37CBz5drM/uOOz8GyBg7ACfSqGKYBKraMUzXUX39/16sw==
X-Received: by 2002:a17:90a:c706:: with SMTP id o6mr269038pjt.82.1581357572300;
        Mon, 10 Feb 2020 09:59:32 -0800 (PST)
Received: from localhost (pat_11.qualcomm.com. [192.35.156.11])
        by smtp.gmail.com with ESMTPSA id e11sm744483pgj.70.2020.02.10.09.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 09:59:31 -0800 (PST)
Date:   Mon, 10 Feb 2020 09:59:31 -0800 (PST)
X-Google-Original-Date: Mon, 10 Feb 2020 07:02:08 PST (-0800)
Subject:     Re: [PATCH] riscv: set pmp configuration if kernel is running in M-mode
In-Reply-To: <CAHCEeh+4a0O7tpp4dRXKudc6bmdJct=-H0SrPt=HbOs00T3-Hg@mail.gmail.com>
CC:     greentime@kernel.org, linux-riscv@lists.infradead.org,
        green.hu@gmail.com, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     greentime.hu@sifive.com
Message-ID: <mhng-bb195861-6e17-41e3-ab0f-ec8f4c5eca69@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jan 2020 18:38:43 PST (-0800), greentime.hu@sifive.com wrote:
> On Thu, Jan 30, 2020 at 3:23 AM Palmer Dabbelt <palmerdabbelt@google.com> wrote:
>>
>> On Thu, 09 Jan 2020 03:17:40 GMT (+0000), greentime.hu@sifive.com wrote:
>> > When the kernel is running in S-mode, the expectation is that the
>> > bootloader or SBI layer will configure the PMP to allow the kernel to
>> > access physical memory.  But, when the kernel is running in M-mode and is
>> > started with the ELF "loader", there's probably no bootloader or SBI layer
>> > involved to configure the PMP.  Thus, we need to configure the PMP
>> > ourselves to enable the kernel to access all regions.
>> >
>> > Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
>> > ---
>> >  arch/riscv/include/asm/csr.h | 12 ++++++++++++
>> >  arch/riscv/kernel/head.S     |  6 ++++++
>> >  2 files changed, 18 insertions(+)
>> >
>> > diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
>> > index 0a62d2d68455..0f25e6c4e45c 100644
>> > --- a/arch/riscv/include/asm/csr.h
>> > +++ b/arch/riscv/include/asm/csr.h
>> > @@ -72,6 +72,16 @@
>> >  #define EXC_LOAD_PAGE_FAULT  13
>> >  #define EXC_STORE_PAGE_FAULT 15
>> >
>> > +/* PMP configuration */
>> > +#define PMP_R                        0x01
>> > +#define PMP_W                        0x02
>> > +#define PMP_X                        0x04
>> > +#define PMP_A                        0x18
>> > +#define PMP_A_TOR            0x08
>> > +#define PMP_A_NA4            0x10
>> > +#define PMP_A_NAPOT          0x18
>> > +#define PMP_L                        0x80
>> > +
>> >  /* symbolic CSR names: */
>> >  #define CSR_CYCLE            0xc00
>> >  #define CSR_TIME             0xc01
>> > @@ -100,6 +110,8 @@
>> >  #define CSR_MCAUSE           0x342
>> >  #define CSR_MTVAL            0x343
>> >  #define CSR_MIP                      0x344
>> > +#define CSR_PMPCFG0          0x3a0
>> > +#define CSR_PMPADDR0         0x3b0
>> >  #define CSR_MHARTID          0xf14
>> >
>> >  #ifdef CONFIG_RISCV_M_MODE
>> > diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
>> > index 5c8b24bf4e4e..f8f996916c5b 100644
>> > --- a/arch/riscv/kernel/head.S
>> > +++ b/arch/riscv/kernel/head.S
>> > @@ -60,6 +60,12 @@ _start_kernel:
>> >       /* Reset all registers except ra, a0, a1 */
>> >       call reset_regs
>> >
>> > +     /* Setup a PMP to permit access to all of memory. */
>> > +     li a0, -1
>> > +     csrw CSR_PMPADDR0, a0
>> > +     li a0, (PMP_A_NAPOT | PMP_R | PMP_W | PMP_X)
>> > +     csrw CSR_PMPCFG0, a0
>>
>> These should be guarded by some sort of #ifdef CONFIG_M_MODE, as they're not
>> part of S mode.
>
> Hi Palmer,
>
> This code segment is guarded by CONFIG_RISCV_M_MODE
>
> #ifdef CONFIG_RISCV_M_MODE
>         /* flush the instruction cache */
>         fence.i
>
>         /* Reset all registers except ra, a0, a1 */
>         call reset_regs
>
>         /* Setup a PMP to permit access to all of memory. */
>         li a0, -1
>         csrw CSR_PMPADDR0, a0
>         li a0, (PMP_A_NAPOT | PMP_R | PMP_W | PMP_X)
>         csrw CSR_PMPCFG0, a0
>
>         /*
>          * The hartid in a0 is expected later on, and we have no firmware
>          * to hand it to us.
>          */
>         csrr a0, CSR_MHARTID
> #endif /* CONFIG_RISCV_M_MODE */

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

Whoops.  It's queued up for the RCs.
