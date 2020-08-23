Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5042C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 15:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C30120706
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 15:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IWPT+EnC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgHWPVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 11:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbgHWPVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 11:21:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8078EC061573
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 08:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gm1l7LMMWkh8XudQNYEYGcqLPJBnhezkbfdutvBRAvQ=; b=IWPT+EnCVx+/a2LokrEVSSUtYT
        X/gyZpW0+IE9jiZvqtwsJy5omgmg3wmH5OniZg9R84dYUOYzlBCZDdZWI0IMiniWIYWP86tnMUx48
        MAjQWdu8+Vu4VQrWnKfQv8SS1RgvljT+OWCfJvnJ71Zgx4XdHxLrAiOUf82qDBc/7E7eQ0GNrzkAU
        9T82GFNby8NlDlHaDSL6Cgfu4S1opi9VM1G5kvNTe4981Ah/A7l1maBTQphbZTYZsoVjUzq2yzmGQ
        N3/vKzwoUHDArg5Ke06Mq36ZG2ZhiTa0Hx6OyezpaonT+i1RF8IJHSwmtpGJxlWAvUEfIybDRnPLa
        8GEWnl/A==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k9roJ-0007Hg-1f; Sun, 23 Aug 2020 15:21:31 +0000
Date:   Sun, 23 Aug 2020 16:21:30 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Xu Wang <vulab@iscas.ac.cn>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] hugetlb_cgroup: convert comma to semicolon
Message-ID: <20200823152130.GA17456@casper.infradead.org>
References: <20200818064333.21759-1-vulab@iscas.ac.cn>
 <20200818184036.d6c479446b2c3b231d1e3bff@linux-foundation.org>
 <87eeo32gto.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eeo32gto.fsf@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 10:14:11AM +0200, Giuseppe Scrivano wrote:
> >> -	cft->file_offset = offsetof(struct hugetlb_cgroup, events_file[idx]),
> >> +	cft->file_offset = offsetof(struct hugetlb_cgroup, events_file[idx]);
> >>  	cft->flags = CFTYPE_NOT_ON_ROOT;
> 
> I think in this case having two expressions as part of the same
> statement is equivalent to having two separate statements.  Both
> cft->file_offset and cft->flags get the expected value.

That's not how the comma operator works.

It will evaluate offsetof(struct hugetlb_cgroup, events_file[idx]) and
then discard the result.  Since it has no side-effects, this is effectively
doing:

	cft->file_offset = cft->flags = CFTYPE_NOT_ON_ROOT;
