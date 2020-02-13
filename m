Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB957C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 11:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B245D218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 11:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qVVIbygX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729911AbgBMLiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 06:38:20 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40982 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729531AbgBMLiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 06:38:20 -0500
Received: by mail-qt1-f193.google.com with SMTP id l21so4091434qtr.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 03:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PjmkkFzgtjZ/QS2g7YjgibuqZHgtw/RNL1AtsboLREc=;
        b=qVVIbygXYBc33x42k66krjJYZEisxQv50r89SaxKqM0SGuZaq3kscj5vXKPmtWs/iX
         jMbZZKRvdzPq0GKAKu0g+vYmW9NCVVkTpBkgh+45N35QdnOmdrp0cf5a/gRcRKH71HTe
         g3n02MxEW/sTtMpubWeXIKdcIN+D4sxhpnaFvUMVFPMB/faf9138uQl4gSIaT4ojF3xx
         V7C/UMRFWs+URQRe8YasZaTNeeFhUhSLefqalj5aX+gF6phpFLopqwjLgm/kESvh/1S5
         piWUVC0KHKn4CXzSL8vqIOOBe0uXsx8ZElpwH1gEGLE6wjiFYkMBm06VkiAjuRvBIQgw
         7oEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PjmkkFzgtjZ/QS2g7YjgibuqZHgtw/RNL1AtsboLREc=;
        b=NBdnVHBbQLM9KXBzmwPvqVWXTostizI7Cd7BFOH4Gxucp7IMHgwbsvcCiKSAupkLQB
         /OBZwqg/wo+rLHuO2byQ2GfghRTR0NnEA/TedZm8bdpvJUo0So6WjChde83Fvg5OJ/Th
         4Qvm2X5D3qf4DoYORWfKPSKBMoh0LhJD8Dk0LTYXVdWUVEMdj7k3c7IXNGZ/wefdZKgJ
         Fbhzyz4ezPcRSRq9JQ3Kr9rsjePREkWLmwa4f14+fHR1tXK7v5t8bDGKOls3NioGO3iF
         oIG9k3NOxhJ8Ad9rBqHUztu8Jyp06gi0ukugwwOLvaC1GSiAkWeasAXDNi3/I1ZgQeDk
         tsIA==
X-Gm-Message-State: APjAAAVs2KHewYzXJfmVOd/EKiTEMGP1OI1d+WdeB6OJSWwB8YJ1poF2
        gL6wgYXGjPnVWbpKnrm7mT0=
X-Google-Smtp-Source: APXvYqxYAYg+ls14eD0cJg/qIfOQV2XNKSV1u31QwajkXG5FyKvmlw35lQVfhZ8LOxm3362w8ajhCg==
X-Received: by 2002:ac8:1ca:: with SMTP id b10mr11070659qtg.314.1581593899066;
        Thu, 13 Feb 2020 03:38:19 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id p19sm1313008qte.81.2020.02.13.03.38.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Feb 2020 03:38:18 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id EE53822023;
        Thu, 13 Feb 2020 06:38:17 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 13 Feb 2020 06:38:17 -0500
X-ME-Sender: <xms:JjVFXvUkt2cEIqWPtabxXB8eSLxXVzNRvAd4lAdL5r00GaGtKZSxHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrieekgddvlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucffohhmrghinh
    epghhithhhuhgsrdgtohhmnecukfhppeehvddrudehhedrudduuddrjedunecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvsh
    hmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheeh
    vddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:JjVFXtH5qYZQ8INyaZo_5E1ZBcJQUoZJLpjIn3OPKD8EklIqSfH24g>
    <xmx:JjVFXju7l_m9_-CTZyN5dtvioYofqqAYlARw0oBKFwFKxJsAi6mu7A>
    <xmx:JjVFXoZ57PdqP3sJZ2Ho69F6gS3PM9Dfw-_JvKHypLZzS6DMiimyrQ>
    <xmx:KTVFXorctqNbphR6PJ3OB7E-Aqn_V8O9xoLNxDj0rONthmt97PrKvzN8MpI>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id C1B1B328005D;
        Thu, 13 Feb 2020 06:38:13 -0500 (EST)
Date:   Thu, 13 Feb 2020 19:38:12 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        arnd@arndb.de,
        Stefan Asserhall load and store 
        <stefan.asserhall@xilinx.com>, Will Deacon <will@kernel.org>,
        paulmck@kernel.org, parri.andrea@gmail.com
Subject: Re: [PATCH 7/7] microblaze: Do atomic operations by using exclusive
 ops
Message-ID: <20200213113812.GG69108@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <cover.1581522136.git.michal.simek@xilinx.com>
 <ba3047649af07dadecf1a52e7d815db8f068eb24.1581522136.git.michal.simek@xilinx.com>
 <20200212155500.GB14973@hirez.programming.kicks-ass.net>
 <4b46b33e-14ad-7097-f0db-2915ac772f15@xilinx.com>
 <20200213085849.GL14897@hirez.programming.kicks-ass.net>
 <20200213113432.GF69108@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213113432.GF69108@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Forget to copy Andrea in the previous email)

Andrea, could you tell us more about how to use klitmus to generate test
modules from litmus test?

Regards,
Boqun

On Thu, Feb 13, 2020 at 07:34:32PM +0800, Boqun Feng wrote:
> On Thu, Feb 13, 2020 at 09:58:49AM +0100, Peter Zijlstra wrote:
> [...]
> > 
> > > Also is there any testsuite I should run to verify all these atomics
> > > operations? That would really help but I haven't seen any tool (but also
> > > didn't try hard to find it out).
> > 
> > Will, Paul; can't this LKMM thing generate kernel modules to run? And do
> 
> The herd toolset does have something called klitmus:
> 
> "an experimental tool, similar to litmus7 that runs kernel memory model
> tests as kernel modules."
> 
> I think Andrea knows more about how to use it.
> 
> > we have a 'nice' collection of litmus tests that cover atomic_t ?
> > 
> 
> There is a few in Paul's litmus repo:
> 
> 	https://github.com/paulmckrcu/litmus/tree/master/manual/atomic
> 
> Maybe a good start?
> 
> Regards,
> Boqun
> 
> > The one in atomic_t.txt should cover this one at least.
