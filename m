Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74340C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 08:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CD132081A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 08:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592037745;
	bh=xCW5zEEUc0j8JdLZK9w8g52it34RuX3NHf5pgk9G+Q8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0yOn1UAy5GgXk+SwW8ZiSZtDwn/bB0xofpgO1es99ctiJmr9Y70WBAkCThJog0r18
	 YRjap6wtkZX5CqoXUvyPFya5o7BQjAdhw1TXZDT41IbhLJqmp8Fq5AqTKLhja3FVXf
	 Siv/ffUwKkpRxSpDMx3tB0DVkPE7Vf8TVePsUWxw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgFMImX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 04:42:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:53022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbgFMImW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 04:42:22 -0400
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E54F8206D7;
        Sat, 13 Jun 2020 08:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592037741;
        bh=xCW5zEEUc0j8JdLZK9w8g52it34RuX3NHf5pgk9G+Q8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Iwfdc9+ZI0pFLKMFbArS+mmOOkBl1ZLAWFJpMtXB4coT8Weu+3DzBIZA9hHssCUQK
         87L8LfuWJYOo9qkTMuTYh+aqRJHSVF0s1xU/HYyq1LMKqWBAwddQ26eJAvgGazoGq+
         oPG0+TZWSTMtNg6qCkRl0NocHNo6y2qBHTtoT0WY=
Received: by mail-lj1-f174.google.com with SMTP id 9so13665314ljv.5;
        Sat, 13 Jun 2020 01:42:20 -0700 (PDT)
X-Gm-Message-State: AOAM531FXcN8P+afd26iHaCcw4TVMgv43fJ3TiMNJAap1wRwYKa9zTMg
        uwJbMg7CqySCnyi6ysDKElHdkMf/JRhiQLPP90Q=
X-Google-Smtp-Source: ABdhPJy02XUNfPeMM6pACPbGXMYswnZVke4nUOam3qQ1p+P0sRElAvHF5XOt2Jc5DD+VGNKuP9OiS7sgLWH+7bFPoHs=
X-Received: by 2002:a2e:7105:: with SMTP id m5mr7955290ljc.79.1592037739090;
 Sat, 13 Jun 2020 01:42:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200610153935.13794-1-tklauser@distanz.ch>
In-Reply-To: <20200610153935.13794-1-tklauser@distanz.ch>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 13 Jun 2020 16:42:07 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRGVQcn5Hu+kaHfzhEpyXuMkQQYyfHkuxREYci4QJ0SoQ@mail.gmail.com>
Message-ID: <CAJF2gTRGVQcn5Hu+kaHfzhEpyXuMkQQYyfHkuxREYci4QJ0SoQ@mail.gmail.com>
Subject: Re: [PATCH] csky: remove unusued thread_saved_pc and *_segments functions/macros
To:     Tobias Klauser <tklauser@distanz.ch>
Cc:     Mao Han <han_mao@c-sky.com>, linux-csky@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Guo Ren <guoren@kernel.org>

On Wed, Jun 10, 2020 at 11:45 PM Tobias Klauser <tklauser@distanz.ch> wrote:
>
> These are used nowhere in the tree (except for some architectures which
> define them for their own use) and were already removed for other
> architectures in:
>
> commit 6474924e2b5d ("arch: remove unused macro/function thread_saved_pc()")
> commit c17c02040bf0 ("arch: remove unused *_segments() macros/functions")
>
> Remove them from arch/csky as well.
>
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---
>  arch/csky/include/asm/processor.h |  6 ------
>  arch/csky/kernel/process.c        | 10 ----------
>  2 files changed, 16 deletions(-)
>
> diff --git a/arch/csky/include/asm/processor.h b/arch/csky/include/asm/processor.h
> index 24442d8e86f9..4800f6563abb 100644
> --- a/arch/csky/include/asm/processor.h
> +++ b/arch/csky/include/asm/processor.h
> @@ -82,12 +82,6 @@ static inline void release_thread(struct task_struct *dead_task)
>
>  extern int kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
>
> -#define copy_segments(tsk, mm)         do { } while (0)
> -#define release_segments(mm)           do { } while (0)
> -#define forget_segments()              do { } while (0)
> -
> -extern unsigned long thread_saved_pc(struct task_struct *tsk);
> -
>  unsigned long get_wchan(struct task_struct *p);
>
>  #define KSTK_EIP(tsk)          (task_pt_regs(tsk)->pc)
> diff --git a/arch/csky/kernel/process.c b/arch/csky/kernel/process.c
> index 8b3fad062ab2..3da63cf0bfde 100644
> --- a/arch/csky/kernel/process.c
> +++ b/arch/csky/kernel/process.c
> @@ -30,16 +30,6 @@ asmlinkage void ret_from_kernel_thread(void);
>   */
>  void flush_thread(void){}
>
> -/*
> - * Return saved PC from a blocked thread
> - */
> -unsigned long thread_saved_pc(struct task_struct *tsk)
> -{
> -       struct switch_stack *sw = (struct switch_stack *)tsk->thread.sp;
> -
> -       return sw->r15;
> -}
> -
>  int copy_thread_tls(unsigned long clone_flags,
>                 unsigned long usp,
>                 unsigned long kthread_arg,
> --
> 2.27.0
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
