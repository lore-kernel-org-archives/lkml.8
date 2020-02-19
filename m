Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963B8C35254
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 21:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB82208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 21:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582146411;
	bh=We7qiHyZF1+0bxnalw+B0B6unBvDDpo3FZ3UilP54wo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=m8QK/wv6eeFDZdAJSuvWEt/w5Vn2Kq/y1eAfT1e64Io2nGQHeUBChH+iv7sXNQp97
	 67EJu1w8cdhYoSKTmFOLBm9RjSZeMvQwura2N6JoBNhYhj10KAdaX1O6Kp2KbmYElF
	 uD+iwSi7XO/Yewkpm7xt/i5FvqRsr/tZpo5O4BhM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgBSVGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 16:06:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:39090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727592AbgBSVGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 16:06:50 -0500
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27675207FD;
        Wed, 19 Feb 2020 21:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582146409;
        bh=We7qiHyZF1+0bxnalw+B0B6unBvDDpo3FZ3UilP54wo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ukHYLZC7569bA3jMgJUE4Me0eScdonEH4QsdinQzJLb/YmaJEH255Pbk2YXN3mr++
         8Wg+cUdQTDSNrybE0lLFSy2X/bFPK8Dj5fyqLpxDt9xuTdPnYxpJKwIX5E0LNZZBZp
         gfmu61lnSEqsTfX2wTnJ6qyaDxsrEdO8My8VKDao=
Date:   Wed, 19 Feb 2020 13:06:48 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, shuah <shuah@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v12 1/9] hugetlb_cgroup: Add hugetlb_cgroup reservation
 counter
Message-Id: <20200219130648.83e6810848774c6fd649c445@linux-foundation.org>
In-Reply-To: <CAHS8izPUFQWq3PzhhRzp7u11173_-cmRkNuQWEswS51Xz6ZM0Q@mail.gmail.com>
References: <20200211213128.73302-1-almasrymina@google.com>
        <20200211151906.637d1703e4756066583b89da@linux-foundation.org>
        <CAHS8izPUFQWq3PzhhRzp7u11173_-cmRkNuQWEswS51Xz6ZM0Q@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Feb 2020 11:05:41 -0800 Mina Almasry <almasrymina@google.com> wrote:

> On Tue, Feb 11, 2020 at 3:19 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Tue, 11 Feb 2020 13:31:20 -0800 Mina Almasry <almasrymina@google.com> wrote:
> >
> > > These counters will track hugetlb reservations rather than hugetlb
> > > memory faulted in. This patch only adds the counter, following patches
> > > add the charging and uncharging of the counter.
> >
> > We're still pretty thin on review here, but as it's v12 and Mike
> > appears to be signed up to look at this work, I'll add them to -next to
> > help move things forward.
> >
> 
> Hi Andrew,
> 
> Since the patches were merged into -next there have been build fixes
> and test fixes and some review comments. Would you like me to submit
> *new* patches to address these, or would you like me to squash the
> fixes into my existing patch series and submit another iteration of
> the patch series?

What you did worked OK ;)

Please check the end result next time I release a kernel.
