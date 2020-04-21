Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A10C54FD0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68A0220724
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="gFxehvHG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbgDUOj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 10:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbgDUOj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 10:39:26 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE146C061A41
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 07:39:25 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id v38so6618998qvf.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 07:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=FUghwdK61ELIcdqNXkNEUPkemM8u8aFA3cSbQm57Oy0=;
        b=gFxehvHGSNlG++mszljqSCAK7x9JFhjfQndMRxcNzeicsRBEWHLOnuSk7TV/f0lpJS
         hI40Kn4d4RhA2dhOIjiFgB4c9koyFw954Gi9PeFxAZnTNJx7vt622EPZLNpn9eUYH9le
         O9pbbJh5hVwKmuS42wfYZ3Y+WPU27d7VfvhPFCoLpJ467jhpzjCYj6m1WrPsIbmBx/Kr
         4h/THAUC+GEjA1w+FrC360VuFTaR4mLjUzraOoMvViF56WaYnVAS8b6VWjmlABi86u0L
         2yIVk9FFEx1KfLomk93emTZXN5qcyqBBKpgW+00of/GRzhQUA58c3n0SxXHmwIwDoTJh
         opFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=FUghwdK61ELIcdqNXkNEUPkemM8u8aFA3cSbQm57Oy0=;
        b=mnSmjJUQejX+u4s+tQQuDyL25g9ahlMHwegBr8GwvseyZUUHTfVV4DIHQeR/6+qBxN
         DsZoCSkUGICUBwjhyI3pnu+euYVZ+U90GWboxgcL2p7/qNxnznEHlXfwC7FvKYxlJRwS
         kQ+pVcgxuvpUlDVXbwBiyXjCwgfKsI9EUyECUeolN0ZhoI68YxwEJ/U50Ltm4Pcfq/E1
         aDujxSjsCXIajCBv4WSsAKr7AySuHuGI3lQc2z5fOOdoXELz5E7wNF0pCaaLyYANv8kw
         Gxk0hASR+mwuNlDDXPbXNhvPL4Se2ekLf4n3oFWUXhZfptHgYh2Hrnq6BnlvvtapAYgX
         RttA==
X-Gm-Message-State: AGi0PuZ+VJTSerYiK4RUpCyy/gVaVpe6Nn5PyvwrRnneOTfObO1tcz0v
        qj+pKdc0fNwPvO2Msb62spRZQA==
X-Google-Smtp-Source: APiQypInpg4gUIZ3ZyekCXLwMFg9UBr6vB/iUDK8KN7FOJEIEMxL1qkg7RMokE8ry7h8Zwv72b5e1g==
X-Received: by 2002:ad4:49d3:: with SMTP id j19mr19534989qvy.78.1587479964857;
        Tue, 21 Apr 2020 07:39:24 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id l8sm1864795qtl.86.2020.04.21.07.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 07:39:24 -0700 (PDT)
Date:   Tue, 21 Apr 2020 10:39:23 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Joonsoo Kim <js1304@gmail.com>, Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 15/18] mm: memcontrol: make swap tracking an integral
 part of memory control
Message-ID: <20200421143923.GC341682@cmpxchg.org>
References: <20200420221126.341272-1-hannes@cmpxchg.org>
 <20200420221126.341272-16-hannes@cmpxchg.org>
 <e9d58c82-d746-dcd0-d9e3-6322014a3b03@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e9d58c82-d746-dcd0-d9e3-6322014a3b03@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

thanks for your quick review so far, I'll add the tags to the patches.

On Tue, Apr 21, 2020 at 05:27:30PM +0800, Alex Shi wrote:
> 
> 
> 在 2020/4/21 上午6:11, Johannes Weiner 写道:
> > The swapaccount=0 boot option will continue to exist, and it will
> > eliminate the page_counter overhead and hide the swap control files,
> > but it won't disable swap slot ownership tracking.
> 
> May we add extra explanation for this change to user? and the default
> memsw limitations?

Can you elaborate what you think is missing and where you would like
to see it documented?

From a semantics POV, nothing changes with this patch. The memsw limit
defaults to "max", so it doesn't exert any control per default. The
only difference is whether we maintain swap records or not.
