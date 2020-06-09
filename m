Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AB2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 22:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCDFE2072F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 22:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Br1KIEf2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgFIWID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 18:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbgFIWIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 18:08:00 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50492C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 15:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zlVxGaFxeXJTmRUwi1+mkg+w9meYkQ0A5n5ZmuQ4mak=; b=Br1KIEf2GpWeQ66qFhFP2Yd6p7
        zT16cYiJ7waOVWXTOACpHapn7ew8aeGMbe5GKNJZbQFgdmwRAV/7qQi1mfVtXFw+c5JFFaPkTfyZs
        n8sBZp2sHcpP2ky12qAAJFIu3NLdJrds+PQMten3Ns8e2sEpj1c9kzr3KbidzJmvViA57w0HcTciD
        tDIOrNwkTc4paX2brNHudI3KyBCVCCWQX6IAKM0Xbd10yFwBxXkszMa+E33XtGYYrFsGXhSV4IvlJ
        QcyJc+bY7YfNeO8j0/bdGpm92chCvtpBRKY17yenQGqBWpyaFQQFc5vexgSfh0gAYsf7FGlK1JYNX
        qsR/Rmwg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jimPB-0003As-4p; Tue, 09 Jun 2020 22:07:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7B6A13019CE;
        Wed, 10 Jun 2020 00:07:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6E3242038F8AB; Wed, 10 Jun 2020 00:07:34 +0200 (CEST)
Date:   Wed, 10 Jun 2020 00:07:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, tglx@linutronix.de,
        frederic@kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        cai@lca.pw, mgorman@techsingularity.net
Subject: Re: [RFC][PATCH 7/7] sched: Replace rq::wake_list
Message-ID: <20200609220734.GE2514@hirez.programming.kicks-ass.net>
References: <20200526161057.531933155@infradead.org>
 <20200526161908.129371594@infradead.org>
 <20200604141837.GA179816@roeck-us.net>
 <20200605002433.GA148196@sol.localdomain>
 <20200605074154.GB2750@hirez.programming.kicks-ass.net>
 <20200605161532.GD1373@sol.localdomain>
 <53318971-561c-b445-0408-530b3d3ba44e@roeck-us.net>
 <20200609202134.GA1105@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609202134.GA1105@sol.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 01:21:34PM -0700, Eric Biggers wrote:
> Still occurring on Linus' tree.  This needs to be fixed.  (And not by removing
> support for randstruct; that's not a "fix"...)
> 
> Shouldn't the kbuild test robot have caught this?

Should probably, but the thing has been rather spotty of late.
