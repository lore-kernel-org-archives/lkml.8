Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF292C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 22:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D22F02078A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 22:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgFLWvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 18:51:49 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:52884 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgFLWvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 18:51:48 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jjsWY-0001uC-Qj; Fri, 12 Jun 2020 16:51:46 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jjsWV-0001NB-VW; Fri, 12 Jun 2020 16:51:46 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
References: <875zc8kxyg.fsf@x220.int.ebiederm.org>
        <87zh9atx0x.fsf@x220.int.ebiederm.org>
        <871rmkozf5.fsf_-_@x220.int.ebiederm.org>
        <CAHk-=wh7nZNf81QPcgpDh-0jzt2sOF3rdUEB0UcZvYFHDiMNkw@mail.gmail.com>
        <87v9jwm4s7.fsf@x220.int.ebiederm.org>
        <CAHk-=whEMmvh=gAgo=Ae0zaJ06vfaYrKxa3jV+AgPBz450Rerw@mail.gmail.com>
Date:   Fri, 12 Jun 2020 17:47:34 -0500
In-Reply-To: <CAHk-=whEMmvh=gAgo=Ae0zaJ06vfaYrKxa3jV+AgPBz450Rerw@mail.gmail.com>
        (Linus Torvalds's message of "Fri, 12 Jun 2020 13:16:24 -0700")
Message-ID: <875zbvnbp5.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jjsWV-0001NB-VW;;;mid=<875zbvnbp5.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX194xhfvJgmnqqi/nJq0VfGodOeuQnQXedE=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [GIT PULL] proc fixes v2 for v5.8-rc1
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, Jun 12, 2020 at 1:06 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> I have a sense that a use after free that anyone can trigger could be a
>> bit dangerous, and despite not being the only virtual filesystem in the
>> kernel proc is the only virtual filesystem that called new_inode_pseudo.
>
> So the reason I pulled that change despite my questions was that I do
> agree with the whole "there's probably little point to use
> new_inode_pseudo() here" argument.
>
> But at the same time, I ghet the feeling that this partly just is
> papering over the problem. If fsnotify causes problems with a
> new_inode_pseudo() inode, then fsnotify should be _checking_ for that
> case.
>
> And if fsnotify were to check for it, then the reason for /proc to use
> it would largely go away. Maybe the debug check for umount matters,
> but honestly it doesn't really seem to be a big deal.
>
> A pseudo-inode is basically independent of the filesystem it was
> mounted as, so the generic_shutdown_super() check not triggering for
> them is sensible, I feel.
>
> But yeah, we could also make the rule go the other way, and simply
> make sure that "new_inode_pseudo()" itself checks that the super-block
> you give it is something fundamenally unmountable and was created with
> 'kern_mount()'.
>
> That would have also figured out that the /proc case was broken.
>
> So the main objection I have here is really that this fix feels
> incomplete, and doesn't really reflect the underlying issue, just
> fixes the symptom.
>
> Either the underlying issue is that you shouldn't call 'fsnotify' on
> /proc, or the underlying issue is that /proc was using a bad inode and
> nobody even noticed until the fsnotify issue.
>
> This is not a huge deal. I think you've fixed the bug, I just have
> this itch that the thing that triggered it shouldn't have happened in
> the first place.

Yeah.  I have a similar feeling.

Especially since it took about 7 years for someone to notice something
was not right.

Still right now I am not up to digging and adding warnings and causing
things to fail.  What energy I have I am going to use to keep sorting
out exec.  I am not ready to page back in the fine details of how all of
the filesystem pieces interact right now.

I am wondering now if there are any crazy corner cases of the unix
domain sockets where fsnotify could latch onto one, and have problems.
It looks like the inode comes from the underlying filesystem so we
should be safe.

Eric
