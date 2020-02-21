Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942DAC35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5789924670
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582272960;
	bh=Izh1q7FxqCspuUufDA0SeKtC98zPn21rVDYFbOw+Fmk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ktb5xw7FAq1flIn8H3B4J85yxTMIvLIfMe3ZFynfk1SLTpnnKGyv2REqwRZSBa+Qj
	 sQrwb+MdNYqBygPvYzd0csMEOliullsvLuQEO7UWkdZiNMqAfx4OVS2pbT574Wgh5l
	 mWfz0W+wuQFXBRL5PwTPY79kgUp3eXyvwcdH+qk8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732617AbgBUIP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:15:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:52738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387439AbgBUIPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:15:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C544A24681;
        Fri, 21 Feb 2020 08:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582272951;
        bh=Izh1q7FxqCspuUufDA0SeKtC98zPn21rVDYFbOw+Fmk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=McbyAGFqIF+YmDjH+czrI7tK2sS19UNV1imeSCkFTq/DVkVqddskRwCd8ZtTTnwTi
         GWu7fqsF9phE7A/tJhaSFSuvbSR0pZlOyqluMMEIRQJy+37Ij1pEpBBLCjBNAV5cty
         BOjr3XrnXRH+Wn9IalRUxX2/z9H0bQI0wKf2/et4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <sashal@kernel.org>, Frank <fgndev@posteo.de>
Subject: [PATCH 5.4 290/344] iommu/vt-d: Remove unnecessary WARN_ON_ONCE()
Date:   Fri, 21 Feb 2020 08:41:29 +0100
Message-Id: <20200221072416.181032034@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072349.335551332@linuxfoundation.org>
References: <20200221072349.335551332@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lu Baolu <baolu.lu@linux.intel.com>

[ Upstream commit 857f081426e5aa38313426c13373730f1345fe95 ]

Address field in device TLB invalidation descriptor is qualified
by the S field. If S field is zero, a single page at page address
specified by address [63:12] is requested to be invalidated. If S
field is set, the least significant bit in the address field with
value 0b (say bit N) indicates the invalidation address range. The
spec doesn't require the address [N - 1, 0] to be cleared, hence
remove the unnecessary WARN_ON_ONCE().

Otherwise, the caller might set "mask = MAX_AGAW_PFN_WIDTH" in order
to invalidating all the cached mappings on an endpoint, and below
overflow error will be triggered.

[...]
UBSAN: Undefined behaviour in drivers/iommu/dmar.c:1354:3
shift exponent 64 is too large for 64-bit type 'long long unsigned int'
[...]

Reported-and-tested-by: Frank <fgndev@posteo.de>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/dmar.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index eecd6a4216672..7196cabafb252 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -1351,7 +1351,6 @@ void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 	struct qi_desc desc;
 
 	if (mask) {
-		WARN_ON_ONCE(addr & ((1ULL << (VTD_PAGE_SHIFT + mask)) - 1));
 		addr |= (1ULL << (VTD_PAGE_SHIFT + mask - 1)) - 1;
 		desc.qw1 = QI_DEV_IOTLB_ADDR(addr) | QI_DEV_IOTLB_SIZE;
 	} else
-- 
2.20.1



