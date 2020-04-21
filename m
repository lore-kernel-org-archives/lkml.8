Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E58C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 15:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C50FE206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 15:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbgDUPAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 11:00:18 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:52656 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbgDUPAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 11:00:18 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jQuNk-00011K-8L; Tue, 21 Apr 2020 09:00:16 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jQuNj-0008Pv-43; Tue, 21 Apr 2020 09:00:15 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org,
        Linux Containers <containers@lists.linux-foundation.org>,
        Christof Meerwald <cmeerw@cmeerw.org>,
        Oleg Nesterov <oleg@redhat.com>
References: <20200419201336.GI22017@edge.cmeerw.net>
        <87sggyytnh.fsf@x220.int.ebiederm.org>
        <20200421083031.5wapruzncjkagvhf@wittgenstein>
Date:   Tue, 21 Apr 2020 09:57:09 -0500
In-Reply-To: <20200421083031.5wapruzncjkagvhf@wittgenstein> (Christian
        Brauner's message of "Tue, 21 Apr 2020 10:30:31 +0200")
Message-ID: <871rog6g56.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jQuNj-0008Pv-43;;;mid=<871rog6g56.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+BjMt48Bfgsu37PxcbesKuyDH8b45kCUc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] signal: Avoid corrupting si_pid and si_uid in do_notify_parent
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Brauner <christian.brauner@ubuntu.com> writes:

> On Mon, Apr 20, 2020 at 12:05:38PM -0500, Eric W. Biederman wrote:
>> diff --git a/kernel/signal.c b/kernel/signal.c
>> index 9899c5f91ee1..a88a89422227 100644
>> --- a/kernel/signal.c
>> +++ b/kernel/signal.c
>> @@ -1993,8 +1993,12 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
>>  		if (psig->action[SIGCHLD-1].sa.sa_handler == SIG_IGN)
>>  			sig = 0;
>>  	}
>> +	/*
>> +	 * Bypass send_signal as the si_pid and si_uid values have
>> +	 * been generated in the parent's namespaces.
>> +	 */
>
> At first I misread that comment as saying that we're skipping sending a
> signal not that it relates to a specific function (and I won't admit that
> I wrote a whole long paragraph on why I'm confused we're skipping
> sending signals on invalid si_pid and si_uid...).

I have updated the comment to read:
+       /*
+        * Send with __send_signal as si_pid and si_uid are in the
+        * parent's namespaces.
+        */

That should be enough of a hint for someone to read the code and figure
out what is going on.

Eric
