Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B782C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 17:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B03E20757
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 17:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbgD1R6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 13:58:24 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:51462 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbgD1R6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 13:58:23 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jTUUw-0008S4-H8; Tue, 28 Apr 2020 11:58:22 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jTUUv-00068u-LG; Tue, 28 Apr 2020 11:58:22 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>
References: <20200419141057.621356-1-gladkov.alexey@gmail.com>
        <87ftcv1nqe.fsf@x220.int.ebiederm.org>
        <87wo66vvnm.fsf_-_@x220.int.ebiederm.org>
        <20200424173927.GB26802@redhat.com>
        <87mu6ymkea.fsf_-_@x220.int.ebiederm.org>
        <875zdmmj4y.fsf_-_@x220.int.ebiederm.org>
        <CAHk-=whvktUC9VbzWLDw71BHbV4ofkkuAYsrB5Rmxnhc-=kSeQ@mail.gmail.com>
        <878sihgfzh.fsf@x220.int.ebiederm.org>
        <CAHk-=wjSM9mgsDuX=ZTy2L+S7wGrxZMcBn054As_Jyv8FQvcvQ@mail.gmail.com>
        <87sggnajpv.fsf_-_@x220.int.ebiederm.org>
        <CAHk-=wiBYMoimvtc_DrwKN5EaQ98AmPryqYX6a-UE_VGP6LMrw@mail.gmail.com>
Date:   Tue, 28 Apr 2020 12:55:07 -0500
In-Reply-To: <CAHk-=wiBYMoimvtc_DrwKN5EaQ98AmPryqYX6a-UE_VGP6LMrw@mail.gmail.com>
        (Linus Torvalds's message of "Tue, 28 Apr 2020 09:53:22 -0700")
Message-ID: <87pnbr8phg.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jTUUv-00068u-LG;;;mid=<87pnbr8phg.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19/UlenhLPHsqhEZAfwxw9ynR2w+0kVTag=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v4 0/2] proc: Ensure we see the exit of each process tid exactly
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, Apr 28, 2020 at 5:20 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> In short I don't think this change will introduce any regressions.
>
> I think the series looks fine, but I also think the long explanation
> (that I snipped in this reply) in the cover letter should be there in
> the kernel tree.

When I have been adding patchsets like this to my tree I have been doing
merge --no-ff so I can create a place for explanations like this, and I
will do the same with this.

I already have Alexey Gladkov's proc changes, and my next_tgid cleanup
on a branch of proc changes in my tree already.

> So if you send me this as a single pull request, with that explanation
> (either in the email or in the signed tag - although you don't seem to
> use tags normally - so that we have that extra commentary for
> posterity, that sounds good.

I hope you don't mind if I combind this with some other proc changes.
If you do mind I will put this on a separate topic branch.

Right now it just seems easier for me to keep track of if I keep my
number of topics limited.

> That said, this fix seems to not matter for normal operation, so
> unless it's holding up something important, maybe it's 5.8 material?

Yes, this is 5.8 material.

I am just aiming to get review before I put in linux-next, and later
send it to your for merging.  I should have mentioned that in the cover
letter.

I am noticing that removing technical debt without adding more technical
debt is quite a challenge.

Eric


