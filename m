Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13DBC3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 04:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7666C246A1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 04:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/VnF2uy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730862AbgB1EDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 23:03:13 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:36601 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730736AbgB1EDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 23:03:12 -0500
Received: by mail-pj1-f68.google.com with SMTP id gv17so722092pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 20:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n06LPF76AGlFyu3px3XA7keYv9Nj0np/EAZ7d2DaCjk=;
        b=E/VnF2uyJTkB+VM5CNaV5k0gccIMZAi3b3mcDfzYqsYfIoZ63P1LHZFJpO2Goiv8MX
         gFMRgrh4f3tV6czHNvtZfkGCdeJhu9xp/62UtHLQUxC75KIzHA5Jlr9GfG49FdvStlLF
         L5Qpm7CXg6odc9iYpa0wxXJ8bDOAI5PUznqNj41wsFYE/0B3XO/uMfBkpJJguq2pMXTX
         PClxs4RQEFCearSfKiNoXelt/3EWBTCWvXr6sthJh9WU9Y+/IFvhqC3g+xC01C74ltu2
         5VmkOgYrvCq3gxdz+JB9I1s1xAzPZPGtG/iYFWFWW/GYdmPJGESTD6kyyWoSHU5fifyo
         Ss6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n06LPF76AGlFyu3px3XA7keYv9Nj0np/EAZ7d2DaCjk=;
        b=nCAhbfIUEGlN/Eim6/quyjJdABnFlPexTx7LsNScgsrrIaWRwxVoHkPlMygThiTypT
         oDZwfxN6L7410a37A+FBAeQBWj9sEYG+gjd2BiCZ/ERcr+bnoaAIRZi/Jh8S89x+mxvX
         v0Zwr0RovuaGcYVb3BpsB3uijytBPNSI82FuaxeUFdjDGTeSOVj6Tlu+p/VeodkSUERq
         O164uTjZWTdy7sGgBz1U1p/EkXNf0jj0qx0xFk8FtbZZ+YX2LHquhUWECgvPNrqZFI5g
         KutC0vMIkYLWvT5tbBroUbT3tLYwe/Vzn/jzWCltAWmsLc0tuIpBgpImXSwGmw/30UjP
         Pm6w==
X-Gm-Message-State: APjAAAWI0LApEBv0vE81RGo9uI6EYOmpw3Lhwu0XTLTtoNJpZhmcaUM7
        gS3t3CyzfC/Ah41I03M2Vqs=
X-Google-Smtp-Source: APXvYqyzsTaCPNcK0kE9GMAKVJzjfmXwp/cufCznytHLEzdjK8vt+n6gEuIHuExc4F3uSt6/RR3Y1Q==
X-Received: by 2002:a17:902:264:: with SMTP id 91mr2138284plc.335.1582862591643;
        Thu, 27 Feb 2020 20:03:11 -0800 (PST)
Received: from js1304-desktop ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id u7sm8640380pfh.128.2020.02.27.20.03.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Feb 2020 20:03:11 -0800 (PST)
Date:   Fri, 28 Feb 2020 13:03:03 +0900
From:   Joonsoo Kim <js1304@gmail.com>
To:     Aaron Lu <aaron.lwe@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com
Subject: Re: [PATCH v2 0/9] workingset protection/detection on the anonymous
 LRU list
Message-ID: <20200228040214.GA21040@js1304-desktop>
References: <1582175513-22601-1-git-send-email-iamjoonsoo.kim@lge.com>
 <20200226193942.30049da9c090b466bdc5ec23@linux-foundation.org>
 <20200227134806.GC39625@cmpxchg.org>
 <20200228032358.GB634650@ziqianlu-desktop.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228032358.GB634650@ziqianlu-desktop.localdomain>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Feb 28, 2020 at 11:23:58AM +0800, Aaron Lu wrote:
> On Thu, Feb 27, 2020 at 08:48:06AM -0500, Johannes Weiner wrote:
> > On Wed, Feb 26, 2020 at 07:39:42PM -0800, Andrew Morton wrote:
> > > It sounds like the above simple aging changes provide most of the
> > > improvement, and that the workingset changes are less beneficial and a
> > > bit more risky/speculative?
> > > 
> > > If so, would it be best for us to concentrate on the aging changes
> > > first, let that settle in and spread out and then turn attention to the
> > > workingset changes?
> > 
> > Those two patches work well for some workloads (like the benchmark),
> > but not for others. The full patchset makes sure both types work well.
> > 
> > Specifically, the existing aging strategy for anon assumes that most
> > anon pages allocated are hot. That's why they all start active and we
> > then do second-chance with the small inactive LRU to filter out the
> > few cold ones to swap out. This is true for many common workloads.
> > 
> > The benchmark creates a larger-than-memory set of anon pages with a
> > flat access profile - to the VM a flood of one-off pages. Joonsoo's
> 
> test: swap-w-rand-mt, which is a multi thread swap write intensive
> workload so there will be swap out and swap ins.
> 
> > first two patches allow the VM to usher those pages in and out of
> 
> Weird part is, the robot says the performance gain comes from the 1st
> patch only, which adjust the ratio, not including the 2nd patch which
> makes anon page starting from inactive list.
> 
> I find the performance gain hard to explain...

Let me explain the reason of the performance gain.

1st patch provides more second chance to the anonymous pages.
In swap-w-rand-mt test, memory used by all threads is greater than the
amount of the system memory, but, memory used by each thread would
not be much. So, although it is a rand test, there is a locality
in each thread's job. More second chance helps to exploit this
locality so performance could be improved.

Thanks.
