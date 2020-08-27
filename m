Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55DAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A77922BEA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="a7EE7PAb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgH0HVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:21:35 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:47824 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726851AbgH0HVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:21:32 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07R7HHh7017753;
        Thu, 27 Aug 2020 09:21:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=er4Ixrwfv9fQtVwv3DRVGw1gJfakQBAKllzYQn9OtiM=;
 b=a7EE7PAbll3c14ASBRIA+wF9bjVb1pnKUnvURwGJPoYW1D/UmRufs//ZJ3TW9RwpVSss
 zw+qNQfqpeau7nChrzJAmh/LNiS2VMk6cMwYWhy4pnnYpWC0aNRg7Em1zXaZuEG3qA+O
 3cGmb2aiDw0wDsw0VNJ7+fg+fEDz+2UnLK6/N7syIDZk9/6CKsUUaBVlWnL5MRSp/6qt
 Xk7sMg6eaEBdC7aFbDZYhHZq2S2NNx9d+cIZD1Okxip5JsDc6sL8pK2AMCSi7NiXby17
 xniCOBKz3zLGvmt+uTZYftAyOzfS0JEmxhvDsSiRLTLnY46WfpnI4EtNcDecWmF/Zq+6 ew== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 332t8fy7b5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 09:21:18 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1DE1E100034;
        Thu, 27 Aug 2020 09:21:18 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 07B43212648;
        Thu, 27 Aug 2020 09:21:18 +0200 (CEST)
Received: from localhost (10.75.127.47) by SFHDAG3NODE1.st.com (10.75.127.7)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 27 Aug 2020 09:21:17
 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
To:     Rob Herring <robh@kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 0/3] ARM: stm32: add DT properties for remote proc synchronisation
Date:   Thu, 27 Aug 2020 09:20:58 +0200
Message-ID: <20200827072101.26588-1-arnaud.pouliquen@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_02:2020-08-27,2020-08-27 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements the DT part associated to the commit 9276536f455b3
("remoteproc: stm32: Parse syscon that will manage M4 synchronisation")

Arnaud Pouliquen (3):
  dt-bindings: arm: stm32: Add compatible for syscon tamp node
  dt-bindings: remoteproc: stm32_rproc: update for firmware
    synchronization
  ARM: dts: stm32: update stm32mp151 for remote proc synchronization
    support

 .../bindings/arm/stm32/st,stm32-syscon.yaml   |  1 +
 .../bindings/remoteproc/st,stm32-rproc.yaml   | 19 +++++++++++++++++++
 arch/arm/boot/dts/stm32mp151.dtsi             |  7 +++++++
 3 files changed, 27 insertions(+)

-- 
2.17.1

