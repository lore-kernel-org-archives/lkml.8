Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC81C433EA
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 21:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 270792077D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 21:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594417095;
	bh=isY0pS9oGm7dGtxlL9m4aLsA5EJIEBlakrUHURN2ht0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hpB93Uk04grpEv3yNHb4zyafBAVZoK0b50PA+fqhXVLRwOC2KpXhBwWKUN2ToO8pR
	 kZnbfjJvOzSYUQzyytlNe+c1d0+LABZeprIrkDrGMGvHu80BjlG8j7sLQCd3iJ90ei
	 u8M//+YHn7eJQ8vuQIx1rs0UdK8s5EZeQdpH+K64=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgGJViO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 17:38:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:44740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbgGJViM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 17:38:12 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3865920772;
        Fri, 10 Jul 2020 21:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594417092;
        bh=isY0pS9oGm7dGtxlL9m4aLsA5EJIEBlakrUHURN2ht0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qzBtSTV5wS1vLwn1ewmhaZpMbH2Sj9LaladOMvk6RCzyJ48ljQ/ZeHxpW8BjuyNlX
         dkqx/FLR54+gqNiz6bKVN99d4X6OMYOGMSB2zJ0b/EVAueY7NAJVgHW8Z6DKNAkz95
         8JNtFVBZgrz0tz2F4jlNRcJczX0yTCJwt2/vovp8=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Sean V Kelley <sean.v.kelley@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/2] PCI/ACPI: Unexport acpi_pci_find_root()
Date:   Fri, 10 Jul 2020 16:37:53 -0500
Message-Id: <20200710213753.83420-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200710213753.83420-1-helgaas@kernel.org>
References: <20200710213753.83420-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

acpi_pci_find_root() is called only from pci_root.c and
drivers/pci/hotplug/acpi_pcihp.c, neither of which can be modules.
Unexport it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/acpi/pci_root.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index b6da9745efcd..933890f97720 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -246,7 +246,6 @@ struct acpi_pci_root *acpi_pci_find_root(acpi_handle handle)
 
 	return root;
 }
-EXPORT_SYMBOL_GPL(acpi_pci_find_root);
 
 struct acpi_handle_node {
 	struct list_head node;
-- 
2.25.1

