Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4CCC2D0FB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 00:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CED5A206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 00:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731740AbgEMAU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 20:20:57 -0400
Received: from inva020.nxp.com ([92.121.34.13]:56324 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731604AbgEMAU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 20:20:56 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7049C1A12A9;
        Wed, 13 May 2020 02:20:54 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 97B7D1A12A5;
        Wed, 13 May 2020 02:20:49 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 4A5B0402BE;
        Wed, 13 May 2020 08:20:43 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V5 0/5] Convert i.MX6 SoCs clock bindings to json-schma
Date:   Wed, 13 May 2020 08:11:19 +0800
Message-Id: <1589328684-1397-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Converts i.MX6Q/i.MX6SX/i.MX6SL/i.MX6SLL/i.MX6UL clock bindings to
json-schma format.

Changes since V4:
	- add descriptions for interrupts and each item of it.

Anson Huang (5):
  dt-bindings: clock: Convert i.MX6Q clock to json-schema
  dt-bindings: clock: Convert i.MX6SX clock to json-schema
  dt-bindings: clock: Convert i.MX6SL clock to json-schema
  dt-bindings: clock: Convert i.MX6SLL clock to json-schema
  dt-bindings: clock: Convert i.MX6UL clock to json-schema

 .../devicetree/bindings/clock/imx6q-clock.txt      | 41 ------------
 .../devicetree/bindings/clock/imx6q-clock.yaml     | 72 ++++++++++++++++++++++
 .../devicetree/bindings/clock/imx6sl-clock.txt     | 10 ---
 .../devicetree/bindings/clock/imx6sl-clock.yaml    | 48 +++++++++++++++
 .../devicetree/bindings/clock/imx6sll-clock.txt    | 36 -----------
 .../devicetree/bindings/clock/imx6sll-clock.yaml   | 66 ++++++++++++++++++++
 .../devicetree/bindings/clock/imx6sx-clock.txt     | 13 ----
 .../devicetree/bindings/clock/imx6sx-clock.yaml    | 70 +++++++++++++++++++++
 .../devicetree/bindings/clock/imx6ul-clock.txt     | 13 ----
 .../devicetree/bindings/clock/imx6ul-clock.yaml    | 66 ++++++++++++++++++++
 10 files changed, 322 insertions(+), 113 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/imx6q-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/imx6q-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/imx6sl-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/imx6sl-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/imx6sll-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/imx6sll-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/imx6sx-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/imx6sx-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/imx6ul-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/imx6ul-clock.yaml

-- 
2.7.4

