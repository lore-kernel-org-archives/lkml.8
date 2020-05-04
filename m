Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36CAC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEF482068E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JFjS6HjZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730468AbgEDRRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 13:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730047AbgEDRRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 13:17:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A49C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 10:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=u+5DhK/YCI055IE7ZBmVvDTxb6P2B8wAxhmtbg9+XOA=; b=JFjS6HjZzG70/7/eSJmrWFLrMM
        8KF2YwM+1/Mf7v/WnjkhltfpC44QdruYl5rYqhwF70aBkrpoDecKjoA0/B+UfxG8L3HBBGU5x86Dn
        aUZTORKVAXZcpXCTqhHGUGoJYRrulvTFmm8UHzhaJ8YdRS6+QfoijPrSZk8PB1w4q6nl1hlbH4MGk
        E0vvSOkvnwKmvumV1xBr1IWm2RG8QE6n8+bAORWKZIXbEgUoRwBG5r8yKjstb2yA7w9EewG0Wjq/K
        BFvNuaxKmReCypczTBc6RhetPxDKbZOs7NE7lKLikKAWLH2CSzCK9qyigkzWH8PxMuOHlJ452bdja
        PyB6cl0w==;
Received: from 089144205116.atnat0014.highway.webapn.at ([89.144.205.116] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVeis-0003Sw-LN; Mon, 04 May 2020 17:17:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     x86@kernel.org
Cc:     Mike Travis <mike.travis@hpe.com>, linux-kernel@vger.kernel.org
Subject: x86/uv cleanups
Date:   Mon,  4 May 2020 19:15:16 +0200
Message-Id: <20200504171527.2845224-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi x86 maintainers,

this series removes various exports and sniplets of dead code
from the x86/uv code.

Diffstat:

  8 files changed, 21 insertions(+), 111 deletions(-)
