Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC712C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 17:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89B6020717
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 17:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="cpJF38mn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgGRR5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 13:57:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41965 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbgGRR5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 13:57:50 -0400
Received: from [IPv6:2601:646:8600:3281:9416:e5ae:2b2f:5c90] ([IPv6:2601:646:8600:3281:9416:e5ae:2b2f:5c90])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id 06IHux0t2096145
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Sat, 18 Jul 2020 10:57:00 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 06IHux0t2096145
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2020062301; t=1595095022;
        bh=576S0uLdlTzZkpv4dTasY9ctAja7Muk0zQ6AU9/0rFE=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=cpJF38mnPmSLQcTdI+s4iNg3G/fWoGECqGRTrU3PAZq/urufmkKV6bU7iGNH0yuxt
         rirYPVU2iYjZZKLV7eHpZBHQpGOW/DF4YWMCNW+MFWIf9Z1SlUIY6F+L86crXfGZLG
         8pAXoV1kx3bVY0iWeR5QVZjLo1i1suhjiim0irplVkVz2y0+K/tcBxr4f1a4xSF/Mr
         nxPFd5BeAm28FcI322JB6nGxVUezSIfB1GbkUfbntA4vcWnwqD73+ujBFXCSkxcrMY
         aiMifXb2qu4RqF+S3oikjCDFsnRdWcy5fOI9qsq1zMyOrxZK+4ke5juCuTkCSpusvY
         5CRMXEIBMvpAg==
Date:   Sat, 18 Jul 2020 10:56:48 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20200709103355.11359-1-joro@8bytes.org>
References: <20200709103355.11359-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] x86/idt: Make sure idt_table takes a whole page
To:     Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
CC:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org,
        joro@8bytes.org
From:   hpa@zytor.com
Message-ID: <0CEC6A66-FD50-4B6B-9521-A40E5B9DA10F@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On July 9, 2020 3:33:55 AM PDT, Joerg Roedel <joro@8bytes=2Eorg> wrote:
>From: Joerg Roedel <jroedel@suse=2Ede>
>
>On x86-32 the idt_table with 256 entries needs only 2048 bytes=2E It is
>page-aligned, but the end of the =2Ebss=2E=2Epage_aligned section is not
>guaranteed to be page-aligned=2E
>
>As a result, symbols from other =2Ebss sections may end up on the same
>4k page as the idt_table, and will accidentially get mapped read-only
>during boot, causing unexpected page-faults when the kernel writes to
>them=2E
>
>Avoid this by making the idt_table 4kb in size even on x86-32=2E On
>x86-64 the idt_table is already 4kb large, so nothing changes there=2E
>
>Fixes: 3e77abda65b1c ("x86/idt: Consolidate idt functionality")
>Signed-off-by: Joerg Roedel <jroedel@suse=2Ede>
>---
> arch/x86/kernel/idt=2Ec | 12 ++++++++++--
> 1 file changed, 10 insertions(+), 2 deletions(-)
>
>diff --git a/arch/x86/kernel/idt=2Ec b/arch/x86/kernel/idt=2Ec
>index 0db21206f2f3=2E=2E83e24f837127 100644
>--- a/arch/x86/kernel/idt=2Ec
>+++ b/arch/x86/kernel/idt=2Ec
>@@ -157,8 +157,13 @@ static const __initconst struct idt_data
>apic_idts[] =3D {
> #endif
> };
>=20
>-/* Must be page-aligned because the real IDT is used in the cpu entry
>area */
>-static gate_desc idt_table[IDT_ENTRIES] __page_aligned_bss;
>+/*
>+ * Must be page-aligned because the real IDT is used in the cpu entry
>area=2E
>+ * Allocate more entries than needed so that idt_table takes a whole
>page, so it
>+ * is safe to map the idt_table read-only and into the user-space
>page-table=2E
>+ */
>+#define IDT_ENTRIES_ALLOCATED	(PAGE_SIZE / sizeof(gate_desc))
>+static gate_desc idt_table[IDT_ENTRIES_ALLOCATED] __page_aligned_bss;
>=20
> struct desc_ptr idt_descr __ro_after_init =3D {
> 	=2Esize		=3D IDT_TABLE_SIZE - 1,
>@@ -335,6 +340,9 @@ void __init idt_setup_apic_and_irq_gates(void)
> 	idt_map_in_cea();
> 	load_idt(&idt_descr);
>=20
>+	BUILD_BUG_ON(IDT_ENTRIES_ALLOCATED < IDT_ENTRIES);
>+	BUILD_BUG_ON(sizeof(idt_table) !=3D PAGE_SIZE);
>+
> 	/* Make the IDT table read only */
> 	set_memory_ro((unsigned long)&idt_table, 1);
>=20

NAK=2E=2E=2E this isn't the right way to fix this and just really kicks th=
e can down the road=2E The reason is that you aren't fixing the module that=
 actually has a problem=2E

The Right Way[TM] is to figure out which module(s) lack the proper alignme=
nt for this section=2E A script using objdump -h or readelf -SW running ove=
r the =2Eo files looking for alignment less than 2**12 should spot the modu=
les that are missing the proper =2Ebalign directives=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
