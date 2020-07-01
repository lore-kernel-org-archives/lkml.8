Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABCFC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DEB120702
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="bPdVAqgY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731684AbgGAPCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 11:02:33 -0400
Received: from first.geanix.com ([116.203.34.67]:51098 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727124AbgGAPCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 11:02:31 -0400
X-Greylist: delayed 329 seconds by postgrey-1.27 at vger.kernel.org; Wed, 01 Jul 2020 11:02:30 EDT
Received: from localhost (unknown [193.163.1.7])
        by first.geanix.com (Postfix) with ESMTPSA id C31832243302;
        Wed,  1 Jul 2020 14:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1593615423; bh=VCNbg8KAWx3WCHakE9UqNr62DnfO64KL9n8mC4ADfdA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=bPdVAqgYWpxE6wwb4vEtZS+OtqJwEKf5eE6nTdMnUSvsDTCyw6OP0RObYaOhHB85i
         nKSq80rAZ/3yjwYkkjg15qL1g9YYNHtaIUdR6lC7TFprTbHH5bg8TKtbqujzDv2LI6
         i2L4jNoiYQPKCbPn1bbm9bfgyuKX2rfNWQz+HSxqVQi6Fhh8im84+f/BmG0dwAIAXy
         RWqDLe2MjsACnEXWHwqRQWDnye53fgpVxNxHwrGBgN1o0hpl06vkbI23laZ/18u8oO
         9inM496APTLIC180EC48nYmpMDkzYdLyYQ2UWY5PkHRiDmXiVuiuIeP9jh1KAet09I
         35BRCZFMlMmkg==
From:   Esben Haabendal <esben@geanix.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] uio_pdrv_genirq: Allow use with non-page-aligned memory resources
Date:   Wed,  1 Jul 2020 16:56:59 +0200
Message-Id: <20200701145659.3978-4-esben@geanix.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200701145659.3978-1-esben@geanix.com>
References: <20200701145659.3978-1-esben@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to the changes made in 270579d95f82 ("uio_mf624: Align memory
regions to page size and set correct offsets"), this will allow
uio_pdrv_genirq devices to expose memory regions that is not page-aligned,
requiring the users to respect the offset sysfs attribute (as implemented
in libuio).

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/uio/uio_pdrv_genirq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/uio/uio_pdrv_genirq.c b/drivers/uio/uio_pdrv_genirq.c
index b60173bc93ce..86f75a4fe0e3 100644
--- a/drivers/uio/uio_pdrv_genirq.c
+++ b/drivers/uio/uio_pdrv_genirq.c
@@ -187,8 +187,10 @@ static int uio_pdrv_genirq_probe(struct platform_device *pdev)
 		}
 
 		uiomem->memtype = UIO_MEM_PHYS;
-		uiomem->addr = r->start;
-		uiomem->size = resource_size(r);
+		uiomem->addr = r->start & PAGE_MASK;
+		uiomem->offs = r->start & ~PAGE_MASK;
+		uiomem->size = (uiomem->offs + resource_size(r)
+				+ PAGE_SIZE - 1) & PAGE_MASK;
 		uiomem->name = r->name;
 		++uiomem;
 	}
-- 
2.4.11

