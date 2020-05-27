Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B206C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 01:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50B812071A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 01:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="bdCwamy6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbgE0BWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 21:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbgE0BWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 21:22:49 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6E3C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 18:22:48 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b27so12872172qka.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 18:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lfaYQxAvjEIlf4eTifAP04WQLIjbuEqWZK7YVJA2P8E=;
        b=bdCwamy6l5y36tWaBAzw2jsOMRDVBFifmX0OhKp5L2f5ScxkRWlrKyoQKiqD4EeJKV
         r+6FDToY923n0az0tXSPj3wsGp8copRiOZkLeDF23sQ+QpMMHNroqCBKC4N86cfu2+pE
         gRdAk3lFfu8cKsuCTWNl38G8C5Toaqo8iPC8JRJQTeT/TJD29zkYEdZWCjpGUaKsvExt
         Kgexof+updggUzQv3Hh5nwcCouAWGuH4y0cvBuPKaep20bdhYpSNeVaEiycuBhe/Q/cP
         WmDx9CVktclY7TJzbk7DtYAwo5yxGuvOGVb6xy40yatS8SOR2vr/6Vo0E0NQI1wRWObQ
         xn2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lfaYQxAvjEIlf4eTifAP04WQLIjbuEqWZK7YVJA2P8E=;
        b=SWl6tsqYoD1mDZbFr0FOdQKkRut86JZ7SV4rlfViXG8gYol5lCdBb6HprDbH1hwxPQ
         CJFuDVah3MLOGT3krlRSGv6f8PCAH4tQW09ZiXragLczpToG+IsnOYD9VlMwhOHM1lOQ
         3b4wAVbH8B4tQ2vWTbd2fpfc5tGH2JSJ86zvqK3FYe9nRQrZbK1PHojnatrtE/ZpGgeG
         XESNc0x9Z5mZ7OReEMRuH8TRWkb0B4x3/vnSS5tlMsRLWpWH/VhsLZXpQSJOybgV/238
         msTwRpnXd2vjgyG2fs4q5oewR93VJpNsbT8FCfoo5mldVMJ1S+K5CuYNGWgH8uLmknBT
         l38Q==
X-Gm-Message-State: AOAM532iMqQJS5xi7iwKxRz57sl1TElhsLisZmKXzlxLQrqxvYvUDnhf
        Hfy7/qxXYsro16TFuoe3LRizDA==
X-Google-Smtp-Source: ABdhPJwVgOsRZKK7L4GJOZmoCuR0CuYBMeqWZSLSs2+BbpvtTBspMPRVLYX3X/faUhr8Z3IcSE8AVw==
X-Received: by 2002:a37:9586:: with SMTP id x128mr1790368qkd.312.1590542568200;
        Tue, 26 May 2020 18:22:48 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id x41sm1286992qtb.76.2020.05.26.18.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 18:22:47 -0700 (PDT)
Date:   Tue, 26 May 2020 21:22:45 -0400
From:   Qian Cai <cai@lca.pw>
To:     Paul Mackerras <paulus@ozlabs.org>
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org, aik@ozlabs.ru,
        paulmck@kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/kvm/book3s64/vio: fix some RCU-list locks
Message-ID: <20200527012245.GJ991@lca.pw>
References: <20200510051834.2011-1-cai@lca.pw>
 <20200527011323.GA293451@thinks.paulus.ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527011323.GA293451@thinks.paulus.ozlabs.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 11:13:23AM +1000, Paul Mackerras wrote:
> On Sun, May 10, 2020 at 01:18:34AM -0400, Qian Cai wrote:
> > It is unsafe to traverse kvm->arch.spapr_tce_tables and
> > stt->iommu_tables without the RCU read lock held. Also, add
> > cond_resched_rcu() in places with the RCU read lock held that could take
> > a while to finish.
> 
> This mostly looks fine.  The cond_resched_rcu() in kvmppc_tce_validate
> doesn't seem necessary (the list would rarely have more than a few
> dozen entries) and could be a performance problem given that TCE
> validation is a hot-path.
> 
> Are you OK with me modifying the patch to take out that
> cond_resched_rcu(), or is there some reason why it's essential that it
> be there?

Feel free to take out that cond_resched_rcu(). Your reasoning makes
sense.
