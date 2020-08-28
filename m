Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E4FC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 20:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A88FD20872
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 20:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wdzgkhjN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgH1UTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 16:19:55 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:37360 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgH1UTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 16:19:55 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07SKJrSL026540;
        Fri, 28 Aug 2020 15:19:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1598645993;
        bh=XTgVhSn9cvqVM8cziFcXaCIXMVCkPt/CZLpLP6PMMGY=;
        h=From:To:CC:Subject:Date;
        b=wdzgkhjNcLmy8owkWsGoBdsChiujWMh7pWnMAX2Dqe2zs+XWfs5nBekaSqGGvkSTl
         gysdBR9MmCDP6ryOLWYBFHLTPjRkcoASpBTbj6aHuN7IykitwN9RpQAA130yoxvt3I
         LTm5UPSnWoH12Zer+7S5GSIfLZoK+Og2lTIBy+CQ=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 07SKJrYI125552
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Aug 2020 15:19:53 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 28
 Aug 2020 15:19:52 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 28 Aug 2020 15:19:52 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07SKJpsS052244;
        Fri, 28 Aug 2020 15:19:51 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 0/3] phy: ti: gmii-sel: update to support multiport k3 devices
Date:   Fri, 28 Aug 2020 23:19:40 +0300
Message-ID: <20200828201943.29155-1-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon,

This series introduces support for multiport K3 CPSW devices like one, which
can be found on J721E SoC (MAIN CPSW).
The first two patches are preparation changes. The Patch 3 add support for
retrieving number of ports and base registers offset from DT.

Grygorii Strashko (3):
  phy: ti: gmii-sel: move phy init in separate function
  phy: ti: gmii-sel: use features mask during init
  phy: ti: gmii-sel: retrieve ports number and base offset from dt

 drivers/phy/ti/phy-gmii-sel.c | 159 ++++++++++++++++++++--------------
 1 file changed, 96 insertions(+), 63 deletions(-)

-- 
2.17.1

