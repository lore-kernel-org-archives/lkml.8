Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EA5C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 21:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82FF520842
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 21:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387926AbgCDVAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 16:00:38 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:34736 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgCDVAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 16:00:38 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9b83-005NzE-Dj; Wed, 04 Mar 2020 21:00:31 +0000
Date:   Wed, 4 Mar 2020 21:00:31 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCHSET] sanitized pathwalk machinery (v3)
Message-ID: <20200304210031.GT23230@ZenIV.linux.org.uk>
References: <20200223011154.GY23230@ZenIV.linux.org.uk>
 <20200301215125.GA873525@ZenIV.linux.org.uk>
 <CAHk-=wh1Q=H-YstHZRKfEw2McUBX2_TfTc=+5N-iH8DSGz44Qg@mail.gmail.com>
 <20200302003926.GM23230@ZenIV.linux.org.uk>
 <87o8tdgfu8.fsf@x220.int.ebiederm.org>
 <20200304002434.GO23230@ZenIV.linux.org.uk>
 <87wo80g0bo.fsf@x220.int.ebiederm.org>
 <20200304065547.GP23230@ZenIV.linux.org.uk>
 <20200304105946.4xseo3jokcnpptrj@yavin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304105946.4xseo3jokcnpptrj@yavin>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 09:59:46PM +1100, Aleksa Sarai wrote:

> > FWIW, I'm putting together some litmus tests for pathwalk semantics -
> > one of the things I'd like to discuss at LSF; quite a few codepaths
> > are simply not touched by anything in xfstests.
> 
> I won't be at LSF unfortunately, but this is something I would be very
> interested in helping with -- one of the things I've noticed is the lack
> of a test-suite for some of the more generic VFS bits (such as namei).

BTW, has anyone tried to run tests with oprofile and see how much of the
core kernel gets exercised?  That looks like an obvious thing to try -
at least the places outside of spin_lock_irq() ought to get lit after
a while...

Have any CI folks tried doing that, or am I missing some obvious reason
why that is not feasible?
