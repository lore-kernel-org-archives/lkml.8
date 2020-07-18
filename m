Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E066BC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 19:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBC8B20724
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 19:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="h5UClVI5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgGRTZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 15:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbgGRTZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 15:25:56 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2E1C0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 12:25:56 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id m9so7035070pfh.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 12:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=IUuO59HPOhmBxerlGrYcaRptbgM0uZnsf5CqGWahS/Q=;
        b=h5UClVI5adBPz6tYw3fU49YKvdDMVv1U6O8LRIExeg98jNqeK15rMydsvli5+Vd97F
         3Z3/EJ2Q4VCNrzwbu0JeKqUOIkekxjeJnivsOIN1q4Z3AV5JWUBmo21ea1L5Fjc5B6Cf
         RtswAIUdXBK3sjHzv8Z6tbDquWeMl2mzFPKOjBSaQxzWfiIM0vaknNBpfKmoVpOGTeL5
         1eKa8oBzCv/qXUkPgEoUtHkuqEMMWAsjz5OJUY3ZYnQFyf6eJYayKg/T7wCF9vyf2Ty5
         +39WxPLIOYV39XepXX5w1+/HbIg7dxtllERI7QK/v36pdsEDFWGjVM88VuppXwYjFhHF
         E8lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=IUuO59HPOhmBxerlGrYcaRptbgM0uZnsf5CqGWahS/Q=;
        b=a4x6DqnB7pn7J8W8UWwvrKBfsSGpPiz7MZLyMIVq7gFGEIJuHedge3bOx5wfBf6nGs
         AiLyrw+yUKckYIvDlgCF/XmKRfbrOLcRZay4uqQdYQgjF0Bul14asBeXIdOPGULLhXGQ
         vzS6QonmR08l6m7F0cBykRojMnWH4FfPhiq9GDSTxI2NL30t/UloJd2dvF2EovEW6dsJ
         MwcoY4aDxPRz2I57M0o01rf5JwIXtpWCG67Vd5nvAgsXzpbtLW59sNameyC6+cjxmsRp
         p0FJAGb2GjI+qT4NNVoq9hAEl78qDOWLaoV3LlI25fo9uOWedvkESU6QFDQEA2NwmQTp
         4JdA==
X-Gm-Message-State: AOAM532ZW99ZB7bBvlB4BesypG2aX7lGXcttEk7L5OfY4coFBECGS7wQ
        +KcMtnslNgU2uzJpIi6tLk6R4FEz3mmiHg==
X-Google-Smtp-Source: ABdhPJyaVNNy8aVMTzNXB9e1dfav1DtEjLaSW0pIevxCJg2Sq7bR9lR6zeVDREsg8sZjq+1Gxswwpg==
X-Received: by 2002:a63:3308:: with SMTP id z8mr13049944pgz.409.1595100355358;
        Sat, 18 Jul 2020 12:25:55 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:e0ba:42b5:b0b0:d1a? ([2601:646:c200:1ef2:e0ba:42b5:b0b0:d1a])
        by smtp.gmail.com with ESMTPSA id m9sm6505426pjs.18.2020.07.18.12.25.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jul 2020 12:25:54 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] x86/idt: Make sure idt_table takes a whole page
Date:   Sat, 18 Jul 2020 12:25:46 -0700
Message-Id: <7FB389D0-77D4-482E-8A21-8662DDB00268@amacapital.net>
References: <0CEC6A66-FD50-4B6B-9521-A40E5B9DA10F@zytor.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org,
        joro@8bytes.org
In-Reply-To: <0CEC6A66-FD50-4B6B-9521-A40E5B9DA10F@zytor.com>
To:     hpa@zytor.com
X-Mailer: iPhone Mail (17F80)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Jul 18, 2020, at 10:57 AM, hpa@zytor.com wrote:
>=20
> =EF=BB=BFOn July 9, 2020 3:33:55 AM PDT, Joerg Roedel <joro@8bytes.org> wr=
ote:
>> From: Joerg Roedel <jroedel@suse.de>
>>=20
>> On x86-32 the idt_table with 256 entries needs only 2048 bytes. It is
>> page-aligned, but the end of the .bss..page_aligned section is not
>> guaranteed to be page-aligned.
>>=20
>> As a result, symbols from other .bss sections may end up on the same
>> 4k page as the idt_table, and will accidentially get mapped read-only
>> during boot, causing unexpected page-faults when the kernel writes to
>> them.
>>=20
>> Avoid this by making the idt_table 4kb in size even on x86-32. On
>> x86-64 the idt_table is already 4kb large, so nothing changes there.
>>=20
>> Fixes: 3e77abda65b1c ("x86/idt: Consolidate idt functionality")
>> Signed-off-by: Joerg Roedel <jroedel@suse.de>
>> ---
>> arch/x86/kernel/idt.c | 12 ++++++++++--
>> 1 file changed, 10 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
>> index 0db21206f2f3..83e24f837127 100644
>> --- a/arch/x86/kernel/idt.c
>> +++ b/arch/x86/kernel/idt.c
>> @@ -157,8 +157,13 @@ static const __initconst struct idt_data
>> apic_idts[] =3D {
>> #endif
>> };
>>=20
>> -/* Must be page-aligned because the real IDT is used in the cpu entry
>> area */
>> -static gate_desc idt_table[IDT_ENTRIES] __page_aligned_bss;
>> +/*
>> + * Must be page-aligned because the real IDT is used in the cpu entry
>> area.
>> + * Allocate more entries than needed so that idt_table takes a whole
>> page, so it
>> + * is safe to map the idt_table read-only and into the user-space
>> page-table.
>> + */
>> +#define IDT_ENTRIES_ALLOCATED    (PAGE_SIZE / sizeof(gate_desc))
>> +static gate_desc idt_table[IDT_ENTRIES_ALLOCATED] __page_aligned_bss;
>>=20
>> struct desc_ptr idt_descr __ro_after_init =3D {
>>    .size        =3D IDT_TABLE_SIZE - 1,
>> @@ -335,6 +340,9 @@ void __init idt_setup_apic_and_irq_gates(void)
>>    idt_map_in_cea();
>>    load_idt(&idt_descr);
>>=20
>> +    BUILD_BUG_ON(IDT_ENTRIES_ALLOCATED < IDT_ENTRIES);
>> +    BUILD_BUG_ON(sizeof(idt_table) !=3D PAGE_SIZE);
>> +
>>    /* Make the IDT table read only */
>>    set_memory_ro((unsigned long)&idt_table, 1);
>>=20
>=20
> NAK... this isn't the right way to fix this and just really kicks the can d=
own the road. The reason is that you aren't fixing the module that actually h=
as a problem.
>=20
> The Right Way[TM] is to figure out which module(s) lack the proper alignme=
nt for this section. A script using objdump -h or readelf -SW running over t=
he .o files looking for alignment less than 2**12 should spot the modules th=
at are missing the proper .balign directives.

I don=E2=80=99t see the problem. If we are going to treat an object as thoug=
h it=E2=80=99s 4096 bytes, making C think it=E2=80=99s 4096 bytes seems enti=
rely reasonable to me.

> --=20

> Sent from my Android device with K-9 Mail. Please excuse my brevity.
