Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C30C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 13:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E5D32065C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 13:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgHDNZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 09:25:35 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:42162 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728450AbgHDNZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 09:25:13 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k2wwE-009rlJ-T2; Tue, 04 Aug 2020 07:25:06 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k2wwD-0004MA-R9; Tue, 04 Aug 2020 07:25:06 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, adobriyan@gmail.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org
References: <159644958332.604812.13004003379291842292.stgit@localhost.localdomain>
        <20200804115649.kzea757e5wwpk4k3@wittgenstein>
        <87d046sj8w.fsf@x220.int.ebiederm.org>
        <20200804123036.2lnkm6it7ko7j3ju@wittgenstein>
Date:   Tue, 04 Aug 2020 08:21:51 -0500
In-Reply-To: <20200804123036.2lnkm6it7ko7j3ju@wittgenstein> (Christian
        Brauner's message of "Tue, 4 Aug 2020 14:30:36 +0200")
Message-ID: <87r1smpmvk.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1k2wwD-0004MA-R9;;;mid=<87r1smpmvk.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19ppTB73/xotCa7yBDyd4M6ra+WwgCk7ws=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 0/8] namespaces: Introduce generic refcount
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Brauner <christian.brauner@ubuntu.com> writes:

> On Tue, Aug 04, 2020 at 07:11:59AM -0500, Eric W. Biederman wrote:
>> Christian Brauner <christian.brauner@ubuntu.com> writes:
>> 
>> > On Mon, Aug 03, 2020 at 01:16:10PM +0300, Kirill Tkhai wrote:
>> >> Every namespace type has its own counter. Some of them are
>> >> of refcount_t, some of them are of kref.
>> >> 
>> >> This patchset introduces generic ns_common::count for any
>> >> type of namespaces instead of them.
>> >> 
>> >> ---
>> >
>> > I was wondering why that series never made it to me turns out there's
>> > some weird bug in my (neo)mutt where it sometimes marks messages as read
>> > when I'm deleting completely unrelated messages. That has already cost
>> > me a talk slot for an event I really wanted to attend and now it seems
>> > to start costing me patches... I need to figure this out.
>> >
>> > Anyway, thanks for sending this. I pulled this into my tree now.
>> 
>> Actually why in the world should the reference count be generic?
>> 
>> What is the point of this patchset?
>> 
>> What problem does it solve.  Name spaces are not the same, and
>> their refcounting needs are not the same so I don't have a clue how it
>> helps anything to have a reference count in ns_common.
>
> What is the point of this opposition to this cleanup?
>
> It unifies reference counting across namespaces and gets rid of
> inconsistencices. Over the years none of the namespaces seem to have
> deviated enough from each that they really have needed separate
> reference counting mechanisms.

First this posting is the first I have seen of it, unless it was a
subset of the weird /proc/namespaces/ patchset that has design problems.
In which case I never got this far.

Second I don't see a motivation for this.  The only point to place a
reference count in ns_common is if it makes something easier.  What
does it make easier and what does it make harder?

For a pure cleanup the questions are what are the trade offs.
There are potential performance differences between refcount_t and
kfref.

From a practical matter it makes absolutely no sense in the least to
talk about the reference count, when some of the namespaces have more
than one reference count, with difference semantics and they interrelate
in somewhat subtle ways.

Further depending on what is happening sharing code that does not
have a fundamental reason to be shared, can make maintenance more
difficult as the entire generic infrastructure will need to be updated
instead of just that the part that focuses on the one thing.

So I am opposed because the patchset does not explain at all why it
makes sense to do, nor what tradeoffs were considered, nor what
testing was done.

This change is not as trivial as a spelling change so it is not ok to
say it is just a cleanup and move on.  A change in the reference
counting can be noticable.  This needs at least to be acknowledged in
the change log and at a minimum a hand wavy reason put forth why it is
ok.


Instead what I am seeing as justification is this is a trivial cleanup
and no one will notice or care.   And it is not that trivial so I
object to the patchset.

Eric
