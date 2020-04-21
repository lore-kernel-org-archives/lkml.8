Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EE0C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED41520672
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbgDUNp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:45:57 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:52046 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbgDUNp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 09:45:56 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jQtDl-000827-RM; Tue, 21 Apr 2020 07:45:53 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jQtDk-0000Pr-Ma; Tue, 21 Apr 2020 07:45:53 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Christof Meerwald <cmeerw@cmeerw.org>,
        linux-kernel@vger.kernel.org
References: <20200419201336.GI22017@edge.cmeerw.net>
        <87sggyytnh.fsf@x220.int.ebiederm.org>
        <20200421083031.5wapruzncjkagvhf@wittgenstein>
        <20200421092846.GB6787@redhat.com>
        <20200421102104.6pt34jknxmtu5ygm@wittgenstein>
        <20200421111139.GC6787@redhat.com>
        <20200421112606.ay4cck2dphguqazb@wittgenstein>
        <20200421121722.GE6787@redhat.com>
        <20200421125908.ls5nwgkl4q7hjoov@wittgenstein>
Date:   Tue, 21 Apr 2020 08:42:47 -0500
In-Reply-To: <20200421125908.ls5nwgkl4q7hjoov@wittgenstein> (Christian
        Brauner's message of "Tue, 21 Apr 2020 14:59:08 +0200")
Message-ID: <874ktd6jl4.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jQtDk-0000Pr-Ma;;;mid=<874ktd6jl4.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18vK2aBxynwRn1BhQBpA2lakrIC6F+9FUA=
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

> On Tue, Apr 21, 2020 at 02:17:22PM +0200, Oleg Nesterov wrote:
>> On 04/21, Christian Brauner wrote:
>> >
>> > process B setnses into
>> > <pidnsC> which is a sibling pid namespace,
>> 
>> please see pidns_install(), it verifies that
>> 
>> 	* Only allow entering the current active pid namespace
>> 	* or a child of the current active pid namespace.
>
> I forgot about that.
>
> Though, don't we have the same problem in:
>
> static void do_notify_parent_cldstop(struct task_struct *tsk,
> 				     bool for_ptracer, int why)
>
> at least for the for_ptrace is false case?


The same problem does not exist with do_notify_parent_cldstop because
do_notify_parent_cldstop is always called from current (there is
one case of current->group_leader but that is close enough calculations
made against current are true).

However because do_notify_parent_cldstop calculates si_pid and si_uid of
the target parent process I think we can still get the wrong si_uid.

So it probably makes sense to generalize the fixup code in send_signal
and make do_notify_parent_cldstop just generate ids in the current
namespace and let the fixup code do it's job.

Eric
