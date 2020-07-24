Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C66C433E8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 12:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 169DF2074B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 12:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="bNRdx3Ms"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgGXMiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 08:38:15 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:14808 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726488AbgGXMiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 08:38:10 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06OCSu3Q021272;
        Fri, 24 Jul 2020 14:37:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=12BNeW8kdpYe6Tv/kvZ96T8siqgJHyfAxDDSL69rsG8=;
 b=bNRdx3Msw/kPotaC5l56xfodMakG+hMLgZwRpL5jWg3jCN3Lq9/ZNsLmLX4K+NCitUM4
 yGz+e2GMtET0w+QjQLvv/DUpmhNn13uNRGkkJ7dUV9UNugHK3gzsX2XNj1fiDoiUUPCq
 a/5STmBdTAzVuDvS9AkqteUPPvvIzSfDqrqIb4UCTcgNCXZDxda4I78CFocigmoHHS9p
 +mcgVSLKVsMC+b0hF/FVqPCqpp1ulnke3wdIhXCACQCecmPI3KkkH6C4dFOOBhbTL2ck
 HXVvC6qkVw62xcRp5c8ci54b/hDQjBlraBhCskIFzVSKaAGCOwRj/DK5D36sdTXurpuz iQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 32cux0tsaa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jul 2020 14:37:53 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 28BE710002A;
        Fri, 24 Jul 2020 14:37:53 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 14A692AF334;
        Fri, 24 Jul 2020 14:37:53 +0200 (CEST)
Received: from localhost (10.75.127.47) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 24 Jul 2020 14:37:52
 +0200
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/4] Fix DWC2 USB role switch support
Date:   Fri, 24 Jul 2020 14:37:44 +0200
Message-ID: <20200724123748.25369-1-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-24_04:2020-07-24,2020-07-24 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds missing documentation for usb-role-switch support in DWC2
bindings. It also fixes build issue when config is DWC2_HOST only, 
sleeping while atomic issue and missing usb-role-switch unregistration in probe
error path.

Amelie Delaunay (4):
  dt-bindings: usb: dwc2: add optional usb-role-switch property
  usb: dwc2: fix build issue when config is USB_DWC2_HOST only
  usb: dwc2: drd: fix sleeping while spinlock atomic context
  usb: dwc2: fix error path with missing dwc2_drd_exit

 .../devicetree/bindings/usb/dwc2.yaml         |  4 +++
 drivers/usb/dwc2/core.h                       |  1 +
 drivers/usb/dwc2/drd.c                        | 30 +++++++------------
 drivers/usb/dwc2/platform.c                   |  2 ++
 4 files changed, 17 insertions(+), 20 deletions(-)

-- 
2.17.1

