Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6FCC54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 19:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DF3120781
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 19:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbgDXT6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 15:58:07 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:48954 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDXT6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 15:58:07 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jS4Sa-0004H3-Qr; Fri, 24 Apr 2020 13:58:04 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jS4Sa-0007oo-3E; Fri, 24 Apr 2020 13:58:04 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Christof Meerwald <cmeerw@cmeerw.org>,
        Linux Containers <containers@lists.linux-foundation.org>
References: <20200419201336.GI22017@edge.cmeerw.net>
        <87sggyytnh.fsf@x220.int.ebiederm.org>
        <20200421090426.GA6787@redhat.com> <20200421101904.GA9358@redhat.com>
        <87mu74517d.fsf@x220.int.ebiederm.org>
        <20200424180523.GD26802@redhat.com>
Date:   Fri, 24 Apr 2020 14:54:55 -0500
In-Reply-To: <20200424180523.GD26802@redhat.com> (Oleg Nesterov's message of
        "Fri, 24 Apr 2020 20:05:24 +0200")
Message-ID: <87d07wpskw.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jS4Sa-0007oo-3E;;;mid=<87d07wpskw.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+QVvs3O+peet5LQjScDuiQmGVaCM7O6Wc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] remove the no longer needed pid_alive() check in __task_pid_nr_ns()
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 04/21, Eric W. Biederman wrote:
>>
>> Oleg Nesterov <oleg@redhat.com> writes:
>>
>> > Starting from 2c4704756cab ("pids: Move the pgrp and session pid pointers
>> > from task_struct to signal_struct") __task_pid_nr_ns() doesn't dereference
>> > task->group_leader, we can remove the pid_alive() check.
>> >
>> > pid_nr_ns() has to check pid != NULL anyway, pid_alive() just adds the
>> > unnecessary confusion.
>> >
>> > Signed-off-by: Oleg Nesterov <oleg@redhat.com>
>> Reviewed-by: "Eric W. Biederman" <ebiederm@xmission.com>
>
> Thanks, can you take this patch?

I plan to.  Probably on a topic branch for signals.  I am sorting
that out now.

Eric

