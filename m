Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B53EC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 13:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 586FB206F5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 13:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qaF9jgqX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgDFNJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 09:09:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34452 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbgDFNJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 09:09:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=d8z40dNKaPY2tTRvNqVh/Hg7COGe6Xus2Dj2Co5njCA=; b=qaF9jgqXRIEeKu2Y2Dr7vB13TD
        KAolynoC5eVhhwajk0M4cxtVWIE6G7MpqOI8nrq6w21TdsRfaf03cgNCb4ztaP5X1jrRsvGzGvCHP
        dIPR3oBv+MDsPAvpd6u9p+//LYaetf5LYB3R+VCJKwXq4rzAswlBPGdVBHYyNAWmgGL3HMKYMi+Mo
        6ril3DjTx0HIsB0ky0W/jYQ9Uu2uAUq5Q9KbXwQYip2ADF/2/AFKAK+s44RVAnQGeL9QfqYpAgRB5
        hawKVDzbjNyucsIwbKpLvr/mplANc239iPxGKmzma4N1lDRPRvDZNkoWDCnV6AVw7MDt6TIpGyl++
        jpQc4UJw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLRVH-0000Ci-KN; Mon, 06 Apr 2020 13:09:27 +0000
Date:   Mon, 6 Apr 2020 06:09:27 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] vdpa-sim: depend on HAS_DMA
Message-ID: <20200406130927.GA20291@infradead.org>
References: <20200405081355.2870-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200405081355.2870-1-mst@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pleae just drop the code - we should not add new drivers with custom
DMA ops.
