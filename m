Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B474DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 16:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 821FB20727
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 16:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nMZvLC6f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730474AbgEVQ1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 12:27:25 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43360 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730058AbgEVQ1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 12:27:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wI/8yAenaDAQU5DV7y4CbiIHIuujya3ynkD2vjkagqs=; b=nMZvLC6fLSante1sWCqNxhJUD1
        GSiy6bd/m+oLFuoZpwlaUTwT24yM+MwWbdD1XFr9FtVj3Yvf/NxbVutHbSs/VZh+Zjq/g+y9TOEIk
        SKIy+cDisaTdZbfUQejVOt/x/CYD3GkgsWoTylE3LujM/nrxNJsqFPJ5NUpilmay//m3FxsSgbPO9
        zk0U5gmLhqbwRZ6Mb7XO4DHmVY091Y1ZBHY/Yx4beCE1uM8kwMTumt2JNZRbalTmsZlblKXaHUaI7
        MPa3ptw0XCzTix/4vwPBTwOn39SWuGsD5QjaHYbKA/UHeDF1yQl/24wa3eydhcegjYnQirSPWQ2X6
        /uZnMzPw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jcAVV-00061K-5c; Fri, 22 May 2020 16:26:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 62512301EFB;
        Fri, 22 May 2020 18:26:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4CC9620B5D17E; Fri, 22 May 2020 18:26:47 +0200 (CEST)
Date:   Fri, 22 May 2020 18:26:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     sumit.garg@linaro.org, jason.wessel@windriver.com,
        dianders@chromium.org, kgdb-bugreport@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, patches@linaro.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [RFC PATCH 1/2] debug: Convert dbg_slave_lock to an atomic
Message-ID: <20200522162647.GW317569@hirez.programming.kicks-ass.net>
References: <20200522145510.2109799-1-daniel.thompson@linaro.org>
 <20200522145510.2109799-2-daniel.thompson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522145510.2109799-2-daniel.thompson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 03:55:09PM +0100, Daniel Thompson wrote:

> +static atomic_t			slaves_must_spin;

> +			if (!atomic_read(&slaves_must_spin))

> +		atomic_set(&slaves_must_spin, 1);

> +		atomic_set(&slaves_must_spin, 0);

There is no atomic operation there; this is pointless use of atomic_t.
