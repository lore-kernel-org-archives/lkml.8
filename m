Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08E4C3F2D7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 11:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B10121739
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 11:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="EzwiVbDw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729439AbgCDLpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 06:45:55 -0500
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:34832 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729389AbgCDLpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 06:45:53 -0500
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 7B3D93F6D0;
        Wed,  4 Mar 2020 12:45:50 +0100 (CET)
Authentication-Results: pio-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b="EzwiVbDw";
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0YoJBpSr6G0B; Wed,  4 Mar 2020 12:45:49 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id ED6AB3F5E6;
        Wed,  4 Mar 2020 12:45:43 +0100 (CET)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 88CAA36037A;
        Wed,  4 Mar 2020 12:45:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1583322343; bh=DkZKy1wxQheUXkdvovfrp91b02AhTEEUVAqp7+y35v4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EzwiVbDwAhXV/f1h/n/D9arFrtr4vg44pc78QosAdspFrqHgPEnxhAZU5T+ybQXGL
         5b8Ve7NgSbH6L+UhU69baqJY7I010YPB+RV+qsDrLNdXkL1tcUqrOLk12xQYgNOGTZ
         jb9qqkimgJgMlZQLlNxIG8XTU3oUWq3e9o76/WgU=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     x86@kernel.org, Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH v3 2/2] dma-mapping: Fix dma_pgprot() for unencrypted coherent pages
Date:   Wed,  4 Mar 2020 12:45:27 +0100
Message-Id: <20200304114527.3636-3-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200304114527.3636-1-thomas_os@shipmail.org>
References: <20200304114527.3636-1-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

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

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Christian König <christian.koenig@amd.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
---
 kernel/dma/mapping.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 12ff766ec1fa..98e3d873792e 100644
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
2.21.1

