Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E62C38BE2
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 20:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6103A24656
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 20:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Wa7aXd4/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbgBXU5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 15:57:51 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:24221 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727168AbgBXU5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 15:57:49 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1582577868; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=jpQmCzTy7WRDO9KgfaNO7qY4qtW8D61+hiCBxB0dvDo=; b=Wa7aXd4/UE5LlREIliNj1W091nQylXNW1Kt5pk0EfH7JWhzIrz0nsSZtaBWw6HRwSoniDy2n
 P5pbiZV+VjXYgQmcwh+0vfVU5wj5m8DPPdztQjnu2v1OlqK1EN3MdCD9czFXR2X1rJSXZuAH
 W4Tn3j0ROKA0fTI9w1LC+VA/VYk=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e5438cb.7f98303fd1f0-smtp-out-n01;
 Mon, 24 Feb 2020 20:57:47 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C8F32C447A4; Mon, 24 Feb 2020 20:57:47 +0000 (UTC)
Received: from eberman-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: eberman)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C752BC433A2;
        Mon, 24 Feb 2020 20:57:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C752BC433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=eberman@codeaurora.org
From:   Elliot Berman <eberman@codeaurora.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Elliot Berman <eberman@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Trilok Soni <tsoni@codeaurora.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dt: psci: Add arm,psci-sys-reset2-type property
Date:   Mon, 24 Feb 2020 12:57:36 -0800
Message-Id: <1582577858-12410-2-git-send-email-eberman@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582577858-12410-1-git-send-email-eberman@codeaurora.org>
References: <1582577858-12410-1-git-send-email-eberman@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some implementors of PSCI may relax the requirements of the PSCI
architectural warm reset. In order to comply with PSCI specification, a
different reset_type value must be used. The alternate PSCI
SYSTEM_RESET2 may be used in all warm/soft reboot scenarios, replacing
the architectural warm reset.

Signed-off-by: Elliot Berman <eberman@codeaurora.org>
---
 Documentation/devicetree/bindings/arm/psci.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/psci.yaml b/Documentation/devicetree/bindings/arm/psci.yaml
index 8ef8542..469256a2 100644
--- a/Documentation/devicetree/bindings/arm/psci.yaml
+++ b/Documentation/devicetree/bindings/arm/psci.yaml
@@ -102,6 +102,11 @@ properties:
       [1] Kernel documentation - ARM idle states bindings
         Documentation/devicetree/bindings/arm/idle-states.txt
 
+  arm,psci-sys-reset2-param:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+        reset_param value to use during a warm or soft reboot.
+
   "#power-domain-cells":
     description:
       The number of cells in a PM domain specifier as per binding in [3].
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
