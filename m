Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0A4C35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 22:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1204206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 22:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="CGPUfV41"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbgBKWYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 17:24:51 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:10547 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727041AbgBKWYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 17:24:50 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581459890; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=bb81B+KmcUpC/VrodZKsA0Bckmi8L+Zj/k27kIOQiOs=; b=CGPUfV410uPIyZPBnHXp3I0NSxAjkKsfAoA26tBPmydgW8KDU5BLwxxsgH2iO3NEaqyjLiJD
 bBaGfXVl451gFvnMZID6mUUD252Nd/kVBaUHhFOa0c9BjvQCskWVGMu/dF4139vGEtbDTJlW
 yTJrJuNJUBqYNnmi4AsXUoAfLVA=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e4329ae.7f8b99783308-smtp-out-n02;
 Tue, 11 Feb 2020 22:24:46 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 814A1C433A2; Tue, 11 Feb 2020 22:24:46 +0000 (UTC)
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2FD19C43383;
        Tue, 11 Feb 2020 22:24:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2FD19C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCHv3 0/2] Convert QCOM watchdog timer bindings to YAML
Date:   Wed, 12 Feb 2020 03:54:28 +0530
Message-Id: <cover.1581459151.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series converts QCOM watchdog timer bindings to YAML. Also
it adds the missing SoC-specific compatible for QCS404, SC7180,
SDM845 and SM8150 SoCs.

v1: https://lore.kernel.org/lkml/cover.1576211720.git.saiprakash.ranjan@codeaurora.org/
v2: https://lore.kernel.org/lkml/cover.1580570160.git.saiprakash.ranjan@codeaurora.org/

Changes since v2:
 * Add missing compatibles to enum.

Changes since v1:
 As per Rob's suggestion:
  * Replaced oneOf+const with enum.
  * Removed timeout-sec and included watchdog.yaml.
  * Removed repeated use of const:qcom,kpss-wdt and made use of enum.

Sai Prakash Ranjan (2):
  dt-bindings: watchdog: Convert QCOM watchdog timer bindings to YAML
  dt-bindings: watchdog: Add compatible for QCS404, SC7180, SDM845,
    SM8150

 .../devicetree/bindings/watchdog/qcom-wdt.txt | 28 -----------
 .../bindings/watchdog/qcom-wdt.yaml           | 48 +++++++++++++++++++
 2 files changed, 48 insertions(+), 28 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/watchdog/qcom-wdt.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
