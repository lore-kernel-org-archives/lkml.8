Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D21C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADCA721508
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgE1HiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 03:38:19 -0400
Received: from inva020.nxp.com ([92.121.34.13]:33934 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgE1HiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 03:38:18 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1FBE51A0184;
        Thu, 28 May 2020 09:38:16 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 440271A0C56;
        Thu, 28 May 2020 09:38:10 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id D5B8A402D3;
        Thu, 28 May 2020 15:38:02 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, shc_work@mail.ru, s.trumtrar@pengutronix.de,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 0/9] Convert i.MX legacy platforms clock binding to json-schema
Date:   Thu, 28 May 2020 15:27:50 +0800
Message-Id: <1590650879-18288-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch series converts i.MX legacy platforms clock binding to
json-schema, including i.MX1, i.MX21, i.MX23, i.MX25, i.MX27, i.MX28,
i.MX31, i.MX35 and i.MX5.

On i.MX21, the CCM has no interrupt at all, so remove the interrupts
property from original binding doc.

Anson Huang (9):
  dt-bindings: clock: Convert i.MX5 clock to json-schema
  dt-bindings: clock: Convert i.MX35 clock to json-schema
  dt-bindings: clock: Convert i.MX31 clock to json-schema
  dt-bindings: clock: Convert i.MX28 clock to json-schema
  dt-bindings: clock: Convert i.MX23 clock to json-schema
  dt-bindings: clock: Convert i.MX27 clock to json-schema
  dt-bindings: clock: Convert i.MX25 clock to json-schema
  dt-bindings: clock: Convert i.MX21 clock to json-schema
  dt-bindings: clock: Convert i.MX1 clock to json-schema

 .../devicetree/bindings/clock/imx1-clock.txt       |  26 ---
 .../devicetree/bindings/clock/imx1-clock.yaml      |  49 ++++++
 .../devicetree/bindings/clock/imx21-clock.txt      |  27 ---
 .../devicetree/bindings/clock/imx21-clock.yaml     |  49 ++++++
 .../devicetree/bindings/clock/imx23-clock.txt      |  70 --------
 .../devicetree/bindings/clock/imx23-clock.yaml     |  90 ++++++++++
 .../devicetree/bindings/clock/imx25-clock.txt      | 160 ------------------
 .../devicetree/bindings/clock/imx25-clock.yaml     | 184 +++++++++++++++++++++
 .../devicetree/bindings/clock/imx27-clock.txt      |  27 ---
 .../devicetree/bindings/clock/imx27-clock.yaml     |  53 ++++++
 .../devicetree/bindings/clock/imx28-clock.txt      |  93 -----------
 .../devicetree/bindings/clock/imx28-clock.yaml     | 113 +++++++++++++
 .../devicetree/bindings/clock/imx31-clock.txt      |  90 ----------
 .../devicetree/bindings/clock/imx31-clock.yaml     | 118 +++++++++++++
 .../devicetree/bindings/clock/imx35-clock.txt      | 114 -------------
 .../devicetree/bindings/clock/imx35-clock.yaml     | 137 +++++++++++++++
 .../devicetree/bindings/clock/imx5-clock.txt       |  28 ----
 .../devicetree/bindings/clock/imx5-clock.yaml      |  63 +++++++
 18 files changed, 856 insertions(+), 635 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/imx1-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/imx1-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/imx21-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/imx21-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/imx23-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/imx23-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/imx25-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/imx25-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/imx27-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/imx27-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/imx28-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/imx28-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/imx31-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/imx31-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/imx35-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/imx35-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/imx5-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/imx5-clock.yaml

-- 
2.7.4

