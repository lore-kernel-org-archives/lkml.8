Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D342DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 05:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1EB8206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 05:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ykr7aZeX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbgFBFZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 01:25:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32602 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728294AbgFBFZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 01:25:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591075504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VehAfr1QcK1Dwcz7+ds+E0e6uhlAX/0K+5UtuSIJbmY=;
        b=Ykr7aZeXAj71puhTDzDkpDwNHgmlhc1TPiJ5hjsQ9I5x/mycROf37HS/8XmSJ6HWcXkvvq
        asdgoqZAQmTqGZmA6seJQXCzkZyq7I26HmJqwMtkJsapXHPZKT3QE5NYky/WojEJYt+DBb
        TlLVx/FJaQyRt1g6UEHD6vwQt8CxyvU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-Y4XWxJivMeqtDIlHcQpGMg-1; Tue, 02 Jun 2020 01:24:59 -0400
X-MC-Unique: Y4XWxJivMeqtDIlHcQpGMg-1
Received: by mail-qt1-f200.google.com with SMTP id e44so12750773qta.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 22:24:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VehAfr1QcK1Dwcz7+ds+E0e6uhlAX/0K+5UtuSIJbmY=;
        b=uJ9Tlv3+FtCD+yl7fQU/9n7DwdjceDAM9sCIzqQjmqg24UuOqObgDPrpjn5Vt+38ka
         gKKkyCoF7kUvp/USHWrysQDjpuOac4II5i/SNC60MgweSxXnDqsY64qkwurPPUItEhdt
         9gRf4ZwAQpwpHTU+z9g03x6QohG9zLcmjbBhynqmHBYGs1ZY6Mzpy49oP1zd8CP9uNZ7
         wnZ95+JBDP+gY5Mf7dmTieWv2gTPOl88rj+ewNmYFGzuhZL11uJT12ppAqT1nZiSLSrb
         yE7JY6KbAOaO4RUaxSbbr9ygTZLeobj+Mgcrax2E2X9mZ8796t83B70Sm3VfJpiwug3d
         U17A==
X-Gm-Message-State: AOAM532ieBLIteV/R3oqfJtEkrq5uuTx+kWFY50ikNVqPzM1UOTPaVHY
        P9QPPYjvhmGXxgLu4ODDlTC6g6SGfaVryeoCwjd3Hv3bKnaW6pZxK2M1EdUfe/xU7TUHW4VCKam
        L7pSIiv81ThA3k6H+i467s0fdDFY1X40lKSrATd1f
X-Received: by 2002:a37:b9c7:: with SMTP id j190mr18446738qkf.210.1591075498896;
        Mon, 01 Jun 2020 22:24:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqSml3yIRLnTsy9Th/UnRcgf1YOKMax0M+KxC4ZQtHYQlBJISkBakBOY31tAwc7YBCMcTTQOYw3l/yGOmFjpg=
X-Received: by 2002:a37:b9c7:: with SMTP id j190mr18446721qkf.210.1591075498589;
 Mon, 01 Jun 2020 22:24:58 -0700 (PDT)
MIME-Version: 1.0
References: <1589395957-24628-1-git-send-email-bhsharma@redhat.com>
In-Reply-To: <1589395957-24628-1-git-send-email-bhsharma@redhat.com>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Date:   Tue, 2 Jun 2020 10:54:46 +0530
Message-ID: <CACi5LpMKSNz=_OQWmEQ2kaswbjAONjn2pXQiu=jCA=wMt3wGCQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] Append new variables to vmcoreinfo (TCR_EL1.T1SZ
 for arm64 and MAX_PHYSMEM_BITS for all archs)
To:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        x86@kernel.org
Cc:     Bhupesh SHARMA <bhupesh.linux@gmail.com>,
        Boris Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Steve Capper <steve.capper@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Dave Anderson <anderson@redhat.com>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
        John Donnelly <john.p.donnelly@oracle.com>,
        scott.branden@broadcom.com, Amit Kachhap <amit.kachhap@arm.com>,
        linuxppc-dev@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        kexec mailing list <kexec@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, May 14, 2020 at 12:22 AM Bhupesh Sharma <bhsharma@redhat.com> wrote:
