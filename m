Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D93C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 13:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB972207CD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 13:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YQHjvMGy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbgGBNNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 09:13:45 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:38948 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729257AbgGBNNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 09:13:38 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 062DDRY4028105;
        Thu, 2 Jul 2020 08:13:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593695607;
        bh=E9ZXMX0J4uAqFIUOK8a+Zeoabh9L1MjhyY9iL70MnSY=;
        h=From:To:CC:Subject:Date;
        b=YQHjvMGyWMzK/ZiR8ZunsTBOuzxTInh6qDXedbzPhsjKjM2bDqLHfy/f2icCCRo5L
         p6ogUDVN8rjXaJs4Lw7G0FlQh0oA2kcmV8oFnwCHyJBmH2tDy5YbT43hUAens/0wrp
         zhuOUs06oHOi0lcCNqCPDHYC7IvKYbqaA8OsUXg0=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 062DDRY9109705
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 2 Jul 2020 08:13:27 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 2 Jul
 2020 08:13:27 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 2 Jul 2020 08:13:27 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 062DDOap130577;
        Thu, 2 Jul 2020 08:13:25 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <t-kristo@ti.com>, <nm@ti.com>
CC:     <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>
Subject: [PATCH 0/2] arm64: dts: ti: k3-j721e-common-proc-board: Enable audio support
Date:   Thu, 2 Jul 2020 16:14:22 +0300
Message-ID: <20200702131424.21241-1-peter.ujfalusi@ti.com>
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

 .../dts/ti/k3-j721e-common-proc-board.dts     | 137 +++++++++++++++++-
 1 file changed, 134 insertions(+), 3 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

