Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B8AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 12:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F1E02071E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 12:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mQBTP56L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbgHYMED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 08:04:03 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:48284 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728511AbgHYMC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 08:02:59 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07PC13WA016565;
        Tue, 25 Aug 2020 07:01:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1598356863;
        bh=YMje2OmYthGF4LvGUre6qsVw0B9DlzxvxWv+/hvmnpU=;
        h=From:To:CC:Subject:Date;
        b=mQBTP56L/xPJMHM1P6TyiAB2Kw3XbEf3dEwQRWhmecmVrRBkQJnwMrsPSKRhXDYVx
         WH4QdO61+GtkqfB71tbRwbRQ+mEqUCjBU11L2a7C2vG49n2bkVniHIh8+R+JkofLBQ
         xXjd1qmw+u5vi+x8NGfcVl6oO2FkMIZ8Bw53X3+M=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 07PC13Ud009097
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Aug 2020 07:01:03 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 25
 Aug 2020 07:01:03 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 25 Aug 2020 07:01:03 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07PC10LA024089;
        Tue, 25 Aug 2020 07:01:00 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <balbi@kernel.org>
CC:     <pawell@cadence.com>, <kurahul@cadence.com>, <nsekhar@ti.com>,
        <vigneshr@ti.com>, <robh+dt@kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH 0/3] usb: cdns,usb3: Convert DT binding to YALM
Date:   Tue, 25 Aug 2020 15:00:56 +0300
Message-ID: <20200825120059.12436-1-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series converts DT binding to YAML schema.
Then adds a new property to enable workaround for USB2.0 PHY
Rx compliance issues.

cheers,
-roger

Pawel Laszczak (1):
  usb: cdns3: Enable workaround for USB2.0 PHY Rx compliance test PHY
    lockup

Roger Quadros (2):
  dt-bindings: usb: Convert cdns-usb3.txt to YAML schema
  dt-bindings: usb: cdns,usb3: Add cdns,phyrst-a-enable property

 .../devicetree/bindings/usb/cdns,usb3.yaml    | 93 +++++++++++++++++++
 .../devicetree/bindings/usb/cdns-usb3.txt     | 45 ---------
 drivers/usb/cdns3/core.c                      |  2 +
 drivers/usb/cdns3/core.h                      |  1 +
 drivers/usb/cdns3/drd.c                       | 12 +++
 drivers/usb/cdns3/drd.h                       |  5 +-
 6 files changed, 112 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/cdns,usb3.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/cdns-usb3.txt

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

