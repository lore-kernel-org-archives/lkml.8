Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22992C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 18:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8EAD20768
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 18:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592247553;
	bh=ZgkCZHpPn9fCGTb0Eh4ewUQRqkvl5j30hGoU9iJBhJ8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=dnR8BSN58YV1lVRm1c5O1uwn2ac4Ss+gjKuRQU86fK3yiCUaTmj63Y1VJ27KhF64L
	 /JlnUtU0TrhDoQjPgBoHf//XArcYwgWOV6tBJb5Gwrby/XtEh99J8nqvjVm+iIAe6v
	 sS4gmcKvdAOpegB1NljULuikgn2P7uTzqRUAQdic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730976AbgFOS7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 14:59:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:34760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731332AbgFOS7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 14:59:11 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2257E20656;
        Mon, 15 Jun 2020 18:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592247551;
        bh=ZgkCZHpPn9fCGTb0Eh4ewUQRqkvl5j30hGoU9iJBhJ8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=kE/HXzcyTUuDoL1xh1GJ22YxrIk34rb3pC0jn7Tn9vsn9DFQvjvpRSPtQAJ0c/vVH
         tE4QigSnCvx8L5XXbMJjRz8fiqAZba5XtwRUo0BnSYt1WL1voiowKDgjn8U6Dct4Z9
         xJ9Ixh1RzehvJId1VwXi61vj6ougN+PHc190g7YA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 04EDE35218F0; Mon, 15 Jun 2020 11:59:11 -0700 (PDT)
Date:   Mon, 15 Jun 2020 11:59:10 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, x86@kernel.org, elver@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        will@kernel.org, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com
Subject: Re: [PATCH 2/9] rcu: Fixup noinstr warnings
Message-ID: <20200615185910.GK2723@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200603114014.152292216@infradead.org>
 <20200603114051.896465666@infradead.org>
 <20200615154905.GZ2531@hirez.programming.kicks-ass.net>
 <20200615155513.GG2554@hirez.programming.kicks-ass.net>
 <20200615162427.GI2554@hirez.programming.kicks-ass.net>
 <20200615171404.GI2723@paulmck-ThinkPad-P72>
 <20200615183325.GF2531@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615183325.GF2531@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 08:33:25PM +0200, Peter Zijlstra wrote:
> On Mon, Jun 15, 2020 at 10:14:04AM -0700, Paul E. McKenney wrote:
> 
> > This merge window has been quite the trainwreck, hasn't it?  :-/
> 
> Keeps life interesting I suppose..

;-) ;-) ;-)

							Thanx, Paul
