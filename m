Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD2DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 09:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C76F206F4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 09:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B12PawCG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgFJJvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 05:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgFJJvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 05:51:17 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8394AC03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 02:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CH9odIVhPX5FVHMV+K1sA5Qpo6krlVJ8Eisnid5ZZZw=; b=B12PawCGZwa1sdACkvN5a720uk
        Rw9yh7HGh7NOqwtDeM+ShYLAjT5t5D+iCti3ZnCrB0m4/Z9PBmh9TGmm/uk2zD8Flegt+GslnllUP
        D87D6svzTDRnJ8Geq8a3l7znmNmKBNqNQvVjKAo1iiXVipZN+iZw8HHwBjR1h16cuaWkiqayUuDtK
        cX3T+e/cpxP9AX7LNVKCwAmB/Ecp7WQ/10TIXrlNqLh7N9EO4rnTwrVDeJ9uGQwbYIFS/K5GzXYY0
        Nn4i+eRiOJj9dE/Qdma8oUoq4q9Sd11kP4ektnW3LnYDB8y+uIHJhSFXNA9oyWorUnxSim2gtDZTj
        G1xrQMCg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jixNo-0000wL-IB; Wed, 10 Jun 2020 09:50:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 23A3F30280E;
        Wed, 10 Jun 2020 11:50:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0A32A21071930; Wed, 10 Jun 2020 11:50:54 +0200 (CEST)
Date:   Wed, 10 Jun 2020 11:50:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        rui.zhang@intel.com
Subject: Re: [smp] b2a02fc43a: suspend-stress.fail
Message-ID: <20200610095054.GF2531@hirez.programming.kicks-ass.net>
References: <20200610083502.GF12456@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610083502.GF12456@shao2-debian>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 04:35:02PM +0800, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: b2a02fc43a1f40ef4eb2fb2b06357382608d4d84 ("smp: Optimize send_call_function_single_ipi()")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: suspend-stress
> with following parameters:
> 
> 	mode: freeze
> 	iterations: 10
> 
> 
> 
> on test machine: 2 threads Broxton with 4G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> 
> 
> the result of this commit:
> 
> test started

No dmesg output? No splat?
