Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC37C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF134214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tczxyNyN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbgDQH3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 03:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728419AbgDQH3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 03:29:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D2FC061A0C;
        Fri, 17 Apr 2020 00:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+AdJjVSPFFgTfj/HyAVB1EqazKksGsV1ZI1hF7Y4UOk=; b=tczxyNyNA3+ZMs0GthRHP3fwnP
        Sct8xH6GNEXuA/a4VryU2imFJknluHl9Vk8EpzrEwJ3/R7HYflWhJkmVNR9Hh9yqIpF9fG7hSgsuY
        aNc2r0+qGqvQHPHO0ufRaENKrUuRl2fsrR7j+SkAzF/p9LPCM5D7P5bWjt890h/chUXHYtlnlCs8s
        M1+p2W+QIJ/9TvQB1suAyP7Hlm/eoI7hvPiv4Zcrj52TZ2nEW9jNjv/d68eKfoQ13/olxgngM2gMQ
        n52SMP4rb2bFzIsl9lgvXSvLDMyXA8Ikw+iNqKL8GoKb9PpOmWh5GaKuMzjhEU52rujNY7XPkbLK6
        zb/2AdvA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPLRL-00008d-3k; Fri, 17 Apr 2020 07:29:31 +0000
Date:   Fri, 17 Apr 2020 00:29:31 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: implicit AOP_FLAG_NOFS for grab_cache_page_write_begin
Message-ID: <20200417072931.GA20822@infradead.org>
References: <20200415070228.GW4629@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415070228.GW4629@dhcp22.suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 09:02:28AM +0200, Michal Hocko wrote:
> Hi,
> I have just received a bug report about memcg OOM [1]. The underlying
> issue is memcg specific but the stack trace made me look at the write(2)
> patch and I have noticed that iomap_write_begin enforces AOP_FLAG_NOFS
> which means that all the page cache that has to be allocated is
> GFP_NOFS. What is the reason for this? Do all filesystems really need
> the reclaim protection? I was hoping that those filesystems which really
> need NOFS context would be using the scope API
> (memalloc_nofs_{save,restore}.

This comes from the historic XFS code, and this commit from Dave
in particular:

commit aea1b9532143218f8599ecedbbd6bfbf812385e1
Author: Dave Chinner <dchinner@redhat.com>
Date:   Tue Jul 20 17:54:12 2010 +1000

    xfs: use GFP_NOFS for page cache allocation

    Avoid a lockdep warning by preventing page cache allocation from
    recursing back into the filesystem during memory reclaim.

