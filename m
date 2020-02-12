Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47D6C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 07:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD388206DB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 07:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OqCYBmBV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbgBLHe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 02:34:59 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35138 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbgBLHe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 02:34:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VxRUapHd7o/hPw0/UoJoo3K3tLVDD3iUiQQ+YB+fPrU=; b=OqCYBmBVgZgY2PVrufwv58UlCA
        e+gVjjox/snuJ/bOm/aXA7TljNw4yq8StckvefQVj9cnX2lfVUvtbcxLLKHzEmQ0XdPUBNK5y228v
        4AIUFcFEx8cTkHRynBy9jPFLPJcQU7yQo6978V89mjkJutdx6T4bzl1jchS93B8oNX/KC8Iia1VdD
        uvL0xSRjO6GOhkrgVwrgTJwgvpgT1lVkS25py7QDJ1Hru9JAY+98dtDw5ULGuAm/2FhiUHT9QR3rV
        aTlLegX/iWzNNsz2b9/xZFspNczK3TYOwIE1gw7LD/qVgMuvt0RjOSEIrnjK8VME9zZrat5zHVGlB
        on3Ahb+A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1mXu-0003wy-H1; Wed, 12 Feb 2020 07:34:57 +0000
Date:   Tue, 11 Feb 2020 23:34:54 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v2 01/25] mm: Use vm_fault error code directly
Message-ID: <20200212073454.GB7068@infradead.org>
References: <20200212041845.25879-1-willy@infradead.org>
 <20200212041845.25879-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212041845.25879-2-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 08:18:21PM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Use VM_FAULT_OOM instead of indirecting through vmf_error(-ENOMEM).
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
