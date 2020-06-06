Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE11C433E1
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 10:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7E162074B
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 10:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbgFFK7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 06:59:41 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:42528 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728768AbgFFK7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 06:59:39 -0400
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 06 Jun 2020 03:59:38 -0700
Received: from sivaprak-linux.qualcomm.com ([10.201.3.202])
  by ironmsg02-sd.qualcomm.com with ESMTP; 06 Jun 2020 03:59:34 -0700
Received: by sivaprak-linux.qualcomm.com (Postfix, from userid 459349)
        id C20172147A; Sat,  6 Jun 2020 16:29:32 +0530 (IST)
From:   Sivaprakash Murugesan <sivaprak@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        jassisinghbrar@gmail.com, sivaprak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/3] Add ipq6018 apcs mailbox driver
Date:   Sat,  6 Jun 2020 16:29:28 +0530
Message-Id: <1591441171-20341-1-git-send-email-sivaprak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ipq6018 devices has apcs block for ipc interrupts, this block also
provides a clock controller which provides cpu clocks.

This series adds support for the apcs block found in ipq6018 devices.

This series was originally part of ipq6018 apss clock controller series
https://lkml.org/lkml/2020/5/27/637

[V2]
 * Addressed Bjorn's review comment, created a new structure for driver
   data.
 * Re-arranged compatible string based on sort order.
 * dropped dts patch from this series, will send it separately

Sivaprakash Murugesan (3):
  dt-bindings: mailbox: Add YAML schemas for QCOM APCS global block
  dt-bindings: mailbox: Add dt-bindings for ipq6018 apcs global block
  mailbox: qcom: Add ipq6018 apcs compatible

 .../bindings/mailbox/qcom,apcs-kpss-global.txt     | 88 -------------------
 .../bindings/mailbox/qcom,apcs-kpss-global.yaml    | 99 ++++++++++++++++++++++
 drivers/mailbox/qcom-apcs-ipc-mailbox.c            | 61 +++++++++----
 3 files changed, 142 insertions(+), 106 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt
 create mode 100644 Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml

-- 
2.7.4

