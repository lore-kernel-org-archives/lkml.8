Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B24C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 04:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C4420870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 04:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581307438;
	bh=VKYQSUd1KMzC7piMBvLKw4fwXam6DItDJgifymRcFsk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=KbCfmzZe5SGN1XaseGnk6NvqFeM/vgkK/0WS144cqar7FLG94Mt9ku6v8aerHz6Tn
	 7R745TnAhQr93vCNut5IgO7NbhZpgXspa2vgPhMaS8TxyO6OaFMrA4xUn6m1o+GOP5
	 qIT2dKcEi8+KtGH1EECjibqrB0mOOmhOPGyjmNgo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbgBJED5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 23:03:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:37012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726944AbgBJED5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 23:03:57 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D7A220870;
        Mon, 10 Feb 2020 04:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581307435;
        bh=VKYQSUd1KMzC7piMBvLKw4fwXam6DItDJgifymRcFsk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Dqp1i1cZswP3CtTebLi0mhZnqNLVSEQaD7KJM/LVWl4D3t+BmNSAymLxqvD5aBPA2
         skOQRP7l9/y40zPbJlHKOXfifqG7vhqO7MDvECTqepGefopEg98woBlUbU/KR89Yet
         gEZBlsfoxcpQNDzD6P0FuuUg0Te2Y2Jpp3DU+DbQ=
Date:   Sun, 9 Feb 2020 20:03:54 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Qian Cai <cai@lca.pw>
Cc:     elver@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH -next] mm/swap_state: mark various intentional data
 races
Message-Id: <20200209200354.ab9d62d3090d4307f5f6eaa5@linux-foundation.org>
In-Reply-To: <44866E74-9C6A-4B25-9E6E-894FB097F8A4@lca.pw>
References: <20200209180053.784806e3bf028caa8bc584b3@linux-foundation.org>
        <44866E74-9C6A-4B25-9E6E-894FB097F8A4@lca.pw>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Feb 2020 21:56:38 -0500 Qian Cai <cai@lca.pw> wrote:

> 
> 
> > On Feb 9, 2020, at 9:00 PM, Andrew Morton <akpm@linux-foundation.org> wrote:
> > 
> > The data_race() macro appears to be stuck in Paul's linx-next tree. 
> > Can we expect this to be mainlined soon, or is there an issue?
> 
> I read Paul is trying to get this merged into the mainline no later than v5.7-rc1 or sooner.
> 
> lore.kernel.org/lkml/20200131211950.GX2935@paulmck-ThinkPad-P72/

OK, thanks.

c48981eeb0d5 clearly can't break anything as it simply adds a macro. 
Ingo, can we please get that upstream soonish?

