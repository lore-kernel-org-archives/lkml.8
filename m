Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEA6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 19:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C49FC2074D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 19:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="XfSHPkEj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgHXTuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 15:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgHXTuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 15:50:15 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5B5C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 12:50:14 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id p25so8704599qkp.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 12:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=85LkKtijLyN/OhxDFk0kAql1huZBkB94f5RcTYwHk5c=;
        b=XfSHPkEj7U77O4jChB1IJFQGHGtpuZzQ3plVs8yYXSH65jQSvMg9341yheyQPiyvhB
         S5HYsSz00oW1qLer36HFmSCxaNybFL5PGZt90u4gzDdJkBQ40kR5bTOjPkMCUkGx+z9u
         jfFfDwhBlPnlJRfH7EAtNc8Sj76JItvg6J+b8+R4tsiaGIuocAEVUsalHYuzNEW7371e
         lIKnkY2wygcg4XGhAxgyxk/wI/I4z70UkIrzaDIXOy77WWjZzQ3r9Z4hPYDQ7oqG5pXL
         wqb7o9im19kkoReuLpksU8HeNSxXUMsohLOVAzBfqGqS88Qgomhe1U17o5WG3jw4IiqS
         ikCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=85LkKtijLyN/OhxDFk0kAql1huZBkB94f5RcTYwHk5c=;
        b=GU0WykDApXKdFl5039IwamSol0heT4lU4TFq2pj6R4FO1VsrepKSfOvBaGo2+x5pt3
         rM3QhaBECmZxBuUOiM7hAdcaD/lkaeduXyunZYUUXEaQlxlcteUG/1/lUIZ90hERTgdy
         V6DwrvSWfQkKtuTkOxkTXZG0P5acRY1ig7uoXT58yOWcoVZNzxLbtdN4C6NIur6WZi+D
         6qRuJV528L8EpvEhU3h0A9tK2sQwEc+o3/FdRNtA8GBcY7C+bF9yZ8PcCjRs4h92fEQf
         YVPyoZPADTXy/fjrxbk3FW2HOggxlcQ3XETWwn+wWSUCKGYuDkiIJv64F1BrvhJFF3+Y
         uhRA==
X-Gm-Message-State: AOAM533mBea//pW1WaWnBXvgkDvmtR3z7oRDKF4ixyAmn5BTRi7gGpvi
        qrVBnWaaCwSpXNd9DT/mOvqt5w==
X-Google-Smtp-Source: ABdhPJznHcOmna8OkRl5WMSB11MLulqco/+XJ75Z4286/vi1UX3SVCWpNJ7bVFpMzwcHxspD6xQ3mw==
X-Received: by 2002:a37:6445:: with SMTP id y66mr2267881qkb.336.1598298613349;
        Mon, 24 Aug 2020 12:50:13 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id d8sm2650085qtn.70.2020.08.24.12.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 12:50:12 -0700 (PDT)
Date:   Mon, 24 Aug 2020 15:50:10 -0400
From:   Qian Cai <cai@lca.pw>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, willy@infradead.org,
        hannes@cmpxchg.org, lkp@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        shakeelb@google.com, iamjoonsoo.kim@lge.com,
        richard.weiyang@gmail.com, kirill@shutemov.name,
        alexander.duyck@gmail.com, rong.a.chen@intel.com, mhocko@suse.com,
        vdavydov.dev@gmail.com, shy828301@gmail.com
Subject: Re: [PATCH v18 00/32] per memcg lru_lock
Message-ID: <20200824195009.GE4337@lca.pw>
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com>
 <20200824114204.cc796ca182db95809dd70a47@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824114204.cc796ca182db95809dd70a47@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 11:42:04AM -0700, Andrew Morton wrote:
> On Mon, 24 Aug 2020 20:54:33 +0800 Alex Shi <alex.shi@linux.alibaba.com> wrote:
> 
> > The new version which bases on v5.9-rc2. The first 6 patches was picked into
> > linux-mm, and add patch 25-32 that do some further post optimization.
> 
> 32 patches, version 18.  That's quite heroic.  I'm unsure whether I
> should merge it up at this point - what do people think?

I certainly hope not given how buggy the previous reversion and Alex's other
patchset are. There is really no room for the shortcut this time.

> 
> > 
> > Following Daniel Jordan's suggestion, I have run 208 'dd' with on 104
> > containers on a 2s * 26cores * HT box with a modefied case:
> > https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/tree/case-lru-file-readtwice
> > With this patchset, the readtwice performance increased about 80%
> > in concurrent containers.
> 
> That's rather a slight amount of performance testing for a huge
> performance patchset!  Is more detailed testing planned?
> 
> 
