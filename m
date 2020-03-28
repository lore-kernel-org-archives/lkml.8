Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440E4C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 08:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08E5E2072F
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 08:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r1cKMSe3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbgC1I0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 04:26:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46408 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgC1I0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 04:26:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eOggFzgbFn29dkfZZlS6sfCOV6wLELqWWgS4F9Z7Rho=; b=r1cKMSe3yQ+cuGcB49zG8+uJNK
        WLsTpDaI2Zn6VXLBEMIhWTETP7kTCKGyFhSQlNNrcgp00b+9ZoedZRR+V1gqYITVmCs7rbECRpvqv
        ZT9teqcEbS9FCiO7bsb3j1Cz3/2dMDHT4nMnYhKKvotvbhceaE6o6A58yrbPCHuw5Zq1tNaI4a2l0
        iJ+Y0NedmZRfAuj7ICc9o7I+zgMzr+ZHOg93+gT/R8eQG32+5LKgVccFIOXLpzy5hIWsMdIJ3w9Li
        ccofMIMRp8AoQnB67VxGQbDDRrfP3QziQKNjvL4tj51L0QiwaSsfMxEGDJAdNPA0Stsz2PWd54Fun
        1ElRh0qQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jI6nj-0003xm-Bp; Sat, 28 Mar 2020 08:26:43 +0000
Date:   Sat, 28 Mar 2020 01:26:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Nick Bowler <nbowler@draconx.ca>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@infradead.org>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v2 2/2] nvme: Fix compat address handling in several
 ioctls
Message-ID: <20200328082643.GB7658@infradead.org>
References: <20200328050909.30639-1-nbowler@draconx.ca>
 <20200328050909.30639-3-nbowler@draconx.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200328050909.30639-3-nbowler@draconx.ca>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good, and I really like the new nvme_to_user_ptr helper!

Reviewed-by: Christoph Hellwig <hch@lst.de>
