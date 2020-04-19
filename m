Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E00AC5321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 16:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6865F21974
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 16:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgDSQtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 12:49:53 -0400
Received: from v6.sk ([167.172.42.174]:43732 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbgDSQtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 12:49:53 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 987D5610A9;
        Sun, 19 Apr 2020 16:49:21 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 2/7] dmaengine: mmp_tdma: Drop "mmp_tdma: from error messages
Date:   Sun, 19 Apr 2020 18:49:07 +0200
Message-Id: <20200419164912.670973-3-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200419164912.670973-1-lkundrak@v3.sk>
References: <20200419164912.670973-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop a redundant "mmp_tdma:" from some error messages. The dev_err()
appends mostly the same thing for us:

  [  120.756530] mmp-tdma d42a0800.adma: mmp_tdma: unknown burst size.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/dma/mmp_tdma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/mmp_tdma.c b/drivers/dma/mmp_tdma.c
index 51e08c16756ae..d559bb4d6a31d 100644
--- a/drivers/dma/mmp_tdma.c
+++ b/drivers/dma/mmp_tdma.c
@@ -235,7 +235,7 @@ static int mmp_tdma_config_chan(struct dma_chan *chan)
 			tdcr |= TDCR_BURSTSZ_128B;
 			break;
 		default:
-			dev_err(tdmac->dev, "mmp_tdma: unknown burst size.\n");
+			dev_err(tdmac->dev, "unknown burst size.\n");
 			return -EINVAL;
 		}
 
@@ -250,7 +250,7 @@ static int mmp_tdma_config_chan(struct dma_chan *chan)
 			tdcr |= TDCR_SSZ_32_BITS;
 			break;
 		default:
-			dev_err(tdmac->dev, "mmp_tdma: unknown bus size.\n");
+			dev_err(tdmac->dev, "unknown bus size.\n");
 			return -EINVAL;
 		}
 	} else if (tdmac->type == PXA910_SQU) {
@@ -276,7 +276,7 @@ static int mmp_tdma_config_chan(struct dma_chan *chan)
 			tdcr |= TDCR_BURSTSZ_SQU_32B;
 			break;
 		default:
-			dev_err(tdmac->dev, "mmp_tdma: unknown burst size.\n");
+			dev_err(tdmac->dev, "unknown burst size.\n");
 			return -EINVAL;
 		}
 	}
-- 
2.26.0

