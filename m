Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABBCC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37CC52073A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgH0QUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 12:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbgH0QUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 12:20:40 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8F7C061264;
        Thu, 27 Aug 2020 09:20:40 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 1001)
        id CB8B4C01B; Thu, 27 Aug 2020 18:20:38 +0200 (CEST)
Date:   Thu, 27 Aug 2020 18:20:23 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     syzbot <syzbot+fbe34b643e462f65e542@syzkaller.appspotmail.com>,
        alsa-devel@alsa-project.org, daniel.baluta@nxp.com,
        davem@davemloft.net, ericvh@gmail.com, kuba@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        lucho@ionkov.net, netdev@vger.kernel.org, perex@perex.cz,
        rminnich@sandia.gov, syzkaller-bugs@googlegroups.com,
        tiwai@suse.com, v9fs-developer@lists.sourceforge.net
Subject: Re: INFO: task can't die in p9_fd_close
Message-ID: <20200827162023.GD31016@nautica>
References: <000000000000ca0c6805adc56a38@google.com>
 <20200826104919.GE4965@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200826104919.GE4965@sirena.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Brown wrote on Wed, Aug 26, 2020:
> On Wed, Aug 26, 2020 at 03:38:15AM -0700, syzbot wrote:
> 
> > console output: https://syzkaller.appspot.com/x/log.txt?x=10615b36900000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=a61d44f28687f508
> > dashboard link: https://syzkaller.appspot.com/bug?extid=fbe34b643e462f65e542
> > compiler:       gcc (GCC) 10.1.0-syz 20200507
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15920a05900000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13a78539900000
> > 
> > The issue was bisected to:
> > 
> > commit af3acca3e35c01920fe476f730dca7345d0a48df
> > Author: Daniel Baluta <daniel.baluta@nxp.com>
> > Date:   Tue Feb 20 12:53:10 2018 +0000
> > 
> >     ASoC: ak5558: Fix style for SPDX identifier
> 
> This bisection is clearly not accurate, I'm guessing the bug is
> intermittent and it was just luck that landed it on this commit.

It's a bug that's been present since day 1 pretty much.

I have a fix that had been overcooking for a while which I had planned
to take in this cycle -- I'll submit to -next during next week, so
hopefully syzbot will be able to spend its time more usefully after
that.

-- 
Dominique
