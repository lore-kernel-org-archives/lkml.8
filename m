Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD1BC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 23:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61BD320936
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 23:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fjSVHbuk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbgIHXcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 19:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgIHXcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 19:32:23 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C12C061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 16:32:23 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id o5so797059qke.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 16:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o8jHrcuT+UhHm+x4p55K5Cj+RnXI4w9eRakLutqS70Q=;
        b=fjSVHbuknhuGPTE8g56tCpaf7IzInC7bCV7CouEraDVgjHPM8nUB8dIS/iH38ZK3xM
         DBszpcs6gE03JkVE5Fm8RFdEEKqswgNUEQ75tG5V1QoOmFo+boXLEX6xtFTBuQgzdiOr
         YaxlzXset6AhJ50QnlFDGq4s9+hsDMqyjeGTVCmZtpIgeu0jc11/+Lct/6zj0UMOSvo3
         1RXJGwNM3+1D/YgII9Paa2mKaIEbH8F1UWDAl4YycHvPpbgbIyKCfpFLIFeKganR2XNL
         WJmj5Wl5y9BpW1eotsz9oSKFzMVj3kfBAgTUgJ1qQSjEJmmIyvBU6MVukOa4OciisnuV
         N30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o8jHrcuT+UhHm+x4p55K5Cj+RnXI4w9eRakLutqS70Q=;
        b=kP/cTL61lc3esoSkqccsjXtf6J1yaQDxwf/Mv4TF3ly/ljO6t/7P2xzjf5BtVo5bAk
         hIulj40S8EsxC4kwBBtVkulKbrD3OpR9fOnmc9nLylm7CG0ZTsfyMVc/TH7NjxSGStEb
         9RHzfUVVgavBrkIU8tPxuhptGDQFW2wO660Rns8rcV89ICr+kLqoPHIo15rCQ5oeC807
         iVsX5hNW0/2v+vDr5fG7LqYv+Qoc57yRo2xqMsviLmSEZNft5YLK/hX9nOo7gSf/fo56
         MeJhxkXji+eL2Xzj2QDDL7hX4EPPM7oYrG4DtfQZjaKcJsxqt3fhcJbaakPDtNY8jP+x
         05eQ==
X-Gm-Message-State: AOAM530wf0mWRx+/7M3E6dXmYVDcfXCCrWXhkeW2ZA43hAejydLTrRWc
        oo0Dim32P8oshZOKk6a/Rwf1Hw==
X-Google-Smtp-Source: ABdhPJyaIuJjWPQ2j+zsck3b5R1hIgcLf9K+Aq2lUdkNJPfgl1QB/eHwhvXDWRRr2hKtT1Tmp68ZNg==
X-Received: by 2002:a05:620a:14b0:: with SMTP id x16mr852709qkj.441.1599607942247;
        Tue, 08 Sep 2020 16:32:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id i10sm783768qkh.15.2020.09.08.16.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 16:32:21 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kFn64-0038Dy-MG; Tue, 08 Sep 2020 20:32:20 -0300
Date:   Tue, 8 Sep 2020 20:32:20 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Mateusz Nosek <mateusznosek0@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: [PATCH] mm/mmu_notifier.c: micro-optimization substitute kzalloc
 with kmalloc
Message-ID: <20200908233220.GC87483@ziepe.ca>
References: <20200906114321.16493-1-mateusznosek0@gmail.com>
 <20200906142645.GA1976319@kernel.org>
 <39c79454-9a97-2c06-3186-939c1f3a2b27@gmail.com>
 <20200908064245.GE1976319@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908064245.GE1976319@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 09:42:45AM +0300, Mike Rapoport wrote:
> On Sun, Sep 06, 2020 at 06:06:39PM +0200, Mateusz Nosek wrote:
> > Hi,
> > 
> > I performed simple benchmarks using custom kernel module with the code
> > fragment in question 'copy-pasted' in there in both versions. In case of 1k,
> > 10k and 100k iterations the average time for kzalloc version was 5.1 and for
> > kmalloc 3.9, for each iterations number.
> > The time was measured using 'ktime_get(void)' function and the results given
> > here are in ktime_t units.
> > The machine I use has 4 core Intel(R) Core(TM) i5-3470 CPU @ 3.20GHz CPU.
> > 
> > The performance increase happens, but as you wrote it is probably not really
> > noticeable.
> 
> I don't think that saving a few cylces of memset() in a function that
> called only on the initialization path in very particular cases is worth
> risking uninitialized variables when somebody will add a new field to
> the 'struct mmu_notifier_subscriptions' and will forget to explicitly
> set it.

Indeed, it is not a common path, it is already very expensive if code
is running here (eg it does mm_take_all_locks()).

So there is no reason at all to optimize this and risk problems down
the road.

Jason
