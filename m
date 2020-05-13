Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B699DC2D0FC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DEFB206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="A2U7blwa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733100AbgEMNHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 09:07:16 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:57168 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgEMNHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:07:15 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04DD7Ej9020488;
        Wed, 13 May 2020 08:07:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589375234;
        bh=LDyxAA4SwKan1ZwYDVOZs8hTdszW97RTY6Flp1z7EHg=;
        h=From:To:CC:Subject:Date;
        b=A2U7blwaBgciolqSRpNrprT0BUzdnlukr4eEvGQmjSQ5LB7JQo1DOorGOmmgOswXM
         Rw+oBSRxZMP8VSph9bbexjmDPXghIrE+d5b8rCwFWhkqVdzTuLyq9VceCemp2xnWgP
         idGaODa7yl1m76p3GagyZ0ib3oDXcEU6ovg/NM2I=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04DD7EMF067967;
        Wed, 13 May 2020 08:07:14 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 13
 May 2020 08:07:14 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 13 May 2020 08:07:14 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04DD7B2Q074071;
        Wed, 13 May 2020 08:07:12 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <balbi@kernel.org>
CC:     <robh+dt@kernel.org>, <vigneshr@ti.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH 0/3] usb: dwc3: keystone: Convert binding to YAML
Date:   Wed, 13 May 2020 16:07:06 +0300
Message-ID: <20200513130709.10239-1-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe,

This series converts keystone-usb.txt to YAML and prepares
for Super-Speed support for AM654 SoC.

cheers,
-roger

Roger Quadros (3):
  dt-bindings: usb: convert keystone-usb.txt to YAML
  dt-bindings: usb: ti,keystone-dwc3.yaml: Add USB3.0 PHY property
  usb: dwc3: keystone: Turn on USB3 PHY before controller

 .../devicetree/bindings/usb/keystone-usb.txt  | 56 ------------
 .../bindings/usb/ti,keystone-dwc3.yaml        | 88 +++++++++++++++++++
 drivers/usb/dwc3/dwc3-keystone.c              | 47 +++++++++-
 3 files changed, 134 insertions(+), 57 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/usb/keystone-usb.txt
 create mode 100644 Documentation/devicetree/bindings/usb/ti,keystone-dwc3.yaml

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

