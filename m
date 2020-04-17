Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F182C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 18:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5579522201
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 18:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730462AbgDQSNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 14:13:18 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:49632 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730323AbgDQSNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 14:13:17 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jPVUJ-0004yd-Mc; Fri, 17 Apr 2020 12:13:15 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jPVUH-0000Xy-J7; Fri, 17 Apr 2020 12:13:15 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christoph Hellwig <hch@lst.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeremy Kerr <jk@ozlabs.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        x86@kernel.org
References: <20200414070142.288696-1-hch@lst.de>
        <20200414070142.288696-5-hch@lst.de>
        <CAK8P3a3HvbPKTkwfWr6PbZ96koO_NrJP1qgk8H1mgk=qUScGkQ@mail.gmail.com>
        <20200415074514.GA1393@lst.de>
        <CAK8P3a0QGQX85LaqKC1UuTERk6Bpr5TW6aWF+jxi2cOpa4L_AA@mail.gmail.com>
        <20200417132714.GA6401@lst.de>
Date:   Fri, 17 Apr 2020 13:10:12 -0500
In-Reply-To: <20200417132714.GA6401@lst.de> (Christoph Hellwig's message of
        "Fri, 17 Apr 2020 15:27:14 +0200")
Message-ID: <87o8rqc7az.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jPVUH-0000Xy-J7;;;mid=<87o8rqc7az.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18JO8/Ppng68LNpdE4K4Z5+2lJxR7m8FSs=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 4/8] binfmt_elf: open code copy_siginfo_to_user to kernelspace buffer
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:

> On Wed, Apr 15, 2020 at 10:20:11AM +0200, Arnd Bergmann wrote:
>> > I'd rather keep it out of this series and to
>> > an interested party.  Then again x32 doesn't seem to have a whole lot
>> > of interested parties..
>> 
>> Fine with me. It's on my mental list of things that we want to kill off
>> eventually as soon as the remaining users stop replying to questions
>> about it.
>> 
>> In fact I should really turn that into a properly maintained list in
>> Documentation/... that contains any options that someone has
>> asked about removing in the past, along with the reasons for keeping
>> it around and a time at which we should ask about it again.
>
> To the newly added x86 maintainers:  Arnd brought up the point that
> elf_core_dump writes the ABI siginfo format into the core dump. That
> format differs for i386 vs x32.  Is there any good way to find out
> which is the right format when are not in a syscall?
>
> As far a I can tell x32 vs i386 just seems to be based around what
> syscall table was used for the current syscall, but core dumps aren't
> always in syscall context.

I don't think this matters.  The i386 and x32 signal structures
only differ for SIGCHLD.  The SIGCHLD signal does cause coredumps.
So as long as we get the 32bit vs 64bit distinct correct all should be
well.

Eric



