Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE68C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C76EF20663
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592946467;
	bh=QH+neuwgJTaNsiAoFnlGmSL3MuUoC4K7tqTFYVtZokE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ei8CIirPZl9Y1/yme8QpbTDh00mFZxL8MKHmECPpA8MwwDM7y3hppKl6oL/K/DJvw
	 Og7UQ4ETvkMAQW72GJ3zTgVqMPskMGTfskDkoNtM7Sxf9pt+xVLcmfxYTEs+icOl41
	 OmFx14zHyl5IHXYtKOQpa0O662RYMkZbG5AgHqJ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403795AbgFWUfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:35:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391639AbgFWUe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:34:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80B98206C3;
        Tue, 23 Jun 2020 20:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944499;
        bh=QH+neuwgJTaNsiAoFnlGmSL3MuUoC4K7tqTFYVtZokE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ph/ropRxMqEFR9r3qkeot2Wrt3nqbQRzxsCNP5hdwW70QAHRHkdXqq86UAiN77Yzc
         Fdxq8p4dFgOWQGRR9bLQJObrfKb63tl5KDfDPnsS85qew7Ao//afjaKuB/yF3buvgt
         X7dGn568UNnkd/igB5G/RQ1g7cw8x3C1LU1UyzQk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 014/206] PCI: Allow pci_resize_resource() for devices on root bus
Date:   Tue, 23 Jun 2020 21:55:42 +0200
Message-Id: <20200623195317.663954863@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195316.864547658@linuxfoundation.org>
References: <20200623195316.864547658@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index d8ca40a976934..d21fa04fa44d2 100644
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



