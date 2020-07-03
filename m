Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669A3C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3525620890
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NpMfzUwh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgGCHnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 03:43:49 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:55376 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbgGCHnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 03:43:49 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0637hkXL045469;
        Fri, 3 Jul 2020 02:43:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593762226;
        bh=h5djLFPsArRTkD/MPeDP9hPD0238gUacEpCc7VkMb0s=;
        h=From:To:CC:Subject:Date;
        b=NpMfzUwh3I8Sx9KcPc/KarS4kGCWCGrJc2+O36vhr0KDyNrsB0O4X8yCfj/oLBM+L
         BfgcPiL8VvoBEm9+uOtELpj3Pvo2o+KdrUsVkV/DOftJDH0OYvdfRH1KsI15/3CyLA
         1j8p7BT0gM9e5Zgm9xhDwKrP/UWfK21ZB5P34aKo=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0637hjhk069397
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 3 Jul 2020 02:43:45 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 3 Jul
 2020 02:43:45 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 3 Jul 2020 02:43:45 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0637hhdo098446;
        Fri, 3 Jul 2020 02:43:43 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <t-kristo@ti.com>, <nm@ti.com>
CC:     <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>
Subject: [PATCH v2 0/2] arm64: dts: ti: k3-j721e-common-proc-board: Enable audio support
Date:   Fri, 3 Jul 2020 10:44:41 +0300
Message-ID: <20200703074443.27142-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Change since v1:
- not including dt-bindings/sound/ti-mcasp.h as it is not needed

the DT binding document and the driver is now in linux-next:
https://lore.kernel.org/lkml/159364215574.10630.2058528286314798186.b4-ty@kernel.org/

Before adding the audio support, first fix up the DTS file by removing the
duplicated main_i2c1_exp4_pins_default.

Regards,
Peter
---
Peter Ujfalusi (2):
  arm64: dts: ti: k3-j721e-common-proc-board: Remove duplicated
    main_i2c1_exp4_pins_default
  arm64: dts: ti: j721e-common-proc-board: Analog audio support

 .../dts/ti/k3-j721e-common-proc-board.dts     | 136 +++++++++++++++++-
 1 file changed, 133 insertions(+), 3 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

