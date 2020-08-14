Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23679C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 08:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8D282074D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 08:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YiTlwITG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgHNIRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 04:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgHNIRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 04:17:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595B0C061383
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 01:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=g8PSEAUA7x2opNJ9a7x6NEXmPCi+/BopzEM5tlmpuYw=; b=YiTlwITG20aDN876I+mE/JX+xS
        AeqYqW0mEmRrrc6vwVasr/wMYwOG3IBnH8h2+s46OQyWKhMp98c3i4/GlMAg/O5QBj+dJ+DNZ3ZuF
        OhN8mNTpmBBvJIHzMJ3YdU0+El1b1sqM9yS1H1bhKaKVSWQbJgaDZDXcAuimgx0Hys8Swl7hyGjKT
        QyjMs8b0FMM/Zobo6kAaxW6s0CHJGIXk1qa+Y9EZuYvflAikGe1fBA2LoMDUAMcCoQBRDlBRz8oZV
        +uq86/ahtS6IhUc9nPLV11BilFUb52dwDczoHFcvjg8k3gvPjmyBkVZd39iZmCDDh3yy4x74tJZDI
        JiRKFEQA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k6Utl-0004nA-DH; Fri, 14 Aug 2020 08:17:13 +0000
Date:   Fri, 14 Aug 2020 09:17:13 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     james.smart@broadcom.com, kbusch@kernel.org, axboe@fb.com,
        hch@lst.de, sagi@grimberg.me, jthumshirn@suse.de,
        james_p_freyensee@linux.intel.com, tianjia.zhang@alibaba.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-fc: Fix wrong return value in
 __nvme_fc_init_request()
Message-ID: <20200814081713.GA18371@infradead.org>
References: <20200802111545.5566-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200802111545.5566-1-tianjia.zhang@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 02, 2020 at 07:15:45PM +0800, Tianjia Zhang wrote:
> On an error exit path, a negative error code should be returned
> instead of a positive return value.
> 
> Fixes: e399441de9115 ("nvme-fabrics: Add host support for FC transport")
> Cc: James Smart <jsmart2021@gmail.com>
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
