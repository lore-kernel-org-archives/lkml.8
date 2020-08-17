Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B9BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC34820716
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="m+BtZ93P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgHQHTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 03:19:22 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:48076 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbgHQHTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:19:21 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597648760; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=hwlJ5WSyqLCQ3kLhAjhnixhlrCzC9z8oa3p4W6kt32o=; b=m+BtZ93P2JWpvR2Zr3iRycqR59YKEKLmkmq6qr4atHH6Peovf1oO+UhUpwioo7TBZwOPNUQI
 TrxY6fPJyWWAVIvZSovwDrpSB4ZjNnvfa8dpJIr8b6kitFZ5cwdZY3VkzBaDlJ8C8Dfy77fW
 ppzDn8oT2Mgyeu2HKPfCyY/NBTM=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f3a2f60f2b697637a623b48 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 17 Aug 2020 07:18:56
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4F96DC43387; Mon, 17 Aug 2020 07:18:55 +0000 (UTC)
Received: from kathirav-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kathirav)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 82022C433C6;
        Mon, 17 Aug 2020 07:18:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 82022C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kathirav@codeaurora.org
From:   Kathiravan T <kathirav@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, sivaprak@codeaurora.org,
        devicetree@vger.kernel.org
Cc:     kathirav@codeaurora.org
Subject: [PATCH V2 0/2] Enable DVFS support for IPQ6018
Date:   Mon, 17 Aug 2020 12:48:38 +0530
Message-Id: <1597648720-13649-1-git-send-email-kathirav@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add A53 PLL, APCS clock, RPM Glink, RPM message RAM, cpu-opp-table,
SMPA2 regulator to enable the cpu frequency on IPQ6018.

[v2]
	- Rebased on v5.9-rc1
	- Picked up the Rob's Acked-by tag for mailbox YAML
	- Regulator binding in V1 was picked by Mark and available in v5.9-rc1

Kathiravan T (2):
  dt-bindings: mailbox: add compatible for the IPQ6018 SoC
  arm64: dts: ipq6018: enable DVFS support

 .../bindings/mailbox/qcom,apcs-kpss-global.yaml    |  1 +
 arch/arm64/boot/dts/qcom/ipq6018.dtsi              | 96 +++++++++++++++++++++-
 2 files changed, 94 insertions(+), 3 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

