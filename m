Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE86C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED38120786
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592947361;
	bh=QH+neuwgJTaNsiAoFnlGmSL3MuUoC4K7tqTFYVtZokE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GEl0GnxJI7RUt3lvLReLbpF+HV6rEvibQpoFSy9731/ihJtLbx0jgyiL0k3/LrEGR
	 +aCctKOfYINizjgKNgLykuV6ZiY2jAUtjzBkc46GT4PKMSdxATFUIWZj12nzRi2T9h
	 HUp2lA42b438IyYiNKggdsd0VQPY+zNml5C34hyM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390511AbgFWVWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:22:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:39614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390094AbgFWUVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:21:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58F8D2070E;
        Tue, 23 Jun 2020 20:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943711;
        bh=QH+neuwgJTaNsiAoFnlGmSL3MuUoC4K7tqTFYVtZokE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fCS6HG35cE2zY3p+Tsd7niCiofUZMP5A7db/BuJjNFBUvTvNZ9RIOcl5Ee51WO2xk
         1Pn+ExEpXDPQ0tX/4ICtCdOac7zuk1pR4+SSqIkUZhUTJSGW1xXl9bF3aJKk3PpI04
         o/NuYupRqbMoZqoaMeGi1BiQABdi0B4f2cHD5RBc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 020/314] PCI: Allow pci_resize_resource() for devices on root bus
Date:   Tue, 23 Jun 2020 21:53:35 +0200
Message-Id: <20200623195339.747814091@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195338.770401005@linuxfoundation.org>
References: <20200623195338.770401005@linuxfoundation.org>
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



