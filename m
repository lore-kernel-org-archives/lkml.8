Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C9CC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 15:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28AA020848
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 15:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BvHUVuHK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731150AbgCaPsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 11:48:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45784 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731122AbgCaPsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 11:48:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fUz6OAumwsnNN13FJN1nZm6qsC+5OL3CtJbJy+PsHps=; b=BvHUVuHKW9qmd6A+07zy3EB34g
        sQlYipI+KAR0yQYTmDV+64pPnOiz92PPliuUuDtZik70lNGQBXDSagZVvVv67o5gXZLAvTTD5AlMY
        JwFgv61F0aLD+aWmLWivFZ9yVhJVfCXrbRvIJYZBTELotUercAAeUSNprcUwyvG8RXg1rMSErG6hW
        rGA7dJ4EagH5BF8nEuAuGYQ0bEM6TnlFn/fBjJY23NU8tS5R0bgTC4wKEhLkj2oPB+Me92p5QlxiL
        0gPVgd2UuzloLoQk+5R0p3lsR+YAcYFEnlGzq8DVKyGOAd67SyLFbsCg/dUo0+ol74l/B9JhCj1VY
        D0yrjKVA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJHhk-0006tY-CT; Tue, 31 Mar 2020 14:17:24 +0000
Date:   Tue, 31 Mar 2020 07:17:24 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Nick Bowler <nbowler@draconx.ca>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2 2/2] nvme: Fix compat address handling in several
 ioctls
Message-ID: <20200331141724.GB26408@infradead.org>
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

Thanks,

applied to nvme-5.7.
