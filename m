Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0967C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 06:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2EC0208FE
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 06:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EC13Q5W5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgIIGTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 02:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgIIGTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 02:19:25 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BE4C061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 23:19:25 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id o68so1367885pfg.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 23:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HqHbWs7WrbQ+q4MvJlKQimTJrTFBaf0KhAZXJ06WT8k=;
        b=EC13Q5W5+C5gd1b173sBLJBBYCsfX7vbZSbtu2AQVLcGm08ys9p6dQ/ruEI+jqnI7Y
         UJQo6Jv+GC8dJTGNi4vDHw0RAfwBz19Mkp6P84Sek83Iun3op5+AP8JX2mtU3g8z15jL
         HhRrXyYGmQyQYwftRBPXtVO/OsnOVZJ4EaFLTYOnne9HXT1/ZXVMmwW/RrDn+U3JmusV
         CBRXVD8CVz4yIx658SvhpfvT0abBqokhnJjlO++RUEDZeZG+pjZ7gUmHQbpbSgKaxDWw
         veY1yZ08gii2FrqlGziIhllBGtRfNV2vJBg8W7I0r03wDbtxWTlF1S1oapA1MLQuj96F
         bHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HqHbWs7WrbQ+q4MvJlKQimTJrTFBaf0KhAZXJ06WT8k=;
        b=fOgF5ymt3+DWiaXt+W4yaLmFStLJ7KtxBAV6gKCAy6Lp26EDy8hPQEdRhgDKxxRpuu
         ZV5UmoU2iEo4WEb0Mw7D9wdKsUKqrsaRVlOPLkhlLFyV2qtp20pkKMquNgEeHcTJ2+CJ
         IhCYhnuuzZacpTTW2WF/jiD2Swo6ly5wAk5Z38d7gMgKd6t2MnHh2G9roXFN+yePHFtv
         LCrBjr1gz0RyZQg3SnJYc3FqJ4VzWGp4ZG/AtOCbObeDsjK3hfmQUy5hT9oFqNjmJMRl
         xjjb/A6aXfYHMeN4dUdEp0eWdazZrAc1F6dKEoUeTKrV0aiDgqvayUHt2y/l/v4ZTvq5
         EwzA==
X-Gm-Message-State: AOAM533j2eRTFwFOv1QbkiIdHbOW5uAS7sG7AdW2MUqgyVHhWy8QJ+IO
        yfUUTre6js41Xo2YyYfcXISUKaSoYd/P5w==
X-Google-Smtp-Source: ABdhPJxMkP2iGBAFWd3hkKL2kDy3vwfhYM73r+DTMNKz76O9DaRWn/WXERcRmHcH/8FnIzXF4R0eiQ==
X-Received: by 2002:a63:5363:: with SMTP id t35mr1813033pgl.443.1599632364942;
        Tue, 08 Sep 2020 23:19:24 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id gj6sm946802pjb.10.2020.09.08.23.19.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Sep 2020 23:19:23 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2] dt-bindings: mailbox: add doorbell support to ARM MHU
Date:   Wed,  9 Sep 2020 11:49:15 +0530
Message-Id: <ee7439aea0c2076aab5dab26d8266d5faab01b6b.1599632119.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sudeep Holla <sudeep.holla@arm.com>

The ARM MHU's reference manual states following:

"The MHU drives the signal using a 32-bit register, with all 32 bits
logically ORed together. The MHU provides a set of registers to enable
software to set, clear, and check the status of each of the bits of this
register independently.  The use of 32 bits for each interrupt line
enables software to provide more information about the source of the
interrupt. For example, each bit of the register can be associated with
a type of event that can contribute to raising the interrupt."

This patch thus extends the MHU controller's DT binding to add support
for doorbell mode.

Though the same MHU hardware controller is used in the two modes, A new
compatible string is added here to represent the combination of the MHU
hardware and the firmware sitting on the other side (which expects each
bit to represent a different signal now).

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Co-developed-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V2:
- New compatible string and minor reformatting.
- Not sending as RFC anymore.

 .../devicetree/bindings/mailbox/arm-mhu.txt   | 44 +++++++++++++++++--
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/arm-mhu.txt b/Documentation/devicetree/bindings/mailbox/arm-mhu.txt
index 4971f03f0b33..1adc441a2c63 100644
--- a/Documentation/devicetree/bindings/mailbox/arm-mhu.txt
+++ b/Documentation/devicetree/bindings/mailbox/arm-mhu.txt
@@ -10,21 +10,41 @@ STAT register and the remote clears it after having read the data.
 The last channel is specified to be a 'Secure' resource, hence can't be
 used by Linux running NS.
 
+Doorbell mode: The MHU drives the interrupt signal using a 32-bit
+register, with all 32-bits logically ORed together. It provides a set of
+registers to enable software to set, clear and check the status of each
+of the bits of this register independently. The use of 32 bits per
+interrupt line enables software to provide more information about the
+source of the interrupt. For example, each bit of the register can be
+associated with a type of event that can contribute to raising the
+interrupt. Each of the 32-bits can be used as "doorbell" to alert the
+remote processor.
+
 Mailbox Device Node:
 ====================
 
 Required properties:
 --------------------
-- compatible:		Shall be "arm,mhu" & "arm,primecell"
+- compatible:		Shall be "arm,mhu" (in data transfer mode) or
+			"arm,mhu-doorbell" (in doorbell mode) and
+			"arm,primecell".
 - reg:			Contains the mailbox register address range (base
 			address and length)
-- #mbox-cells		Shall be 1 - the index of the channel needed.
+- #mbox-cells		Shall be 1 - the index of the channel needed,
+			when used in data transfer mode.
+			Shall be 2 - the index of the channel needed, and
+			the index of the doorbell bit within the
+			channel, when used in doorbell mode.
 - interrupts:		Contains the interrupt information corresponding to
-			each of the 3 links of MHU.
+			each of the 3 physical channels of MHU namely low
+			priority non-secure, high priority non-secure and
+			secure channels.
 
 Example:
 --------
 
+1. In data transfer mode
+
 	mhu: mailbox@2b1f0000 {
 		#mbox-cells = <1>;
 		compatible = "arm,mhu", "arm,primecell";
@@ -41,3 +61,21 @@ used by Linux running NS.
 		reg = <0 0x2e000000 0x4000>;
 		mboxes = <&mhu 1>; /* HP-NonSecure */
 	};
+
+2. In doorbell mode
+
+	mhu: mailbox@2b1f0000 {
+		#mbox-cells = <2>;
+		compatible = "arm,mhu-doorbell", "arm,primecell";
+		reg = <0 0x2b1f0000 0x1000>;
+		interrupts = <0 36 4>, /* LP-NonSecure */
+			     <0 35 4>; /* HP-NonSecure */
+		clocks = <&clock 0 2 1>;
+		clock-names = "apb_pclk";
+	};
+
+	mhu_client: scb@2e000000 {
+		compatible = "arm,scpi";
+		reg = <0 0x2e000000 0x200>;
+		mboxes = <&mhu 1 4>; /* HP-NonSecure 5th doorbell bit */
+	};
-- 
2.25.0.rc1.19.g042ed3e048af

