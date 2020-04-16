Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA44BC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 765E021924
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587052911;
	bh=GRMBxBlJT/dO0QD5MNbcBQeYW30XVAvGkRBTy11zOTs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Av2xktXW4c4gNOq7Eynsact2IRG1WrrCb2jhqHirTEOK3M0MNlDe7ZNtBBBi8Smz1
	 QofhnikSORJby+ooGThSGWjvMLSqZ8xSakgVSpKVV4R+rzmQeY8tz6hI7xiXBIPfOE
	 G84KleDa6Vr2QhoyKetbcEwfoGYx5z8SoFprEWf8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410656AbgDPQBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:01:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:37346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2636447AbgDPQBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 12:01:40 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC9E5214AF;
        Thu, 16 Apr 2020 16:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587052899;
        bh=GRMBxBlJT/dO0QD5MNbcBQeYW30XVAvGkRBTy11zOTs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Wd6gpejeL4CD8GUdf4YOdFd2JV29pdtKPe9SZek/dgSskzy/RLN+hLerzcN4Gv5CO
         oD4TsUO4ngAUFXYY0s4mZm09YALzZoiWP86TLZVs96jY+ONPtcqWPp7nC+Jilcwv5H
         WW+Z9SXGgiRB1gO+Qz7+Do1Xdahl8FxCmlT2Ytl4=
Received: by mail-io1-f50.google.com with SMTP id n10so21551870iom.3;
        Thu, 16 Apr 2020 09:01:39 -0700 (PDT)
X-Gm-Message-State: AGi0PubTzof1dhfBsJ00kt0jXm4DVcWJEgrUZTenTlmsKJAyA0tjYzvN
        7qQg2Nl9R+KbjtcTvx/5KtOJixFlRfz3XetsbLw=
X-Google-Smtp-Source: APiQypI5m+VVAEjBcHIER11Qc+zAjLHrN9hHgnqG6Tf5SDyVH6demyr0ouoviqm1aacN4anUNnkTfBIHcMcqYhD8J2o=
X-Received: by 2002:a02:3341:: with SMTP id k1mr22768776jak.74.1587052899328;
 Thu, 16 Apr 2020 09:01:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200415221520.2692512-1-nivedita@alum.mit.edu> <20200416151227.3360778-1-nivedita@alum.mit.edu>
In-Reply-To: <20200416151227.3360778-1-nivedita@alum.mit.edu>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 16 Apr 2020 18:01:27 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFD7JYRLrn0D-pGG2thGdjsvQ1QDdRpXKdG9DqfW7vc4g@mail.gmail.com>
Message-ID: <CAMj1kXFD7JYRLrn0D-pGG2thGdjsvQ1QDdRpXKdG9DqfW7vc4g@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] efi: Remove __efistub_global annotation
To:     Arvind Sankar <nivedita@alum.mit.edu>,
        Atish Patra <atish.patra@wdc.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Apr 2020 at 17:12, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> This patch series removes the need for annotating global data in the EFI
> stub with __efistub_global for ARM32 and X86.
>
> This is done by renaming the .data and .bss sections in the object files
> linked into the EFI stub to .data.efistub and .bss.efistub respectively,
> and including those sections into the compressed kernel's .data section
> using its linker script.
>
> Changes from v1:
> - drop patch 2 and squash patches 3 and 5 for x86
> - fix R_X86 -> R_386
> - only check native relocation size (32-bit for R386 and 64-bit for
>   RX86_64)
>

Thanks Arvind. I have queued these up now.

Atish, I have queued up the first 2 patches of your RISC-V EFI stbu
series as well. Please base your next version on

https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/log/?h=next

Thanks,
Ard.
