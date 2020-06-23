Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48429C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2104A206EB
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592944020;
	bh=DV9HBnnggnuXJR8WVIySzNUQiSadqv442HEQBtx5BcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tAhObzatly4Hn7pB1wLlI/EO2l0kg18NXIoIJ9SVEuXFY9CN3tuCNBlbeDcyf6WdG
	 gmFQFbMI2KbnEiZMMPMh9TD4HS5Aj3CJyY5QXvzS43mFVmHqeL6rsgERfV/nhvfOhV
	 pT1O0t0MMzcLF5rJISwNvrZlIerx9gPDRY6Rpkn4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389521AbgFWU06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:26:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389512AbgFWU0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:26:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4683206C3;
        Tue, 23 Jun 2020 20:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944012;
        bh=DV9HBnnggnuXJR8WVIySzNUQiSadqv442HEQBtx5BcU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qBoZtrgElz0yUOWQO8liXLMt+p8eV6Xjt5Ukee6Ml15kUi4MdsDKWKXPcMXyaq1Nm
         3SFq1wuMmBXc3IbtFsmSxgNSUfoUquXjXKylQqyytfqvsQ4kbWFssH7EgB2VxYIyi9
         auOUVwlf/wZnArjf0luc3CfKZYjd4LV9qDAcVfcU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 139/314] PCI: Fix pci_register_host_bridge() device_register() error handling
Date:   Tue, 23 Jun 2020 21:55:34 +0200
Message-Id: <20200623195345.491600428@linuxfoundation.org>
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
index 83d909abc61d1..8fa13486f2f15 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -867,9 +867,10 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
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



