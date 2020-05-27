Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC10C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17EE821534
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="wr9R8e/k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390840AbgE0QIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 12:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390822AbgE0QIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 12:08:49 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35216C03E97D
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 09:08:48 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id x12so19569078qts.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 09:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w8h0j9dH4yYJY4/vfPJevkjnamNxkzeTwIjaJ077JR0=;
        b=wr9R8e/kt+6YZN51MgGSrgrQKN+iV0+U0w3YDiUZds+tcdj7UMMAPuL2YRAryMtohX
         VNKbvNrG4bIjPWETOEhzA2c4U/E+X4CVY2EgJ/5ySPQ3LlqJidyQIRGPfTzASiiFnl+S
         uHmbW0X2xvXgxyXg4abfE1eHxfYdyOP2KHd5y4aqtb2dKO5FWfHDDlvh4G4leXuoDM2X
         6k6SD1XYo3XXhbqc/Ijv/Mz+1Egec9v2tRNzcTRPdOlPecpv6ZUeA9Eni8M8qGoWVGYI
         25JlCJx5lZcI/qzgwceu2T05yXTObMsf3EZfQHFHZ6afE2C5Lsf9qFojbh1qNErXd8RZ
         b0/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w8h0j9dH4yYJY4/vfPJevkjnamNxkzeTwIjaJ077JR0=;
        b=M71WRA4YM3CJQZGux5zl13T0E4+9sWEVz0ZioH1Egg7nqKSzJW9zZqToUsCdY0ZtHt
         JK7RuQcu6xNjHPvC/RsghXJ8Kku6+W5VpDkSAY9ZWJ9ZACIwjWYn58KounR44SqNvgO+
         BB2zF4r5loh/kvW6V0oCSc7rE6lX/yREJydEZ0Ey0KqLCLidhAME+ZNfeC6LLl3/7cUy
         /csH1Cr+1fDRdYcxY8MyjKzeBrrNEtlLO8OH2QPJ0O3Ck1CTclzOrCDaPWDVEvbZzr2O
         fyyEvOxCGnEsIFwP+AeItVyJzqUhCRUIxj7+rFaGw9WwHUVdis1l/QtXUqbEvbvPPkc6
         ibpw==
X-Gm-Message-State: AOAM530qT2yCbkYhCvYz3H3Fb13vGkEGK2iU22v7iR8W8mvzDzkSHPCI
        aGoJCn4tbWDrCdA3jPEj0wKdoL+YUw4=
X-Google-Smtp-Source: ABdhPJy5UGsbDyy2tFB1CZRSSq0mPUHmpiz0WO0wsfMt60nuAnhNi+TNUDnh/WaDsCnTkdOrWSy7Rg==
X-Received: by 2002:ac8:42ce:: with SMTP id g14mr4989535qtm.117.1590595727478;
        Wed, 27 May 2020 09:08:47 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2535])
        by smtp.gmail.com with ESMTPSA id f14sm2558579qka.70.2020.05.27.09.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 09:08:46 -0700 (PDT)
Date:   Wed, 27 May 2020 12:08:21 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Boris Burkov <boris@bur.io>
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH cgroup/for-5.8] cgroup: add cpu.stat file to root cgroup
Message-ID: <20200527160821.GC42293@cmpxchg.org>
References: <20200526200800.3969430-1-boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526200800.3969430-1-boris@bur.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 01:08:00PM -0700, Boris Burkov wrote:
> Currently, the root cgroup does not have a cpu.stat file. Add one which
> is consistent with /proc/stat to capture global cpu statistics that
> might not fall under cgroup accounting.
> 
> We haven't done this in the past because the data are already presented
> in /proc/stat and we didn't want to add overhead from collecting root
> cgroup stats when cgroups are configured, but no cgroups have been
> created.
> 
> By keeping the data consistent with /proc/stat, I think we avoid the
> first problem, while improving the usability of cgroups stats.
> We avoid the second problem by computing the contents of cpu.stat from
> existing data collected for /proc/stat anyway.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> Suggested-by: Tejun Heo <tj@kernel.org>

Looks good to me, but Boris can you please update
Documentation/admin-guide/cgroup-v2.rst as well in this patch?

  cpu.stat
        A read-only flat-keyed file which exists on non-root cgroups.

Thanks!
