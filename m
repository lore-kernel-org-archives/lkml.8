Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CA2C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 14:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54F25207C4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 14:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgERO51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 10:57:27 -0400
Received: from inva020.nxp.com ([92.121.34.13]:56228 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726940AbgERO51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 10:57:27 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 718FC1A0B0D;
        Mon, 18 May 2020 16:57:25 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3715C1A0B0C;
        Mon, 18 May 2020 16:57:20 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 593B9402A8;
        Mon, 18 May 2020 22:57:13 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, ping.bai@nxp.com, aisheng.dong@nxp.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 0/3] Covert i.MX GPT/TPM/SYSCTR timer binding to json-schema
Date:   Mon, 18 May 2020 22:47:37 +0800
Message-Id: <1589813260-20036-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series converts i.MX GPT, TPM and system counter timer binding
to json-schema, test build passed.

Anson Huang (3):
  dt-bindings: timer: Convert i.MX GPT to json-schema
  dt-bindings: timer: Convert i.MX TPM to json-schema
  dt-bindings: timer: Convert i.MX SYSCTR to json-schema

 .../devicetree/bindings/timer/fsl,imxgpt.txt       |  45 ---------
 .../devicetree/bindings/timer/fsl,imxgpt.yaml      | 109 +++++++++++++++++++++
 .../devicetree/bindings/timer/nxp,sysctr-timer.txt |  25 -----
 .../bindings/timer/nxp,sysctr-timer.yaml           |  54 ++++++++++
 .../devicetree/bindings/timer/nxp,tpm-timer.txt    |  28 ------
 .../devicetree/bindings/timer/nxp,tpm-timer.yaml   |  63 ++++++++++++
 6 files changed, 226 insertions(+), 98 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/fsl,imxgpt.txt
 create mode 100644 Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
 delete mode 100644 Documentation/devicetree/bindings/timer/nxp,sysctr-timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml
 delete mode 100644 Documentation/devicetree/bindings/timer/nxp,tpm-timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/nxp,tpm-timer.yaml

-- 
2.7.4

