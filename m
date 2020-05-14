Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39F3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 15:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABBF3205CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 15:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GGEf+AZk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgENPOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 11:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgENPOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 11:14:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4E7C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 08:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uSUydUvO5de16QbUQV/j8lXZOq2OQ7UGLXiWZJlBoBY=; b=GGEf+AZkYpqjLYConVlocDzcCG
        AYmCaUtORs64iLf59ZyBlOFcU5w5CfwSaDpvpq5fQK4iXHRrSV1HHqBMPsPClwoNNtSReObuPEbaM
        zvb9jvfFFr4q9K13X9Ay6rOomqz/SPhUrsIyHQjGXUCH7PXY2uqkjXxucDXoHhc+se3qRXvrD9k4q
        JrH3/g46azjvxCRvYld1s3DOgEM093IiucOXxPOUbBTJGyPRuk3T0pO7I0qS3yCu897dTbuG/XyBB
        eG40gXfYs+ckYbWaauhG83nH3Ry76t1oMwSVftINOdk0ceKebuROn1W8BTijky8IFto4WvPUN6b1Q
        yJKots0A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZFYd-0000MF-Vm; Thu, 14 May 2020 15:13:59 +0000
Date:   Thu, 14 May 2020 08:13:59 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH] lightnvm: Replace zero-length array with flexible-array
Message-ID: <20200514151359.GA1145@infradead.org>
References: <20200507190452.GA15449@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507190452.GA15449@embeddedor>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nvme.h has nothing to do with lightnvm.  I'll merge this with the next
one into a single nvme zero-length array patch.
