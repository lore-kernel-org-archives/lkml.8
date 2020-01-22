Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799B3C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AA04205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="I87jvKWM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgAVNQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:16:03 -0500
Received: from mail.skyhub.de ([5.9.137.197]:52978 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbgAVNQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:16:03 -0500
Received: from zn.tnic (p200300EC2F0CAE008532B502E47E7E30.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:ae00:8532:b502:e47e:7e30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E159C1EC0C8A;
        Wed, 22 Jan 2020 14:16:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1579698962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ErfpLrlI5rPO9/Q4XjM/mH+JI/9bNiFG/5mLcaipfkA=;
        b=I87jvKWMnwrqJc7VqCwyh5aVTGxpDAC2DJs+y/yux+2ORnYbB2l9cv29Qqf2ZnQe8jzUOk
        2rfZ/TxksO6h1eUncdQKE5HzbVHzLYzTdIfc9bdWQQX/hOc7wDHvrJo9AGRr9kaeDcCM+R
        LE63ubMm7RVEos970TIrrB99D7x+UYs=
Date:   Wed, 22 Jan 2020 14:16:00 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Waiman Long <longman@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/iperm: remove unused pointers
Message-ID: <20200122131559.GC20584@zn.tnic>
References: <1579596054-254032-1-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1579596054-254032-1-git-send-email-alex.shi@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 04:40:54PM +0800, Alex Shi wrote:
> No one use the prev/next pointers in its function after commit 22fe5b0439dd
> ("x86/ioperm: Move TSS bitmap update to exit to user work"). So better to
> remove them.
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Thomas Gleixner <tglx@linutronix.de> 
> Cc: Ingo Molnar <mingo@redhat.com> 
> Cc: Borislav Petkov <bp@alien8.de> 
> Cc: "H. Peter Anvin" <hpa@zytor.com> 
> Cc: x86@kernel.org 
> Cc: Andy Lutomirski <luto@kernel.org> 
> Cc: Rik van Riel <riel@surriel.com> 
> Cc: Dave Hansen <dave.hansen@intel.com> 
> Cc: Waiman Long <longman@redhat.com> 
> Cc: Marcelo Tosatti <mtosatti@redhat.com> 
> Cc: linux-kernel@vger.kernel.org 
> ---
>  arch/x86/kernel/process.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index 61e93a318983..839b5244e3b7 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -615,12 +615,8 @@ void speculation_ctrl_update_current(void)
>  
>  void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p)
>  {
> -	struct thread_struct *prev, *next;
>  	unsigned long tifp, tifn;
>  
> -	prev = &prev_p->thread;
> -	next = &next_p->thread;
> -
>  	tifn = READ_ONCE(task_thread_info(next_p)->flags);
>  	tifp = READ_ONCE(task_thread_info(prev_p)->flags);
>  
> -- 

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/cleanups&id=27353d5785bca61bb49cfd7c78e14f1d21e66ec5

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
