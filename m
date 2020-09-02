Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA2FC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3081720767
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OBefMpTE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgIBObh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 10:31:37 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43740 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbgIBO3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 10:29:45 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 082DZls6028416;
        Wed, 2 Sep 2020 08:35:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599053747;
        bh=K5qBBK8U6hjB2NNhfCKUHbnA7a4cstCXECTtIpV0nF4=;
        h=From:To:CC:Subject:Date;
        b=OBefMpTEu329mouZhYm8mzO6vDzu1mB4w3S6FXPD0tPzzGyIDcpxl69UsqpnBAAiD
         SzvFcZr1eebTaOHNyctULecgl2IssIyU534S4rF4/B+/sQsmQwDPW5XYVVyUZiN9v4
         5ZnoqGI+zwKODqT6KZeefUoZpu/ON7+NnE2vtqP0=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 082DZlNm056935
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Sep 2020 08:35:47 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 2 Sep
 2020 08:35:47 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 2 Sep 2020 08:35:47 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 082DZiG9065816;
        Wed, 2 Sep 2020 08:35:45 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <balbi@kernel.org>
CC:     <pawell@cadence.com>, <kurahul@cadence.com>, <nsekhar@ti.com>,
        <vigneshr@ti.com>, <robh+dt@kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 0/3] usb: cdns,usb3: Convert DT binding to YAML
Date:   Wed, 2 Sep 2020 16:35:40 +0300
Message-ID: <20200902133543.17222-1-rogerq@ti.com>
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

Changelog:
v2:
- updated commit log to better describe why DT property is required
for the quirk.

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

