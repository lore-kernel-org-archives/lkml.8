Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1669C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 20:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 772E720767
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 20:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="q3G44Rtz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgIBUe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 16:34:56 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53158 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgIBUe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 16:34:56 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 082KYog6040414;
        Wed, 2 Sep 2020 15:34:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599078890;
        bh=fF830SA/Eu15w6Qx/NrIv2wkFC3SQSwPL90CCFfHyjE=;
        h=From:To:CC:Subject:Date;
        b=q3G44RtzjJB1hEyee3pJz/GMC6liv/DyxyCiTuYQS1hU57AwSDsBb0aFvqqEkd7FY
         v8Fbd+9bkK+SyIh3bg17b4YZDZKwAWeVlApJsLDzdlYijsmzczKOSYQwgWc0Lf/1MT
         OMDx3FORtJJk4P+HCiqbd1cGLgzR+Ls3DkfzsmEY=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 082KYojn078081
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Sep 2020 15:34:50 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 2 Sep
 2020 15:34:49 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 2 Sep 2020 15:34:49 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 082KYn6B060950;
        Wed, 2 Sep 2020 15:34:49 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <davem@davemloft.net>, <andrew@lunn.ch>, <f.fainelli@gmail.com>,
        <hkallweit1@gmail.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH net-next v2 0/3] DP83869 Feature additions
Date:   Wed, 2 Sep 2020 15:34:41 -0500
Message-ID: <20200902203444.29167-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Adding features to the DP83869 PHY.  These features are also supported in other
TI PHYs like the DP83867 and DP83822.

Fiber Advertisement: (This is v2 fixing the return of phy_modify)
The DP83869 supports a 100Base-FX connection. When this mode is selected the
driver needs to advertise that this PHY supports fiber.

WoL:
The PHY also supports Wake on Lan feature with SecureOn password.

Downshift:
Speed optimization or AKA downshift is also supported by this PHY.

Dan Murphy (3):
  net: dp83869: Add ability to advertise Fiber connection
  net: phy: dp83869: support Wake on LAN
  net: dp83869: Add speed optimization feature

 drivers/net/phy/dp83869.c | 280 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 280 insertions(+)

-- 
2.28.0

