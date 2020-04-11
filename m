Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30978C2BB85
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D5420644
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586608089;
	bh=4xxN/LclMpdMStU1HXKQchgd+iyfOMPCUl1uogaTx9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DM5qS4Ehv015fgriCnnP/7YkfGpEOoWRJ2qcBDJjgMLsRW6mXo9GfpB5MuPg+xHIG
	 O2x8seYBV4WyTKFhe5AEWN5p25jn69ZcjEOQVaE9F9vQn7TOT5BlqJoVQMeFFRDZS5
	 6OVQ7MPXhbkGfzPD3OManJHVIgugZe/CHXXG+piE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbgDKMNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 08:13:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:45968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727608AbgDKMNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 08:13:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 240BA21556;
        Sat, 11 Apr 2020 12:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586607189;
        bh=4xxN/LclMpdMStU1HXKQchgd+iyfOMPCUl1uogaTx9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OvpZRp3KkMTGWcI2MloNS0+X+xjy294AN7Qoq/zYvCuiOEiF2IsFJ1us9OexwS2+/
         9GK5+3vv3D03r2G9BsnSoehnYOAuWj29GqkUZCUo5ba7vPiJmpJeErExHSIMZkn4x/
         nfNVNKCXQtzy+G2gDyuQciWm2lJf11YFKvZNRL0o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 4.14 11/38] misc: pci_endpoint_test: Fix to support > 10 pci-endpoint-test devices
Date:   Sat, 11 Apr 2020 14:08:55 +0200
Message-Id: <20200411115439.110258519@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200411115437.795556138@linuxfoundation.org>
References: <20200411115437.795556138@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kishon Vijay Abraham I <kishon@ti.com>

commit 6b443e5c80b67a7b8a85b33d052d655ef9064e90 upstream.

Adding more than 10 pci-endpoint-test devices results in
"kobject_add_internal failed for pci-endpoint-test.1 with -EEXIST, don't
try to register things with the same name in the same directory". This
is because commit 2c156ac71c6b ("misc: Add host side PCI driver for PCI
test function device") limited the length of the "name" to 20 characters.
Change the length of the name to 24 in order to support upto 10000
pci-endpoint-test devices.

Fixes: 2c156ac71c6b ("misc: Add host side PCI driver for PCI test function device")
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: stable@vger.kernel.org # v4.14+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/misc/pci_endpoint_test.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -466,7 +466,7 @@ static int pci_endpoint_test_probe(struc
 	int err;
 	int irq = 0;
 	int id;
-	char name[20];
+	char name[24];
 	enum pci_barno bar;
 	void __iomem *base;
 	struct device *dev = &pdev->dev;


