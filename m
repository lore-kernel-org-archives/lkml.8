Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01851C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C66E624979
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588941805;
	bh=GQS6+EQAyU4PQ2E8sPYaUu3YJ+wCBWJ8k/5K90gMOfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UqHAwAUI0QYRD2DChTJk1ff37C5NL8xPezXfKNsoPVYtiA7gmAfYQ2lzNqy8cyw+K
	 tih1ULa13hjf1Dk9Rxni7d/luYM39KF2sx1KwGbG39ZrCRN1rS4427T66X+f/yYHAR
	 cgFq0+y2moLpg+RDT0shP1PrxZ2Nm3CCXbodSIOw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbgEHMnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:43:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:40870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728620AbgEHMnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:43:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34D2B24973;
        Fri,  8 May 2020 12:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941795;
        bh=GQS6+EQAyU4PQ2E8sPYaUu3YJ+wCBWJ8k/5K90gMOfM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nXPJrs2Hn4Gs1YwI5H9ZGo2eN+AAjffUImrZhJtLm2sDW4ylhzo/6BH7LcOnkeunE
         Dd8LtAnmfHeXa7E+Xm8fSN4DP/1uYnbpTAaFLu+BW2YKBkAPzRGxQktznoMEoaKFmc
         In7bw7DZ1t33vV/jZnBlAXeK8Vs078uTFkBBkASY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Eric Auger <eric.auger@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH 4.4 174/312] VFIO: platform: reset: fix a warning message condition
Date:   Fri,  8 May 2020 14:32:45 +0200
Message-Id: <20200508123136.734835774@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
References: <20200508123124.574959822@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 967628827f404b3063016c138ccc7b06c54350f8 upstream.

This loop ends with count set to -1 and not zero so the warning message
isn't printed when it should be.  I've fixed this by change the postop
to a preop.

Fixes: 0990822c9866 ('VFIO: platform: reset: AMD xgbe reset module')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Eric Auger <eric.auger@linaro.org>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/vfio/platform/reset/vfio_platform_amdxgbe.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/vfio/platform/reset/vfio_platform_amdxgbe.c
+++ b/drivers/vfio/platform/reset/vfio_platform_amdxgbe.c
@@ -110,7 +110,7 @@ int vfio_platform_amdxgbe_reset(struct v
 	usleep_range(10, 15);
 
 	count = 2000;
-	while (count-- && (ioread32(xgmac_regs->ioaddr + DMA_MR) & 1))
+	while (--count && (ioread32(xgmac_regs->ioaddr + DMA_MR) & 1))
 		usleep_range(500, 600);
 
 	if (!count)


