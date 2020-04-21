Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8795DC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 15:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DF30206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 15:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbgDUPIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 11:08:18 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:39462 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbgDUPIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 11:08:18 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jQuVU-0005rQ-Qg; Tue, 21 Apr 2020 09:08:16 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jQuVU-000873-0g; Tue, 21 Apr 2020 09:08:16 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Christof Meerwald <cmeerw@cmeerw.org>,
        Linux Containers <containers@lists.linux-foundation.org>
References: <20200419201336.GI22017@edge.cmeerw.net>
        <87sggyytnh.fsf@x220.int.ebiederm.org>
        <20200421090426.GA6787@redhat.com> <20200421101904.GA9358@redhat.com>
Date:   Tue, 21 Apr 2020 10:05:10 -0500
In-Reply-To: <20200421101904.GA9358@redhat.com> (Oleg Nesterov's message of
        "Tue, 21 Apr 2020 12:19:04 +0200")
Message-ID: <87mu74517d.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jQuVU-000873-0g;;;mid=<87mu74517d.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19Yjwrl5mq9JkJujsk7jmlVVXuCbMojEnw=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] remove the no longer needed pid_alive() check in __task_pid_nr_ns()
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> Starting from 2c4704756cab ("pids: Move the pgrp and session pid pointers
> from task_struct to signal_struct") __task_pid_nr_ns() doesn't dereference
> task->group_leader, we can remove the pid_alive() check.
>
> pid_nr_ns() has to check pid != NULL anyway, pid_alive() just adds the
> unnecessary confusion.
>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Reviewed-by: "Eric W. Biederman" <ebiederm@xmission.com>

> ---

Good catch that does simplify things.

Eric

>  kernel/pid.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/kernel/pid.c b/kernel/pid.c
> index bc21c0fb26d8..47221db038e2 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -475,8 +475,7 @@ pid_t __task_pid_nr_ns(struct task_struct *task, enum pid_type type,
>  	rcu_read_lock();
>  	if (!ns)
>  		ns = task_active_pid_ns(current);
> -	if (likely(pid_alive(task)))
> -		nr = pid_nr_ns(rcu_dereference(*task_pid_ptr(task, type)), ns);
> +	nr = pid_nr_ns(rcu_dereference(*task_pid_ptr(task, type)), ns);
>  	rcu_read_unlock();
>  
>  	return nr;
