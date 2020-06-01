Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EB6C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 16:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F5B32073B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 16:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=tmsp.io header.i=dorian.stoll@tmsp.io header.b="DHQLFHtu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgFAQSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 12:18:35 -0400
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21454 "EHLO
        sender4-of-o54.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgFAQSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 12:18:35 -0400
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Jun 2020 12:18:34 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1591027399; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=RGaLXN/0pJQ5XCpiTzGmASIWJhTFJXXIXV/O1eLEdA2rLNHxMVeLht0It/PGpEvZGmkFjvj1q7yIHh1d0GaHo0dz88zDGHEaOKvfyaqiaAKbX0oKqC+7NyyNLbnsgrFk8NcMzuT1Rs8NWCayydZTBaXg89XtQH6KcQlKozIM3RI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1591027399; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=X+xeA4Yaz4db9RbtSMm/UfrZwbfOwJ48gdi78Ynycyw=; 
        b=D7I0zvMgfrUt12RwL0dFJQxBNF98M5NHbbHdBZgaTWabcJh2IxPJDJI9XRHZnY4Ui9zOmz2WE4hC5wjaT9sBSXpEED7h+6PJHhHCX1Nosu0g4IPJYsDWm6sDQGqCSHK5Zvg2ixoIHxf4sZS1KmSMwNvNjk46YCEbjctVXmCVKZc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=tmsp.io;
        spf=pass  smtp.mailfrom=dorian.stoll@tmsp.io;
        dmarc=pass header.from=<dorian.stoll@tmsp.io> header.from=<dorian.stoll@tmsp.io>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1591027399;
        s=zoho; d=tmsp.io; i=dorian.stoll@tmsp.io;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=X+xeA4Yaz4db9RbtSMm/UfrZwbfOwJ48gdi78Ynycyw=;
        b=DHQLFHturLtWn+Wj70zqYtCKE3xCLl1PTjC2A7oq3uGC48uBSfSoVmlwrb5NXWOu
        MrIKyAsm8fE9xLsAbyjnjHESy6Lo/cy9rEGeDz6lxcFT6gWyaYj7KhOaUhDypbADkFn
        5WIXuCmGMYOyoqDIRhxrpBgawsdLEq4/OYDKk6xE=
Received: from desktop.fritz.box (79.140.114.1 [79.140.114.1]) by mx.zohomail.com
        with SMTPS id 1591027397737977.2859413189593; Mon, 1 Jun 2020 09:03:17 -0700 (PDT)
From:   Dorian Stoll <dorian.stoll@tmsp.io>
To:     Tomas Winkler <tomas.winkler@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Dorian Stoll <dorian.stoll@tmsp.io>
Message-ID: <20200601155954.764558-1-dorian.stoll@tmsp.io>
Subject: [PATCH] mei: me: Add itouch device IDs for SPT / ICP
Date:   Mon,  1 Jun 2020 17:59:54 +0200
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These device IDs can be found on Microsoft Surface devices.

Signed-off-by: Dorian Stoll <dorian.stoll@tmsp.io>
---
 drivers/misc/mei/hw-me-regs.h | 2 ++
 drivers/misc/mei/pci-me.c     | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/misc/mei/hw-me-regs.h b/drivers/misc/mei/hw-me-regs.h
index 9392934e3a06..90e7d3020fa5 100644
--- a/drivers/misc/mei/hw-me-regs.h
+++ b/drivers/misc/mei/hw-me-regs.h
@@ -59,6 +59,7 @@
=20
 #define MEI_DEV_ID_SPT        0x9D3A  /* Sunrise Point */
 #define MEI_DEV_ID_SPT_2      0x9D3B  /* Sunrise Point 2 */
+#define MEI_DEV_ID_SPT_4      0x9D3E  /* Sunrise Point 4 (iTouch) */
 #define MEI_DEV_ID_SPT_H      0xA13A  /* Sunrise Point H */
 #define MEI_DEV_ID_SPT_H_2    0xA13B  /* Sunrise Point H 2 */
=20
@@ -90,6 +91,7 @@
 #define MEI_DEV_ID_CDF        0x18D3  /* Cedar Fork */
=20
 #define MEI_DEV_ID_ICP_LP     0x34E0  /* Ice Lake Point LP */
+#define MEI_DEV_ID_ICP_LP_4   0x34E4  /* Ice Lake Point LP 4 (iTouch) */
=20
 #define MEI_DEV_ID_JSP_N      0x4DE0  /* Jasper Lake Point N */
=20
diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index a1ed375fed37..5e621e90d8d4 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -68,6 +68,7 @@ static const struct pci_device_id mei_me_pci_tbl[] =3D {
=20
 =09{MEI_PCI_DEVICE(MEI_DEV_ID_SPT, MEI_ME_PCH8_CFG)},
 =09{MEI_PCI_DEVICE(MEI_DEV_ID_SPT_2, MEI_ME_PCH8_CFG)},
+=09{MEI_PCI_DEVICE(MEI_DEV_ID_SPT_4, MEI_ME_PCH8_CFG)},
 =09{MEI_PCI_DEVICE(MEI_DEV_ID_SPT_H, MEI_ME_PCH8_SPS_CFG)},
 =09{MEI_PCI_DEVICE(MEI_DEV_ID_SPT_H_2, MEI_ME_PCH8_SPS_CFG)},
 =09{MEI_PCI_DEVICE(MEI_DEV_ID_LBG, MEI_ME_PCH12_SPS_CFG)},
@@ -94,6 +95,7 @@ static const struct pci_device_id mei_me_pci_tbl[] =3D {
 =09{MEI_PCI_DEVICE(MEI_DEV_ID_CMP_H_3, MEI_ME_PCH8_CFG)},
=20
 =09{MEI_PCI_DEVICE(MEI_DEV_ID_ICP_LP, MEI_ME_PCH12_CFG)},
+=09{MEI_PCI_DEVICE(MEI_DEV_ID_ICP_LP_4, MEI_ME_PCH12_CFG)},
=20
 =09{MEI_PCI_DEVICE(MEI_DEV_ID_TGP_LP, MEI_ME_PCH15_CFG)},
=20
--=20
2.26.2


