Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2A3C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 01:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B7E5206EC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 01:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUS6W2x8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbgCRBpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 21:45:52 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38301 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbgCRBpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 21:45:51 -0400
Received: by mail-pf1-f193.google.com with SMTP id z5so12990377pfn.5;
        Tue, 17 Mar 2020 18:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id;
        bh=vl7JF+OisrWnn7NeOtdHVLmflZshg8AAgtUNfRFLflc=;
        b=FUS6W2x88n00x5pQaTOUkBnchsk57tCIrdDh1sFLYJvRuj9+qP8hL8K1XtcxhJsHwo
         Wr29miD6cbpw84zTFBoqdOKAP8EmPPi8Qq55/Vxixxq89oC4PxG9wBOgUdREOb9xE8h7
         K+LTcsBLMRas28dCdBuNeKLXoG+wg+wHoHwB7om35zrBB1iVlpPUhpEUl4bhEeWoKqif
         z+GlPTe7UTHE0XZntOL61mRmNLiQrEiiIfsKvs7m4Hj3xtVMQR78lOV1qrWm+asqFIC1
         nzQluPQsKxBrw5BO4Z8or75bptDI5DKNK6PBiQBKJo9sls6/G3j+cvOU+pv0K6L716tP
         VG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id;
        bh=vl7JF+OisrWnn7NeOtdHVLmflZshg8AAgtUNfRFLflc=;
        b=XgN4rRtuvAFJT4mV4ISg/BZRbNRtMzS4P0rH1tQmNkS+r8b3OETOlaXIPq6qxrEnxd
         5BFCVQk3dxIYGaZQI6RZJLoMj4VE2fN0gvhU9V6sVixxitiM6JZvIoqx/zH4+S6W8Xp6
         nAFd5OAOxL9IL+E5Fl+8kpBboDjdh5ZG4paGiQcysipYwcibR0mZQ8WDwd3Pw5KrMIMS
         pXCxvAEKCJZ1Z27Jo+956QUVmz2WcjmZ/EUk/UHdPGJIZLbu3vgcPZNAwNtdjmWZl1mF
         vOob7irxCg38frPNKbnRuTq2ORfOj8g18wA+Y54WNh8hYxI5ZXX4iU2Q6YpkvFNbc7ra
         1D7g==
X-Gm-Message-State: ANhLgQ1++kMocrbWIL6t5wjLEZbsJ+bHDSzxMt1k+DaGbdvld32naM1e
        b4jcm/ZtbAMabObZ7uQTKQA=
X-Google-Smtp-Source: ADFU+vuS+bdJUG5tLY7i8U6U3kyyVSoXxc9bsPwpUqCLo38zkEFB5U5elGkdJs2VfdrkgveNtP5Ygg==
X-Received: by 2002:a63:48e:: with SMTP id 136mr2073825pge.169.1584495950400;
        Tue, 17 Mar 2020 18:45:50 -0700 (PDT)
Received: from localhost (220-135-95-34.HINET-IP.hinet.net. [220.135.95.34])
        by smtp.gmail.com with ESMTPSA id s125sm3800084pgc.53.2020.03.17.18.45.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Mar 2020 18:45:49 -0700 (PDT)
From:   AceLan Kao <acelan.kao@canonical.com>
To:     Realtek linux nic maintainers <nic_swsd@realtek.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] r8169: only disable ASPM L1.1 support, instead of disabling them all
Date:   Wed, 18 Mar 2020 09:45:48 +0800
Message-Id: <20200318014548.14547-1-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The issues which have been seen by enabling ASPM support are from the
BIOS that enables the ASPM L1.1 support on the device. It leads to some
strange behaviors when the device enter L1.1 state.
So, we don't have to disable ASPM support entriely, just disable L1.1
state, that fixes the issues and also has good power management.

Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index a2168a14794c..b52680e7323b 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5473,11 +5473,10 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc)
 		return rc;
 
-	/* Disable ASPM completely as that cause random device stop working
-	 * problems as well as full system hangs for some PCIe devices users.
+	/* r8169 suppots ASPM L0 and L1 well, and doesn't support L1.1,
+	 * so disable ASPM L1.1 only.
 	 */
-	rc = pci_disable_link_state(pdev, PCIE_LINK_STATE_L0S |
-					  PCIE_LINK_STATE_L1);
+	rc = pci_disable_link_state(pdev, PCIE_LINK_STATE_L1_1);
 	tp->aspm_manageable = !rc;
 
 	/* enable device (incl. PCI PM wakeup and hotplug setup) */
-- 
2.17.1

