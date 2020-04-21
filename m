Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB14C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 08:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8D022084D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 08:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h8c6i4hD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgDUIGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 04:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgDUIGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 04:06:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AECC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 01:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=h+r1x9KhnyPt84Iz/3/Xv5cxPC5WTNlXZPYBrogn23Q=; b=h8c6i4hDi/WuPaCeqF6nsa6PXI
        me37IaFVT3j6NBaYmD131z0Zg2JBC5WChtksoFSRqzubiDoTxpqk5L3icaUri3ow4tD3LE+slKlyt
        HhojzTa9HfJ8zQPhpXsFLNDCqDCHzWz2p83bgtS7m98PHZWraiVynKvR++XioCU0ON/AH/syEqR/l
        OymJ9R33kgLvZnkz7noBOB4+gT0YTMzi73zR5FWK8VSfV6wyoqGkrLt8RrDoEnIeuoUhOScMKTyNo
        CEPZXb+JrbHv4vufwLEnxITJWbFmyGYyrRWJVJsx5rkUewlLfJsfHTg9QfhB8uNFog8RgIzlN/liJ
        Aq5uC1Tg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQnuq-0006zR-Rn; Tue, 21 Apr 2020 08:06:00 +0000
Date:   Tue, 21 Apr 2020 01:06:00 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
        Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: qlge: replace deprecated apis pci_dma_*
Message-ID: <20200421080600.GA26595@infradead.org>
References: <20200420154009.21161-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420154009.21161-1-realwakka@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 12:40:09AM +0900, Sidong Yang wrote:
> From: realwakka <realwakka@gmail.com>
> 
> Replace legacy/depreacted pci_dma_* functions to new dma_* functions.
> Also replace PCI_DMA_* macro to DMA* macro.
> 
> Signed-off-by: realwakka <realwakka@gmail.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
