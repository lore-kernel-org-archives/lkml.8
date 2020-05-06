Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C58EC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 14:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1359120836
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 14:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588775778;
	bh=aLWjSnjjo2PT3Npfpel+8huQZQfm2NUKfytKskttSRk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=HAfuOwTwZhNhBxfnwXUJLUgDP+Up85zplVLhz0ukx5m85q2jAVAdRSpif8J3U5zR7
	 pXAOYWu0clqLsKyFPnlOwWK84uxQA8aeDNyorjKOzxYgMXJRvIafMiUNWrx/aefN42
	 Kn1UE0KZ4EO2XbTUWpfxsF6Jq0ycU5DbHNoAsmlo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbgEFOgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 10:36:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:33622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728712AbgEFOgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 10:36:16 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 498782076D;
        Wed,  6 May 2020 14:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588775776;
        bh=aLWjSnjjo2PT3Npfpel+8huQZQfm2NUKfytKskttSRk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=fvhcoFABTbH0WquTBCFaLsADbDanAfBKk2hmQTakjNTlp0tM34/g3Lbc2UuIK2+BK
         wPrdMNfJW2zcLvkYuRDvRtWOdD4IJF3j5vH+4xH29vOM78xxp5Q9/MvfOexkTB6t/y
         2030Q+9LY9WG1CCylOid08zZ1Fqt9up6g4djPWzw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3139835227D0; Wed,  6 May 2020 07:36:16 -0700 (PDT)
Date:   Wed, 6 May 2020 07:36:16 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        elver@google.com, linux-kernel@vger.kernel.org
Subject: Re: Please can I have a stable KCSAN branch for 5.8?
Message-ID: <20200506143616.GY2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200506132816.GJ8043@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506132816.GJ8043@willie-the-truck>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 02:28:17PM +0100, Will Deacon wrote:
> Hi TIP folks,
> 
> I'm looking to rebase my READ_ONCE() series [1] on top of the KCSAN patches
> so that we can get them in for 5.8. However, tip/locking/kcsan seems to be
> missing some bits:
> 
>   * An update to checkpatch.pl to warn about missing comments for
>     data_race():
> 
>     https://lore.kernel.org/r/20200401101714.44781-1-elver@google.com

For some reason, I thought this was going up some other tree, but I do
not see it in -next.  So unless I hear otherwise, I will pull it into
the v5.8 kcsan branch.

>   * I'm unable to apply these two patches from Marco that are needed for
>     my READ_ONCE() work:
> 
>     https://lore.kernel.org/lkml/20200424154730.190041-1-elver@google.com/
> 
>     I think these depend on stuff that has been queued by Paul, and appears
>     in linux-next, but to be honest with you I'm quite confused about what
>     is queued for 5.8 and what isn't.

This one is queued, but I currently have it in the v5.9 pile (but
tentatively for v5.8).  Unless Marco tells me otherwise, I will move it
to the v5.8 branch, which will be part of my pull request next week.

> What's the best base for me to use?

The -next tree has the latter, but not yet the former.

Hopefully we can get this straightened out, and please accept my apologies
for the hassle!

							Thanx, Paul

> Cheers,
> 
> Will
> 
> [1] https://lore.kernel.org/r/20200421151537.19241-1-will@kernel.org
