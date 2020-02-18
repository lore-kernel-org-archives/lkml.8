Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91197C34049
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6620921D56
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MSVWYxBs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgBRSlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 13:41:39 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45442 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgBRSli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 13:41:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=1oMlAqkswRy6z1mHgxyhn28sxtzqgf7pOgIVPkyRZVw=; b=MSVWYxBsB6pwrCb63c9y7K9Eof
        CM3I0J+nMSxFYWJqUAxpLv8JD/I2seyhRqFKC5ZouzNomNp9OI6hSY+fkNbvM+DzrwQW05M7k8U51
        Yx+Rz6pjkDhoZmFjdmZUipxZgnLhfa6e/wN78P2XNdkfKFFVbA08jnhGdImDsPKHF9zisJZS5B0LE
        fJOy2Rrxmr1wh5MJBuRzIPWNplu6BtqS6wDC0pzYPaJarTqSWohHG/Ag63n2XKwavAVTvZr4zdqcs
        YcpyPhjXtGKB5AXHHt9plw6LHVjW3gqnGyy+QVFGsS7LvsWNVRPq3K30q9ihnIZca2nNTfgv9oK/x
        +wA31VUQ==;
Received: from [199.255.44.128] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j47oF-0002Ka-9J; Tue, 18 Feb 2020 18:41:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Roger Quadros <rogerq@ti.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: take the bus_dma_limit into account on arm
Date:   Tue, 18 Feb 2020 10:41:00 -0800
Message-Id: <20200218184103.35932-1-hch@lst.de>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

this series fixes the arm dma coherent allocator to take the bus dma
mask into account, similar to what other architectures do.  Without
this devices that support 64-bit mask, but are limited by the
interconnect won't work properly.
