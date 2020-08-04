Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC59C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 11:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6229D206D4
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 11:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wSphxppf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbgHDL04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 07:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgHDL0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 07:26:43 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDA0C06174A;
        Tue,  4 Aug 2020 04:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2i+QGiaNp+sv6m2LX/F8Ni3iFD347QAZn5gEBy/VsVQ=; b=wSphxppfmozDafOpNPo5/0qoiQ
        xrWSE5XG5d5eOEsJEjcQH5y5m4Q/wx3fAPNOujiZZ++UqIpbRhDo/1w/81EffBiZEOktTeA2qJGMS
        6+yzl/dK5W6mrtTaTVHxJMcxf/oFPLhQy9OXAcRAn2joioZtCDx0hHJhD3AWiGoAV6dV9LVnM/9NU
        p5NQnPPxVRvvFn2EaPOacK0cznxQvbE49biF3lh4bCPeR40/LE+ATQVkPPJgbrzNNdf9Lx2K1qDk6
        kBRpnny5Cmv6inCR5d0mq8n0VH8OzfIt6bFFBCK9rB41YgjvlTHM5z0k5POI7+djcEFIjhRYYD4GX
        qHPt+ACQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k2v5X-00067S-UP; Tue, 04 Aug 2020 11:26:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2EB74301631;
        Tue,  4 Aug 2020 13:26:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0AAE82BDB8C9B; Tue,  4 Aug 2020 13:26:32 +0200 (CEST)
Date:   Tue, 4 Aug 2020 13:26:31 +0200
From:   peterz@infradead.org
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        Quentin Perret <qperret@google.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 2/3] sched/doc: Document capacity aware scheduling
Message-ID: <20200804112631.GG2657@hirez.programming.kicks-ass.net>
References: <20200731192016.7484-1-valentin.schneider@arm.com>
 <20200731192016.7484-3-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731192016.7484-3-valentin.schneider@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 08:20:15PM +0100, Valentin Schneider wrote:
> Add some documentation detailing the concepts, requirements and
> implementation of capacity aware scheduling across the different scheduler
> classes.
> 
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  Documentation/scheduler/index.rst          |   1 +
>  Documentation/scheduler/sched-capacity.rst | 439 +++++++++++++++++++++

How about I make this a .txt file and remove all that unreadable rst
nonsense?
