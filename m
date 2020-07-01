Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB1FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E29A207BB
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bq1vY63R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731736AbgGAPmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 11:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728796AbgGAPmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 11:42:50 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1609EC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 08:42:50 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id e64so20574859iof.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 08:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hvie/6BG7o1swX84/UM5fLpFCqjSlLJ7YxyaK37mWfQ=;
        b=Bq1vY63RSI+AVQWedtGjs4OUW2V0itIttXR/Ci9bU+UKtI2BWdpUf4sDz96BGrSGyR
         V/UHlS3aV5SiS1fho1aDTwbVxTp9t9zupgusW9YlBOKSFD1s5HwzZCEnfkzKUo4houln
         Cb9GusQWPx+4H9uO3kYPoNxDNhXwNZRfOArcBfdPzeZujuNW7QbqNM+E5s1nPvPswtiE
         yalC+9Rq/obRStT18qIsbrsHaiLJfmIufmx2kDpKPpibWV64gwBlaNJtvv+rkyGKxq/D
         QNlSZpiBWDiBf25Mu9KGz+xPLsEN9KPmrpg9RuyfbJ9gKv5/mawluJJ9fmVMi2Zym+aS
         HSIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hvie/6BG7o1swX84/UM5fLpFCqjSlLJ7YxyaK37mWfQ=;
        b=emcheIFaZps05u2zdXWq/0lf1dgu9VCjv3Dc5bebFRQEuzlumNREiChDIpnRGf9cXq
         2YkY109LTHpn4eS0o7n7/K/PFWZaRcba62/e1io6AgQO10DqspqXCrCxE//lZfCGL+6Y
         YoukYT/Z2IwcWiXmo4UH7ycyEPD+P5p8g165ggFf48QeGxinHUO8rYGnpRKhvNfeZG7e
         UQ2c2pi535ODnR9Z1UoVuQzRg3CmbfgbU5luhYEwyYfm+TFlmGiiWCQ1fdTSQydYjuAH
         Zgw6D5tCidWHu2Ja9z4Tfi5gDKuDbFo2xcZhWtGwzc2VMsbM3LYuAGrHK6CYA7HINDkA
         txDw==
X-Gm-Message-State: AOAM532fb/rD/wKcKN7mSyUgCnHsMn+s7hhnpVaW1PVfdEMqQQ9OidO8
        QyPdUq6trCsEboosYIz6qkCd6oqVprF+egn3BgVH
X-Google-Smtp-Source: ABdhPJwY58186upJGjF+++Cg40KulQrFPTck9+8exmcfwwDU6enLRHtvLKw+YqEw0n/2SyAqb90qlC0X5+uiFSQ+OaU=
X-Received: by 2002:a5e:d90c:: with SMTP id n12mr2832816iop.144.1593618168297;
 Wed, 01 Jul 2020 08:42:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593191971.git.luto@kernel.org> <947880c41ade688ff4836f665d0c9fcaa9bd1201.1593191971.git.luto@kernel.org>
In-Reply-To: <947880c41ade688ff4836f665d0c9fcaa9bd1201.1593191971.git.luto@kernel.org>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Wed, 1 Jul 2020 11:42:37 -0400
Message-ID: <CAMzpN2iW4XD1Gsgq0ZeeH2eewLO+9Mk6eyk0LnbF-kP3v=smLg@mail.gmail.com>
Subject: Re: [PATCH 3/6] x86/entry/64/compat: Fix Xen PV SYSENTER frame setup
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 1:30 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> The SYSENTER frame setup was nonsense.  It worked by accident
> because the normal code into which the Xen asm jumped
> (entry_SYSENTER_32/compat) threw away SP without touching the stack.
> entry_SYSENTER_compat was recently modified such that it relied on
> having a valid stack pointer, so now the Xen asm needs to invoke it
> with a valid stack.
>
> Fix it up like SYSCALL: use the Xen-provided frame and skip the bare
> metal prologue.
>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: xen-devel@lists.xenproject.org
> Fixes: 1c3e5d3f60e2 ("x86/entry: Make entry_64_compat.S objtool clean")
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
>  arch/x86/entry/entry_64_compat.S |  1 +
>  arch/x86/xen/xen-asm_64.S        | 20 ++++++++++++++++----
>  2 files changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
> index 7b9d8150f652..381a6de7de9c 100644
> --- a/arch/x86/entry/entry_64_compat.S
> +++ b/arch/x86/entry/entry_64_compat.S
> @@ -79,6 +79,7 @@ SYM_CODE_START(entry_SYSENTER_compat)
>         pushfq                          /* pt_regs->flags (except IF = 0) */
>         pushq   $__USER32_CS            /* pt_regs->cs */
>         pushq   $0                      /* pt_regs->ip = 0 (placeholder) */
> +SYM_INNER_LABEL(entry_SYSENTER_compat_after_hwframe, SYM_L_GLOBAL)

This skips over the section that truncates the syscall number to
32-bits.  The comments present some doubt that it is actually
necessary, but the Xen path shouldn't differ from native.  That code
should be moved after this new label.

--
Brian Gerst
