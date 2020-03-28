Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C314DC43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 08:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AFA320714
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 08:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WE6PYqk9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbgC1I0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 04:26:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44008 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgC1I0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 04:26:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=O13t8NusS3D/3XhZSEG+NS2S3e48ZOuJ7579C8SUUrE=; b=WE6PYqk9eLUmPmVbWiCJFE7PGM
        rnN7F6psV/9G31XGwvU7++iQxwAyDQPcLiYyr1BWvvPazkJzqQgpkbQ4gC4SxkZibgfUEwV5Gqx1D
        Ts7vJxJC9l4u878GIhM7g+K4R2d05d22j3akS7jhco/2UJuMYCmEw32fEhOyE8diRuVujECJGwyq/
        HHWHtkorWVp3dGlLiGnle5+IdcdRNlrMHZvy/7exRBry6da2ZcMSJDG4MuKAAXc/foKrD9Yb/aGnL
        F+GbKPpiXIm3mzfnkqgJXWK3U10x3Q3lBZuJ7PmdfwlhxygUFaWH8EuXjXHuU9fgp8cs5OVFvRDZ7
        RuORGq5g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jI6n3-0003Uu-8G; Sat, 28 Mar 2020 08:26:01 +0000
Date:   Sat, 28 Mar 2020 01:26:01 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Nick Bowler <nbowler@draconx.ca>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@infradead.org>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v2 1/2] nvme: Fix compat NVME_IOCTL_SUBMIT_IO numbering
Message-ID: <20200328082601.GA7658@infradead.org>
References: <20200328050909.30639-1-nbowler@draconx.ca>
 <20200328050909.30639-2-nbowler@draconx.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200328050909.30639-2-nbowler@draconx.ca>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 28, 2020 at 01:09:08AM -0400, Nick Bowler wrote:
> When __u64 has 64-bit alignment, the nvme_user_io structure has trailing
> padding.  This causes problems in the compat case with 32-bit userspace
> that has less strict alignment because the size of the structure differs.
> 
> Since the NVME_IOCTL_SUBMIT_IO macro encodes the structure size itself,
> the result is that this ioctl does not work at all in such a scenario:
> 
>   # nvme read /dev/nvme0n1 -z 512
>   submit-io: Inappropriate ioctl for device
> 
> But by the same token, this makes it easy to handle both cases and
> since the structures differ only in unused trailing padding bytes
> we can simply not read those bytes.
> 
> Signed-off-by: Nick Bowler <nbowler@draconx.ca>

I think we already have a similar patch titled
"nvme: Add compat_ioctl handler for NVME_IOCTL_SUBMIT_IO" in
linux-next, with the difference of actually implementing the
.compat_ioctl entry point.
