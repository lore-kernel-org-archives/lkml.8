Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A30DC433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 14:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA09720716
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 14:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eJE5fFt5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbgICOwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 10:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729020AbgICONn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 10:13:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E6DC061246
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 07:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=k1S85AjwbKHwjD2iukGj6VnkOZ5YiCsnVPYjfnzmtXg=; b=eJE5fFt5JjkgIJF1IzkfiCZYJl
        Myfe0lwKyhTuGu8sMK1FV8Xn6HsNucoqHHNbsFcgOJk8vNvv8BmpEWSCDDELNZ8Yzp/X1NnoPV//I
        pFV74JJ4mlZgPze4qoauoJC0HagkRAmpyLHNJbI/ysjv+ftDl+ttpbIlPw2JzEST++1SRTSCsDJfn
        qBaVoFRR2fZrL9djLmpOjNx/cmlm6aWl7/5c8GN3mJxBs02h1oyUOmy5+8ahruf4L86TC3D7RHx0s
        Mc7RZlcOsrLt/wzfSyK9xnvSMeobIMMaOtbXopGPP0BSoC2ZkOWh9DKNKR5A5xSkFCHI4SDtKncpS
        pEk8l9/w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDpzC-00041T-WE; Thu, 03 Sep 2020 14:13:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2558F3011C6;
        Thu,  3 Sep 2020 16:13:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 152D82BBD6A02; Thu,  3 Sep 2020 16:13:10 +0200 (CEST)
Date:   Thu, 3 Sep 2020 16:13:10 +0200
From:   peterz@infradead.org
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, will@kernel.org,
        npiggin@gmail.com, elver@google.com, jgross@suse.com,
        paulmck@kernel.org, rostedt@goodmis.org, rjw@rjwysocki.net,
        joel@joelfernandes.org, svens@linux.ibm.com, tglx@linutronix.de,
        ulf.hansson@linaro.org, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org
Subject: Re: [PATCH v2 11/11] lockdep,trace: Expose tracepoints
Message-ID: <20200903141310.GY35926@hirez.programming.kicks-ass.net>
References: <20200821084738.508092956@infradead.org>
 <20200821085348.782688941@infradead.org>
 <20200902035146.GA45826@roeck-us.net>
 <20200902085636.GV1362448@hirez.programming.kicks-ass.net>
 <e4999b75-604f-29a3-e78c-508ee6bede88@roeck-us.net>
 <20200903140047.GD1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903140047.GD1362448@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 04:00:47PM +0200, peterz@infradead.org wrote:
> I stuck a tracepoint in intel_idle and had a rummage around. The below
> seems to work for me now.

Note that this will insta-kill all trace_*_rcuidle() tracepoint that are
actually used in rcuidle.

A git-grep seems to suggest the remaining users are:

 - arch/arm
 - arch/arm64 -- IPI tracepoint that are ordered incorrectly in
                 their entry code,

 - runtime pm
 - common clk -- these both need re-ordering somehow

 - trace_preemptirq -- this is going to be interesting for
                       those archs that idle with IRQs enabled

 - printk -- we shouldn't be printk()-ing from idle, and if we are,
             missing this is the least of our problems.


