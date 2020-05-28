Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD9DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9BAB215A4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590667170;
	bh=k001eEf5CLExcWv0jpkcsGYlWKNLQH8dqQpCxSJ/W54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kheZWK452Hm4E8LQHs26YB7Nx7XcySZi6mVhWThDgBq1Loxr81qvpxTNRatIDJjoF
	 LErPf/RwEQDJLQx30gH5H2SZo+psNXghFNKxeawS39ymp+grgSSiZbsMbnciOgVw9n
	 SLOZWiq8D+tDOnVjYbwC3g/Bp3Pov7lb6bdenLkw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389340AbgE1L7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 07:59:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:51282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389216AbgE1L6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 07:58:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD698217D9;
        Thu, 28 May 2020 11:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590667099;
        bh=k001eEf5CLExcWv0jpkcsGYlWKNLQH8dqQpCxSJ/W54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=edn910yLJndH7A57k7QCKoXOF7VLL0NQ695tPPGOsZ7mBNV9hLs5Hlm0TVlMyPNti
         hSR1TF72eSCTNL54VZVndou6lihl6zwK0pIiDTpEud4H0HfIsjux+c3Pau5ebGn+n6
         Z8VWDjsqNYmC7Gkdi6KOvHjIz6uqIijAWVOhtgJs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Qiushi Wu <wu000273@umn.edu>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 6/7] net: sun: fix missing release regions in cas_init_one().
Date:   Thu, 28 May 2020 07:58:10 -0400
Message-Id: <20200528115811.1406810-6-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200528115811.1406810-1-sashal@kernel.org>
References: <20200528115811.1406810-1-sashal@kernel.org>
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
index 062bce9acde6..bfe7b55f9714 100644
--- a/drivers/net/ethernet/sun/cassini.c
+++ b/drivers/net/ethernet/sun/cassini.c
@@ -4980,7 +4980,7 @@ static int cas_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 					  cas_cacheline_size)) {
 			dev_err(&pdev->dev, "Could not set PCI cache "
 			       "line size\n");
-			goto err_write_cacheline;
+			goto err_out_free_res;
 		}
 	}
 #endif
@@ -5151,7 +5151,6 @@ err_out_iounmap:
 err_out_free_res:
 	pci_release_regions(pdev);
 
-err_write_cacheline:
 	/* Try to restore it in case the error occurred after we
 	 * set it.
 	 */
-- 
2.25.1

