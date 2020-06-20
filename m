Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2300FC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 13:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E409C2070E
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 13:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="N2us6WUQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbgFTNPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 09:15:25 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:3260 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728064AbgFTNPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 09:15:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1592658923; x=1624194923;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kQsP/yVJQUNUJxvLd2o3N1wn7VHKUz9qL3WSHlmLZFk=;
  b=N2us6WUQO4APmEO+qJkkUqSnBlHXxvCMxN5vdFkh4X+9vJMPLC9LSzZ2
   2wStEmwMzzoLMgXdmaNmgucZJ2dhN3g59eqDd++T8XKq9XNRLhQ4Guo3v
   F0x5WoODducsUjKUK7KsCfF500nM1lKXeS931gW6S3wypTi71w5JCrfBS
   KesGo5KdodwWfZb5RX+01SnYzKOBNEGJ3redjry6P2NHz2GHnygUzuGMq
   7URHW08vok3IhhOuh+GNyXuzFStEw7yOVd5C7rMfDnVkv2XHmnusYn2sE
   OmU0iieGAzAn9PdseqRwNG8rBxquYGljAOdp8rkrwmNA3FCCxR7epGVFf
   g==;
IronPort-SDR: WAMWTpq09LYqWn6Ceh2XBiAHI/SoV1GaprFyyD/rLGVR/896Ds2ffs6SDwJn3OlpWQwijKNCXh
 M49fWZhgK4HyY8pBgnttFdrrVBfQ0wr/wBojscDrLYW5fZ9JoVIgDtNsRFaMFeM4++JB8GAtsb
 V0Zum7T7H2zozwTWMv/ziRLkIklxQ985h39mN0iAzXyr7Hn8TLPojfSMYDaeiGaivBQwG0zyjZ
 aknxA2XDxhspYyjVG5T4Vul7xqZYqVW1k1gz9zFEeR7acLaH9la7T9Ifxc9+4EokQpBgvHvwKn
 y8E=
X-IronPort-AV: E=Sophos;i="5.75,258,1589266800"; 
   d="scan'208";a="80211034"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jun 2020 06:15:10 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sat, 20 Jun 2020 06:15:09 -0700
Received: from soft-dev3.localdomain (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Sat, 20 Jun 2020 06:15:08 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <nikolay@cumulusnetworks.com>, <davem@davemloft.net>,
        <UNGLinuxDriver@microchip.com>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [Resend PATCH net] bridge: uapi: mrp: Fix MRP_PORT_ROLE
Date:   Sat, 20 Jun 2020 15:14:03 +0200
Message-ID: <20200620131403.2680293-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the MRP_PORT_ROLE_NONE has the value 0x2 but this is in conflict
with the IEC 62439-2 standard. The standard defines the following port
roles: primary (0x0), secondary(0x1), interconnect(0x2).
Therefore remove the port role none.

Fixes: 4714d13791f831 ("bridge: uapi: mrp: Add mrp attributes.")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 include/uapi/linux/mrp_bridge.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/uapi/linux/mrp_bridge.h b/include/uapi/linux/mrp_bridge.h
index 84f15f48a7cb1..bee3665402129 100644
--- a/include/uapi/linux/mrp_bridge.h
+++ b/include/uapi/linux/mrp_bridge.h
@@ -36,7 +36,6 @@ enum br_mrp_port_state_type {
 enum br_mrp_port_role_type {
 	BR_MRP_PORT_ROLE_PRIMARY,
 	BR_MRP_PORT_ROLE_SECONDARY,
-	BR_MRP_PORT_ROLE_NONE,
 };
 
 enum br_mrp_tlv_header_type {
-- 
2.26.2

