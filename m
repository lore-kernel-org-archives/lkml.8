Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB96EC10F25
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 00:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 970FF2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 00:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="lm+H5tfR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbgCJAEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 20:04:41 -0400
Received: from smtpweb146.aruba.it ([62.149.158.146]:42866 "EHLO
        smtpweb146.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbgCJAEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 20:04:41 -0400
Received: from ubuntu.localdomain ([146.241.70.103])
        by smtpcmd05.ad.aruba.it with bizsmtp
        id CPxW2200V2DhmGq01PxWb4; Tue, 10 Mar 2020 00:57:31 +0100
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc:     Giulio Benetti <giulio.benetti@benettiengineering.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: clk: fix example for single-output provider
Date:   Tue, 10 Mar 2020 00:57:22 +0100
Message-Id: <20200309235722.26278-1-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aruba.it; s=a1;
        t=1583798251; bh=t09PIkcfDqhH2smlQIxEEW+HTkXTi0Jg/uM+cRD92JQ=;
        h=From:To:Subject:Date:MIME-Version;
        b=lm+H5tfRdd64vO8PqQ/QkUPZb5KfLRQEoV+Oe3REcO+x6sz2j7441t+0B85lxwjuQ
         s1gbNdi+BXI4PuQOtGCSXaO4IeKqsdIiz2Y2+pwi6U9hB8x7AaXFpNRLJte+kAW3/C
         HtOLc+IPQmf5Ip41uFkplHSBix91p13yMFKMjW3a3rcuhzPsFFsCY/6GdeTPJYKImh
         ymY6v/JPpzgoFGJ5OyNsHI6cyt5bE4mNY1EgRvI3f/R7DI/c+uvpaQ6H5sX6ax9AUy
         LFHUHgjT22JVvRG0E/6SXlBwqHwUrKmjr3dPuXBadMxUIQ/uwDzHx6sREf0S5/iRwb
         XuxbJ0+1O6CvA==
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As described above single-output clock provider should have
0 cells number, so let's fix it by using 0 as cells number.

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
 Documentation/devicetree/bindings/clock/clock-bindings.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/clock-bindings.txt b/Documentation/devicetree/bindings/clock/clock-bindings.txt
index b646bbcf7f92..8a55fdcf96ee 100644
--- a/Documentation/devicetree/bindings/clock/clock-bindings.txt
+++ b/Documentation/devicetree/bindings/clock/clock-bindings.txt
@@ -94,7 +94,7 @@ clock is connected to output 0 of the &ref.
     /* external oscillator */
     osc: oscillator {
         compatible = "fixed-clock";
-        #clock-cells = <1>;
+        #clock-cells = <0>;
         clock-frequency  = <32678>;
         clock-output-names = "osc";
     };
-- 
2.20.1

