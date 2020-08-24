Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F3DC433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E14DA2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598294529;
	bh=Nd2awSgpg3NOzIIw5/W9KTQlYTFQWu5lPKGtd3+FdgI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=UauGQpHt9PPmR00mfJAyc7KSQ57giGgCapKSY231Mr2kg1QcFj3xOiVc1x98DjIyh
	 odcUYlGekTVrgGfPl6XN6Tf6gyZzyYVBHYM4Y3lNaesDgNmIVi2LEcQT/a/MAiizDX
	 xDXKQZTZCkgqZz9ur4MCIPjyMKGF5aDrZ3AY+UiI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgHXSmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 14:42:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:44818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725998AbgHXSmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 14:42:06 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59D8F20866;
        Mon, 24 Aug 2020 18:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598294526;
        bh=Nd2awSgpg3NOzIIw5/W9KTQlYTFQWu5lPKGtd3+FdgI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NOVxsxxfKZUuSkWhhaeTdPaLhuV4A66ePOhaJl3iuBe698JtvkFNo6oULxqlhRKP9
         go5x9qm6wtG2ewR1N11GC7U8IRi2+zLl5jsMqJbl1fpfY+Ehcgt4iV8yyI/eb7Q/wE
         BKPTYrXANG2WV2orZF5CadUwCkVAyb6/6Ktcz9Hg=
Date:   Mon, 24 Aug 2020 11:42:04 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com, mhocko@suse.com, vdavydov.dev@gmail.com,
        shy828301@gmail.com
Subject: Re: [PATCH v18 00/32] per memcg lru_lock
Message-Id: <20200824114204.cc796ca182db95809dd70a47@linux-foundation.org>
In-Reply-To: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Aug 2020 20:54:33 +0800 Alex Shi <alex.shi@linux.alibaba.com> wrote:

> The new version which bases on v5.9-rc2. The first 6 patches was picked into
> linux-mm, and add patch 25-32 that do some further post optimization.

32 patches, version 18.  That's quite heroic.  I'm unsure whether I
should merge it up at this point - what do people think?

> 
> Following Daniel Jordan's suggestion, I have run 208 'dd' with on 104
> containers on a 2s * 26cores * HT box with a modefied case:
> https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/tree/case-lru-file-readtwice
> With this patchset, the readtwice performance increased about 80%
> in concurrent containers.

That's rather a slight amount of performance testing for a huge
performance patchset!  Is more detailed testing planned?

