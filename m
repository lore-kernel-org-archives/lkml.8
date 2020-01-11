Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED124C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 05:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0F3C2082E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 05:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578719848;
	bh=5KNJjB7AvbZOIDEyTUBZ1IFseJ1ac2DzeG/hUGChJr0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=PkOvy1WahqPo7rH6W+U+hisa8oZyYSpSBa18s00xF0nCqdwUfFKq2/n5eIOnG57rc
	 8/6oSHhKpjVSPcT1PoE5KAxMzsGcCsVuWKaBtYi0tePhCqdX+VKHPbAWqeHeqpq7gp
	 c9x2WkywvWxOrfRYmHKZth3NxZAEwJyS+mF18EjI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgAKFR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 00:17:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:59648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbgAKFR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 00:17:27 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFDD52077C;
        Sat, 11 Jan 2020 05:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578719846;
        bh=5KNJjB7AvbZOIDEyTUBZ1IFseJ1ac2DzeG/hUGChJr0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=R/QhIys1G63mfeH7UqZNcZL2BTaWHkF13+mbMNYo671n0AbxoI0CTI2KRgGilIEIx
         vKlDjKuTLTLk8EWA5GnITf2NFsRdTO0143IpkPcojbKBMsc/7Hc1GAmcyxwCNLvIz7
         lPXLWY0GFcZLf7quoQw/DACAiaNIrsugy29mebr8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 9599C3522887; Fri, 10 Jan 2020 21:17:26 -0800 (PST)
Date:   Fri, 10 Jan 2020 21:17:26 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     andreyknvl@google.com, glider@google.com, dvyukov@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -rcu v2 0/2] kcsan: Improvements to reporting
Message-ID: <20200111051726.GH13449@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200110184834.192636-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110184834.192636-1-elver@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 07:48:32PM +0100, Marco Elver wrote:
> Improvements to KCSAN data race reporting:
> 1. Show if access is marked (*_ONCE, atomic, etc.).
> 2. Rate limit reporting to avoid spamming console.
> 
> v2:
> * Paul E. McKenney: commit message reword.
> * Use jiffies instead of ktime -- we want to avoid calling into any
>   further complex libraries, since KCSAN may also detect data races in
>   them, and as a result potentially leading to observing corrupt state
>   (e.g. here, observing corrupt ktime_t value).
> 
> 
> Marco Elver (2):
>   kcsan: Show full access type in report
>   kcsan: Rate-limit reporting per data races

I replaced the existing commits with these guys, thank you!

							Thanx, Paul

>  kernel/kcsan/core.c   |  15 +++--
>  kernel/kcsan/kcsan.h  |   2 +-
>  kernel/kcsan/report.c | 151 +++++++++++++++++++++++++++++++++++-------
>  lib/Kconfig.kcsan     |  10 +++
>  4 files changed, 146 insertions(+), 32 deletions(-)
> 
> -- 
> 2.25.0.rc1.283.g88dfdc4193-goog
> 
