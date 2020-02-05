Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB8FC35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 16:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B83217BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 16:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmPL0gav"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbgBEQvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 11:51:46 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:35687 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbgBEQvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 11:51:46 -0500
Received: by mail-pj1-f67.google.com with SMTP id q39so1240761pjc.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 08:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ywEsvWm4XVLIMTnvEIQGcAo+zgmS5NmEL02AYmIK1Y8=;
        b=NmPL0gav3uJ5A/Mbh21U5I4QCRwUW32KYipdtdD6pSLUAI743KHd6WwwbypJkQ0Byd
         sn3Z+1bL0V+RloZmr7vJsfphoIlFkLPQOw0ox9euG87te7ZgLyq1hbw8cUrDMydZEGRv
         xuOsNvt1tU+0zpiqASKIGBox/QhiCx+3Zv9Y8p9EQULevVi2iOt3OqEmTh1Yaj6MTFO9
         M+3b+KyoqND1pHU7q1Dw3H+ITTJibRQ051CGVT4BGpH5i7e3S5vRysvEjiTSTkMwADNq
         qtARhG/UWh3aijEAitsUfjy8eYSFAP5OnHTulgheENbRoURrTQAUAQ75Duxy+z4O/Vvn
         TVrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ywEsvWm4XVLIMTnvEIQGcAo+zgmS5NmEL02AYmIK1Y8=;
        b=F3tKYfZsAplIetJ9kEAl4ZVHchLDTC6/64GwOqfhfjPtgD7XIZjEL4sV1s8R8ykUUt
         S1fn+b80SqiwFsKpQVYzCd/aHUOACxSBYO/U67k88KYLuKHSeNuzMZYccLHx3pRWaRYA
         a3cYeQ5lwFJEinyV/jKuNdeKNkEVeT5rtbGAyCU5/GxXsqjP3Voz92tCsOe3WZOlu89Y
         AYRxTa6jwcJgTZ6biQKuyq8SQHtMM7x33VYkjJ9SQXBjUrsww2wdY3uzNUpkOj1XFaTW
         iJfehX/Y0hQ6u15wWlP1P9pD2Ft/gm0YzFuXOTbb4cQI1VAN7+JCM2iCo3zj6g5TErft
         S44A==
X-Gm-Message-State: APjAAAW2d01fUIecOCHxuvZGzq5ZYJCwXAVWaE0z2n65PKu6uCyKNekC
        ZeKHuWij7OqOuuFww0UYN9M=
X-Google-Smtp-Source: APXvYqxXmsQtDlHhBs00qKZgpGV/nHF2y5uD2anu+uCp67JH4gEJlJrFqNlzACA4NDaxUinEjbNAUw==
X-Received: by 2002:a17:902:a706:: with SMTP id w6mr36261822plq.79.1580921505290;
        Wed, 05 Feb 2020 08:51:45 -0800 (PST)
Received: from workstation-portable ([103.211.17.109])
        by smtp.gmail.com with ESMTPSA id p17sm43132pfn.31.2020.02.05.08.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 08:51:44 -0800 (PST)
Date:   Wed, 5 Feb 2020 22:21:38 +0530
From:   Amol Grover <frextrite@gmail.com>
To:     madhuparnabhowmik10@gmail.com
Cc:     ebiederm@xmission.com, oleg@redhat.com,
        christian.brauner@ubuntu.com, guro@fb.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, paulmck@kernel.org,
        joel@joelfernandes.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] signal.c: Fix sparse warnings
Message-ID: <20200205165138.GB22537@workstation-portable>
References: <20200205162319.28263-1-madhuparnabhowmik10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205162319.28263-1-madhuparnabhowmik10@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 09:53:19PM +0530, madhuparnabhowmik10@gmail.com wrote:
> From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> 
> This patch fixes the following two sparse warnings caused due to
> accessing RCU protected pointer tsk->parent without rcu primitives.
> 
> kernel/signal.c:1948:65: warning: incorrect type in argument 1 (different address spaces)
> kernel/signal.c:1948:65:    expected struct task_struct *tsk
> kernel/signal.c:1948:65:    got struct task_struct [noderef] <asn:4> *parent
> kernel/signal.c:1949:40: warning: incorrect type in argument 1 (different address spaces)
> kernel/signal.c:1949:40:    expected void const volatile *p
> kernel/signal.c:1949:40:    got struct cred const [noderef] <asn:4> *[noderef] <asn:4> *
> kernel/signal.c:1949:40: warning: incorrect type in argument 1 (different address spaces)
> kernel/signal.c:1949:40:    expected void const volatile *p
> kernel/signal.c:1949:40:    got struct cred const [noderef] <asn:4> *[noderef] <asn:4> *
> 
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> ---
>  kernel/signal.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 9ad8dea93dbb..3d59e5652d94 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1945,8 +1945,8 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
>  	 * correct to rely on this
>  	 */
>  	rcu_read_lock();
> -	info.si_pid = task_pid_nr_ns(tsk, task_active_pid_ns(tsk->parent));
> -	info.si_uid = from_kuid_munged(task_cred_xxx(tsk->parent, user_ns),
> +	info.si_pid = task_pid_nr_ns(tsk, task_active_pid_ns(rcu_access_pointer(tsk->parent)));
> +	info.si_uid = from_kuid_munged(task_cred_xxx(rcu_access_pointer(tsk->parent), user_ns),

Shouldn't rcu_dereference() OR rcu_dereference_check() be better suited
here? Since, rcu_access_pointer() omits all lockdep checks.

Thanks
Amol

>  				       task_uid(tsk));
>  	rcu_read_unlock();
>  
> -- 
> 2.17.1
> 
