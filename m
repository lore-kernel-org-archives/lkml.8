Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C863DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D2F221702
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590667112;
	bh=AVGXMPcUqHOK+pnEmmZktx6RISb91wkTsxgWSVKUtYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YMYpwQYa6EscA8xuDuAVAQeXeqH/cidESsw4y31plQ5udM5BaF89o6TNIWX7/Nezk
	 8/74Bqfksle2njqtXH5DcbrF9xFaRFdBtU9ts/D7Ry6QTXFD1MC4Zpl93aDxGjW50S
	 8c/Gr+j/NBLsHufZWKBlltro2qfPgCSUmKbxubB0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388611AbgE1L6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 07:58:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:50254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389058AbgE1L5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 07:57:41 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D13E2176B;
        Thu, 28 May 2020 11:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590667060;
        bh=AVGXMPcUqHOK+pnEmmZktx6RISb91wkTsxgWSVKUtYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zhTYjoRVGXGEdfx2AGTjuJ5qYKaRDt4n/ez5aFVbyjsE8Evucg8KNb0nf4mUexlH/
         LdzZHxz4AT/FKaPIteLzQNFYlLu+H/5xAQB8irjEBrCLq0I7T33ZWSx4G8hVe/6sZG
         WM62KVkE45RiOnEGNx26DIUOkLUi6MpJ8KvRs/fI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Qiushi Wu <wu000273@umn.edu>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 14/17] net: sun: fix missing release regions in cas_init_one().
Date:   Thu, 28 May 2020 07:57:21 -0400
Message-Id: <20200528115724.1406376-14-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200528115724.1406376-1-sashal@kernel.org>
References: <20200528115724.1406376-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

[ Upstream commit 5a730153984dd13f82ffae93d7170d76eba204e9 ]

In cas_init_one(), "pdev" is requested by "pci_request_regions", but it
was not released after a call of the function “pci_write_config_byte”
failed. Thus replace the jump target “err_write_cacheline” by
"err_out_free_res".

Fixes: 1f26dac32057 ("[NET]: Add Sun Cassini driver.")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/sun/cassini.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/sun/cassini.c b/drivers/net/ethernet/sun/cassini.c
index 7ec4eb74fe21..d323dd9daccb 100644
--- a/drivers/net/ethernet/sun/cassini.c
+++ b/drivers/net/ethernet/sun/cassini.c
@@ -4971,7 +4971,7 @@ static int cas_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 					  cas_cacheline_size)) {
 			dev_err(&pdev->dev, "Could not set PCI cache "
 			       "line size\n");
-			goto err_write_cacheline;
+			goto err_out_free_res;
 		}
 	}
 #endif
@@ -5144,7 +5144,6 @@ err_out_iounmap:
 err_out_free_res:
 	pci_release_regions(pdev);
 
-err_write_cacheline:
 	/* Try to restore it in case the error occurred after we
 	 * set it.
 	 */
-- 
2.25.1

