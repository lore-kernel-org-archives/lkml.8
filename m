Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF64C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 16:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA97020A8B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 16:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596473570;
	bh=8fZKZCq/kq0vvTAQSOkReFepFnp21HZwMwGyekFmX40=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=Exu540kZCkJ+RHVVCEzVgogDW2sPllsop4VAgRmhCkwWFyhWuYYubAYkVKVUZjYC/
	 lKLQzozV+P4yc+MICjih8vd0/qpwX0MIoBMqbwBk6aQrCrP6Q0FV7HviiSoGdl3PB4
	 CLr0aOn5RI+jKXsjR4F+N4pHFlczWGOkMWEAzeqE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgHCQwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 12:52:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbgHCQwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 12:52:50 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02355207DF;
        Mon,  3 Aug 2020 16:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596473569;
        bh=8fZKZCq/kq0vvTAQSOkReFepFnp21HZwMwGyekFmX40=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=gfdlfqbKMzw9rXAZepiuIiEJCn+hz4xhcthehgvO9K76gr6hWkn/eO+sjT2o90yIO
         /dws/5XD711ZMA0bxKdaER0ZaqXhhFMdf9Wv0b3lAFXR1Il6LAzU9LlxVh96Rju1U1
         YxjROKRhhYBpmuo/NDhTBpcyOVdyfBwAOLx7MURg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id DAA0435230CD; Mon,  3 Aug 2020 09:52:49 -0700 (PDT)
Date:   Mon, 3 Aug 2020 09:52:49 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     dvyukov@google.com, glider@google.com, andreyknvl@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] kcsan: Cleanups, readability, and cosmetic
 improvements
Message-ID: <20200803165249.GA28157@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200731081723.2181297-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731081723.2181297-1-elver@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 10:17:18AM +0200, Marco Elver wrote:
> Cleanups, readability, and cosmetic improvements for KCSAN.
> 
> Marco Elver (5):
>   kcsan: Simplify debugfs counter to name mapping
>   kcsan: Simplify constant string handling
>   kcsan: Remove debugfs test command
>   kcsan: Show message if enabled early
>   kcsan: Use pr_fmt for consistency

Queued and pushed, thank you!

						Thanx, Paul

>  kernel/kcsan/core.c     |   8 ++-
>  kernel/kcsan/debugfs.c  | 111 ++++++++--------------------------------
>  kernel/kcsan/report.c   |   4 +-
>  kernel/kcsan/selftest.c |   8 +--
>  4 files changed, 33 insertions(+), 98 deletions(-)
> 
> -- 
> 2.28.0.163.g6104cc2f0b6-goog
> 
