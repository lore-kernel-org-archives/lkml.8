Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F32C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 13:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F2A020728
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 13:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589463211;
	bh=fCSUwMf7Ao1rkoQxej32piTB4hAp14IcBswN1PhYQ8E=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=SX8YPX6t72EY9Uc71r9WleR+o3rOoHJ18Y3A2+7rxRm9LIE0aimVtFYagCP1wCUYR
	 fzak7ddr8F2Mown/Q70HKN+WXx8BVbY8qrrMZLVOee2GYb2l9ru4GvOTEGPwE9l3oJ
	 68+FjcyKhw4anj8b+FWeUOiFMDcNCfM6ZDdpf8o4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgENNda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 09:33:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:39028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbgENNd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 09:33:29 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFEF02065D;
        Thu, 14 May 2020 13:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589463208;
        bh=fCSUwMf7Ao1rkoQxej32piTB4hAp14IcBswN1PhYQ8E=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ay0oyqYKLgSp6hVXVo2r22o8XMbY1zIy/VJmtbHr5lrHw5qWwzVZsmlaKMEQc8N0N
         26+LBgiiUECDRJuopBcT2loxPskxHPTZ8pcfKiZOHAOKnXDpHTs+xcWmx+GzJNLxFK
         DrYI7/LeRUGKWZmMqwEP8i96/sB+msaTyI9BbpQA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 4E69035206A2; Thu, 14 May 2020 06:33:28 -0700 (PDT)
Date:   Thu, 14 May 2020 06:33:28 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Amol Grover <frextrite@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: Default enable RCU list lockdep debugging with PROVE_RCU
Message-ID: <20200514133328.GG2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200514222535.259cb69e@canb.auug.org.au>
 <ADC503BE-32C0-46BB-A65E-59FFEC30ED57@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ADC503BE-32C0-46BB-A65E-59FFEC30ED57@lca.pw>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 08:31:13AM -0400, Qian Cai wrote:
> 
> 
> > On May 14, 2020, at 8:25 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > 
> > Hi Paul,
> > 
> > This patch in the rcu tree
> > 
> >  d13fee049fa8 ("Default enable RCU list lockdep debugging with PROVE_RCU")
> > 
> > is causing whack-a-mole in the syzbot testing of linux-next.  Because
> > they always do a debug build of linux-next, no testing is getting done. :-(
> > 
> > Can we find another way to find all the bugs that are being discovered
> > (very slowly)?
> 
> Alternatively, could syzbot to use PROVE_RCU=n temporarily because it can’t keep up with it? I personally found PROVE_RCU_LIST=y is still useful for my linux-next testing, and don’t want to lose that coverage overnight.

The problem is that PROVE_RCU is exactly PROVE_LOCKING, and asking people
to test without PROVE_LOCKING is a no-go in my opinion.  But of course
on the other hand if there is no testing of RCU list lockdep debugging,
those issues will never be found, let alone fixed.

One approach would be to do as Stephen asks (either remove d13fee049fa8
or pull it out of -next) and have testers force-enable the RCU list
lockdep debugging.

Would that work for you?

							Thanx, Paul
