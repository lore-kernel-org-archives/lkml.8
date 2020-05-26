Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D384C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 10:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F3D12073B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 10:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JO05icFZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388673AbgEZKn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 06:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388622AbgEZKn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 06:43:27 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32979C03E97E
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 03:43:27 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id t11so9920052pgg.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 03:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8vLgjzSO/LxApXStr6hj3HmlT19nlNPyYTwZYXJ6lsI=;
        b=JO05icFZ2oOl/2ZydYLDpoc/seP84LVDwFA4hznRqc7Lu0yJLk0v/w6NbHZzhsxjuS
         gg4jMSyfdmLwLM60OHlDX4Y3MVOV5TzoPG6xd9yxGCw0ja35SqLsoypvbzE31UCzcSqq
         OcRIb0hIT5TTpShmMiKtTmXK7rs/ssU+M4bDNUVZhCvFWzRlyEcirejoD5UfZKvX9S1D
         Csq7H849+0mQBVi8tr5j0FQW0W+huh+OIzF9MT9AoRLcmTt9ZGDiGrrZbmZLlhGiqTUe
         pBl4aglramB7+ZeBDEIXs8Rg3R6u5K6cUYUYIU3VpEHNEvdbbuyaAXJc7R6aQoO0Mlzk
         vfcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8vLgjzSO/LxApXStr6hj3HmlT19nlNPyYTwZYXJ6lsI=;
        b=clKzp994yPIRb8+a2rXiFIeUOWjGD+3FPj2JxipBNlr1nBsupc4ta8GVLIrJtU4nXq
         p1iIXkfDyDKIVsc7BrP4/qL1t8D0XI1krvj3/pi5vSs7+g0lfuudJhI98IA0EtijF5aj
         XiiO2geKEnXvIp8S4GDkyagA9ghw1mztGPhvRoeOT8MMI/eUFFY9DO7E1r+jMc3HPW8X
         JdoIBaqFi0bBDIprAPqxGljPA6t37ih5PGyfaZJu2O5Yh9FqNLaKs1oeTfKdvgWp7eLv
         HtrrLWeKCxoeSy/AMkr+7gCVDGcsY97fquiFBc9sV0RIuBB7wU7+ctSvsBiO5FpkL1Si
         VSLw==
X-Gm-Message-State: AOAM533J1WtegY0pmEbqJ7Hw5XtkifEqRlecHF7ATUa7IPeEBj5j/SRt
        ReDoeVgqO/TNuURw/f8y1+dDHQ==
X-Google-Smtp-Source: ABdhPJxiGuXC9T8/0vvEp1ide6CNqP2MI7swVISrxEein7BriB8dAwfiHIb1d2IH6djWdEDEo+E4iQ==
X-Received: by 2002:a65:67d0:: with SMTP id b16mr437917pgs.91.1590489806616;
        Tue, 26 May 2020 03:43:26 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id s15sm13277931pgv.5.2020.05.26.03.43.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 May 2020 03:43:26 -0700 (PDT)
Date:   Tue, 26 May 2020 18:43:37 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Will Deacon <will@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Al Grant <al.grant@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>
Subject: Re: [PATCH v7 0/3] perf arm-spe: Add support for synthetic events
Message-ID: <20200526104337.GA7154@leoy-ThinkPad-X240s>
References: <20200504115625.12589-1-leo.yan@linaro.org>
 <20200522030919.GE32389@leoy-ThinkPad-X240s>
 <20200526102602.GA27166@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526102602.GA27166@willie-the-truck>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On Tue, May 26, 2020 at 11:26:03AM +0100, Will Deacon wrote:
> On Fri, May 22, 2020 at 11:09:19AM +0800, Leo Yan wrote:
> > On Mon, May 04, 2020 at 07:56:22PM +0800, Leo Yan wrote:
> > > This patch set is to support synthetic events with enabling Arm SPE
> > > decoder.  Since before Xiaojun Tan (Hisilicon) and James Clark (Arm)
> > > have contributed much for this task, so this patch set is based on their
> > > privous work and polish for the version 7.
> > > 
> > > The main work in this version is to polished the core patch "perf
> > > arm-spe: Support synthetic events", e.g. rewrite the code to calculate
> > > ip, packet generation for multiple types (L1 data cache, Last level
> > > cache, TLB, remote access, etc).  It also heavily refactors code for
> > > data structure and program flow, which removed unused fields in
> > > structure and polished the program flow to achieve neat code as
> > > possible.
> > > 
> > > This patch set has been checked with checkpatch.pl, though it leaves
> > > several warnings, but these warnings are delibarately kept after
> > > reviewing.  Some warnings ask to add maintainer (so far it's not
> > > necessary), and some warnings complaint for patch 02 "perf auxtrace:
> > > Add four itrace options" for the text format, since need to keep the
> > > consistency with the same code format in the source code, this is why
> > > this patch doesn't get rid of checkpatch warnings.
> > 
> > Gentle ping ...
> > 
> > It would be appreciate if can get some review for this patch set.
> 
> I was hoping that James Clark would have a look, since he was the last
> person to go near the userspace side of SPE.

Yes, I have offline synced with James and James has verified this
patch set at his side.

I don't want to rush to ask Arnaldo to merge patches, so just
want to get wider reviewing if possible; otherwise, I will rebase this
patch set and resend to ML.

Thanks,
Leo
