Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7360C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 16:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 971F520663
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 16:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="NQIobxBr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730931AbgFOQQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 12:16:30 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:1598 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730909AbgFOQQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 12:16:28 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05FGErYJ010869;
        Mon, 15 Jun 2020 18:15:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=bZLdngu1T79B9CrirZEYQHkjEj22wNJY7PUv6kBJrmQ=;
 b=NQIobxBr+rX5VTLmyc7vPLHNgD3LW8Pb5hHYFgsZU9bIOm3wJ7mtTY7nG0ADsWidmAZz
 cyOykLhl35Y6R+kzqh3uioxLQTDj3bGvUOMZ+6jh06Wt+RUzCbGUbqCJrhjzveVq8n6H
 ln5d6knEOJXKn1CyMttgX0LcEL9XA1KvlDJHAWQR7KYk6NJGkNlMEZM7tG3OHz1cGTop
 bfiYMS+XddAzUl3+NpFXQ7mPsxSePA/ESi3vKt3xhl/yebjNJZlhVX+OKycYVnnzScjY
 jFJ20LrnH9eHZINBGRZStfoWxBpq+0ZN7CaZm1c4eRUXZ7Qh+JjGxyPKSLwHUmrQrqos 7A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 31mmjvthhr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Jun 2020 18:15:48 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 241B410002A;
        Mon, 15 Jun 2020 18:15:47 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 02B062C5AD8;
        Mon, 15 Jun 2020 18:15:47 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 15 Jun 2020 18:15:46
 +0200
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Russell King <linux@armlinux.org.uk>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH 0/6] Add STUSB160x Type-C port controller support
Date:   Mon, 15 Jun 2020 18:15:06 +0200
Message-ID: <20200615161512.19150-1-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-15_06:2020-06-15,2020-06-15 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for STMicroelectronics STUSB160x Type-C port
controllers [1].
STUSB160x driver requires to get power operation mode via device tree,
that's why this series also adds the optional DT property power-opmode
for usb-c-connector to select the power operation mode capability and
a function to convert the power operation mode string into power
operation mode value.
This driver has been tested on stm32mp157c-dk2 [2], which has a Type-C
connector managed by STUSB1600, and connected to USB OTG controller. 

[1] https://www.st.com/en/interfaces-and-transceivers/usb-type-c-and-power-delivery-controllers.html
[2] https://www.st.com/en/evaluation-tools/stm32mp157c-dk2.html

Amelie Delaunay (6):
  dt-bindings: connector: add power-opmode optional property to
    usb-connector
  usb: typec: add typec_find_pwr_opmode
  dt-bindings: usb: Add DT bindings for STUSB160x Type-C controller
  usb: typec: add support for STUSB160x Type-C controller family
  ARM: dts: stm32: add STUSB1600 Type-C using I2C4 on stm32mp15xx-dkx
  ARM: multi_v7_defconfig: enable STUSB160X Type-C port controller
    support

 .../bindings/connector/usb-connector.yaml     |  11 +
 .../devicetree/bindings/usb/st,stusb160x.yaml |  85 ++
 arch/arm/boot/dts/stm32mp15-pinctrl.dtsi      |   7 +
 arch/arm/boot/dts/stm32mp15xx-dkx.dtsi        |  38 +
 arch/arm/configs/multi_v7_defconfig           |   2 +
 drivers/usb/typec/Kconfig                     |  12 +
 drivers/usb/typec/Makefile                    |   1 +
 drivers/usb/typec/class.c                     |  15 +
 drivers/usb/typec/stusb160x.c                 | 875 ++++++++++++++++++
 include/linux/usb/typec.h                     |   1 +
 10 files changed, 1047 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/st,stusb160x.yaml
 create mode 100644 drivers/usb/typec/stusb160x.c

-- 
2.17.1

