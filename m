Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB97C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 21:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5C2B20716
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 21:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgA2VUD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 16:20:03 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:37942 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgA2VUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 16:20:02 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1iwuki-0007iu-Cc; Wed, 29 Jan 2020 14:20:00 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iwukg-0008Hi-II; Wed, 29 Jan 2020 14:20:00 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Sasha Levin <sashal@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Voegtle <tv@lio96.de>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, ronnie sahlberg <ronniesahlberg@gmail.com>,
        Christoph =?utf-8?Q?B=C3=B6?= =?utf-8?Q?hmwalder?= 
        <christoph.boehmwalder@linbit.com>,
        Steve French <smfrench@gmail.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        David Laight <David.Laight@aculab.com>
References: <20200128135852.449088278@linuxfoundation.org>
        <20200128135906.176803329@linuxfoundation.org>
        <alpine.LSU.2.21.2001291201030.14408@er-systems.de>
        <20200129113643.GB5277@kroah.com> <20200129191203.GA2896@sasha-vm>
Date:   Wed, 29 Jan 2020 15:18:18 -0600
In-Reply-To: <20200129191203.GA2896@sasha-vm> (Sasha Levin's message of "Wed,
        29 Jan 2020 14:12:03 -0500")
Message-ID: <87o8um0xnp.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1iwukg-0008Hi-II;;;mid=<87o8um0xnp.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18bLNmd2EtwKNWhj6tf4CYqtX5mGBaw4Ds=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 4.9 183/271] signal: Allow cifs and drbd to receive their terminating signals
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sasha Levin <sashal@kernel.org> writes:

> On Wed, Jan 29, 2020 at 12:36:43PM +0100, Greg Kroah-Hartman wrote:
>>On Wed, Jan 29, 2020 at 12:10:47PM +0100, Thomas Voegtle wrote:
>>> On Tue, 28 Jan 2020, Greg Kroah-Hartman wrote:
>>>
>>> > From: Eric W. Biederman <ebiederm@xmission.com>
>>> >
>>> > [ Upstream commit 33da8e7c814f77310250bb54a9db36a44c5de784 ]
>>> >
>>> > My recent to change to only use force_sig for a synchronous events
>>> > wound up breaking signal reception cifs and drbd.  I had overlooked
>>> > the fact that by default kthreads start out with all signals set to
>>> > SIG_IGN.  So a change I thought was safe turned out to have made it
>>> > impossible for those kernel thread to catch their signals.
>>> >
>>> > Reverting the work on force_sig is a bad idea because what the code
>>> > was doing was very much a misuse of force_sig.  As the way force_sig
>>> > ultimately allowed the signal to happen was to change the signal
>>> > handler to SIG_DFL.  Which after the first signal will allow userspace
>>> > to send signals to these kernel threads.  At least for
>>> > wake_ack_receiver in drbd that does not appear actively wrong.
>>> >
>>> > So correct this problem by adding allow_kernel_signal that will allow
>>> > signals whose siginfo reports they were sent by the kernel through,
>>> > but will not allow userspace generated signals, and update cifs and
>>> > drbd to call allow_kernel_signal in an appropriate place so that their
>>> > thread can receive this signal.
>>> >
>>> > Fixing things this way ensures that userspace won't be able to send
>>> > signals and cause problems, that it is clear which signals the
>>> > threads are expecting to receive, and it guarantees that nothing
>>> > else in the system will be affected.
>>> >
>>> > This change was partly inspired by similar cifs and drbd patches that
>>> > added allow_signal.
>>> >
>>> > Reported-by: ronnie sahlberg <ronniesahlberg@gmail.com>
>>> > Reported-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
>>> > Tested-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
>>> > Cc: Steve French <smfrench@gmail.com>
>>> > Cc: Philipp Reisner <philipp.reisner@linbit.com>
>>> > Cc: David Laight <David.Laight@ACULAB.COM>
>>> > Fixes: 247bc9470b1e ("cifs: fix rmmod regression in cifs.ko caused by force_sig changes")
>>> > Fixes: 72abe3bcf091 ("signal/cifs: Fix cifs_put_tcp_session to call send_sig instead of force_sig")
>>>
>>> These two commits come with that release, but...
>>>
>>> > Fixes: fee109901f39 ("signal/drbd: Use send_sig not force_sig")
>>> > Fixes: 3cf5d076fb4d ("signal: Remove task parameter from force_sig")
>>>
>>> ...these two commits not and were never added to 4.9.y.
>>>
>>> Are these both really not needed?
>>
>>I don't think so, do you feel otherwise?
>
> Both of those commits read as a cleanup to me. I've actually slightly
> modified to patch to not need those commits (they were less than trivial
> to backport as is).

All of these changes were cleanup.  Which is why I didn't tag any of
them for stable.

Not to say that there weren't real problems using force_sig instead
of send_sig.  force_sig does nothing to ensure the task it is sending
signals to won't, and hasn't gone away.  Which is why it is a bad
idea to use force_sig on anything but current.  As I recall drbd used
force_sig on a kernel_thread which didn't go away.

When fixing the force_sig vs send_sig confusion I didn't realize that
some places were using force_sig because they had not enabled receiving
the signals they depended on.  Which is where allow_kernel_signal comes
from.  But while using force_sig allow_kernel_signal is not necessary.

Eric

