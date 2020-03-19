Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A951C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 18:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84FF20789
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 18:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584640967;
	bh=3qQZm7XFaohE/NG7YNTIAooWKVQbxtldokkcEbHaF6M=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=r4a1LZM89TdusWXk5SUo/At81ncBQmf8B+qtZOhmGKemnHdXnfkrp6timIaAHn//3
	 FOQ+FNAGzE5f5anqIdRDSHmc3Jt4eQwH47Fbzovv7Y3CCQH8cB3X1Os1mkDGIOMONU
	 x6LA9BVbrsnWHnl4ryaRh4gAACEjJLroZE0iMZEM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbgCSSCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 14:02:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:48116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726892AbgCSSCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 14:02:46 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A3E72070A;
        Thu, 19 Mar 2020 18:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584640966;
        bh=3qQZm7XFaohE/NG7YNTIAooWKVQbxtldokkcEbHaF6M=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=vWx+iONKOhRdCeX7d5jcOwrLtM9q6Q/JlMmhvW+LAs/1UIBztpoxozL/BKd+ASvYH
         PJzyxW++NwlIxabGVqzK0z1ADhMx7PTTrba486HKMa0fYLTi6IwRNnnGGpDYHFxYnN
         e8ES+fM4pDtuW0jIceL9OapiALAtSd0x7QLGWE3w=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B4F7535226B9; Thu, 19 Mar 2020 11:02:45 -0700 (PDT)
Date:   Thu, 19 Mar 2020 11:02:45 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     dvyukov@google.com, glider@google.com, andreyknvl@google.com,
        cai@lca.pw, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kcsan: Introduce report access_info and other_info
Message-ID: <20200319180245.GA17119@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200318173845.220793-1-elver@google.com>
 <20200319152736.GF3199@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319152736.GF3199@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 08:27:36AM -0700, Paul E. McKenney wrote:
> On Wed, Mar 18, 2020 at 06:38:44PM +0100, Marco Elver wrote:
> > Improve readability by introducing access_info and other_info structs,
> > and in preparation of the following commit in this series replaces the
> > single instance of other_info with an array of size 1.
> > 
> > No functional change intended.
> > 
> > Signed-off-by: Marco Elver <elver@google.com>
> 
> Queued both for review and testing, and I am trying it out on one of
> the scenarios that proved problematic earlier on.  Thank you!!!

And all passed, so looking good!  ;-)

							Thanx, Paul
