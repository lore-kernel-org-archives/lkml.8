Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056A1C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 13:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D96D92137B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 13:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M6kPmDoz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbgFPNT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 09:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgFPNT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 09:19:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9ED2C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 06:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QOrBjLsZOcLkb+bVnZ9gACcB3pi6tQLW9rAEtEDmuaA=; b=M6kPmDoznMBMoy9sJaehnjwn7/
        8k247TpaB/vcK26oIp+04os2EFFKkmHeQHAC0H5WKmruH744IYoJAqTVGJ+9kWK76nqBzxva6nm+M
        H985uOOFcDHZaS+6VWM+jUa7qrlCu3Akfjxj1/S38FQH3jfcvAT+uramkCt55q2bulbYEhukm+aN/
        bXw/hj1QYm2HkdcbVuAsYk193WNLwrnw6SCpfTGyergO7maAL/C1nIS+S199bKx+XrBaZZCc1rrlS
        U48CJi6LxQkeQ91HMWq/QnoxCrZnC2InKwIfbtWTe2dX4JhEFg38bSE7gwGYoNbmlIrqcAqy+H3Kj
        2tIahr6g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlBUp-0004JR-Cb; Tue, 16 Jun 2020 13:19:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4AB86301A32;
        Tue, 16 Jun 2020 15:19:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3315C29C11D62; Tue, 16 Jun 2020 15:19:21 +0200 (CEST)
Date:   Tue, 16 Jun 2020 15:19:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] compiler_attributes.h: Support no_sanitize_undefined
 check with GCC 4
Message-ID: <20200616131921.GV2531@hirez.programming.kicks-ass.net>
References: <202006160328.6MfJNuqX%lkp@intel.com>
 <20200615231529.GA119644@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615231529.GA119644@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 01:15:29AM +0200, Marco Elver wrote:
> UBSAN is supported since GCC 4.9, which unfortunately did not yet have
> __has_attribute(). To work around, the __GCC4_has_attribute workaround
> requires defining which compiler version supports the given attribute.
> 
> In the case of no_sanitize_undefined, it is the first version that
> supports UBSAN, which is GCC 4.9.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
> 
> Doing a 'make W=1' with GCC 4.9 and the provided config fixes the build
> robot's report.
> 
> Peter: Feel free to either squash this patch into the one adding
> __no_sanitize_undefined or apply on top.

Yeah, argh! So I only saw this thread now, even though I'd already
pushed out x86/entry to tip last night due to getting:

301805 N + Jun 16 kernel test rob (5.8K) [peterz-queue:x86/entry] BUILD SUCCESS 8e8bb06d199a5aa7a534aa3b3fc0abbbc11ca438

Why that thing is claiming SUCCESS when it introduces a build error I
don't know.

Anyway, let me go push this thing on top.
