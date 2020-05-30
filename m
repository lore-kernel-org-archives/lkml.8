Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E070C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 02:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21D2620707
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 02:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jc2Qe6+f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbgE3CIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 22:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728817AbgE3CIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 22:08:49 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9342CC03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 19:08:48 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id q8so1376331iow.7
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 19:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dN58wg3nEA9rldEIDlifhFJsdB2tbWLhvBZmgq9Fpto=;
        b=Jc2Qe6+f9rFpviKD4nVc6kV2khBM7inMHFWAV3Qm7elegCyxfFVGRcHxq/J5owBV9A
         egyoxYdPg1H2AIlEMxnpjmMPHeHiQKkgUbIqwOPMiYRs3tSXA2Sjzusa1G0yAVs4dqZZ
         CO7TCR7OWs4/RiupwbIJ2b7RmXY/B+M+KWJfbBjAMug9uObCEovwWRaXncVxCJJxVPYn
         JLXBWYvXIgwL9CNTPYf5KgIRkL5kyH3XFB09fgsGsHbEeWsjRbQTfAekrHqR/3XkY35X
         yfjk+NKpW1qLplGRy1FMilzF5bB1wCIN4VFojLsza5qGdLcAhnSAK7niB48Tm3wsklca
         fF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dN58wg3nEA9rldEIDlifhFJsdB2tbWLhvBZmgq9Fpto=;
        b=LJnjOjEbfULM92lnPwVpGKg95xP4Uu/65rff1fMkoftw2X0stjZi4hy+SsPc5Oyd5j
         MR/jVKJlxhObNUpbx99zx5pHcCn4vVvR8VSG6hpYFwv9KpGCHot3cE7PAWf7aCjSxRi0
         B40X0j9cqruRon+XgP0Cza1D6J3zlgiPoyCa8k74Iv9w4QvIyfOjlfDh0i0038cFV73T
         CT35jOZ5l+zV0tVyQg8RR9YgVMKT1LlSEgzKX6TtgR2tiTSFDNSJKPVETxlcc0Bs38EQ
         bS+cr0diKKhPZGyU8IFnekWfdhroSgtSn54Eeh62JHKihxUXD/njICUxoCHGzPyiut9p
         VeLA==
X-Gm-Message-State: AOAM533y7VbRDuDTnnDll1/L729l98TlJSUrZFQ1RWC9+9HXE5dgp8GJ
        JXTuZr4i2NYsYSCVB1RjbfaQTnt5CKObKaj7sz/FiQ==
X-Google-Smtp-Source: ABdhPJwIZ0rq8DVrs10SZZhuOkSscD7hplgkOhNO5MiFM9hNmmv+Q9+faNxj8iyeSPJZafjcQlb3UDI9l1joNcRFQKk=
X-Received: by 2002:a5d:8914:: with SMTP id b20mr9520538ion.34.1590804527793;
 Fri, 29 May 2020 19:08:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588711355.git.ashish.kalra@amd.com> <02cde03d5754c84cfa0dc485f62d85507a2a9dd5.1588711355.git.ashish.kalra@amd.com>
In-Reply-To: <02cde03d5754c84cfa0dc485f62d85507a2a9dd5.1588711355.git.ashish.kalra@amd.com>
From:   Steve Rutherford <srutherford@google.com>
Date:   Fri, 29 May 2020 19:08:11 -0700
Message-ID: <CABayD+dTB-XbR6=FVYdn3FuCzrn-M_Y-pfLxky3WhCkKFmu+pw@mail.gmail.com>
Subject: Re: [PATCH v8 16/18] KVM: x86: Mark _bss_decrypted section variables
 as decrypted in page encryption bitmap.
To:     Ashish Kalra <Ashish.Kalra@amd.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
        Borislav Petkov <bp@suse.de>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        X86 ML <x86@kernel.org>, KVM list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Rientjes <rientjes@google.com>,
        Venu Busireddy <venu.busireddy@oracle.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 2:20 PM Ashish Kalra <Ashish.Kalra@amd.com> wrote:
>
> From: Ashish Kalra <ashish.kalra@amd.com>
>
> Ensure that _bss_decrypted section variables such as hv_clock_boot and
> wall_clock are marked as decrypted in the page encryption bitmap if
> sev liv migration is supported.
>
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
>  arch/x86/kernel/kvmclock.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> index 34b18f6eeb2c..65777bf1218d 100644
> --- a/arch/x86/kernel/kvmclock.c
> +++ b/arch/x86/kernel/kvmclock.c
> @@ -334,6 +334,18 @@ void __init kvmclock_init(void)
>         pr_info("kvm-clock: Using msrs %x and %x",
>                 msr_kvm_system_time, msr_kvm_wall_clock);
>
> +       if (sev_live_migration_enabled()) {
> +               unsigned long nr_pages;
> +               /*
> +                * sizeof(hv_clock_boot) is already PAGE_SIZE aligned
> +                */
> +               early_set_mem_enc_dec_hypercall((unsigned long)hv_clock_boot,
> +                                               1, 0);
> +               nr_pages = DIV_ROUND_UP(sizeof(wall_clock), PAGE_SIZE);
> +               early_set_mem_enc_dec_hypercall((unsigned long)&wall_clock,
> +                                               nr_pages, 0);
> +       }
> +
>         this_cpu_write(hv_clock_per_cpu, &hv_clock_boot[0]);
>         kvm_register_clock("primary cpu clock");
>         pvclock_set_pvti_cpu0_va(hv_clock_boot);
> --
> 2.17.1
>

Reviewed-by: Steve Rutherford <srutherford@google.com>
