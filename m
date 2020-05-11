Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D495C54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FEDE20708
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pbdNklvQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729763AbgEKLcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 07:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729683AbgEKLco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 07:32:44 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38772C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 04:32:44 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id m12so12774055wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 04:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=SlmjEj3bKJAyK8rlaIxpBQ8KBu5meHckDyaJlKxfQxg=;
        b=pbdNklvQvR/gH0ZSDykgkjuPLjB9xOg8wtAgu+svcFb9/FzN6Cd3CIe/c5/NsvIYcX
         y6eVlLK9MeqFVnbk+8lNkOX2jbv0Cx5SoCmlL6tll4+SAybSsgRiWXQy1YAuL+sSz9xL
         Jjbp1hBpmkW7ktcydAzWapn0z/vfPpfCMTlGP59XqGgpFMFsgeDbyNFjL3ioUmVHQ1G7
         uniugDEZiDlmJ8nkWIa+XjgiKVr57gEJg6TFm2nTxDwP5Eu4upLY2soZukU5hJrGsEZs
         W2Vx6q75soV1abL8RUU20RaOwMPyxrutyjrIe2BKKK4XJ2mGOzm9bxlv2dBtT/Vb+86T
         +D6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=SlmjEj3bKJAyK8rlaIxpBQ8KBu5meHckDyaJlKxfQxg=;
        b=b9RRG3hG9qqtyAIf4eT0MSvqG37PBdMkbVlelSgGaPbmGCgY+paHkfvB6wrN3cvuiD
         mBVMECu4RRgNyOFrzCcvFIFS3+yHwMZxYeEERO1ASSDRn+wUSzMdLHTw2z8lLGBd7aun
         rVmqsQXeFF3J5i9qlhaiDLH7PMfb/DeLcrlHETe7MkZF2kiMh12id8LWMpbS8cqzKclP
         BCJEv8EuqKbbjYyqK21i7Hqs5Ib2Jbx9Ewl7UOWNjMfC7mYVk7lkj2ZKWu0truoO6Fjw
         MQh7vKNhw/U0ewjH2JqeG6ChVrlmxhLTTIB9cl1p84e8UqVjQX+rEat1pauXE5YSnJn3
         GnZw==
X-Gm-Message-State: AGi0PuYix0XekPFfwsbPQ0nqp427s9tNGvNJokirfLl4f2YUXwiqdZ1b
        gsEWSFKDYC5eKNxMxZaIfKDLxIiT
X-Google-Smtp-Source: APiQypJ/AiSNFtEGx80PAtDazZJWxIEF7EXEmEKz6Z0KiHNDHSWcAW7bJVTJ3pDKQmliecdBEpj0GA==
X-Received: by 2002:a1c:9ac3:: with SMTP id c186mr495971wme.150.1589196762594;
        Mon, 11 May 2020 04:32:42 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id u12sm27830595wmu.25.2020.05.11.04.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 04:32:41 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai, gregkh@linuxfoundation.org
Subject: [PATCH 04/11] habanalabs: get card type, location from F/W
Date:   Mon, 11 May 2020 14:32:25 +0300
Message-Id: <20200511113232.5771-5-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200511113232.5771-1-oded.gabbay@gmail.com>
References: <20200511113232.5771-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omer Shpigelman <oshpigelman@habana.ai>

For Gaudi the driver gets two new additional properties from the F/W:
1. The card's type - PCI or PMC
2. The card's location in the Gaudi's box (relevant only for PMC).

The card's location is also passed to the user in the HW IP info structure
as it needs this property for establishing communication between Gaudis.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/habanalabs_ioctl.c |  2 ++
 drivers/misc/habanalabs/include/armcp_if.h | 22 +++++++++++++++++++---
 include/uapi/misc/habanalabs.h             |  3 ++-
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/habanalabs/habanalabs_ioctl.c b/drivers/misc/habanalabs/habanalabs_ioctl.c
index f5993698d315..52eedd3a6c3a 100644
--- a/drivers/misc/habanalabs/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/habanalabs_ioctl.c
@@ -71,6 +71,8 @@ static int hw_ip_info(struct hl_device *hdev, struct hl_info_args *args)
 		min(CARD_NAME_MAX_LEN, HL_INFO_CARD_NAME_MAX_LEN));
 
 	hw_ip.armcp_cpld_version = le32_to_cpu(prop->armcp_info.cpld_version);
+	hw_ip.module_id = le32_to_cpu(prop->armcp_info.card_location);
+
 	hw_ip.psoc_pci_pll_nr = prop->psoc_pci_pll_nr;
 	hw_ip.psoc_pci_pll_nf = prop->psoc_pci_pll_nf;
 	hw_ip.psoc_pci_pll_od = prop->psoc_pci_pll_od;
diff --git a/drivers/misc/habanalabs/include/armcp_if.h b/drivers/misc/habanalabs/include/armcp_if.h
index 9e3bc21f20a0..a34fc39ad87e 100644
--- a/drivers/misc/habanalabs/include/armcp_if.h
+++ b/drivers/misc/habanalabs/include/armcp_if.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0
  *
- * Copyright 2016-2019 HabanaLabs, Ltd.
+ * Copyright 2016-2020 HabanaLabs, Ltd.
  * All Rights Reserved.
  *
  */
@@ -35,7 +35,8 @@ struct hl_eq_entry {
 enum pq_init_status {
 	PQ_INIT_STATUS_NA = 0,
 	PQ_INIT_STATUS_READY_FOR_CP,
-	PQ_INIT_STATUS_READY_FOR_HOST
+	PQ_INIT_STATUS_READY_FOR_HOST,
+	PQ_INIT_STATUS_READY_FOR_CP_SINGLE_MSI
 };
 
 /*
@@ -350,11 +351,24 @@ struct armcp_sensor {
 	__le32 flags;
 };
 
+/**
+ * struct armcp_card_types - ASIC card type.
+ * @armcp_card_type_pci: PCI card.
+ * @armcp_card_type_pmc: PCI Mezzanine Card.
+ */
+enum armcp_card_types {
+	armcp_card_type_pci,
+	armcp_card_type_pmc
+};
+
 /**
  * struct armcp_info - Info from ArmCP that is necessary to the host's driver
  * @sensors: available sensors description.
  * @kernel_version: ArmCP linux kernel version.
  * @reserved: reserved field.
+ * @card_type: card configuration type.
+ * @card_location: in a server, each card has different connections topology
+ *                 depending on its location (relevant for PMC card type)
  * @cpld_version: CPLD programmed F/W version.
  * @infineon_version: Infineon main DC-DC version.
  * @fuse_version: silicon production FUSE information.
@@ -366,7 +380,9 @@ struct armcp_sensor {
 struct armcp_info {
 	struct armcp_sensor sensors[ARMCP_MAX_SENSORS];
 	__u8 kernel_version[VERSION_MAX_LEN];
-	__le32 reserved[3];
+	__le32 reserved;
+	__le32 card_type;
+	__le32 card_location;
 	__le32 cpld_version;
 	__le32 infineon_version;
 	__u8 fuse_version[VERSION_MAX_LEN];
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 70dfccea7038..079613dd7aae 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -125,7 +125,8 @@ struct hl_info_hw_ip_info {
 	__u32 sram_size;
 	__u32 num_of_events;
 	__u32 device_id; /* PCI Device ID */
-	__u32 reserved[3];
+	__u32 module_id; /* For mezzanine cards in servers (From OCP spec.) */
+	__u32 reserved[2];
 	__u32 armcp_cpld_version;
 	__u32 psoc_pci_pll_nr;
 	__u32 psoc_pci_pll_nf;
-- 
2.17.1

