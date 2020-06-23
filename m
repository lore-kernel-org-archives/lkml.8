Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FF6C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD9DA2078A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592948691;
	bh=IJOs31q3U0GUA/Gt9yQ3tZenC2Ks1uwhy0P91NDVngA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kTr6ai25yKrtqA7OGADiiJ2jF7W0sNLMKQ1B2mehPtooccFhfcmxSBrHTdyBBPOPQ
	 yc3cyTnuqkgniycJS+8JRQFzyC2FrU8Caw6lHKXEC+TscLw2kLxK+6wK3GT5inkHEQ
	 po8XuWXuPZxBHQVFG26hPWMRlMqflXzkAy11M7bI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387749AbgFWUB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:01:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:38764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387714AbgFWUBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:01:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92D0A2078A;
        Tue, 23 Jun 2020 20:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592942512;
        bh=IJOs31q3U0GUA/Gt9yQ3tZenC2Ks1uwhy0P91NDVngA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HAZLwo6HbmiQ31pDlbWA2fsRZRi+opLWnwyZnWrz7Doa90CFKNK37gIwc6JsseJ/H
         lj1yl3kuPla9KQHUdEWC3Ze9NZ6Vz5yd6V6CZC5h7LfBbVBoaMtnjNemguY+XXR+6z
         Nk+AiKeZpYUPARpTGVaXTWR6FVx8FNJObjVL4TB4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 027/477] PCI: endpoint: functions/pci-epf-test: Fix DMA channel release
Date:   Tue, 23 Jun 2020 21:50:24 +0200
Message-Id: <20200623195408.891413807@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

[ Upstream commit 0e86d981f9b7252e9716c5137cd8e4d9ad8ef32f ]

When unbinding pci_epf_test, pci_epf_test_clean_dma_chan() is called in
pci_epf_test_unbind() even though epf_test->dma_supported is false.

As a result, dma_release_channel() will trigger a NULL pointer
dereference because dma_chan is not set.

Avoid calling dma_release_channel() if epf_test->dma_supported
is false.

Link: https://lore.kernel.org/r/1587540287-10458-1-git-send-email-hayashi.kunihiko@socionext.com
Fixes: 5ebf3fc59bd2 ("PCI: endpoint: functions/pci-epf-test: Add DMA support to transfer data")
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
[lorenzo.pieralisi@arm.com: commit log]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 60330f3e37516..c89a9561439f9 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -187,6 +187,9 @@ static int pci_epf_test_init_dma_chan(struct pci_epf_test *epf_test)
  */
 static void pci_epf_test_clean_dma_chan(struct pci_epf_test *epf_test)
 {
+	if (!epf_test->dma_supported)
+		return;
+
 	dma_release_channel(epf_test->dma_chan);
 	epf_test->dma_chan = NULL;
 }
-- 
2.25.1



