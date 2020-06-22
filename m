Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9E5C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 16:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF8362073E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 16:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbgFVQYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 12:24:35 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:59208 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729479AbgFVQYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 12:24:34 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jnPFJ-0001B5-RR; Mon, 22 Jun 2020 10:24:33 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jnPFI-00036S-V4; Mon, 22 Jun 2020 10:24:33 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>
References: <87pn9u6h8c.fsf@x220.int.ebiederm.org>
        <87k1026h4x.fsf@x220.int.ebiederm.org>
        <CAHk-=wgczNRMP-DK3Ga-e_HXvZMBbQNxthdGt=MqMZ0CFDHHcg@mail.gmail.com>
Date:   Mon, 22 Jun 2020 11:20:11 -0500
In-Reply-To: <CAHk-=wgczNRMP-DK3Ga-e_HXvZMBbQNxthdGt=MqMZ0CFDHHcg@mail.gmail.com>
        (Linus Torvalds's message of "Sat, 20 Jun 2020 11:58:13 -0700")
Message-ID: <87eeq7xebo.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jnPFI-00036S-V4;;;mid=<87eeq7xebo.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+6wsbR3bkAf75/oFgf7QvXKVQ+hcFeirM=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 1/2] exec: Don't set group_exit_task during a coredump
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, Jun 19, 2020 at 11:36 AM Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>>
>> Instead test SIGNAL_GROUP_COREDUMP in signal_group_exit().
>
> You say "instead", but the patch itself doesn't agree:
>
>>  static inline int signal_group_exit(const struct signal_struct *sig)
>>  {
>> -       return  (sig->flags & SIGNAL_GROUP_EXIT) ||
>> +       return  (sig->flags & (SIGNAL_GROUP_EXIT | SIGNAL_GROUP_COREDUMP)) ||
>>                 (sig->group_exit_task != NULL);
>>  }
>
> it does it _in_addition_to_.

Hmm.  I think I can change that line to:
>> Instead add a test for SIGNAL_GROUP_COREDUMP in signal_group_exit().

Does that read better?

> I think the whole test for "sig->group_exit_task != NULL" should be
> removed for this commit to make sense.

The code change is designed not to have a behavioral change in
signal_group_exit().  As de_thread also sets sig->group_exit_task
the test for sig->group_exit_task needs to remain in signal_group_exit()
for the behavior of signal_group_exit() to remain unchanged.



Why do you think the test sig->group_exit_task != NULL should be removed
for the commit to make sense?

Eric
