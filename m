Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2056C33CAF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A246E24125
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgAVN5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:57:54 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33514 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgAVN5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:57:53 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dafna)
        with ESMTPSA id 842AE292556
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dafna.hirschfeld@collabora.com,
        helen.koike@collabora.com, ezequiel@collabora.com,
        kernel@collabora.com, dafna3@gmail.com
Subject: [PATCH] dt-bindings: fix warnings in validation of qcom,gcc.yaml
Date:   Wed, 22 Jan 2020 14:57:41 +0100
Message-Id: <20200122135741.12123-1-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The last example in qcom,gcc.yaml set 'sleep' as the second
value of 'clock-names'. According to the schema is should
be 'sleep_clk'. Fix the example to conform the schema.
This fixes a warning when validating the schema:
"clock-names:  ... is not valid under any of the given schemas"

Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
I tested this patch on top of the patch
"dt-binding: fix compilation error of the example in qcom,gcc.yaml"
which fixes a compilation error in this file

 Documentation/devicetree/bindings/clock/qcom,gcc.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
index 50ff07f80acb..cac1150c9292 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
@@ -235,7 +235,7 @@ examples:
                <0>,
                <0>;
       clock-names = "xo",
-                    "sleep",
+                    "sleep_clk",
                     "usb3_pipe",
                     "ufs_rx_symbol0",
                     "ufs_rx_symbol1",
-- 
2.17.1