>
> Apologies for the delayed update. Its been quite some time since I
> posted the last version (v5), but I have been really caught up in some
> other critical issues.
>
> Changes since v5:
> ----------------
> - v5 can be viewed here:
>   http://lists.infradead.org/pipermail/kexec/2019-November/024055.html
> - Addressed review comments from James Morse and Boris.
> - Added Tested-by received from John on v5 patchset.
> - Rebased against arm64 (for-next/ptr-auth) branch which has Amit's
>   patchset for ARMv8.3-A Pointer Authentication feature vmcoreinfo
>   applied.
>
> Changes since v4:
> ----------------
> - v4 can be seen here:
>   http://lists.infradead.org/pipermail/kexec/2019-November/023961.html
> - Addressed comments from Dave and added patches for documenting
>   new variables appended to vmcoreinfo documentation.
> - Added testing report shared by Akashi for PATCH 2/5.
>
> Changes since v3:
> ----------------
> - v3 can be seen here:
>   http://lists.infradead.org/pipermail/kexec/2019-March/022590.html
> - Addressed comments from James and exported TCR_EL1.T1SZ in vmcoreinfo
>   instead of PTRS_PER_PGD.
> - Added a new patch (via [PATCH 3/3]), which fixes a simple typo in
>   'Documentation/arm64/memory.rst'
>
> Changes since v2:
> ----------------
> - v2 can be seen here:
>   http://lists.infradead.org/pipermail/kexec/2019-March/022531.html
> - Protected 'MAX_PHYSMEM_BITS' vmcoreinfo variable under CONFIG_SPARSEMEM
>   ifdef sections, as suggested by Kazu.
> - Updated vmcoreinfo documentation to add description about
>   'MAX_PHYSMEM_BITS' variable (via [PATCH 3/3]).
>
> Changes since v1:
> ----------------
> - v1 was sent out as a single patch which can be seen here:
>   http://lists.infradead.org/pipermail/kexec/2019-February/022411.html
>
> - v2 breaks the single patch into two independent patches:
>   [PATCH 1/2] appends 'PTRS_PER_PGD' to vmcoreinfo for arm64 arch, whereas
>   [PATCH 2/2] appends 'MAX_PHYSMEM_BITS' to vmcoreinfo in core kernel code (all archs)
>
> This patchset primarily fixes the regression reported in user-space
> utilities like 'makedumpfile' and 'crash-utility' on arm64 architecture
> with the availability of 52-bit address space feature in underlying
> kernel. These regressions have been reported both on CPUs which don't
> support ARMv8.2 extensions (i.e. LVA, LPA) and are running newer kernels
> and also on prototype platforms (like ARMv8 FVP simulator model) which
> support ARMv8.2 extensions and are running newer kernels.
>
> The reason for these regressions is that right now user-space tools
> have no direct access to these values (since these are not exported
> from the kernel) and hence need to rely on a best-guess method of
> determining value of 'vabits_actual' and 'MAX_PHYSMEM_BITS' supported
> by underlying kernel.
>
> Exporting these values via vmcoreinfo will help user-land in such cases.
> In addition, as per suggestion from makedumpfile maintainer (Kazu),
> it makes more sense to append 'MAX_PHYSMEM_BITS' to
> vmcoreinfo in the core code itself rather than in arm64 arch-specific
> code, so that the user-space code for other archs can also benefit from
> this addition to the vmcoreinfo and use it as a standard way of
> determining 'SECTIONS_SHIFT' value in user-land.
>
> Cc: Boris Petkov <bp@alien8.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: James Morse <james.morse@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Steve Capper <steve.capper@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Dave Anderson <anderson@redhat.com>
> Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
> Cc: John Donnelly <john.p.donnelly@oracle.com>
> Cc: scott.branden@broadcom.com
> Cc: Amit Kachhap <amit.kachhap@arm.com>
> Cc: x86@kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-doc@vger.kernel.org
> Cc: kexec@lists.infradead.org
>
> Bhupesh Sharma (2):
>   crash_core, vmcoreinfo: Append 'MAX_PHYSMEM_BITS' to vmcoreinfo
>   arm64/crash_core: Export TCR_EL1.T1SZ in vmcoreinfo
>
>  Documentation/admin-guide/kdump/vmcoreinfo.rst | 16 ++++++++++++++++
>  arch/arm64/include/asm/pgtable-hwdef.h         |  1 +
>  arch/arm64/kernel/crash_core.c                 | 10 ++++++++++
>  kernel/crash_core.c                            |  1 +
>  4 files changed, 28 insertions(+)

Ping. @James Morse , Others

Please share if you have some comments regarding this patchset.

Thanks,
Bhupesh

