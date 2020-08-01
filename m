Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF71C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 01:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A343C2083B
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 01:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596246311;
	bh=sjM/fAEGxClBOS+U8ynUmUP8+Aqqz5vPbhJDNMh/upo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1UTDz0GDLqWI/UbRpMOwSg/odONXvfWYucsWAxfX5z5Tpjhdfgq1uJ+bW2L92akyc
	 9f7ettxu9aNoTAmaaAh8tZMOM7VKUlxB6Dd/Q34ghjGuwOn3XpkJuIxvJs3XmJ4r+O
	 jnv9Ohdn+OEIyBJPZLhXV3o/mht+KBHWFthShVeo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgHABpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 21:45:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:47342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbgHABpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 21:45:09 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A1E422CAE
        for <linux-kernel@vger.kernel.org>; Sat,  1 Aug 2020 01:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596246308;
        bh=sjM/fAEGxClBOS+U8ynUmUP8+Aqqz5vPbhJDNMh/upo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TMfWmch3BHPGsKcmy0Xb3lWNIXId60zUQ4P7jKkHpfpohSZFUzpdhYxCWO7h1u/yp
         LR/8wQwopDHtZeuUmU+G0vINxBGwhh7MxPt/ni2U9lGvBmKjVX/kSd3zFwcW1znLeM
         KUKomZnt2pgq6e6qwBKjUdwKvcc+kJIAMNNOtCCo=
Received: by mail-wr1-f44.google.com with SMTP id r4so26496302wrx.9
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 18:45:08 -0700 (PDT)
X-Gm-Message-State: AOAM531if0yO3UG38/Aa3zgNIrhkGR3ywRY5wFp6rGbYSy92pSuXdL8P
        xxH9x+tD/qv0+qOHEFeuHJecOiUgpFSECFMEkWn+nQ==
X-Google-Smtp-Source: ABdhPJyh2ARx8wi/UN9nL/otfHQZd5+RGHN7quC5P7hkzkPIb5B7BkSWz9rivA5myA2qOsQl6oEslOsrzUBxG9umpGs=
X-Received: by 2002:adf:fa85:: with SMTP id h5mr5822401wrr.18.1596246306953;
 Fri, 31 Jul 2020 18:45:06 -0700 (PDT)
MIME-Version: 1.0
References: <1594684087-61184-1-git-send-email-fenghua.yu@intel.com> <1594684087-61184-10-git-send-email-fenghua.yu@intel.com>
In-Reply-To: <1594684087-61184-10-git-send-email-fenghua.yu@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 31 Jul 2020 18:44:55 -0700
X-Gmail-Original-Message-ID: <CALCETrVZiCG4rcdMrs2F437oyBooQ2xt+feZLeK7qPk90gmOSw@mail.gmail.com>
Message-ID: <CALCETrVZiCG4rcdMrs2F437oyBooQ2xt+feZLeK7qPk90gmOSw@mail.gmail.com>
Subject: Re: [PATCH v6 09/12] x86/process: Clear PASID state for a newly
 forked/cloned thread
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Joerg Roedel <joro@8bytes.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        H Peter Anvin <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, iommu <iommu@lists.linux-foundation.org>,
        amd-gfx <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 4:48 PM Fenghua Yu <fenghua.yu@intel.com> wrote:
>
> The PASID state has to be cleared on forks, since the child has a
> different address space. The PASID is also cleared for thread clone. While
> it would be correct to inherit the PASID in this case, it is unknown
> whether the new task will use ENQCMD. Giving it the PASID "just in case"
> would have the downside of increased context switch overhead to setting
> the PASID MSR.
>
> Since #GP faults have to be handled on any threads that were created before
> the PASID was assigned to the mm of the process, newly created threads
> might as well be treated in a consistent way.

Just how much context switch overhead are we talking about here?
Unless the CPU works differently than I expect, I would guess you are
saving exactly zero cycles.  What am I missing?

--Andy


>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
> v2:
> - Modify init_task_pasid().
>
>  arch/x86/kernel/process.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index f362ce0d5ac0..1b1492e337a6 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -121,6 +121,21 @@ static int set_new_tls(struct task_struct *p, unsigned long tls)
>                 return do_set_thread_area_64(p, ARCH_SET_FS, tls);
>  }
>
> +/* Initialize the PASID state for the forked/cloned thread. */
> +static void init_task_pasid(struct task_struct *task)
> +{
> +       struct ia32_pasid_state *ppasid;
> +
> +       /*
> +        * Initialize the PASID state so that the PASID MSR will be
> +        * initialized to its initial state (0) by XRSTORS when the task is
> +        * scheduled for the first time.
> +        */
> +       ppasid = get_xsave_addr(&task->thread.fpu.state.xsave, XFEATURE_PASID);
> +       if (ppasid)
> +               ppasid->pasid = INIT_PASID;
> +}
> +
>  int copy_thread_tls(unsigned long clone_flags, unsigned long sp,
>                     unsigned long arg, struct task_struct *p, unsigned long tls)
>  {
> @@ -174,6 +189,9 @@ int copy_thread_tls(unsigned long clone_flags, unsigned long sp,
>         task_user_gs(p) = get_user_gs(current_pt_regs());
>  #endif
>
> +       if (static_cpu_has(X86_FEATURE_ENQCMD))
> +               init_task_pasid(p);
> +
>         /* Set a new TLS for the child thread? */
>         if (clone_flags & CLONE_SETTLS)
>                 ret = set_new_tls(p, tls);
> --
> 2.19.1
>
