Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB86FC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 08:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB3AD206D9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 08:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X7UpOJas"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgDTIsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 04:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725865AbgDTIsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 04:48:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A668AC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 01:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nROlfWRH9W8nLYXQI9f1gSOsE+u5fKGUlSBD/brz8E8=; b=X7UpOJasJeY0uR/Gz/XARnaeAM
        8E+EPRWvK9hk7Trcqic2JJEiFisRF08dBEtJT1zVDVpFBz4vdhCKHOa2Fktnq7aXuQpIDmUcamJz5
        PbGfTJGF75LQyAMEr6zBxqgysYmql5PWBBOOLg1/jNKNznHTtrglr7UdgdBj4hAxPcTl+j9AsDs4n
        N5/15uViDafc8rMuF5SHSKAUhw7VFYvx2PhAOBwNivOFlxcFtmLQCC798GZzIxBfV5ZsJCUbfIaO9
        PRHeKUr9DzysgeJnumwfTXMdYdHwY8EQJyMSKM72P6Skpty+CJRpAD6FZcGf1JgOeaY6xs6S6JGSp
        bvEqTm3Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQS6W-0006bO-SL; Mon, 20 Apr 2020 08:48:36 +0000
Date:   Mon, 20 Apr 2020 01:48:36 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: qlge: replace deprecated apis pci_dma_*
Message-ID: <20200420084836.GA24518@infradead.org>
References: <20200419010816.29125-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200419010816.29125-1-realwakka@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 19, 2020 at 10:08:16AM +0900, Sidong Yang wrote:
>  	direction =
> -	    (bit & (CFG_LRQ | CFG_LR | CFG_LCQ)) ? PCI_DMA_TODEVICE :
> -	    PCI_DMA_FROMDEVICE;
> +	    (bit & (CFG_LRQ | CFG_LR | CFG_LCQ)) ? DMA_TO_DEVICE :
> +	    DMA_FROM_DEVICE;

Can you unobsfucate this while you are at it?

	if (bit & (CFG_LRQ | CFG_LR | CFG_LCQ))
		direction = DMA_TO_DEVICE;
	else
		direction = DMA_FROM_DEVICE;

Otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
