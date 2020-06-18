Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2C2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA9E22075E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592443544;
	bh=1KY3sCatdlrZk8pPgJHuVIdcaXAwLRkY5NEVDPA9ANA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wISdTRRLcfLdJG7uws2SGJHEN9xmU/2EZuU5zg8GgwPtdh+ZHF0jl2LgY3IvN1NJN
	 E/FMmKl9aAQdYucNc3NsMzT5Pqw0wYSncSqHo9wTyfR+LUBdvou6jfkr0wbUDWSEfR
	 HtqN4Y2RNi59xfHLWre/xA0uAvMONn8eY4kwJ6pA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730389AbgFRBZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:25:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:55762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730804AbgFRBWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:22:39 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5960520FC3;
        Thu, 18 Jun 2020 01:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443359;
        bh=1KY3sCatdlrZk8pPgJHuVIdcaXAwLRkY5NEVDPA9ANA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0QcG+tOcUbQ71d03szY0vArVAOZNTc7ZTJD7qFq4jeylDLM59tk7x1WdZ2u1egRdf
         gd+2g5dF+BUoI0Fp3y0z9MORttFsVoylAfzUlbCT/G9LDr/j8w02BxNd6pSff5m29T
         7nBEGF2GXRJOl6T765b9AvO/I9q2vcsNwsRtt66c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 016/172] PCI: Allow pci_resize_resource() for devices on root bus
Date:   Wed, 17 Jun 2020 21:19:42 -0400
Message-Id: <20200618012218.607130-16-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618012218.607130-1-sashal@kernel.org>
References: <20200618012218.607130-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

[ Upstream commit d09ddd8190fbdc07696bf34b548ae15aa1816714 ]

When resizing a BAR, pci_reassign_bridge_resources() is invoked to bring
the bridge windows of parent bridges in line with the new BAR assignment.

This assumes the device whose BAR is being resized lives on a subordinate
bus, but this is not necessarily the case. A device may live on the root
bus, in which case dev->bus->self is NULL, and passing a NULL pci_dev
pointer to pci_reassign_bridge_resources() will cause it to crash.

So let's make the call to pci_reassign_bridge_resources() conditional on
whether dev->bus->self is non-NULL in the first place.

Fixes: 8bb705e3e79d84e7 ("PCI: Add pci_resize_resource() for resizing BARs")
Link: https://lore.kernel.org/r/20200421162256.26887-1-ardb@kernel.org
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/setup-res.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index d8ca40a97693..d21fa04fa44d 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -439,10 +439,11 @@ int pci_resize_resource(struct pci_dev *dev, int resno, int size)
 	res->end = res->start + pci_rebar_size_to_bytes(size) - 1;
 
 	/* Check if the new config works by trying to assign everything. */
-	ret = pci_reassign_bridge_resources(dev->bus->self, res->flags);
-	if (ret)
-		goto error_resize;
-
+	if (dev->bus->self) {
+		ret = pci_reassign_bridge_resources(dev->bus->self, res->flags);
+		if (ret)
+			goto error_resize;
+	}
 	return 0;
 
 error_resize:
-- 
2.25.1

