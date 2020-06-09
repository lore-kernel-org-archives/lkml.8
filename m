Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251BEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 02:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05A002078C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 02:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgFICaG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 22:30:06 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:54882 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726749AbgFICaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 22:30:05 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 391D862EB35D663B2CE9;
        Tue,  9 Jun 2020 10:30:04 +0800 (CST)
Received: from dggeme707-chm.china.huawei.com (10.1.199.103) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Tue, 9 Jun 2020 10:30:03 +0800
Received: from dggema755-chm.china.huawei.com (10.1.198.197) by
 dggeme707-chm.china.huawei.com (10.1.199.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 9 Jun 2020 10:30:03 +0800
Received: from dggema755-chm.china.huawei.com ([10.1.198.197]) by
 dggema755-chm.china.huawei.com ([10.1.198.197]) with mapi id 15.01.1913.007;
 Tue, 9 Jun 2020 10:30:02 +0800
From:   "liuchao (CR)" <liuchao173@huawei.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
CC:     "mingo@kernel.org" <mingo@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hushiyuan <hushiyuan@huawei.com>,
        "hewenliang (C)" <hewenliang4@huawei.com>
Subject: Re: [RFC] decrease tsk->signal->live before profile_task_exit
Thread-Topic: [RFC] decrease tsk->signal->live before profile_task_exit
Thread-Index: AdY+AG0xoFxNBeBNTRuUPpzDg2aFdg==
Date:   Tue, 9 Jun 2020 02:30:02 +0000
Message-ID: <36882010b4b642a0b752eeeea697e783@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.166.215.131]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman <mailto:ebiederm@xmission.com> writes:

> liuchao <liuchao173@huawei.com> writes:
> 
> > I want to dermine which thread is the last one to enter do_exit in
> > profile_task_exit. But when a lot of threads exit, tsk->signal->live
> > is not correct since it decrease after profile_task_exit.
> 
> I don't think that would be wise.
> 
> Any additional code before the sanity checks at the start of do_exit seems
> like a bad idea.
> 
> We could probably move the decrement of tsk->signal->live a little earlier,
> but not that much earlier in the function.
> 
> Does profile_task_exit even make sense that early in the code?  If the code
> is doing much of anything that is a completely inappopriate placement of
> profile_task_exit.

I think so too.

Move the decrement of tsk->signal->live after the sanity checks, then
profile_task_exit and kcov_task_exit make more sense.

> 
> Eric
> 
> 
> > Signed-off-by: liuchao <liuchao173@huawei.com>
> > ---
> >  kernel/exit.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/exit.c b/kernel/exit.c index
> > ce2a75bc0ade..1693764bc356 100644
> > --- a/kernel/exit.c
> > +++ b/kernel/exit.c
> > @@ -708,6 +708,7 @@ void __noreturn do_exit(long code)
> >  	struct task_struct *tsk = current;
> >  	int group_dead;
> >
> > +	group_dead = atomic_dec_and_test(&tsk->signal->live);
> >  	profile_task_exit(tsk);
> >  	kcov_task_exit(tsk);
> >
> > @@ -755,7 +756,6 @@ void __noreturn do_exit(long code)
> >  	if (tsk->mm)
> >  		sync_mm_rss(tsk->mm);
> >  	acct_update_integrals(tsk);
> > -	group_dead = atomic_dec_and_test(&tsk->signal->live);
> >  	if (group_dead) {
> >  		/*
> >  		 * If the last thread of global init has exited, panic
