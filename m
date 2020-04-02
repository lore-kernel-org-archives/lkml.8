Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39967C2BA12
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 154D8206E9
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732614AbgDBOR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 10:17:29 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:33362 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731783AbgDBOR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 10:17:28 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jK0es-0003sC-5r; Thu, 02 Apr 2020 08:17:26 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jK0en-0002Mh-AX; Thu, 02 Apr 2020 08:17:25 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Jann Horn <jannh@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Adam Zabrocki <pi3@pi3.com.pl>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>
References: <20200324215049.GA3710@pi3.com.pl> <202003291528.730A329@keescook>
        <87zhbvlyq7.fsf_-_@x220.int.ebiederm.org>
        <CAG48ez1dCPw9Dep-+GWn=SnHv1nVv4Npv1FpFxmomk6tmazB-g@mail.gmail.com>
Date:   Thu, 02 Apr 2020 09:14:38 -0500
In-Reply-To: <CAG48ez1dCPw9Dep-+GWn=SnHv1nVv4Npv1FpFxmomk6tmazB-g@mail.gmail.com>
        (Jann Horn's message of "Thu, 2 Apr 2020 06:46:49 +0200")
Message-ID: <87y2rekm9d.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jK0en-0002Mh-AX;;;mid=<87y2rekm9d.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19aHVbkFFXhJEzKOhX85KQe0ZY2f9JbahM=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] signal: Extend exec_id to 64bits
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jann Horn <jannh@google.com> writes:

> On Wed, Apr 1, 2020 at 10:50 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>> Replace the 32bit exec_id with a 64bit exec_id to make it impossible
>> to wrap the exec_id counter.  With care an attacker can cause exec_id
>> wrap and send arbitrary signals to a newly exec'd parent.  This
>> bypasses the signal sending checks if the parent changes their
>> credentials during exec.
>>
>> The severity of this problem can been seen that in my limited testing
>> of a 32bit exec_id it can take as little as 19s to exec 65536 times.
>> Which means that it can take as little as 14 days to wrap a 32bit
>> exec_id.  Adam Zabrocki has succeeded wrapping the self_exe_id in 7
>> days.  Even my slower timing is in the uptime of a typical server.
>
> FYI, if you actually optimize this, it's more like 12s to exec 1048576
> times according to my test, which means ~14 hours for 2^32 executions
> (on a single core). That's on an i7-4790 (a Haswell desktop processor
> that was launched about six years ago, in 2014).

Half a day.  I am not at all surprised, but it is good to know it can
take so little time.

Eric
