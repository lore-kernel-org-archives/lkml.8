Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AECC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 19:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A662820659
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 19:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t2i8OYxd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390746AbgEMTiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 15:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390607AbgEMTiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 15:38:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54A5C061A0C;
        Wed, 13 May 2020 12:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=reReYgo4WVO4ahY77rC0AlOaDn1eni/2YS9v5iW5ApQ=; b=t2i8OYxdYVoUKhqrXceLxMmdw+
        +Mebd98m1GvsGp0wQweT9JujipVyjWxIS6jX3BN55aP4vxEl6kYoZSwn9DbPMS5bbJNskJSKKnZns
        s5JFhN7SqHGAnrg5rw7YNUuzVnOldDh+tN+8ZU7CgRhX45pGjQrvJsPuj5QOmbgCDI89SLpPd0Qrj
        eOLgrz3l8E9o5npkW6rzCPk1okuh90NRoZvUmdIR9CtEMoswTdzMkoMhzXsmPPWw4ewMRe/SkgNj/
        r6SPZJaDLDGFTyuZArsNKQQx4RU7PNszLXPzUs1IiXYdp5tERSuwiE9v7NWPEZo7YvjNE1QBnutbl
        4k8kJSAA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYxCb-0002NH-AH; Wed, 13 May 2020 19:38:01 +0000
Date:   Wed, 13 May 2020 12:38:01 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH 04/20] FIEMAP: don't bother with access_ok()
Message-ID: <20200513193801.GC484@infradead.org>
References: <20200509234124.GM23230@ZenIV.linux.org.uk>
 <20200509234557.1124086-1-viro@ZenIV.linux.org.uk>
 <20200509234557.1124086-4-viro@ZenIV.linux.org.uk>
 <20200510070241.GA23496@infradead.org>
 <20200513190207.GV23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513190207.GV23230@ZenIV.linux.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 08:02:07PM +0100, Al Viro wrote:
> > https://lore.kernel.org/linux-fsdevel/20200507145924.GA28854@lst.de/T/#t
> > 
> > which is waiting to be picked up [1], and also has some chance for conflicts
> > due to changes next to the access_ok.
> > 
> > [1] except for the first two patches, which Ted plans to send for 5.7
> 
> I can drop this commit, of course, it's not a prereq for anything else in there.
> Or I could pick your series into never-rebased branch, but it would complicate
> the life wrt ext4 tree - up to you and Ted...

I really don't care - the first two really need to go in ASAP and
Ted promised to pick them up, but I've not seen them in linux-next
yet.  The rest can go wherever once the first ones hit mainline.
