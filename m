Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E73C33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE027246CF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579195514;
	bh=BR4bAa3sU9jTA4hgBf/kKhrT7L1DR2b3BRTZ3iHNCgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LmYC6b9eXgoM79sUF8vsYfri/50+DUiMAlTakBX5DLstXd9TixzhhBtkdgurlKsy4
	 xRYPkUSwK6C91OBAhTVU8P2sfxSxhrMjmX2TsTGKoU/wgIYpvEHWOeTCgIElEzFSUH
	 rdjyR5AUmCfRU3ABNJsSqY5Vq043+ObY/PGgUxJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731740AbgAPRZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:25:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:60228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391824AbgAPRY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:24:56 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A51FE246AE;
        Thu, 16 Jan 2020 17:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195495;
        bh=BR4bAa3sU9jTA4hgBf/kKhrT7L1DR2b3BRTZ3iHNCgU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FAWRqBduZG6ms5+eyc5GmhQd/ljzUuWYFKKyQjfvuC+sJ+Mpq+2+aI47QiICaou4h
         czCwGaP3Vn0BAuLFE5m5TlZyesdG6giHLInyK3sS7E46JyMbXfJc8KxSIzQLnYP32S
         lXUwxawg+/KFa6XlfYINEY1pXyYh489G7cN3sTBw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wen Yang <wen.yang99@zte.com.cn>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Niklas Cassel <niklas.cassel@axis.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        linux-pci@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 097/371] PCI: endpoint: functions: Use memcpy_fromio()/memcpy_toio()
Date:   Thu, 16 Jan 2020 12:19:29 -0500
Message-Id: <20200116172403.18149-40-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116172403.18149-1-sashal@kernel.org>
References: <20200116172403.18149-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wen Yang <wen.yang99@zte.com.cn>

[ Upstream commit 726dabfde6aa35a4f1508e235ae37edbbf9fbc65 ]

Functions copying from/to IO addresses should use the
memcpy_fromio()/memcpy_toio() API rather than plain memcpy().

Fix the issue detected through the sparse tool.

Fixes: 349e7a85b25f ("PCI: endpoint: functions: Add an EP function to test PCI")
Suggested-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
[lorenzo.pieralisi@arm.com: updated log]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: Bjorn Helgaas <bhelgaas@google.com>
CC: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC: Niklas Cassel <niklas.cassel@axis.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
CC: linux-pci@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index f9308c2f22e6..c2541a772abc 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -177,7 +177,7 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
 		goto err_map_addr;
 	}
 
-	memcpy(buf, src_addr, reg->size);
+	memcpy_fromio(buf, src_addr, reg->size);
 
 	crc32 = crc32_le(~0, buf, reg->size);
 	if (crc32 != reg->checksum)
@@ -231,7 +231,7 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
 	get_random_bytes(buf, reg->size);
 	reg->checksum = crc32_le(~0, buf, reg->size);
 
-	memcpy(dst_addr, buf, reg->size);
+	memcpy_toio(dst_addr, buf, reg->size);
 
 	/*
 	 * wait 1ms inorder for the write to complete. Without this delay L3
-- 
2.20.1

