Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EF6C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 22:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E121207F5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 22:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593641479;
	bh=Uu5gADrn1c8/F3DyyVDuZVDs635s6vTyqaj9liPB4zg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wXSoNwzuPGKvIMklzMF68INX+XOJtOvkCo9+V8Y+/ortScuPLPx4PEIKZf557mlPe
	 85y1FfCZ+OCJOn9cs9nbiNOG6WRWlk6aTuxWvEsQkZja157dvxVWF1lCGz8bPDGEIG
	 1vuiPPqK/q4BfIn9T/ZM0h81S2FoR/uFTR5C+WXc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbgGAWLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 18:11:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:46944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgGAWLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 18:11:17 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22F4620780;
        Wed,  1 Jul 2020 22:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593641477;
        bh=Uu5gADrn1c8/F3DyyVDuZVDs635s6vTyqaj9liPB4zg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U8yRMXPv35K3avDnwhvyRBDN3TNUYAo8JSlafx8DbhjvxNvecxo6SLc034QaZPn4h
         lKm1OjMxsQHLbtB1FSpdDBiwsCDxCPL4QTIgMUXfOptbU2PVJLe2Oe1Rv4KuXzxI1A
         zhmCVHmxGbIqhYSKQE5jqPLVCYeSkWEbZptbj6Cw=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 2/2] virtio-mmio: Reject invalid IRQ 0 command line argument
Date:   Wed,  1 Jul 2020 17:10:40 -0500
Message-Id: <20200701221040.3667868-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701221040.3667868-1-helgaas@kernel.org>
References: <20200701221040.3667868-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

The "virtio_mmio.device=" command line argument allows a user to specify
the size, address, and IRQ of a virtio device.  Previously the only
requirement for the IRQ was that it be an unsigned integer.

Zero is an unsigned integer but an invalid IRQ number, and after
a85a6c86c25be ("driver core: platform: Clarify that IRQ 0 is invalid"),
attempts to use IRQ 0 cause warnings.

If the user specifies IRQ 0, return failure instead of registering a device
with IRQ 0.

Fixes: a85a6c86c25be ("driver core: platform: Clarify that IRQ 0 is invalid")
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org
---
 drivers/virtio/virtio_mmio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 9d16aaffca9d..627ac0487494 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -641,11 +641,11 @@ static int vm_cmdline_set(const char *device,
 			&vm_cmdline_id, &consumed);
 
 	/*
-	 * sscanf() must processes at least 2 chunks; also there
+	 * sscanf() must process at least 2 chunks; also there
 	 * must be no extra characters after the last chunk, so
 	 * str[consumed] must be '\0'
 	 */
-	if (processed < 2 || str[consumed])
+	if (processed < 2 || str[consumed] || irq == 0)
 		return -EINVAL;
 
 	resources[0].flags = IORESOURCE_MEM;
-- 
2.25.1

