Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826FAC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53CAB20787
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="F84j12lv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbgE0G2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 02:28:03 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:57548 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727054AbgE0G2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 02:28:03 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590560882; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=XNy12ogKy2XS05WoA+Z2aanfF8e2oeYpurNyGPaGIAk=; b=F84j12lvRMepR1bYbr3mk8S/B/MCwqF4iiyYhAUcqMzpHUMBGecymA1DzpP+zmRKI5Um/Smt
 PZ+mc0+Q4Abi3pjE9ENuUUR1rNCiaAE9WUTcK/GzX+XMwv8oZkaNKWrv0YEtkL38g+45REqP
 Rrx7LEuqNdHmJuPGNYDv3Ytrxfo=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5ece08723131442d9566ece0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 27 May 2020 06:28:02
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3F7F0C43387; Wed, 27 May 2020 06:28:01 +0000 (UTC)
Received: from akashast-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akashast)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 75FE5C433C6;
        Wed, 27 May 2020 06:27:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 75FE5C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=akashast@codeaurora.org
From:   Akash Asthana <akashast@codeaurora.org>
To:     robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mgautam@codeaurora.org,
        rojay@codeaurora.org, skakit@codeaurora.org,
        msavaliy@codeaurora.org, Akash Asthana <akashast@codeaurora.org>
Subject: [PATCH V7 0/3] Convert QUP bindings to YAML and add ICC, pin swap doc
Date:   Wed, 27 May 2020 11:57:41 +0530
Message-Id: <1590560864-27037-1-git-send-email-akashast@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in V6:
 - As per Rob's suggestion moved pin swap documentation from QUP to
   serial.yaml file[PATCH V6 3/3].

Changes in V4:
 - Add interconnect binding patch.
 - Add UART pin swap binding patch.

Akash Asthana (3):
  dt-bindings: geni-se: Convert QUP geni-se bindings to YAML
  dt-bindings: geni-se: Add interconnect binding for GENI QUP
  dt-bindings: serial: Add binding for UART pin swap

 .../devicetree/bindings/serial/serial.yaml         |   6 +
 .../devicetree/bindings/soc/qcom/qcom,geni-se.txt  |  94 ---------
 .../devicetree/bindings/soc/qcom/qcom,geni-se.yaml | 227 +++++++++++++++++++++
 3 files changed, 233 insertions(+), 94 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project

