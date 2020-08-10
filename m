Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0114C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 14:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B928220B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 14:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Ole9foJp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgHJOvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 10:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbgHJOvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 10:51:11 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6877CC061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 07:51:11 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id s16so6909397qtn.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 07:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4aZ52qCxnYvMfbknflPb2u1mseuw+l9ZuJed3m/JJv4=;
        b=Ole9foJpZfRQzAa3/a03VZ+EvcIZf8wVs3U+mzf0dyFUFT713cS0DYrZX8hVxEL+rj
         aluj36HVLrIb5pJ7bb+OVTcit2wqyCrD4/Ta8VqFnXpVFXXiRkXxNV16TldGaWvAzYkm
         kdGIr/xGnnyh5PMl86MtyWj92TLy2WtlObTopiDtuVTsBX+TtCRql2Sc3C1PdtibvHoJ
         fRFXlohpowl2hLMG/MrCoUWlleloKfiBp2jOVw8KUvqob1anv4Vk79JyZ8hvPXgHZp5r
         rZ8MaLCMlVNxpHl39JavfaGQYq1maekj665NDxBrjiATtDYQOZ8p/X1NOLX3z2ugci4m
         Otgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4aZ52qCxnYvMfbknflPb2u1mseuw+l9ZuJed3m/JJv4=;
        b=U0hDOFX8kFlu0m5kyP47bjJ7Nz6BKVQTvq9ILDBUeS+vVmwkJn+XnKby9xL+uPj0xE
         vPKffkIbE9P0w3iNnRaZpX/k0mFWWMUFhTPzJxmbZ6W5qk0Bz7te8XLGuzAmpOMsPxz2
         UhgLp+3gWwNgi0TcbE+U1YtcWfQVJphYPArJoeP7qGez1+rRsJv0smCfioFzvoW7Vgo6
         VfJi13hziwk8XTwrd++OP4NDMsr/X2kuWW7jrzIobvMu9NS2EwxPPOlBPuqto/nzYHhV
         eRfF1Dk1iP3UOuKdtkiej2KQKdwYD687q7NOdGwJHkqFHWoEx5l63fC0Tjl/02B0sgMe
         zeGQ==
X-Gm-Message-State: AOAM530wqT8G3GiE4TJM9PLtvO+IKsqz3vfw/Z2p+BMIZzYqdJhlRoaX
        p1jcrjN6oW03w8/BHO7JDL48fg==
X-Google-Smtp-Source: ABdhPJwfxMiy6K8geUCUuwGC7Vu2zhXPaDAGpBinUKGccsGsPBodxdHZ6OQX3jnr0KG+zijtAUG9zQ==
X-Received: by 2002:ac8:5685:: with SMTP id h5mr28435277qta.378.1597071068740;
        Mon, 10 Aug 2020 07:51:08 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id g49sm17027037qtk.74.2020.08.10.07.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 07:51:08 -0700 (PDT)
Date:   Mon, 10 Aug 2020 10:51:05 -0400
From:   Qian Cai <cai@lca.pw>
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 0/5] kasan: add workqueue and timer stack for generic
 KASAN
Message-ID: <20200810145104.GB5307@lca.pw>
References: <20200810072115.429-1-walter-zh.wu@mediatek.com>
 <B873B364-FF03-4819-8F9C-79F3C4EF47CE@lca.pw>
 <1597060257.13160.11.camel@mtksdccf07>
 <20200810124430.GA5307@lca.pw>
 <1597069882.13160.23.camel@mtksdccf07>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1597069882.13160.23.camel@mtksdccf07>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 10:31:22PM +0800, Walter Wu wrote:
> On Mon, 2020-08-10 at 08:44 -0400, Qian Cai wrote:
> > On Mon, Aug 10, 2020 at 07:50:57PM +0800, Walter Wu wrote:
> > > On Mon, 2020-08-10 at 07:19 -0400, Qian Cai wrote:
> > > > 
> > > > > On Aug 10, 2020, at 3:21 AM, Walter Wu <walter-zh.wu@mediatek.com> wrote:
> > > > > 
> > > > > ﻿Syzbot reports many UAF issues for workqueue or timer, see [1] and [2].
> > > > > In some of these access/allocation happened in process_one_work(),
> > > > > we see the free stack is useless in KASAN report, it doesn't help
> > > > > programmers to solve UAF on workqueue. The same may stand for times.
> > > > > 
> > > > > This patchset improves KASAN reports by making them to have workqueue
> > > > > queueing stack and timer queueing stack information. It is useful for
> > > > > programmers to solve use-after-free or double-free memory issue.
> > > > > 
> > > > > Generic KASAN will record the last two workqueue and timer stacks,
> > > > > print them in KASAN report. It is only suitable for generic KASAN.
> > > > > 
> > > > > In order to print the last two workqueue and timer stacks, so that
> > > > > we add new members in struct kasan_alloc_meta.
> > > > > - two workqueue queueing work stacks, total size is 8 bytes.
> > > > > - two timer queueing stacks, total size is 8 bytes.
> > > > > 
> > > > > Orignial struct kasan_alloc_meta size is 16 bytes. After add new
> > > > > members, then the struct kasan_alloc_meta total size is 32 bytes,
> > > > > It is a good number of alignment. Let it get better memory consumption.
> > > > 
> > > > Getting debugging tools complicated surely is the best way to kill it. I would argue that it only make sense to complicate it if it is useful most of the time which I never feel or hear that is the case. This reminds me your recent call_rcu() stacks that most of time just makes parsing the report cumbersome. Thus, I urge this exercise to over-engineer on special cases need to stop entirely.
> > > > 
> > > 
> > > A good debug tool is to have complete information in order to solve
> > > issue. We should focus on if KASAN reports always show this debug
> > > information or create a option to decide if show it. Because this
> > > feature is Dimitry's suggestion. see [1]. So I think it need to be
> > > implemented. Maybe we can wait his response. 
> > > 
> > > [1]https://lkml.org/lkml/2020/6/23/256
> > 
> > I don't know if it is Dmitry's pipe-dream which every KASAN report would enable
> > developers to fix it without reproducing it. It is always an ongoing struggling
> > between to make kernel easier to debug and the things less cumbersome.
> > 
> > On the other hand, Dmitry's suggestion makes sense only if the price we are
> > going to pay is fair. With the current diffstat and the recent experience of
> > call_rcu() stacks "waste" screen spaces as a heavy KASAN user myself, I can't
> > really get that exciting for pushing the limit again at all.
> > 
> 
> If you are concerned that the report is long, maybe we can create an
> option for the user decide whether print them (include call_rcu).
> So this should satisfy everyone?

Adding kernel config options is just another way to add complications with real
cost. The only other way I can think of right now is to create some kinds of
plugin systems for kasan to be able to run ebpf scripts (for example) to deal
with those special cases.
