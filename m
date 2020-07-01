Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC39C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 19:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B592220720
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 19:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W8jEZt/v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgGATu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 15:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgGATuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 15:50:25 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC3AC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 12:50:25 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id j12so11431500pfn.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 12:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=XJ3z9iA8O6dAIC+NJJ+9t4gOwZXNZKQoXN/EldNu944=;
        b=W8jEZt/vb01WxE/phfcnFCguMVUd3c09MDg/hlHySRsBL+LwESHKejygb7jhMXc6tl
         re3uPXxn/SXD+8nS2hdNIaIFnerkk4601BONkaQi7Iyn8ZAL3yYy9zHj3MmzTKTfpfBv
         6jHMTspS2e2FYsB2oWVlWkPO4eEkYTlQhIc0yWq57rboPv+EHD4eAlpI8wgcDpREFDX8
         OfzaCDsJ1U+t83oKfFz2qR/AEoeu7q68zlmYAp4efotqy07ep5c0/RzPtfr7f1fNcyDk
         gcMCVJuT8jL1G9iB3Brn4iVXSOX6l3JCQncGA4VDyqhypIYroLz4FPue4+gHJKABTCIT
         4gFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=XJ3z9iA8O6dAIC+NJJ+9t4gOwZXNZKQoXN/EldNu944=;
        b=p2HhnT0JNYDU799Fckig0qK8L8HqXq9fzJ508/bL41ubDjzaWqWMmMfAVD66fcOivM
         vxWraqQUB+/lqvZz27IC3to1SX8rZSCau7zCWKw6tlQEJA/MBj2cWspFl8COKsZcjm1p
         Bp5qaNorEVc2OJyCXEF7TosxtON0pbbnyBANvO3BVs7XFL/+f3mr2weWkYzY3c6tO21u
         nwrpd3o4qujpdmkEZMKRyL+umBjH1Nt/9jNspxlIC79nuLbZ5H2BoeileQcNa4q3SSib
         udIHyAWlNSLLX2fxPjq0wP7qevKG3AYc4ukt80A1dtmrrYUgPLxh81CTJ+0WlaNhl+Kg
         uhoQ==
X-Gm-Message-State: AOAM533sz3YGPOvIMxvseMWaGXXQT3emczMrJVZQVx9z2k8qnW5fLnHW
        HfHsw1tRQr95i06n5xX7JeOuwA==
X-Google-Smtp-Source: ABdhPJxRTbwwfv5oYdmBH1GIXgyKUz+5jP5h9ldyt2NCMOtgGQHh83LNaVCxc4v//ByEcPimwVFF/Q==
X-Received: by 2002:a63:4e62:: with SMTP id o34mr21804319pgl.208.1593633024808;
        Wed, 01 Jul 2020 12:50:24 -0700 (PDT)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id j19sm5788338pjy.40.2020.07.01.12.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 12:50:23 -0700 (PDT)
Date:   Wed, 1 Jul 2020 12:50:23 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Dave Hansen <dave.hansen@intel.com>
cc:     "Huang, Ying" <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kbusch@kernel.org, dan.j.williams@intel.com
Subject: Re: [RFC][PATCH 3/8] mm/vmscan: Attempt to migrate page in lieu of
 discard
In-Reply-To: <8182ede7-88ce-b891-d100-8c036130797e@intel.com>
Message-ID: <alpine.DEB.2.23.453.2007011248580.1908531@chino.kir.corp.google.com>
References: <20200629234503.749E5340@viggo.jf.intel.com> <20200629234509.8F89C4EF@viggo.jf.intel.com> <alpine.DEB.2.22.394.2006301732010.1644114@chino.kir.corp.google.com> <039a5704-4468-f662-d660-668071842ca3@linux.alibaba.com>
 <alpine.DEB.2.22.394.2006302208460.1685201@chino.kir.corp.google.com> <87h7urlioe.fsf@yhuang-dev.intel.com> <8182ede7-88ce-b891-d100-8c036130797e@intel.com>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jul 2020, Dave Hansen wrote:

> Even if they don't allocate directly from PMEM, is it OK for such an app
> to get its cold data migrated to PMEM?  That's a much more subtle
> question and I suspect the kernel isn't going to have a single answer
> for it.  I suspect we'll need a cpuset-level knob to turn auto-demotion
> on or off.
> 

I think the answer is whether the app's cold data can be reclaimed, 
otherwise migration to PMEM is likely better in terms of performance.  So 
any such app today should just be mlocking its cold data if it can't 
handle overhead from reclaim?
