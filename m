Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCC3C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 15:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2579C207CB
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 15:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590334942;
	bh=q1uE5Wi2Dr01WADubfdzI24/w+rYlLhrW7QCYzTbk/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Vh0Xa/vVxDHRQfnXlUl6nao2Sr4TJ/UK6UobJlql2o5fL4gezGq6rNK+UQTwhUt79
	 kik1tf7gG8OtM6EtJCkn36H8mbkD5B85KMv7xAb8duS120VMqb5pT/pLE3FEpfTh7I
	 CSJLCvMM8+ac5bxlg6at5voIME1NEn7xIKpsrnMQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgEXPmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 11:42:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:40118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbgEXPmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 11:42:21 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27D4220787;
        Sun, 24 May 2020 15:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590334940;
        bh=q1uE5Wi2Dr01WADubfdzI24/w+rYlLhrW7QCYzTbk/M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sKngrQqV+ZytRfELVjBObcT926/Qo2PdOIm07DNwTVTbhlF4SNsz2x+0qQltGn1cG
         EtJjBsfqPdYnh8Vr2eFUqm8cK5WUJyh3aN3H+CHGPhCeKhjzJf1v6sSWepf1uKlHR5
         gZNxcIFQWSGTPnjQGRQeeqt+9l06EujmKodqsKi4=
Date:   Sun, 24 May 2020 11:42:19 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [GIT PULL] Driver core fixes for 5.7-rc7 - take 2
Message-ID: <20200524154219.GU33628@sasha-vm>
References: <20200523131759.GA55886@kroah.com>
 <20200523152922.GA224858@kroah.com>
 <CAHk-=wih_B_8a48Au=6B+gwFcYnM7qF02dGX3R0QN_2bzVcjVA@mail.gmail.com>
 <20200524150018.GB11262@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200524150018.GB11262@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 24, 2020 at 05:00:18PM +0200, Greg KH wrote:
>On Sat, May 23, 2020 at 11:14:28AM -0700, Linus Torvalds wrote:
>> On Sat, May 23, 2020 at 8:29 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>> >
>> > The kobject patch that was originally in here has now been reverted, as
>> > Guenter reported boot problems with it on some of his systems.
>>
>> Hmm. That original patch looks obviously buggy: in kobject_cleanup()
>> it would end up doing "kobject_put(parent)" regardless of whether it
>> had actually done __kobject_del() or not.
>>
>> That _could_ have been intentional, but considering the commit
>> message, it clearly wasn't in this case.  It might be worth re-trying
>> to the commit, just with that fixed.
>
>Turns out that wasn't the real problem here, the culprit is the
>lib/test_printf.c code trying to tear down a kobject tree from the
>parent down to the children (i.e. in the backwards order).
>
>> Btw, when you end up reverting a patch that was already the top patch,
>> you might as well just remove it entirely from that tree instead (ie
>> "git reset --hard HEAD^" instead of "git revert HEAD").
>>
>> Unless somebody else uses your branches and you are afraid that the
>> non-reverted commit escaped out in the wild that way?
>
>I don't like rebasing or changing the HEAD like that on a public branch.
>As proof, syzbot started sending me a bunch of "this is the failed
>commit" messages right after your email, based on it's testing of the
>tree in linux-next.

OTOH, leaving commits like this may result in confusion later on because
of confusion around the "correct" patch.

Consider this:

1. Someone writes a patch named "close memory leak when freeing XYZ"
2. We revert it a day later with 'Revert "close memory leak when
freeing XYZ"'
3. Now, what would the author of the original patch do? That's right -
re-submit a patch with an identical subject line and patch description,
but with a subtle change in the code to fix the bug the original patch
was reverted for.

So now we end up with two "close memory leak when freeing XYZ" commits
in our git history that are nearly identical. Recipe for a disaster :)

>What is really odd now, is that 'git log lib/kobject.c' does not show
>the change/revert at all.  Is that because there was a revert?  Or is it
>a git config option/default somewhere that prevents that from showing
>up?
>
>Odd, 'git blame lib/kobject.c' doesn't show it either.  Yet e6764aa0e553
>("Revert "kobject: Make sure the parent does not get released before its
>children"") is in your tree.  What am I missing here?

You need to use the '--follow' flag here:

$ git log -n3 --oneline --follow lib/kobject.c
e6764aa0e553 Revert "kobject: Make sure the parent does not get released before its children"
4ef12f719802 kobject: Make sure the parent does not get released before its children
122f8ec7b78e lib : kobject: fix refcount imblance on kobject_rename

$ git log -n3 --oneline lib/kobject.c
122f8ec7b78e lib : kobject: fix refcount imblance on kobject_rename
70e16a620e07 kobject: clean up the kobject add documentation a bit more
ed856349dc08 kobject: Fix kernel-doc comment first line

-- 
Thanks,
Sasha
