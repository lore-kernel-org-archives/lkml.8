Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB571C47257
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6911206D5
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VDpXtkg8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgEHIRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 04:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgEHIRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 04:17:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E87AC05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 01:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Q+BamE3ASAFBZ68gIprCCAuc5n4tI6nmcvfyYRppIqM=; b=VDpXtkg8x50anrq+65d7Tr6chP
        b/qLdMbKJ4YA8CXopAw3eP9Dtta/tW5Uvs/laZNLZEpyXkHIsNsw4c5Z74M1dyaQ3I/ELs0Rr+3T7
        IGTZM9Az6W5/I1pq0NOO2ZNWH1ObzfK74Dzph/X/rbIYPQINsI/B71y+kprugmVPuyxSDgCbSrhNP
        yW4KsSxMoLF/jdmjhEe8566KFgrHm8O3vPN5EWm6ynbDVSKLCdxMbc6SDbcuihBzXtZ2qS6s/73gc
        TIse3GOk15yxenxHGiMiLSRDwZgSoLHMB5dYTL/etwsyy8DDpZGqtj2SlJDHjvSKAzmd6oRIf8agc
        u08IPSAw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWyBM-0002z5-0Z; Fri, 08 May 2020 08:16:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1F77D30018B;
        Fri,  8 May 2020 10:16:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 048732038FB83; Fri,  8 May 2020 10:16:30 +0200 (CEST)
Date:   Fri, 8 May 2020 10:16:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        Julia.Lawall@lip6.fr
Subject: Re: [PATCH] sched/fair: Return true,false in
 voluntary_active_balance()
Message-ID: <20200508081629.GN5298@hirez.programming.kicks-ass.net>
References: <20200507110625.37254-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507110625.37254-1-yanaijie@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 07:06:25PM +0800, Jason Yan wrote:
> Fix the following coccicheck warning:
> 
> kernel/sched/fair.c:9375:9-10: WARNING: return of 0/1 in function
> 'voluntary_active_balance' with return type bool

That's not a warning, that's a broken cocinelle script, which if these
stupid patches don't stop, I'm going to delete myself!


