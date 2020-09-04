Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FFAC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 07:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D11BF206A5
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 07:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L1dBKlcR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbgIDHqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 03:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgIDHqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 03:46:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A584C061244;
        Fri,  4 Sep 2020 00:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QKTSDK+FykCg0MN+vQ8ItyimOO6LKRGC0v2V63iruNc=; b=L1dBKlcRVnxtseJ2dUiZ+ZQz2k
        pr+phGt2j+BhWofRn2lhZZIZMvG91sNBOFg7akek5FkE/6AcJ5b7e98C7xeUgfzwyyC/Qc4LL/Sia
        KgtrwwKoY3S1uVmA5C9FdQgbXZkZ8fVybIRgmawyvFe77qb5+Dw2UxEOT1HvR4YzW+G3HDdBYeubw
        E3PWjgbrBhlA3mtiUhRBvXj8RHBZ1oj2fEzIG47AnTpihQugVZcWI15GXj9t2nsppeQdNiKVEphfM
        BlnigpodSf0S4fksONOyyBSv/v4OhGuWqlZ1l9d9n5inCG4q3UVU2Ux5cmBZCCsMCw8KK2+HSSsVh
        v9W8wO4A==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kE6Ql-0007aC-4o; Fri, 04 Sep 2020 07:46:43 +0000
Date:   Fri, 4 Sep 2020 08:46:43 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Rishabh Bhatnagar <rishabhb@codeaurora.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, tsoni@codeaurora.org,
        psodagud@codeaurora.org, sidgup@codeaurora.org
Subject: Re: [PATCH v3 0/3] Expose recovery/coredump configuration from sysfs
Message-ID: <20200904074643.GA26741@infradead.org>
References: <1599174226-2307-1-git-send-email-rishabhb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599174226-2307-1-git-send-email-rishabhb@codeaurora.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 04:03:42PM -0700, Rishabh Bhatnagar wrote:
> >From Android R onwards Google has restricted access to debugfs in user
> and user-debug builds. This restricts access to most of the features
> exposed through debugfs. This patch series removes the recovery/coredump
> entries from debugfs and adds a configurable option to expose these
> interfaces from sysfs. 

so please fix android instead of messing up the upstream kernel.
