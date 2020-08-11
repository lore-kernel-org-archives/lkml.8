Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FD2C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 11:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EBF82075D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 11:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nnG0xX/t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbgHKLC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 07:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728559AbgHKLC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 07:02:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6EEC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 04:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lt8wHkIyCIxj/2BuJAaCTMhwAvgeabZ4hhroohQEExc=; b=nnG0xX/tjPSiIdvRpowmv8FHjp
        dl0w3Gd1Gms4vzzzsfuDfVi5JHhGZq6O+JV0Rr1DWlM/lIDJTMuYQzJ2PQB9/szxngx6B/ANObyQi
        cZBhmpjWfaHEYx7fJgACSYd8xOLW7rAR4m0vvjO/Xjod7kaaEk2pOHQ8zacbLE7HEc0q+bOYxGrxJ
        S8RGEO4DhfXL9tDZ1vEhhbv6lBJRrLsDGmKDxI2jbMXdm47j+K13oYY1oXrMKlyrf9pFhkY/mLsC2
        j/qEw3yPnDtRf07XpYS5gHOu2s9++RnAbVHv57qKFa1ujHVAfCpZ4TdGnRerWGtd3N/ppkrD1JIP0
        DUXxSZAw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5S3M-0006xO-Mq; Tue, 11 Aug 2020 11:02:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 84357300DAE;
        Tue, 11 Aug 2020 13:02:46 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3A75F20BFC4E4; Tue, 11 Aug 2020 13:02:46 +0200 (CEST)
Date:   Tue, 11 Aug 2020 13:02:46 +0200
From:   peterz@infradead.org
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Rob Herring <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [RFC] libperf: Add support for user space counter access
Message-ID: <20200811110246.GD2674@hirez.programming.kicks-ass.net>
References: <20200807230517.57114-1-robh@kernel.org>
 <20200808102208.GA619980@krava>
 <CAL_Jsq+gfqyqCx3Yuc6TsbXjYSLfJQhhPUnwRVjpJgwL24v1Qg@mail.gmail.com>
 <20200811105027.GD699846@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811105027.GD699846@krava>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 12:50:27PM +0200, Jiri Olsa wrote:

> if it works for all events, which I'm not sure of

That's what we have cap_user_rdpmc for.

