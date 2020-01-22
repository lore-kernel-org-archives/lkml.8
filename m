Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F20C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41CDE2467B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579685769;
	bh=69r7vk7uHEpTuwlwwAtbipRDW/05if9LicMmlZJ/A5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q+NO8ZjEu2D34gR2Q3iWv8jbZiP1M6vw8Z2i26IqK4PW51JyeUJCLBK5Tyw75i3Mm
	 4uQtGfAkaWKWyTsD0AKhdKhJZXtY8WGgCk0ZfQSRGD0FcClsdPpQOCjPY6VKdOWHLg
	 9Xm0deFIrzV5Ib+7BbJRiwcy7R2le2OMNCOYZZXE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731637AbgAVJgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:36:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:51376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731591AbgAVJgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:36:00 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF0002467A;
        Wed, 22 Jan 2020 09:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579685760;
        bh=69r7vk7uHEpTuwlwwAtbipRDW/05if9LicMmlZJ/A5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QXcepaWFy8nfgFniH56r4ClN/sNFlesDuLukVYvoyv0cghibCzTysghEmCy844IE/
         YnzQerzJ3YhdUSfK5XSLN6fLD82qwXrxDt/XPBRP2XKEkqcWMLSA6AARDdIwekICfp
         ZgdAzpA/QBEOr5Vt+J5SgMxZJR60v3AkQkHYW39c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jose Abreu <Jose.Abreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 69/97] net: stmmac: 16KB buffer must be 16 byte aligned
Date:   Wed, 22 Jan 2020 10:29:13 +0100
Message-Id: <20200122092807.473973825@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092755.678349497@linuxfoundation.org>
References: <20200122092755.678349497@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jose Abreu <Jose.Abreu@synopsys.com>

commit 8605131747e7e1fd8f6c9f97a00287aae2b2c640 upstream.

The 16KB RX Buffer must also be 16 byte aligned. Fix it.

Fixes: 7ac6653a085b ("stmmac: Move the STMicroelectronics driver")
Signed-off-by: Jose Abreu <Jose.Abreu@synopsys.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/stmicro/stmmac/common.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -326,8 +326,8 @@ struct dma_features {
 	unsigned int enh_desc;
 };
 
-/* GMAC TX FIFO is 8K, Rx FIFO is 16K */
-#define BUF_SIZE_16KiB 16384
+/* RX Buffer size must be multiple of 4/8/16 bytes */
+#define BUF_SIZE_16KiB 16368
 #define BUF_SIZE_8KiB 8192
 #define BUF_SIZE_4KiB 4096
 #define BUF_SIZE_2KiB 2048


