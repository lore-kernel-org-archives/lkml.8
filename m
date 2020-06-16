Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03494C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D298620882
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592324153;
	bh=fYUP88jpvExRcURUv+QWZjf7n0YAKgdb92mnl17R3i8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=tp32r0xa5Bt4uP5jY13PrYennftYqWOhaHfZWtgqVNl5Q9+gOpEApTw/K1ncwIwxs
	 gEaXO4UhkaGpw/x1OvAvnHjumvctor2zwCAJLsa49yn54nnY0T/FPmcman7YlGlet3
	 xWm/lUVxNzCSfpQu/TdXxsOFAYUwDR2sm7MuwsfE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732397AbgFPQPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 12:15:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:48318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732361AbgFPQPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 12:15:50 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E89A620882;
        Tue, 16 Jun 2020 16:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592324149;
        bh=fYUP88jpvExRcURUv+QWZjf7n0YAKgdb92mnl17R3i8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=YtdntdNfZemJzgI8ZdunFonB0oo5zwvT4Ia0yD3Faa2wvrUt1kUwEB1HWiiwVSZkm
         l14Qz/FzlZQRReDi4nTEjJTixWrKxIuaqUmN1C07cqWpNOo53gj8TumHwvZ2hTaF4d
         D+CAeNyHNshjkjMsZt2H99PXHU2RwUA/ylN81zqw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C5A8B3521103; Tue, 16 Jun 2020 09:15:49 -0700 (PDT)
Date:   Tue, 16 Jun 2020 09:15:49 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: rseq.2 Restartable Sequences man page updated
Message-ID: <20200616161549.GZ2723@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <1094083824.1256.1591899797181.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094083824.1256.1591899797181.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 02:23:17PM -0400, Mathieu Desnoyers wrote:
> Hi Michael,
> 
> I took the liberty of updating the rseq.2 man page based on your
> last round of comments:
> 
> https://git.kernel.org/pub/scm/libs/librseq/librseq.git/tree/doc/man/rseq.2
> 
> Soon, rseq support will be integrated into glibc, and the maintainers
> there want a stable link to documentation of the rseq system call.
> Documentation is pretty much the only remaining blocker for integration
> of rseq support into glibc.
> 
> Ideally it should land into the man-pages project, but since it's been
> more than a year since I heard back from you, I am tempted to host it
> myself within the librseq project, even though it's far from ideal for
> hosting a kernel system call man page. Unfortunately, I suspect that
> hosting it in two locations (librseq and man-pages) will eventually
> create much confusion.
> 
> Can you look into the updated man page please ? I can do the edits
> if you have further feedback.

For whatever it is worth, this looks good to me.

Michael, any reason this cannot be included into the official set of
manual pages?

							Thanx, Paul
