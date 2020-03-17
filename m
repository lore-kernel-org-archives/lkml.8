Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DD7C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 16:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2291420735
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 16:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584461240;
	bh=C3nxCVtOojJI1EE4i/01qvjqY8WR/WwWo9EvGceJqnI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=tlY1oC4KIVFPZDw+EYG6y3akh9/7eqPLE9QDKAutv8fkiug820KfAmfFifIpfgAk6
	 iPL90f8gDiOzwzwfxStFOLdbAItIe3cPDa4jbLKVkATLwUgHKFt1gFVTfc5tWiHMGk
	 D31dZ2TYGjaFZaYMP0smDG4UpuBC3Jv6/7gjyBEI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgCQQHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 12:07:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbgCQQHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 12:07:18 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99C0F20724;
        Tue, 17 Mar 2020 16:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584461237;
        bh=C3nxCVtOojJI1EE4i/01qvjqY8WR/WwWo9EvGceJqnI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=t/XMMiB9rQREmqVkw/QrW6v3HXkY9doFIrtVESl/NbmeLU7cdm8nwvzgvml0lTsbX
         3WAV8yKh2nVv1w28jzMqwj65b7yXkSmc/474gx6Eq6Ak3QKNQWH9l2LfQxwXDuNSoX
         d/0BWBoWrgITzbPO6hh2HTHUs9ASUSmAItXmRe4g=
Message-ID: <61d6b91e9387969f5dfaba192aee366cc9b310f0.camel@kernel.org>
Subject: Re: [locks] 6d390e4b5d: will-it-scale.per_process_ops -96.6%
 regression
From:   Jeff Layton <jlayton@kernel.org>
To:     yangerkun <yangerkun@huawei.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     NeilBrown <neilb@suse.de>,
        kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Date:   Tue, 17 Mar 2020 12:07:15 -0400
In-Reply-To: <6df79609-90eb-2f59-7e86-3532ac309a7a@huawei.com>
References: <20200308140314.GQ5972@shao2-debian>
         <875zfbvrbm.fsf@notabene.neil.brown.name>
         <CAHk-=wg8N4fDRC3M21QJokoU+TQrdnv7HqoaFW-Z-ZT8z_Bi7Q@mail.gmail.com>
         <0066a9f150a55c13fcc750f6e657deae4ebdef97.camel@kernel.org>
         <CAHk-=whUgeZGcs5YAfZa07BYKNDCNO=xr4wT6JLATJTpX0bjGg@mail.gmail.com>
         <87v9nattul.fsf@notabene.neil.brown.name>
         <CAHk-=wiNoAk8v3GrbK3=q6KRBrhLrTafTmWmAo6-up6Ce9fp6A@mail.gmail.com>
         <87o8t2tc9s.fsf@notabene.neil.brown.name>
         <CAHk-=wj5jOYxjZSUNu_jdJ0zafRS66wcD-4H0vpQS=a14rS8jw@mail.gmail.com>
         <f000e352d9e103b3ade3506aac225920420d2323.camel@kernel.org>
         <877dznu0pk.fsf@notabene.neil.brown.name>
         <CAHk-=whYQqtW6B7oPmPr9-PXwyqUneF4sSFE+o3=7QcENstE-g@mail.gmail.com>
         <b5a1bb4c4494a370f915af479bcdf8b3b351eb6d.camel@kernel.org>
         <87pndcsxc6.fsf@notabene.neil.brown.name>
         <ce48ed9e48eda3c0f27d2f417314bd00cb1a68db.camel@kernel.org>
         <CAHk-=whnqDS0NJtAaArVeYQz3hcU=4Ja3auB1Jvs42eADfUgMQ@mail.gmail.com>
         <7c8d3752-6573-ab83-d0af-f3dd4fc373f5@huawei.com>
         <6df79609-90eb-2f59-7e86-3532ac309a7a@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-03-17 at 22:05 +0800, yangerkun wrote:
> 
> On 2020/3/17 9:41, yangerkun wrote:
> > 
> > On 2020/3/17 1:26, Linus Torvalds wrote:
> > > On Mon, Mar 16, 2020 at 4:07 AM Jeff Layton <jlayton@kernel.org> wrote:
> > > > 
> > > > +       /*
> > > > +        * If fl_blocker is NULL, it won't be set again as this 
> > > > thread "owns"
> > > > +        * the lock and is the only one that might try to claim the 
> > > > lock.
> > > > +        * Because fl_blocker is explicitly set last during a delete, 
> > > > it's
> > > > +        * safe to locklessly test to see if it's NULL. If it is, 
> > > > then we know
> > > > +        * that no new locks can be inserted into its 
> > > > fl_blocked_requests list,
> > > > +        * and we can therefore avoid doing anything further as long 
> > > > as that
> > > > +        * list is empty.
> > > > +        */
> > > > +       if (!smp_load_acquire(&waiter->fl_blocker) &&
> > > > +           list_empty(&waiter->fl_blocked_requests))
> > > > +               return status;
> > > 
> > > Ack. This looks sane to me now.
> > > 
> > > yangerkun - how did you find the original problem?\
> > 
> > While try to fix CVE-2019-19769, add some log in __locks_wake_up_blocks 
> > help me to rebuild the problem soon. This help me to discern the problem 
> > soon.
> > 
> > > Would you mind using whatever stress test that caused commit
> > > 6d390e4b5d48 ("locks: fix a potential use-after-free problem when
> > > wakeup a waiter") with this patch? And if you did it analytically,
> > > you're a champ and should look at this patch too!
> > 
> > I will try to understand this patch, and if it's looks good to me, will 
> > do the performance test!
> 
> This patch looks good to me, with this patch, the bug '6d390e4b5d48 
> ("locks: fix a potential use-after-free problem when wakeup a waiter")' 
> describes won't happen again. Actually, I find that syzkaller has report 
> this bug before[1], and the log of it can help us to reproduce it with 
> some latency in __locks_wake_up_blocks!
> 
> Also, some ltp testcases describes in [2] pass too with the patch!
> 
> For performance test, I have try to understand will-it-scale/lkp, but it 
> seem a little complex to me, and may need some more time. So, Rong Chen, 
> can you help to do this? Or the results may come a little later...
> 
> Thanks,
> ----
> [1] https://syzkaller.appspot.com/bug?extid=922689db06e57b69c240
> [2] https://lkml.org/lkml/2020/3/11/578

Thanks yangerkun. Let me know if you want to add your Reviewed-by tag.

Cheers,
-- 
Jeff Layton <jlayton@kernel.org>

