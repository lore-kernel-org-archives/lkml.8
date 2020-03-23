Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AEBC3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 16:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C63420409
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 16:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAd67+xl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbgCWQPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 12:15:44 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34823 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgCWQPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 12:15:44 -0400
Received: by mail-pg1-f195.google.com with SMTP id 7so7441221pgr.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 09:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xLwD/FbGk+fl6Ia4f9QV2q2Qg8OF8NvDOb/WEjHeVu8=;
        b=dAd67+xluNStPH4A7RmwpooNmZSRUGQuFCRPTWzplBUWQGqGTHYXGS0x4UgUGRPk4S
         7jemSrJFWPrerO4slWOrrvl4D3Ys0T7iRHDq7j3ENWlAwU8YZa88zTCZvIHNfxhWTyIT
         5qMWWhEZvj5mnQ2S1gTXn+UbWh7n0dNrnSHrZVfZhLE9OyEXsH1KE2N5YSbA6I9WK1FO
         aUvGXoR1yXSDMSQ+f0P7QoxkYGsyAXitduZHvp+vN/KdZwH780uIMNSQgsL/KWJO+teY
         4T1D4gV9SMYnABXrJuPSBiyp0bEBqHcC0PCHWU8PaVhBufcLNjevmwXtUZ5pdPfm9wrH
         ei0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xLwD/FbGk+fl6Ia4f9QV2q2Qg8OF8NvDOb/WEjHeVu8=;
        b=IEUx51a8umuepys/zNPotjjBICexAPSDNX+JmxAKOF2T4FTRmyuw05l1FRny0wa3+G
         6HKhF5Q7ucP9mFLxHnL26u2UStEDzIu9jczFq0xZi3Hw0HNhl4BHv3UosmKjzrpl+SnJ
         d00lvC/JOsBAU26hXRdBfqlxsNHWqF/iNoeSHsrlW4XYIXbvO+MUf1fW7TPuWLpAsmtk
         yXrJdEteXzVdE1dgF/U9/DiEbLwOarcu/al+kohzs+24gdHEUS86zWG6rY6MJsc+6CpB
         +ACdKHPeOR87P4GNutjBn9MKF1NXXqDKikzeSm96Yy0g4J7y/28MwsvVtRDAS/W9RGb7
         id3g==
X-Gm-Message-State: ANhLgQ1T2k9t+f1hYyf2tK1camb0bTIi0dRIf+Y2x8FLIWaZC3mSlqJd
        82I26SS27VsiPq3+HOHJn+tVtdEm
X-Google-Smtp-Source: ADFU+vsKdeRG2+FWZrh+QHftQfkLCC4yjakXhIm+XlCBS92GBEchwHs7nwReUv42QcfZw5w9tXnFyw==
X-Received: by 2002:a62:8202:: with SMTP id w2mr24688899pfd.117.1584980143016;
        Mon, 23 Mar 2020 09:15:43 -0700 (PDT)
Received: from mail.google.com ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id mq18sm44939pjb.6.2020.03.23.09.15.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Mar 2020 09:15:42 -0700 (PDT)
Date:   Mon, 23 Mar 2020 16:15:40 +0000
From:   Changbin Du <changbin.du@gmail.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Changbin Du <changbin.du@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Two questions about cache coherency on arm platforms
Message-ID: <20200323161537.ptjrihqotgmon7tr@mail.google.com>
References: <20200323123524.w67fici6oxzdo665@mail.google.com>
 <20200323131720.GE2597@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200323131720.GE2597@C02TD0UTHF1T.local>
User-Agent: NeoMutt/20180716-508-7c9a6d
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,
Thanks for your answer. I still don't understand the first question.

On Mon, Mar 23, 2020 at 01:17:20PM +0000, Mark Rutland wrote:
> On Mon, Mar 23, 2020 at 08:35:26PM +0800, Changbin Du wrote:
> > Hi, All,
> > I am not very familiar with ARM processors. I have two questions about
> > cache coherency. Could anyone help me?
> > 
> > 1. How is cache coherency maintenanced on ARMv8 big.LITTLE system?
> > As far as I know, big cores and little cores are in seperate clusters on
> > big.LITTLE system.
> 
> This is often true, but not always the case. For example, with DSU big
> and little cores can be placed within the same cluster.
>
Yes, it is ture for DynamIQ that bl cores can be placed within the same cluster.
But I don't understand how linux support big.LITTLE before DynamIQ.

I read below description in ARM Cortex-A Series Programmer’s Guide for
ARMv8-A.
 | big.LITTLE software models require transparent and efficient transfer of data between big and LITTLE clusters.
 | Coherency between clusters is provided by a cache-coherent interconnect such as the ARM CoreLink CCI-400 described in Chapter 14.

So I think  big cores and little cores are in different clusters in this
case. Then we are not within the same Inner Shareable domain?

> > And cache coherence betwwen clusters requires the
> > memory regions are marked as 'Outer Shareable' and is very expensive.
> 
> This is not correct.
> 
> Linux requires that all cores it uses are within the same Inner
> Shareable domain, regardless of whether they are in distinct clusters.
> Linux does not support systems where cores are in distinct Inner
> Shareable domains.
>
I see. Thanks.

> This is the intended use of the architecture. Per ARM DDI 0487E.a page
> B2-144:
> 
> | This architecture assumes that all PEs that use the same operating
> | system or hypervisor are in the same Inner Shareable shareability
> | shareability
> 
> ... where a PE is a "Processing Element", which you can think of as a
> single core.
> 
> > I have checked the kernel code, and seems it only requires coherence in
> > 'Inner Shareable' domain. So my question is how can linux guarantees
> > cache coherence in 'CPU migration' or 'Global Task Scheduling' models
> > wich both clusters are active at the same time? For example, a thread
> > ran in Cluster A and modified 'Inner Shareable' memory, then it migrates
> > to Cluster B.
> 
> As above, this works because all the relevant cores are within the same
> Inner Shareable domain.
> 
> > 2. ARM64 cache maintenance code sync_icache_aliases() for non-aliasing icache.
> > In linux kernel on arm64 platform, the flow function sync_icache_aliases()
> > is used to sync i-cache and d-cache. I understand the aliasing case. but
> > for non-aliasing case why it just does "dc cvau" (in __flush_icache_range())
> > whithout really invalidate the icache?
> 
> The __flush_icache_range/__flush_cache_user_range assembly function does
> both the D-cache maintenance with DC CVAU, then the I-cache maintenance
> with IC IVAU, so I think you have misread it.
>a
Yes. I missed the IC IVAU instruction defined in macro
invalidate_icache_by_line.

> Thanks,
> Mark.
> 
> > Will i-cache refill from L2 cache?
> >
> > void sync_icache_aliases(void *kaddr, unsigned long len)
> > {
> > 	unsigned long addr = (unsigned long)kaddr;
> > 
> > 	if (icache_is_aliasing()) {
> > 		__clean_dcache_area_pou(kaddr, len);
> > 		__flush_icache_all();
> > 	} else {
> > 		/*
> > 		 * Don't issue kick_all_cpus_sync() after I-cache invalidation
> > 		 * for user mappings.
> > 		 */
> > 		__flush_icache_range(addr, addr + len);
> > 	}
> > }
> > 
> > -- 
> > Cheers,
> > Changbin Du

-- 
Cheers,
Changbin Du
