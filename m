Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0773C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 03:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71A0320888
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 03:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592537134;
	bh=7SuqrjPlw/2UBkZukKDeX1/d8o+4qmUc8Lmo2GQh0ow=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=bXMcmWlqrcXR1tVFFQ/f3uIzTvqwTRGUc4gk98cYoizJBl+DjTfk5DQXafic3QAjM
	 WoUNEgDYZrE/rAUbG5BJLMXAZcWOfbm7DWH/KAf/v2aXqLr00MdVgQUKWBmgRlqWLZ
	 0JLiD5eF/vySXqV8pql6LCs3B3ctgzPtwnKfJkQA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730277AbgFSDZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 23:25:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:46920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729578AbgFSDZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 23:25:30 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E7312080D;
        Fri, 19 Jun 2020 03:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592537130;
        bh=7SuqrjPlw/2UBkZukKDeX1/d8o+4qmUc8Lmo2GQh0ow=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=TwCCwEYAhoJYQQTUxGrRpZR20rmzVTRefLNdOgorJgMxDuBtlQwkUAkx1CbMDfPz+
         nEgOO50PyIWRQXI0z2PhvvH9ciNjc9ORQ9iQAWCPUNAukliWJB262xJU0n8m+5n1Uw
         qPX5wv1MZm5PXwBDp5TFNLWUMmT/kBiWdXi2elQU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 73A58352264E; Thu, 18 Jun 2020 20:25:30 -0700 (PDT)
Date:   Thu, 18 Jun 2020 20:25:30 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     will@kernel.org, peterz@infradead.org, bp@alien8.de,
        tglx@linutronix.de, mingo@kernel.org, dvyukov@google.com,
        cai@lca.pw, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] kcsan: Re-add GCC support, and compiler flags
 improvements
Message-ID: <20200619032530.GI2723@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200618093118.247375-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618093118.247375-1-elver@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 11:31:15AM +0200, Marco Elver wrote:
> Re-add GCC as a supported compiler and clean up compiler flags.
> 
> To use KCSAN with GCC before GCC 11 is released, the following will get
> a stable GCC 10 and cherry-pick the patches required for KCSAN support:
> 
> 	git clone git://gcc.gnu.org/git/gcc.git && cd gcc
> 	git checkout -b gcc-10-for-kcsan releases/gcc-10.1.0
> 	git cherry-pick \
> 	    4089df8ef4a63126b0774c39b6638845244c20d2 \
> 	    ab2789ec507a94f1a75a6534bca51c7b39037ce0 \
> 	    06712fc68dc9843d9af7c7ac10047f49d305ad76
> 	./configure --prefix <your-prefix> --enable-languages=c,c++
> 	make -j$(nproc) && make install

Unless there are objections, I will pull this in Friday (tomorrow)
afternoon, Pacific Time.

							Thanx, Paul

> Marco Elver (3):
>   kcsan: Re-add GCC as a supported compiler
>   kcsan: Simplify compiler flags
>   kcsan: Disable branch tracing in core runtime
> 
>  Documentation/dev-tools/kcsan.rst | 3 ++-
>  kernel/kcsan/Makefile             | 4 ++--
>  lib/Kconfig.kcsan                 | 3 ++-
>  scripts/Makefile.kcsan            | 2 +-
>  4 files changed, 7 insertions(+), 5 deletions(-)
> 
> -- 
> 2.27.0.290.gba653c62da-goog
> 
