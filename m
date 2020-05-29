Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66C6C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 18:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1F3E20776
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 18:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgE2SF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 14:05:26 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:49390 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgE2SFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 14:05:24 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jejNb-00027S-L0; Fri, 29 May 2020 12:05:15 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jejNa-0002Wf-GF; Fri, 29 May 2020 12:05:15 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     liuchao <liuchao173@huawei.com>
Cc:     <mingo@kernel.org>, <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <hushiyuan@huawei.com>,
        <hewenliang4@huawei.com>
References: <20200528040956.30155-1-liuchao173@huawei.com>
Date:   Fri, 29 May 2020 13:01:22 -0500
In-Reply-To: <20200528040956.30155-1-liuchao173@huawei.com> (liuchao's message
        of "Thu, 28 May 2020 12:09:56 +0800")
Message-ID: <87mu5qpqml.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jejNa-0002Wf-GF;;;mid=<87mu5qpqml.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+Bsta5A7aKpNO8LR4qg/R9Jt9gYrytK9c=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC] decrease tsk->signal->live before profile_task_exit
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

liuchao <liuchao173@huawei.com> writes:

> I want to dermine which thread is the last one to enter
> do_exit in profile_task_exit. But when a lot of threads
> exit, tsk->signal->live is not correct since it decrease
> after profile_task_exit.

I don't think that would be wise.

Any additional code before the sanity checks at the start of do_exit
seems like a bad idea.

We could probably move the decrement of tsk->signal->live a little
earlier, but not that much earlier in the function.

Does profile_task_exit even make sense that early in the code?  If the
code is doing much of anything that is a completely inappopriate
placement of profile_task_exit.

Eric


> Signed-off-by: liuchao <liuchao173@huawei.com>
> ---
>  kernel/exit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/exit.c b/kernel/exit.c
> index ce2a75bc0ade..1693764bc356 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -708,6 +708,7 @@ void __noreturn do_exit(long code)
>  	struct task_struct *tsk = current;
>  	int group_dead;
>  
> +	group_dead = atomic_dec_and_test(&tsk->signal->live);
>  	profile_task_exit(tsk);
>  	kcov_task_exit(tsk);
>  
> @@ -755,7 +756,6 @@ void __noreturn do_exit(long code)
>  	if (tsk->mm)
>  		sync_mm_rss(tsk->mm);
>  	acct_update_integrals(tsk);
> -	group_dead = atomic_dec_and_test(&tsk->signal->live);
>  	if (group_dead) {
>  		/*
>  		 * If the last thread of global init has exited, panic
