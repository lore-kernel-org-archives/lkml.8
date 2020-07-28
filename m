Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDE5C433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 07:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12D6321D95
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 07:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="xuFF9Azl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgG1Hqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 03:46:43 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:29444 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727940AbgG1Hqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 03:46:39 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06S7cKUA018522;
        Tue, 28 Jul 2020 09:46:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=jkhu5jd9tFTTiV5t1ZCsv9vY1OMWziyo/KQfmjyC57o=;
 b=xuFF9Azl4+h7KX5i6pabdTnDb7/FlwvffO8eMZxlurG3ZTMGuFzIxTJKkJs9get/03ji
 RcUQ1RyN6QshGkdzY9niB2KrxW+Ac+HaJ85/o6Bw6HmsKQhVHhDXBM0rMEf8EIlwkJ6n
 9+I4AXSdQb3rsUqowPO6+5ABvrzFjAI3PzGP1xQS7vLWcMdOr4zWEU9A9nFLfVGfi+NY
 Jl8HA438CZJoUIhWV2SgatsGwGV24cQmdPqBrsYP6QREhLSPTXtBXB5u10+yD59Ii8EX
 w741SetDBAUzMQ4ep2hzDnsszq8ijHO524oQKCVIKXe6RB23gFdhT30JTEu/POYZ6fq2 bw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 32ga71w1cn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jul 2020 09:46:22 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 503A6100038;
        Tue, 28 Jul 2020 09:46:19 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3F90021FE93;
        Tue, 28 Jul 2020 09:46:19 +0200 (CEST)
Received: from localhost (10.75.127.44) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 28 Jul 2020 09:46:18
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
Subject: [PATCH v5 3/3] usb: dwc2: don't use ID/Vbus detection if usb-role-switch on STM32MP15 SoCs
Date:   Tue, 28 Jul 2020 09:46:02 +0200
Message-ID: <20200728074602.14218-4-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200728074602.14218-1-amelie.delaunay@st.com>
References: <20200728074602.14218-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-28_01:2020-07-27,2020-07-28 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If usb-role-switch is present in the device tree, it means that ID and Vbus
signals are not connected to the OTG controller but to an external
component (GPIOs, Type-C controller). In this configuration, usb role
switch is used to force valid sessions on STM32MP15 SoCs.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
Changes in v5:
- Use device_property_read_bool instead of of_read_property_bool
---
 drivers/usb/dwc2/params.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
index a3611cdd1dea..50df72f32b4c 100644
--- a/drivers/usb/dwc2/params.c
+++ b/drivers/usb/dwc2/params.c
@@ -185,7 +185,7 @@ static void dwc2_set_stm32mp15_hsotg_params(struct dwc2_hsotg *hsotg)
 	struct dwc2_core_params *p = &hsotg->params;
 
 	p->otg_cap = DWC2_CAP_PARAM_NO_HNP_SRP_CAPABLE;
-	p->activate_stm_id_vb_detection = true;
+	p->activate_stm_id_vb_detection = !device_property_read_bool(hsotg->dev, "usb-role-switch");
 	p->host_rx_fifo_size = 440;
 	p->host_nperio_tx_fifo_size = 256;
 	p->host_perio_tx_fifo_size = 256;
-- 
2.17.1

