Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7996CC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 02:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53C3D20663
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 02:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbgCXC75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 22:59:57 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:47478 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbgCXC75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 22:59:57 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jGZn8-0005r7-OH; Mon, 23 Mar 2020 20:59:46 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jGZn7-0005bB-OL; Mon, 23 Mar 2020 20:59:46 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Manfred Spraul <manfred@colorfullife.com>,
        Markus Elfring <elfring@users.sourceforge.net>,
        Yoji <yoji.fujihar.min@gmail.com>, linux-kernel@vger.kernel.org
References: <20200322110901.GA25108@redhat.com>
        <87lfnsh3tm.fsf@x220.int.ebiederm.org>
        <20200322202929.GA1614@redhat.com>
        <87imivc92n.fsf@x220.int.ebiederm.org>
        <20200323191214.81a60c4ae1a59fdbd5c5d46d@linux-foundation.org>
Date:   Mon, 23 Mar 2020 21:57:14 -0500
In-Reply-To: <20200323191214.81a60c4ae1a59fdbd5c5d46d@linux-foundation.org>
        (Andrew Morton's message of "Mon, 23 Mar 2020 19:12:14 -0700")
Message-ID: <87bloma29h.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jGZn7-0005bB-OL;;;mid=<87bloma29h.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18X0LNZ347AoJx56b1D2zQeeFKGzC+6jys=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] ipc/mqueue.c: change __do_notify() to bypass check_kill_permission()
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> writes:

> On Mon, 23 Mar 2020 11:47:12 -0500 ebiederm@xmission.com (Eric W. Biederman) wrote:
>
>> I really just want to be certain that things are fixed well enough that
>> we don't risk a regressing again the next time someone touches the code.
>
> That would be nice ;)
>
> But as Oleg indicated, please let's have something minimal for -stable
> backporting friendliness.  A more comprehensive change can then be
> merged following the regular processes.

So far what we have is a report Oleg has read somewhere that some
program doing something regressed, and his patch to fix that specific
program.  This problem was not noticed for several years.

Presumably the problem is that a message queue was written to by one
user and was read by another user to cause check_kill_permission to
fail. Can someone tell me if that was the case?

At this point all we have are my vague hand wavy readings of the unix98
that even says not checking permissions is correct.

I could reheat the silly arguments I have seen around pdeath_signal and
why pdeath_signal needs a permission check to say that this mq_notify
also needs a permission check to prevent signaling a processes we should
not be able to signal.

So I am looking for something that makes it clear we are not removing
a permission checking and backporting a security hole.

Further even if in the common case it is the right thing to do to remove
the permission check, the handling around exec looks bad enough that we
will be backporting a security hole if we don't fix that and backport
that at the same time.

Eric

p.s. I am grouchy as temporary fixes in this part of the code base
     don't tend to be temporary  and the entire signal/exec/ptrace world
     is bordering on unmaintainble and incomprehensible as a result.













