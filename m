Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672A2C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 16:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43B7C2064C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 16:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594139790;
	bh=RmLIslKrDtxB6F53triYZpBcRENGA9EGTlNzCsVjwi4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=SLeM3DanVN/ApRxe1qqpyNv3GaMdzCoYhhMMwxp7CGCd7DkQ/EZQ7Z9HuWaUpYp0S
	 RYkua3EiBy/pgTWSWLzsy4VhFL+laX5PIwm4t9VIHoN8yFIasvTkqsV9YsP444AoYy
	 /4SIjg6ZTDYklofq5Xj7p4hEhxz7X5ESjWl9fRk0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbgGGQg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 12:36:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:41652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbgGGQg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 12:36:28 -0400
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A939B2082F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 16:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594139787;
        bh=RmLIslKrDtxB6F53triYZpBcRENGA9EGTlNzCsVjwi4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EH7/dWwsAAWGZGyRMmMVipyNihGhxO/DXLd2ANh9jGS4oOA78A8b2Iw9dm0pEDH6O
         guuUttkpSUD+TJLAoG43Xq+uZ4SadmGdRJLDEc+V/9Hm1GMUz9EjZY6y2GWqJuR2Cp
         qR3Kn79BvnYtZd5A8ZIEKN9XB/O8ou0HfaQqE1E8=
Received: by mail-wm1-f53.google.com with SMTP id l17so43992990wmj.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 09:36:27 -0700 (PDT)
X-Gm-Message-State: AOAM530SvcuV/ClmMaRqkouP/yTOCrygzNkfg5WmRmdBS0DkQCdOzSte
        X+nz7uvp6P39K8zKQSD5GfUjFrAK9GSsEXUr8ZnmIw==
X-Google-Smtp-Source: ABdhPJxzCYljEmsDTswMYA+4TmFU6jf7ILq+qh6U+Xg6w8bhrCGvZ0DT0rMAXl9KS6OEgNTrGBBCC0jH+zF2tPIfGx4=
X-Received: by 2002:a7b:c09a:: with SMTP id r26mr4989979wmh.176.1594139786159;
 Tue, 07 Jul 2020 09:36:26 -0700 (PDT)
MIME-Version: 1.0
References: <1594088183-7187-1-git-send-email-cathy.zhang@intel.com> <1594088183-7187-2-git-send-email-cathy.zhang@intel.com>
In-Reply-To: <1594088183-7187-2-git-send-email-cathy.zhang@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 7 Jul 2020 09:36:15 -0700
X-Gmail-Original-Message-ID: <CALCETrWudiF8G8r57r5i4JefuP5biG1kHg==0O8YXb-bYS-0BA@mail.gmail.com>
Message-ID: <CALCETrWudiF8G8r57r5i4JefuP5biG1kHg==0O8YXb-bYS-0BA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] x86/cpufeatures: Add enumeration for SERIALIZE instruction
To:     Cathy Zhang <cathy.zhang@intel.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Kyung Min Park <kyung.min.park@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 6, 2020 at 7:21 PM Cathy Zhang <cathy.zhang@intel.com> wrote:
>
> This instruction gives software a way to force the processor to complete
> all modifications to flags, registers and memory from previous instructions
> and drain all buffered writes to memory before the next instruction is
> fetched and executed.
>
> The same effect can be obtained using the cpuid instruction. However,
> cpuid causes modification on the eax, ebx, ecx, and ecx regiters; it
> also causes a VM exit.
>
> A processor supports SERIALIZE instruction if CPUID.0x0x.0x0:EDX[14] is
> present. The CPU feature flag is shown as "serialize" in /proc/cpuinfo.
>
> Detailed information on the instructions and CPUID feature flag SERIALIZE
> can be found in the latest Intel Architecture Instruction Set Extensions
> and Future Features Programming Reference and Intel 64 and IA-32
> Architectures Software Developer's Manual.

Can you also wire this up so sync_core() uses it?

Thanks,
Andy
