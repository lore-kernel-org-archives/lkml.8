Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DF7C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 07:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22B4F206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 07:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="M0yI2P+E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgHXHvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 03:51:37 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39172 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgHXHvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 03:51:36 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07O7pV0c081316;
        Mon, 24 Aug 2020 02:51:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1598255491;
        bh=qhsD6ggEQVKo7dy3l/6EnMB/h5WlxBy8gxO/MXA0G+w=;
        h=From:To:CC:Subject:Date;
        b=M0yI2P+EWEKxEDaZJmi6dx02wyFL7h6ctiIDQ+2GcmrLqLsSvr+83wusFg65ojzY+
         9IRq0ip0ngcQ4cfd5IN4ZVYLZF5mVMO0z8dBBHDowbQ9qJk3S5ZEywna/NquhAM+ww
         lkp0x4EzaWOBT8L0Jp2mAhbMaRB9SzxnzvpDXSyQ=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 07O7pVMN123426
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Aug 2020 02:51:31 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 24
 Aug 2020 02:51:31 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 24 Aug 2020 02:51:31 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07O7pTbZ075283;
        Mon, 24 Aug 2020 02:51:29 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <kishon@ti.com>, <vkoul@kernel.org>
CC:     <nsekhar@ti.com>, <vigneshr@ti.com>, <jan.kiszka@siemens.com>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH v6 0/2] phy: omap-usb2-phy: Errata and coding style fix
Date:   Mon, 24 Aug 2020 10:51:25 +0300
Message-ID: <20200824075127.14902-1-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series addresses silicon errata
i2075 - "USB2PHY: USB2PHY Charger Detect is Enabled by Default
Without VBUS Presence"

It also fixes coding style issues.

cheers,
-roger

Changelog:

v6
- move coding style fixes to separate patch

v5
- don't use dt property to enable workaround.
  Use soc_device_match() instead.

v4
- fix example to fix dt_binding_check warnings
- '#phy-cells' -> "#phy-cells"
- Add 'oneOf' to compatible logic to allow just "ti,omap-usb2" as valid

v3
- Removed quotes from compatibles
- changed property to "ti,disable-charger-det"

v2
- Address Rob's comments on YAML schema.

Roger Quadros (2):
  phy: omap-usb2-phy: disable PHY charger detect
  phy: omap-usb2-phy: fix coding style issues

 drivers/phy/ti/phy-omap-usb2.c | 83 +++++++++++++++++++++++-----------
 1 file changed, 57 insertions(+), 26 deletions(-)

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

