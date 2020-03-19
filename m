Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BE0C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 20:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78DD52071C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 20:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584648616;
	bh=6D5hT7+jLr3Iy3UiMAn9XDDirUwO522VhjHqnbQXtdo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=sWMTgy3exdbNexV8/G0Ft1HZXwBxJTh0rxSodigzRt3hVbqunH15i1u8BB+SG4a6t
	 jiia5wdCycJ87PfV64x+NxogcInEfeO9Vrv2xzmooPzuB705XYclCfgSbLztWv96z9
	 vdOaiV7YaLYT76W6EeyH/1uAtyWNsKSatS7vB51Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgCSUKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 16:10:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:39876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbgCSUKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 16:10:15 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97223206D7;
        Thu, 19 Mar 2020 20:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584648614;
        bh=6D5hT7+jLr3Iy3UiMAn9XDDirUwO522VhjHqnbQXtdo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=r4DkOONnnYwfpWtDADd+3vX6IJtWgIxuOAOHnmUPnUkJ5ww9CxX3liEfSs0zlcqQZ
         VVfBelLWhUuWH7s9X5bKh3OjaJxUkev1dzOZgwYkbcuqe9lSvgpp/XapJtzUJV/Uvb
         g0tCkCoFTEJWwTgeNfParlBlsYhEb8Bseb1cF94w=
Message-ID: <815c83462125f350b61163f682fb674e515e954e.camel@kernel.org>
Subject: Re: [locks] 6d390e4b5d: will-it-scale.per_process_ops -96.6%
 regression
From:   Jeff Layton <jlayton@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     NeilBrown <neilb@suse.de>, yangerkun <yangerkun@huawei.com>,
        kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Date:   Thu, 19 Mar 2020 16:10:12 -0400
In-Reply-To: <CAHk-=whAWFw5vZB-krqUteHuAYCYypKG6683WEydOynBizpixQ@mail.gmail.com>
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
         <5d7b448858d5a5c01e97aceb45dcadff24d6fc28.camel@kernel.org>
         <CAHk-=wj=UEVBObnZNtSnvX_9afJ3XHBSuXACPbriCBkCUGTHmA@mail.gmail.com>
         <7c10010c3d7745857ee1fba8eb06e7fe047eaa13.camel@kernel.org>
         <CAHk-=whAWFw5vZB-krqUteHuAYCYypKG6683WEydOynBizpixQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-03-19 at 12:35 -0700, Linus Torvalds wrote:
> On Thu, Mar 19, 2020 at 12:24 PM Jeff Layton <jlayton@kernel.org> wrote:
> > > If you have other things, send me a pull request, otherwise just let
> > > me know and I'll apply the patch directly.
> > 
> > That's it for now.
> 
> Lol. You confused me with your question of whether I wanted a pull
> request or not.
> 
> I had already applied the patch as dcf23ac3e846 ("locks: reinstate
> locks_delete_block optimization") yesterday ;)
> 

Sorry about that! I did a pull this morning and didn't see it, you must
have pushed afterward. Thanks again for picking it up.

-- 
Jeff Layton <jlayton@kernel.org>

