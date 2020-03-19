Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA48C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 15:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C652072D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 15:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584632815;
	bh=Cn1m0nZsjDiV+FYhoJLlELXGkyDw2CZ03wWFmubUPo8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wQBsW0Lk9V/O4h1ZFPSEmVpNbT5eKFqTk+Eb4hVChEg/EL1Q6bIDd8tjh3hmXBHcT
	 VhfYn+aLfmWkQA7KFfj9OT9EVVUi+3VEKU7oQ4Y+DqezV0yrKQtyaoLDMvlpo/n5ru
	 fOpjsAEO2dNlWE6JtVVpqwkEdtIWizW4l0Bt/Ebg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbgCSPqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 11:46:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:56426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727593AbgCSPqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 11:46:50 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B886721775
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 15:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584632810;
        bh=Cn1m0nZsjDiV+FYhoJLlELXGkyDw2CZ03wWFmubUPo8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Bqc/DvIBMhIobrqKeilGyFQQIGQMPqcwCCmTWlk+w71Tr24MgghLknOseCQr2FkPP
         pBg3C82P5fhtl5jsxpscyX3d4WPB7JCK7LxSpLZV3ERaPIqyv15Lp22fOEAUXOW1FA
         bO74bLqN3aP8k/9PYSX+u66n4JNxAqhw2T2P1Sww=
Received: by mail-wr1-f53.google.com with SMTP id o12so3118689wrh.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 08:46:49 -0700 (PDT)
X-Gm-Message-State: ANhLgQ2sGBa03C04xGkiWdDNvZFzkMQeBRzkhjPXWlzRWgIu7dMsewVg
        2AfoaeKeNxya3L+xBeDa7Sy8kw+Yw6SHboh5U9GBtg==
X-Google-Smtp-Source: ADFU+vtRWY7b1vbCxAUKKJKmAYVxdIrYpSMuMiWvH4H8RWo6SRJpLSPLzDmmHbdXmaoFC1CnppEqPqcDFxLdoNnM7Rk=
X-Received: by 2002:adf:e883:: with SMTP id d3mr4992846wrm.75.1584632808043;
 Thu, 19 Mar 2020 08:46:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200319091407.1481-1-joro@8bytes.org> <20200319091407.1481-43-joro@8bytes.org>
In-Reply-To: <20200319091407.1481-43-joro@8bytes.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 19 Mar 2020 08:46:36 -0700
X-Gmail-Original-Message-ID: <CALCETrXiWjALMTcG=92DmMn_H=yR88e0-3cj8CjTAjtjTvBR8w@mail.gmail.com>
Message-ID: <CALCETrXiWjALMTcG=92DmMn_H=yR88e0-3cj8CjTAjtjTvBR8w@mail.gmail.com>
Subject: Re: [PATCH 42/70] x86/sev-es: Support nested #VC exceptions
To:     Joerg Roedel <joro@8bytes.org>
Cc:     X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Jiri Slaby <jslaby@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 2:14 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> From: Joerg Roedel <jroedel@suse.de>
>
> Handle #VC exceptions that happen while the GHCB is in use. This can
> happen when an NMI happens in the #VC exception handler and the NMI
> handler causes a #VC exception itself. Save the contents of the GHCB
> when nesting is detected and restore it when the GHCB is no longer
> used.
>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  arch/x86/kernel/sev-es.c | 63 +++++++++++++++++++++++++++++++++++++---
>  1 file changed, 59 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
> index 97241d2f0f70..3b7bbc8d841e 100644
> --- a/arch/x86/kernel/sev-es.c
> +++ b/arch/x86/kernel/sev-es.c
> @@ -32,9 +32,57 @@ struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
>   */
>  struct ghcb __initdata *boot_ghcb;
>
> +struct ghcb_state {
> +       struct ghcb *ghcb;
> +};
> +
>  /* Runtime GHCB pointers */
>  static struct ghcb __percpu *ghcb_page;
>
> +/*
> + * Mark the per-cpu GHCB as in-use to detect nested #VC exceptions.
> + * There is no need for it to be atomic, because nothing is written to the GHCB
> + * between the read and the write of ghcb_active. So it is safe to use it when a
> + * nested #VC exception happens before the write.
> + */
> +static DEFINE_PER_CPU(bool, ghcb_active);
> +
> +static struct ghcb *sev_es_get_ghcb(struct ghcb_state *state)
> +{
> +       struct ghcb *ghcb = (struct ghcb *)this_cpu_ptr(ghcb_page);
> +       bool *active = this_cpu_ptr(&ghcb_active);
> +
> +       if (unlikely(*active)) {
> +               /* GHCB is already in use - save its contents */
> +
> +               state->ghcb = kzalloc(sizeof(struct ghcb), GFP_ATOMIC);
> +               if (!state->ghcb)
> +                       return NULL;

This can't possibly end well.  Maybe have a little percpu list of
GHCBs and make sure there are enough for any possible nesting?

Also, I admit confusion.  Isn't the GHCB required to be unencrypted?
How does that work with kzalloc()?
