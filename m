Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2D3C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D14F206B9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587046700;
	bh=bLaYknW8xJkpruAeW9vzpZ0HesbH5LKBqP1T/qNO/0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T4l6OJecr0ekIp9uXGkeAh5LPDN59p3RAZ+l/spALbWCQG0VqHbwSj6b4KBLJLxMn
	 f4jA7Sw0P6YWCT8MYcXavgl1xJHcNF2ehRxTbdXpnvz1eYNXJP5OtWQzbdqlJwfpLi
	 ZEJT/1W7uqf+J5VZcy0sHJkYjTWkYg1urjHnQLH4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409720AbgDPOSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:18:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:39310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408928AbgDPNw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:52:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED3062076D;
        Thu, 16 Apr 2020 13:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587045178;
        bh=bLaYknW8xJkpruAeW9vzpZ0HesbH5LKBqP1T/qNO/0I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LOm4FXCJ8SmBfOYWoWlqlxd2L/b1Qoe812WPig5NUf3GM1RhQJwkPOJMRZmLlzJtt
         o0xS7LgT2tkFOEmw6OnUjO4YZ8ilY/xo03xQ10fDuprnhDt5/T1WyKZVDY32bqlPDS
         xBiA671V6OsEnmqjDHcTrLFZ5fsPc0A8XrfbsCy0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Hellstrom <thellstrom@vmware.com>,
        Borislav Petkov <bp@suse.de>, Christoph Hellwig <hch@lst.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 028/254] dma-mapping: Fix dma_pgprot() for unencrypted coherent pages
Date:   Thu, 16 Apr 2020 15:21:57 +0200
Message-Id: <20200416131329.359655264@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.804095985@linuxfoundation.org>
References: <20200416131325.804095985@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

[ Upstream commit 17c4a2ae15a7aaefe84bdb271952678c5c9cd8e1 ]

When dma_mmap_coherent() sets up a mapping to unencrypted coherent memory
under SEV encryption and sometimes under SME encryption, it will actually
set up an encrypted mapping rather than an unencrypted, causing devices
that DMAs from that memory to read encrypted contents. Fix this.

When force_dma_unencrypted() returns true, the linear kernel map of the
coherent pages have had the encryption bit explicitly cleared and the
page content is unencrypted. Make sure that any additional PTEs we set
up to these pages also have the encryption bit cleared by having
dma_pgprot() return a protection with the encryption bit cleared in this
case.

Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lkml.kernel.org/r/20200304114527.3636-3-thomas_os@shipmail.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/mapping.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 12ff766ec1fa3..98e3d873792ea 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -154,6 +154,8 @@ EXPORT_SYMBOL(dma_get_sgtable_attrs);
  */
 pgprot_t dma_pgprot(struct device *dev, pgprot_t prot, unsigned long attrs)
 {
+	if (force_dma_unencrypted(dev))
+		prot = pgprot_decrypted(prot);
 	if (dev_is_dma_coherent(dev) ||
 	    (IS_ENABLED(CONFIG_DMA_NONCOHERENT_CACHE_SYNC) &&
              (attrs & DMA_ATTR_NON_CONSISTENT)))
-- 
2.20.1



