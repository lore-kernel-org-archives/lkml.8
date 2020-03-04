Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26258C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 05:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06C6620842
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 05:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgCDFZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 00:25:50 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:39158 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgCDFZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 00:25:50 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1j9MXV-0007tb-6m; Tue, 03 Mar 2020 22:25:49 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1j9MXU-0001BC-FT; Tue, 03 Mar 2020 22:25:49 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200223011154.GY23230@ZenIV.linux.org.uk>
        <20200301215125.GA873525@ZenIV.linux.org.uk>
        <CAHk-=wh1Q=H-YstHZRKfEw2McUBX2_TfTc=+5N-iH8DSGz44Qg@mail.gmail.com>
        <20200302003926.GM23230@ZenIV.linux.org.uk>
        <87o8tdgfu8.fsf@x220.int.ebiederm.org>
        <20200304002434.GO23230@ZenIV.linux.org.uk>
Date:   Tue, 03 Mar 2020 23:23:39 -0600
In-Reply-To: <20200304002434.GO23230@ZenIV.linux.org.uk> (Al Viro's message of
        "Wed, 4 Mar 2020 00:24:34 +0000")
Message-ID: <87wo80g0bo.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1j9MXU-0001BC-FT;;;mid=<87wo80g0bo.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/UTv8fSOWm0P3BimXgYvHzkz1l3lFMik8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC][PATCHSET] sanitized pathwalk machinery (v3)
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Tue, Mar 03, 2020 at 05:48:31PM -0600, Eric W. Biederman wrote:
>
>> > I hope it gets serious beating, though - it touches pretty much every
>> > codepath in pathname resolution.  Is there any way to sic the bots on
>> > a branch, short of "push it into -next and wait for screams"?
>> 
>> Last I looked pushing a branch to kernel.org was enough for the
>> kbuild bots.  Sending patches to LKML is also enough for those bots.
>> 
>> I don't know if that kind of bot is what you need testing your code.
>
> Build bots are generally nice, but in this case... pretty much all of
> the changes are in fs/namei.c, which is not all that sensitive to
> config/architecture/whatnot.  Sure, something like "is audit enabled?"
> may affect the build problems, but not much beyond that.
>
> What was that Intel-run(?) bot that posts "such-and-such metrics has
> 42% regression on such-and-such commit" from time to time?
> <checks>
> Subject: [locking/qspinlock] 7b6da71157: unixbench.score 8.4% improvement
> seems to be the latest of that sort,
> From: kernel test robot <rong.a.chen@intel.com>
>
> Not sure how much of pathwalk-heavy loads is covered by profiling
> bots of that sort, unfortunately... ;-/

Do the xfs-tests cover that sort of thing?
The emphasis is stress testing the filesystem not the VFS but there is a
lot of overlap between the two.

Eric

