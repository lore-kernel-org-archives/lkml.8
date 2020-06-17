Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC04FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 18:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E28B2085B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 18:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592417169;
	bh=1KE2XXvZBw6ABjIUl6aRNNUR2Z7JBARQO8kTjeAHPuE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=YZ/6BEn+35JNCRFZLjyW3S47Uw+2ZHDdI/1RLyEgRLS+MKMNxN3w+fjVPS92tvjTm
	 0ueBxStNxM3Ffcm1vOcTCyg0mqR/Gj6jb8rD1yEja4aUPDvispLRMp6z0Nthm8oJDf
	 tyzydltFpisvNhJLym/wHkmFsFMRnik/3eWEZ4Ic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgFQSGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 14:06:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:33524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727044AbgFQSGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 14:06:07 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDEB320897;
        Wed, 17 Jun 2020 18:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592417166;
        bh=1KE2XXvZBw6ABjIUl6aRNNUR2Z7JBARQO8kTjeAHPuE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=unW1BDEecxeoXqgGlEIs/lOci+UozQYght2iIvY1GsBDa/48ncqbRzBOVGStpWR/4
         Kac+7VhLsg9gu50a26jpFTSSruSWrTE528zyusWhwyy3fAvjQ9tf+VdxuQqORvEiOt
         JiudZfIvO5XjoB9gHDoVqhHbVaGWQKN3H1zcBFPM=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 9D72D352353C; Wed, 17 Jun 2020 11:06:06 -0700 (PDT)
Date:   Wed, 17 Jun 2020 11:06:06 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-tip-commits@vger.kernel.org, x86 <x86@kernel.org>
Subject: Re: [PATCH] rcu/performance: Fix kfree_perf_init() build warning on
 32-bit kernels
Message-ID: <20200617180606.GA23728@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <158923078019.390.12609597570329519463.tip-bot2@tip-bot2>
 <20200526182744.GA3722128@gmail.com>
 <20200527011413.GD149611@google.com>
 <20200603181109.GA5438@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603181109.GA5438@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 11:11:09AM -0700, Paul E. McKenney wrote:
> On Tue, May 26, 2020 at 09:14:13PM -0400, Joel Fernandes wrote:
> > On Tue, May 26, 2020 at 08:27:44PM +0200, Ingo Molnar wrote:

[ . . . ]

> > > BTW., could we please also rename this code from 'PERF_TEST'/'perf test'
> > > to 'PERFORMANCE_TEST'/'performance test'? At first glance I always
> > > mistakenly believe that it's somehow related to perf, while it isn't. =B-)
> > 
> > Would it be better to call it 'RCUPERF_TEST' instead of the
> > 'RCU_PERFORMANCE_TEST' you are proposing? I feel the word 'PERFORMANCE' is
> > too long.  Also, 'rcuperf test' instead of the 'rcu performance test' you are
> > proposing.  I am Ok with doing it however you and Paul want it though, let me
> > know.
> 
> As long as we are bikeshedding the name...  How about refscale.c and
> RCU_REF_SCALE_TEST on the one hand and rcuscale.c and RCU_SCALE_TEST on
> the other?  That keeps the names reasonably short and does not allude
> to perf at all.

Hearing no objections, I will go with the scale/SCALE names.

						Thanx, Paul
