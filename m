Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD27C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD6FA20707
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592943029;
	bh=JwxtI2utEs1b1MKZ4s6+Ql5C+ZhqlhprJ0fgj2lpBNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=czna08wD8CxPqgb/RrkkpMYY634lynX9iF15LHklUR+vlixBmMPnlxvTX6TYP6SmY
	 Km4x+6qL/dfH3VSNsa4sFV/MDccDySMhSWVfnlFHfotF3uo+obpbPcc5yL4aq7+UUu
	 DFvKhl6yOGXcRh3PA1vxUfiA8WEHKwzc+hmdy8pI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388495AbgFWUK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:10:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:50706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388729AbgFWUJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:09:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C46C92082F;
        Tue, 23 Jun 2020 20:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592942973;
        bh=JwxtI2utEs1b1MKZ4s6+Ql5C+ZhqlhprJ0fgj2lpBNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WhJVXu0E64EEEHSopWOYOTsdmDumPd3Vg+Sl397Jr8qvPh1ZAlp7TF50VUySUxTOX
         uqRZlMpCFV9QT0/mGDbAksTeCX+TE5iGhi0zX1EjYkh0ftRJSd5EaUx/suLIq0sT2k
         fCAMOsz0+VrxUa7XSJ/wNejf6fINpAbc7GVaaxtM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 201/477] PCI: Fix pci_register_host_bridge() device_register() error handling
Date:   Tue, 23 Jun 2020 21:53:18 +0200
Message-Id: <20200623195417.087167445@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Herring <robh@kernel.org>

[ Upstream commit 1b54ae8327a4d630111c8d88ba7906483ec6010b ]

If device_register() has an error, we should bail out of
pci_register_host_bridge() rather than continuing on.

Fixes: 37d6a0a6f470 ("PCI: Add pci_register_host_bridge() interface")
Link: https://lore.kernel.org/r/20200513223859.11295-1-robh@kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/probe.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index c7e3a8267521b..b59a4b0f5f162 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -909,9 +909,10 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 		goto free;
 
 	err = device_register(&bridge->dev);
-	if (err)
+	if (err) {
 		put_device(&bridge->dev);
-
+		goto free;
+	}
 	bus->bridge = get_device(&bridge->dev);
 	device_enable_async_suspend(bus->bridge);
 	pci_set_bus_of_node(bus);
-- 
2.25.1



