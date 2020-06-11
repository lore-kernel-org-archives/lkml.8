Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C930C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 19:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6650206A4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 19:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="aV703/Nr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgFKTRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 15:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgFKTRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 15:17:19 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49B1C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 12:17:17 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g10so5963723wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 12:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a+kgHB8QgDpXwNf1f+COLizIWEADFfuhuiC4rxXKUQw=;
        b=aV703/NrD8W1a9omqa3VYdeEoR7ta+1LtsVhYxLv9+AWMNeEOL8lQFXD1E/P9be6Ez
         VRJP11qwC/YGiS/M2bexWrmLsb/CAsyqrK9N0a2xNfdE1YhTv3CRWKWWOwuLLWKVHU3b
         d7hEmBMqDwYjw6MzsgJPqpI/5aYNQv6IqGBcL8hhzPJixbPdSN7YJd/hqKtSYqO1zB9l
         rZRIX8ttEV+69+Sd8+wy4pzANClt7lks77JX1NJB9ClwBAL5E/0On+VgX9qaM+DCKoJw
         FsJ2lWxVUfW265juHvyMCRi0S2NJ5yOCd0+5n2g25GAmsAKS8Y+zq8T0naaVh2QrPOkc
         q7zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a+kgHB8QgDpXwNf1f+COLizIWEADFfuhuiC4rxXKUQw=;
        b=I5GaL5pcAB4Go3DUE9AnvM/6YH3pW0RT9jYGQyLg9xEAMX2Jz5cug5wQy257XKaS67
         kiY0vPzWP8yFHhUpHCaxuVHQjkXVCnnySNAtdt32oPpNA9EZ0r/kOKvv6sEwNjEAX9XK
         gd7UvlZpeyrWayjMnVslQwve0bUw23Rg21OBA/7NX+SyBGmB9KxdAyM+32E3Brnw0Ykv
         sTsvQp26X7FQ5wfrBqaPoNcSwUYTqY8J7HuzvNHEm/lOstlmW4XSQXbQgtgH6HcBRq0f
         9Z/R4gCM4//9XWz/J4YqAWpZMQua18b6lVyKBZMWAc2ZXN1wzbhgqC7m0DE/gSsRhWE6
         7T5w==
X-Gm-Message-State: AOAM532QZTRH3gs1f3ow2fNs1i5QeBy27EkgpxJxdk0XFJA6HrN1f7IQ
        U9bZ0O93OcFuLmDw08w+1x3jHMADolg=
X-Google-Smtp-Source: ABdhPJxkMccXnMPVjqWmfYhm7iJQKNNCgmoueAiXz196VTFKJSoV1fTBj4eMPDenEtu5yEUNBN6oqw==
X-Received: by 2002:a1c:a7c3:: with SMTP id q186mr9043873wme.141.1591903034297;
        Thu, 11 Jun 2020 12:17:14 -0700 (PDT)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id c70sm5027728wme.32.2020.06.11.12.17.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2020 12:17:13 -0700 (PDT)
Subject: Re: vdso_join_timens() question
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org
References: <20200611110221.pgd3r5qkjrjmfqa2@wittgenstein>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <97732762-de71-e015-3989-b87d6e5c4dd4@arista.com>
Date:   Thu, 11 Jun 2020 20:17:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200611110221.pgd3r5qkjrjmfqa2@wittgenstein>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

On 6/11/20 12:02 PM, Christian Brauner wrote:
> Hey,
> 
> I'm about to finish a patch to add CLONE_NEWTIME support to setns().
> Since setns() now allows to attach to a multiple namespaces at the same
> time I've also reworked it to be atomic (already upstream). Either all
> namespaces are switched or no namespace is switched. All namespaces
> basically now have a commit mode after which installation should ideally
> not fail anymore. That could work for CLONE_NEWTIME too, I think. The
> only blocker to this is vdso_join_timens() which can fail due to
> mmap_write_lock_killable().
> 
> Is it possible to change this to mmap_write_lock()? So sm like:
> 
> diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
> index ea7c1f0b79df..5c5b4cc61fce 100644
> --- a/arch/x86/entry/vdso/vma.c
> +++ b/arch/x86/entry/vdso/vma.c
> @@ -144,8 +144,7 @@ int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
>         struct mm_struct *mm = task->mm;
>         struct vm_area_struct *vma;
> 
> -       if (mmap_write_lock_killable(mm))
> -               return -EINTR;
> +       mmap_write_lock(mm);
> 
>         for (vma = mm->mmap; vma; vma = vma->vm_next) {
>                 unsigned long size = vma->vm_end - vma->vm_start;

I think, it should be fine.

I'm thinking if it actually could be downgraded to mmap_read_lock()..
Probably, write lock was being over-cautious.

> vdso_join_timens() is called in two places. Once during fork() and once
> during timens_install(). I would only need the mmap_write_lock() change
> for the latter. So alternatively we could have:
> 
> __vdso_join_timens_unlocked()
> 
> and then have/expose:
> 
> vdso_join_timens_fork()
> {
>         if (mmap_write_lock_killable(mm))
>                 return -EINTR;
> 	__vdso_join_timens_unlocked()
> 	mmap_write_unlock(mm);
> }
> 
> and 
> 
> vdso_join_timens_install()
> {
>         mmap_write_lock(mm);
> 	__vdso_join_timens_unlocked()
> 	mmap_write_unlock(mm);
> }

I think it's not needed. On fork() it's called on creation of new timens:

:	if (nsproxy->time_ns == nsproxy->time_ns_for_children)
:		return 0;

So the vdso_join_timens() is called on setns() or on creation of new
namespace, which both are quite heavy operations themselves (in sense of
locking).

Thanks,
          Dmitry
