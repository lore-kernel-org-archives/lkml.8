Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE672C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 08:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9343206E2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 08:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3YNG9VdF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgFQIbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 04:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgFQIbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 04:31:05 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EFEC061573
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 01:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UpUJdiKyVEtjNOYA6tVPxYqHKCMVKS1bvEmmByHVixk=; b=3YNG9VdF+Va1IKVKo58TKtN31f
        VwpF3LMeMdnxcTflMNK4a9HQ7d08THwr1HTputQhTljvLaqURk3X/aQi9WrE/yxlem+nQPkrYwUG/
        1tuvjwo6yOuzUbm+gG9khiaSI4TMU+VF5TIohymgPETZNsCegIZB+rLOuhViWuvPesm0yb/x+udCt
        kTsYOff08h+OJjA4mfVOzmRHwWKhyycYpNd5Gx+/a524yo6S4OFN/0NVix9NRT8zVRinZVO2ceAd3
        xRqSw/ZScURA6WAMegt0dTBj839Rhq7Nl2kG/FwVT2IJaMbbOtBPpDOhF2a4EDIsziLnAXTGyApoj
        RNGE0e5g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlTT1-0006sk-Ct; Wed, 17 Jun 2020 08:30:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9327430018A;
        Wed, 17 Jun 2020 10:30:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7C2B829E5A2E1; Wed, 17 Jun 2020 10:30:41 +0200 (CEST)
Date:   Wed, 17 Jun 2020 10:30:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rong Chen <rong.a.chen@intel.com>
Cc:     Marco Elver <elver@google.com>, kernel test robot <lkp@intel.com>,
        kbuild-all@lists.01.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [kbuild-all] Re: [PATCH] compiler_attributes.h: Support
 no_sanitize_undefined check with GCC 4
Message-ID: <20200617083041.GD2531@hirez.programming.kicks-ass.net>
References: <202006160328.6MfJNuqX%lkp@intel.com>
 <20200615231529.GA119644@google.com>
 <20200616131921.GV2531@hirez.programming.kicks-ass.net>
 <20200617010051.GS5653@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617010051.GS5653@shao2-debian>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 09:00:51AM +0800, Rong Chen wrote:
> On Tue, Jun 16, 2020 at 03:19:21PM +0200, Peter Zijlstra wrote:

> > 301805 N + Jun 16 kernel test rob (5.8K) [peterz-queue:x86/entry] BUILD SUCCESS 8e8bb06d199a5aa7a534aa3b3fc0abbbc11ca438
> > 
> > Why that thing is claiming SUCCESS when it introduces a build error I
> > don't know.

> Sorry for the misunderstanding, some folks complained that it's too
> noisy when there're only new warnings in a "BUILD REGRESSION" report,
> so we changed to use "BUILD SUCCESS" if there's no new build error. To
> avoid misunderstanding, we'll change build complete report title to
> "BUILD SUCCESS WITH WARNING" for new warnings.

Thanks Rong!
