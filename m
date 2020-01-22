Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A60DC33CAF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 18:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D0A121734
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 18:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579718298;
	bh=fGbpvtFKQaZfdrH7d9vzQ8GEFK4oxdJjis+fNBQ2s60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l4sE1EdDHOqCOkJbiNeNp+sG/vQ9TSbH8TwDnGBWqpzqD1D7qsJLYZwdzx+CM6uWJ
	 +xtWvAG9CUyGMHusYEvPRnI6alPmcYWi2iGxGV6vRk5ShqOb/ZjKQhIcSHu15EzK2K
	 xm1rhayLFAiJ+MIx0Pi39bMWkEQ+RcW0vGub+rqY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgAVSiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 13:38:17 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53542 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgAVSiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 13:38:16 -0500
Received: by mail-wm1-f66.google.com with SMTP id m24so140168wmc.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 10:38:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=966BgYgZRUlLppOTZ8GZw5dVZmBTcRyeqAhJa9bwYzU=;
        b=DYfHAjx7twU4SPZDvRNfCHI0viHQbc6AaSjHitsYODC/o7cqvw6mPOT8re8rPmGAsd
         ppCNce7zf5ZgIz1hoYa12zq7xSxIpSDntVkPR5pHeTFyib62Uf7gGG+hZ2KuO/sUzohj
         mVbwOtB54SNF8odEAyf4BB/plhD/cU9UnzaO/pfNKa2jiJymHu2OaACrLRbnphGmkfWg
         XiCfWDJuOLTUSyGKXjC2WrLIS7yTVid+nGMf6fmhWjEjkAPbtNvDsayGpSOrnRSxIACP
         4At21NUL352ZvlnebxfZk4TypDjSugNwDfWM+ZVAyT9WhR0vbLSRNgc7yWmpZDx0fngS
         ZCHA==
X-Gm-Message-State: APjAAAWmtZyxBzdPDom3wg1kONN2+aKmpLsNburKPhcjY0Y66fUvE+gt
        NMV4R1QCvPJjuTrbZ/A5oE4=
X-Google-Smtp-Source: APXvYqytlJusKX0Kz3YLI2vL5MLf0VI1Z1xBBIdMBORZVE6octNROw4k0V6HC2FB29J3ObqpMFnQGw==
X-Received: by 2002:a05:600c:2c06:: with SMTP id q6mr4482299wmg.154.1579718294349;
        Wed, 22 Jan 2020 10:38:14 -0800 (PST)
Received: from localhost (ip-37-188-245-167.eurotel.cz. [37.188.245.167])
        by smtp.gmail.com with ESMTPSA id j12sm63168372wrw.54.2020.01.22.10.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 10:38:13 -0800 (PST)
Date:   Wed, 22 Jan 2020 19:38:09 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leonardo Bras <leonardo@linux.ibm.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Allison Randal <allison@lohutok.net>,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        lantianyu1986@gmail.com,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH RFC v1] mm: is_mem_section_removable() overhaul
Message-ID: <20200122183809.GB29276@dhcp22.suse.cz>
References: <CAPcyv4jvmYRbX9i+1_LvHoTDGABadHbYH3NVkqczKsQ4fsf74g@mail.gmail.com>
 <20200120074816.GG18451@dhcp22.suse.cz>
 <a5f0bd8d-de5e-9f27-5c94-7746a3d20a95@redhat.com>
 <20200121120714.GJ29276@dhcp22.suse.cz>
 <a29b49b9-28ad-44fa-6c0b-90cd43902f29@redhat.com>
 <20200122104230.GU29276@dhcp22.suse.cz>
 <98b6c208-b4dd-9052-43f6-543068c649cc@redhat.com>
 <816ddd66-c90b-76f1-f4a0-72fe41263edd@redhat.com>
 <20200122164618.GY29276@dhcp22.suse.cz>
 <626d344e-8243-c161-cd07-ed1276eba73d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <626d344e-8243-c161-cd07-ed1276eba73d@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 22-01-20 19:15:47, David Hildenbrand wrote:
> On 22.01.20 17:46, Michal Hocko wrote:
> > On Wed 22-01-20 12:58:16, David Hildenbrand wrote:
[...]
> >> Especially interesting for IBM z Systems, whereby memory
> >> onlining/offlining will trigger the actual population of memory in the
> >> hypervisor. So if an admin wants to offline some memory (to give it back
> >> to the hypervisor), it would use lsmem to identify such blocks first,
> >> instead of trying random blocks until one offlining request succeeds.
> > 
> > I am sorry for being dense here but I still do not understand why s390
> 
> It's good that we talk about it :) It's hard to reconstruct actual use
> cases from tools and some documentation only ...
> 
> Side note (just FYI): One difference on s390x compared to other
> architectures (AFAIKS) is that once memory is offline, you might not be
> allowed (by the hypervisor) to online it again - because it was
> effectively unplugged. Such memory is not removed via remove_memory(),
> it's simply kept offline.

I have a very vague understanding of s390 specialities but this is not
really relevant to the discussion AFAICS because this happens _after_
offlining.
 
> > and the way how it does the hotremove matters here. Afterall there are
> > no arch specific operations done until the memory is offlined. Also
> > randomly checking memory blocks and then hoping that the offline will
> > succeed is not way much different from just trying the offline the
> > block. Both have to crawl through the pfn range and bail out on the
> > unmovable memory.
> 
> I think in general we have to approaches to memory unplugging.
> 
> 1. Know explicitly what you want to unplug (e.g., a DIMM spanning
> multiple memory blocks).
> 
> 2. Find random memory blocks you can offline/unplug.
> 
> 
> For 1, I think we both agree that we don't need this. Just try to
> offline and you know if it worked.
> 
> Now of course, for 2 you can try random blocks until you succeeded. From
> a sysadmin point of view that's very inefficient. From a powerpc-utils
> point of view, that's inefficient.

How exactly is check + offline more optimal then offline which makes
check as its first step? I will get to your later points after this is
clarified.
-- 
Michal Hocko
SUSE Labs
