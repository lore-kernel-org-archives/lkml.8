Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CC9C35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 15:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1253720CC7
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 15:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k+EFgHns"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730808AbgBYPsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 10:48:13 -0500
Received: from merlin.infradead.org ([205.233.59.134]:33320 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729386AbgBYPsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 10:48:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FnQKsJ97/fq0oo8NNxJbdVL/wTi3dUPnAyFaugH0hLw=; b=k+EFgHns3OqZ7Fm8dn7NCV2vx3
        dGTX+K0aRgX92fsGcz9b3HJrFNrQ43NyAaUmeqm+ioMVZPzMein6a5k0qdxFNd11CBLnIpnowVd+9
        afy+oRQwyLHCH7zfb8OCpLpPdl2IlWnounvgOjtnyXiBFV0pD6T+wXTicfMfq6toozhWEFqYpBXnh
        N3rsmhhwqH1BB0b7WEcNxFd4oFkj1rEImSeNeZ3+2f+h5MpaLT5HX6aFkkwyqC7N/Cldh9bVfknwP
        Q4fHdbe7Q29RRoOC/29fNLJLxA7UqXM1Q53tVx2zNIoZgs5krSxil0KpxQPms9pijlWK8wjwtLXa5
        Bag9vjMw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6cR1-0007PE-0T; Tue, 25 Feb 2020 15:47:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B18E930018B;
        Tue, 25 Feb 2020 16:45:49 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C14402BE3211A; Tue, 25 Feb 2020 16:47:44 +0100 (CET)
Date:   Tue, 25 Feb 2020 16:47:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, mingo@redhat.com,
        ionela.voinescu@arm.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rui.zhang@intel.com, qperret@google.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        rostedt@goodmis.org, will@kernel.org, catalin.marinas@arm.com,
        sudeep.holla@arm.com, juri.lelli@redhat.com, corbet@lwn.net,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
Subject: Re: [Patch v10 1/9] sched/pelt: Add support to track thermal pressure
Message-ID: <20200225154744.GN18400@hirez.programming.kicks-ass.net>
References: <20200222005213.3873-1-thara.gopinath@linaro.org>
 <20200222005213.3873-2-thara.gopinath@linaro.org>
 <db1a554a-1c8a-0078-def5-4b5f1ee68c99@infradead.org>
 <d7890dc4-f5d8-9bad-8473-062c0206da09@linaro.org>
 <a3102cf8-bb77-fed4-ffc7-8ef74e9feb23@infradead.org>
 <2c680a71-31ee-3a9a-4859-5c4cbc9dc0e1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c680a71-31ee-3a9a-4859-5c4cbc9dc0e1@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 09:33:22AM -0500, Thara Gopinath wrote:
> I see what you mean. I will send an update to this patch with HAVE_ removed.
> It is not selected by any other options. Best is for user to select it or
> platform/SoC configs to enable it.

Done that for you ;-)
