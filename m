Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EDBC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 17:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB78207FC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 17:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584640322;
	bh=SHOS3GFFaivbdQvbvmQXUdj/9i/JrMdJcqQ6ZMWKEho=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=WH1eK1H0oVHXmKgBoaKGtoSGxp3Bq1nJeuM9Sg8+d36BmOBWJQ5aV4IFZFP5IG5vP
	 rPyl008prPK6+/iVlVOBOsULf9LyoLjQehtMzJVmPst+4nWMGU4Tv5dSX1rQyJBRPL
	 KiQD9M6zXflorllDCJZ5xFwDHCzi4Ojgak6nVjrA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbgCSRwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 13:52:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:43400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726867AbgCSRwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 13:52:01 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05B472072D;
        Thu, 19 Mar 2020 17:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584640320;
        bh=SHOS3GFFaivbdQvbvmQXUdj/9i/JrMdJcqQ6ZMWKEho=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=0UvT1D4ScmuQ+iPUH1ekz62MC/eDbQ313IF3jXMNP8ltAcOv3zQmRkCQDmZogKOMo
         U1fOhLXTtnhdqjhTW0e/JrCp5+s3/2zJzrYnpkHyDGK+LXc573BOo0TDhJom9BYcEh
         mt3rRs9KzVaG0GBlyxxzqcXQYFtC1iU9tb9WSQ8Q=
Message-ID: <5d7b448858d5a5c01e97aceb45dcadff24d6fc28.camel@kernel.org>
Subject: Re: [locks] 6d390e4b5d: will-it-scale.per_process_ops -96.6%
 regression
From:   Jeff Layton <jlayton@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     NeilBrown <neilb@suse.de>, yangerkun <yangerkun@huawei.com>,
        kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Date:   Thu, 19 Mar 2020 13:51:59 -0400
In-Reply-To: <CAHk-=whnqDS0NJtAaArVeYQz3hcU=4Ja3auB1Jvs42eADfUgMQ@mail.gmail.com>
References: <20200308140314.GQ5972@shao2-debian>
         <1bfba96b4bf0d3ca9a18a2bced3ef3a2a7b44dad.camel@kernel.org>
         <87blp5urwq.fsf@notabene.neil.brown.name>
         <41c83d34ae4c166f48e7969b2b71e43a0f69028d.camel@kernel.org>
         <ed73fb5d-ddd5-fefd-67ae-2d786e68544a@huawei.com>
         <923487db2c9396c79f8e8dd4f846b2b1762635c8.camel@kernel.org>
         <36c58a6d07b67aac751fca27a4938dc1759d9267.camel@kernel.org>
         <878sk7vs8q.fsf@notabene.neil.brown.name>
         <c4ef31a663fbf7a3de349696e9f00f2f5c4ec89a.camel@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-03-16 at 10:26 -0700, Linus Torvalds wrote:
> On Mon, Mar 16, 2020 at 4:07 AM Jeff Layton <jlayton@kernel.org> wrote:
> > 
> > +       /*
> > +        * If fl_blocker is NULL, it won't be set again as this thread "owns"
> > +        * the lock and is the only one that might try to claim the lock.
> > +        * Because fl_blocker is explicitly set last during a delete, it's
> > +        * safe to locklessly test to see if it's NULL. If it is, then we know
> > +        * that no new locks can be inserted into its fl_blocked_requests list,
> > +        * and we can therefore avoid doing anything further as long as that
> > +        * list is empty.
> > +        */
> > +       if (!smp_load_acquire(&waiter->fl_blocker) &&
> > +           list_empty(&waiter->fl_blocked_requests))
> > +               return status;
> 
> Ack. This looks sane to me now.
> 
> yangerkun - how did you find the original problem?
> 
> Would you mind using whatever stress test that caused commit
> 6d390e4b5d48 ("locks: fix a potential use-after-free problem when
> wakeup a waiter") with this patch? And if you did it analytically,
> you're a champ and should look at this patch too!
> 

Thanks for all the help with this.

Yangerkun gave me his Reviewed-by and I sent you the most recent version
of the patch yesterday (cc'ing the relevant mailing lists). I left you
as author as the original patch was yours.

Let me know if you'd prefer I send a pull request instead.

Cheers,
-- 
Jeff Layton <jlayton@kernel.org>

