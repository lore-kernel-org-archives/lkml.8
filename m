Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D628C2BA83
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 17:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A98227BF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 17:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgBPRBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 12:01:15 -0500
Received: from netrider.rowland.org ([192.131.102.5]:46015 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728370AbgBPRBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 12:01:15 -0500
Received: (qmail 781 invoked by uid 500); 16 Feb 2020 12:01:14 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Feb 2020 12:01:14 -0500
Date:   Sun, 16 Feb 2020 12:01:14 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     "Paul E. McKenney" <paulmck@kernel.org>
cc:     linux-kernel@vger.kernel.org, <linux-arch@vger.kernel.org>,
        <kernel-team@fb.com>, <mingo@kernel.org>, <parri.andrea@gmail.com>,
        <will@kernel.org>, <peterz@infradead.org>, <boqun.feng@gmail.com>,
        <npiggin@gmail.com>, <dhowells@redhat.com>, <j.alglave@ucl.ac.uk>,
        <luc.maranget@inria.fr>, <akiyks@gmail.com>
Subject: Re: [PATCH memory-model] Add recent references
In-Reply-To: <20200214233139.GA12521@paulmck-ThinkPad-P72>
Message-ID: <Pine.LNX.4.44L0.2002161158140.30459-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Feb 2020, Paul E. McKenney wrote:

> This commit updates the list of LKMM-related publications in
> Documentation/references.txt.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

>  o	Paul E. McKenney, Ulrich Weigand, Andrea Parri, and Boqun
> -	Feng. 2016. "Linux-Kernel Memory Model". (6 June 2016).
> -	http://open-std.org/JTC1/SC22/WG21/docs/papers/2016/p0124r2.html.
> +	Feng. 2018. "Linux-Kernel Memory Model". (27 September 2018).
> +	http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2018/p0124r6.html.

Even though this is an update, the new version referenced here is
already out-of-date (in particular, with regard to its discussions of 
the ordering properties of unlock-lock sequences as viewed by threads 
not holding the lock).  And it contains a few typos scattered 
throughout.

Alan

