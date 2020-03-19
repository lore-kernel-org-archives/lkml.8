Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6859C4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AD33208D6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="El9P5SNt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbgCSODJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 10:03:09 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39126 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbgCSODI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 10:03:08 -0400
Received: by mail-qt1-f196.google.com with SMTP id f20so1840290qtq.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 07:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zVUeEVeA4E7oLTV0ECgEEG2/YC9N9vz1pl7acrL5ucE=;
        b=El9P5SNtEcEMu0/AvqR3cV/68A6G4L9fJEmMnnqpaU4OQ0wcTdBipT8Bjk/L5TvYnK
         /YL4acdcAJuhnKMNx0cl+WEKziQpCPoY3OjDWtb47SHlI7rduYTGncQtgQnMtTmSc3gb
         bn25hHomNvKLlQomjdaA2ii9mUxMS9BaOqh8BNJaKHhzw9QuFFuoEPXWF0Y/X3plqVc6
         X7jn63Dn6pV8Jy3ta1wdTLHyIWH5Qz1KXtVElDpZMM+ljYohZYegpCWNm6tlhJrbyUm3
         +uxKb16MMa1Uq/lY4C1lh2IgjjujBMM0uU/o/bA7L7iXRo7UzAaPpvKZB0hLC7dOlQRO
         bWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zVUeEVeA4E7oLTV0ECgEEG2/YC9N9vz1pl7acrL5ucE=;
        b=cpQgHPIUCsQLfGXqV0GEWbXacDuplfzya/wLTb+w1ViEPMcWzyH6VqxQsDB9/2TwpZ
         53y6EIX8XdF95wQ/c8wBW2zCPj4kBE19++FJSnso6LVwrt/hQfo30WblWUYihqRed0r8
         jNOa35h+Z1dC+JLgIHVst+V8Rx9r9aZlRPNn8MSLctvxOog7gg7sprKYZhlHutZS56e2
         JfDXs2GpwhNcwHG+t9GmsZc05U7cD0MRIsElRtyYkGJvDCG0yVW4Oa61jLqSCwTnhnXH
         +XDEx9SULbFYdkC6+cZ2QcswamRXA4ByU3bodxNwVdegf2f8Mae6hnyx+7J2gh20rXlF
         nwow==
X-Gm-Message-State: ANhLgQ2JnuOi26GWLtrInb/5n5Qf58vF5P85+vZCTVRg6dKHuvCVbylJ
        WBH9dLn5W3lNAMg/NYRDIhB/uA==
X-Google-Smtp-Source: ADFU+vtZKpVbkTQfzQCn4rkumgnjQ034QoO/8wsuuQ9OhmtjDnES5ksSY/f2xcgUYW+S7FTVSDWiHQ==
X-Received: by 2002:ac8:6f19:: with SMTP id g25mr3135902qtv.346.1584626586982;
        Thu, 19 Mar 2020 07:03:06 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:a9a9])
        by smtp.gmail.com with ESMTPSA id p35sm1611812qtk.2.2020.03.19.07.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 07:03:06 -0700 (PDT)
Date:   Thu, 19 Mar 2020 10:03:05 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     shakeelb@google.com, vbabka@suse.cz, willy@infradead.org,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v4 PATCH 2/2] mm: swap: use smp_mb__after_atomic() to order LRU
 bit set
Message-ID: <20200319140305.GC187654@cmpxchg.org>
References: <1584500541-46817-1-git-send-email-yang.shi@linux.alibaba.com>
 <1584500541-46817-2-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584500541-46817-2-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 11:02:21AM +0800, Yang Shi wrote:
> Memory barrier is needed after setting LRU bit, but smp_mb() is too
> strong.  Some architectures, i.e. x86, imply memory barrier with atomic
> operations, so replacing it with smp_mb__after_atomic() sounds better,
> which is nop on strong ordered machines, and full memory barriers on
> others.  With this change the vm-scalability cases would perform better
> on x86, I saw total 6% improvement with this patch and previous inline
> fix.
> 
> The test data (lru-file-readtwice throughput) against v5.6-rc4:
> 	mainline	w/ inline fix	w/ both (adding this)
> 	150MB		154MB		159MB
> 
> Fixes: 9c4e6b1a7027 ("mm, mlock, vmscan: no more skipping pagevecs")
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-and-Tested-by: Shakeel Butt <shakeelb@google.com>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
