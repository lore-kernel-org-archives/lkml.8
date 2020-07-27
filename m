Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D52BC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 10:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50D222070B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 10:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgG0Kwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 06:52:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:45466 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbgG0Kwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 06:52:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EEA79B632;
        Mon, 27 Jul 2020 10:52:52 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8DCE01E12C5; Mon, 27 Jul 2020 12:52:42 +0200 (CEST)
Date:   Mon, 27 Jul 2020 12:52:42 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Rong Chen <rong.a.chen@intel.com>, Jan Kara <jack@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [fsnotify] c738fbabb0: will-it-scale.per_process_ops -9.5%
 regression
Message-ID: <20200727105242.GK23179@quack2.suse.cz>
References: <20200721001505.GD19262@shao2-debian>
 <CAOQ4uxgq39EDS_k3eDTngEAm8cxHPa7qrkUSW8Rk6qS9cxC18w@mail.gmail.com>
 <9a2a4086-fbad-b4f8-9c00-2b7606441022@intel.com>
 <CAOQ4uxgHf_4GQzQGGRTxTECMvEeNjoqhsbGOm5T3GRpV+=0YzA@mail.gmail.com>
 <CAOQ4uxiXiSAaK92pvGDGUCd2hYq=J-7FxJYdUp=KSXncivwJZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiXiSAaK92pvGDGUCd2hYq=J-7FxJYdUp=KSXncivwJZw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 26-07-20 14:52:47, Amir Goldstein wrote:
> On Fri, Jul 24, 2020 at 6:47 AM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Fri, Jul 24, 2020 at 5:45 AM Rong Chen <rong.a.chen@intel.com> wrote:
> > >
> > >
> > >
> > > On 7/21/20 11:59 PM, Amir Goldstein wrote:
> > > > On Tue, Jul 21, 2020 at 3:15 AM kernel test robot <rong.a.chen@intel.com> wrote:
> > > >> Greeting,
> > > >>
> > > >> FYI, we noticed a -9.5% regression of will-it-scale.per_process_ops due to commit:
> > > >>
> > > >>
> > > >> commit: c738fbabb0ff62d0f9a9572e56e65d05a1b34c6a ("fsnotify: fold fsnotify() call into fsnotify_parent()")
> > > > Strange, that's a pretty dumb patch moving some inlined code from one
> > > > function to
> > > > another (assuming there are no fsnotify marks in this test).
> > > >
> > > > Unless I am missing something the only thing that changes slightly is
> > > > an extra d_inode(file->f_path.dentry) deference.
> > > > I can get rid of it.
> > > >
> > > > Is it possible to ask for a re-test with fix patch (attached)?
> > >
> > > Hi Amir,
> > >
> > > We failed to apply this patch, could you tell us the base commit or the
> > > base branch?
> > >
> >
> > Hi Rong,
> >
> > The patch is applied on top of the reported offending commit:
> > c738fbabb0ff62d0f9a9572e56e65d05a1b34c6a ("fsnotify: fold fsnotify()
> > call into fsnotify_parent()")
> >
> > I pushed it to my github:
> > https://github.com/amir73il/linux/commits/for_lkp
> >
> 
> FWIW, I tried reproducing the reported regression on a local machine.
> 
> I ran the test twice on each of the branch commits:
> 
> 26dc3d2bff62 fsnotify: pass inode to fsnotify_parent()
> c738fbabb0ff fsnotify: fold fsnotify() call into fsnotify_parent()
> 71d734103edf fsnotify: Rearrange fast path to minimise overhead when
> there is no watcher
> 47aaabdedf36 fanotify: Avoid softlockups when reading many events
> 
> Not only did I not observe a regression with the reported commit,
> but there was a slight improvement. And then there yet was another
> improvement with the fix commit on top of it.

I suspect this may be closely related to code generation, code cacheline
alignment etc. and thus depends heavily on a particular compiler version
and CPU. I've checked the commit myself and I agree it looks innocent so
for these reasons, I'm not particularly worried about this regression.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
