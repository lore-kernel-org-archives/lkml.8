Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0094C4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C092520754
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbgCSIs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 04:48:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59803 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbgCSIsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 04:48:04 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jEqqP-00033P-Kf; Thu, 19 Mar 2020 09:48:01 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 97FC11C2297;
        Thu, 19 Mar 2020 09:47:53 +0100 (CET)
Date:   Thu, 19 Mar 2020 08:47:53 -0000
From:   "tip-bot2 for Joel Stanley" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: fttmr010: Add ast2600 compatible
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191107094218.13210-5-joel@jms.id.au>
References: <20191107094218.13210-5-joel@jms.id.au>
MIME-Version: 1.0
Message-ID: <158460767331.28353.1480826352666976937.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     5be8badcb64be4c6ac5b0e8b882eca8eb175ec2d
Gitweb:        https://git.kernel.org/tip/5be8badcb64be4c6ac5b0e8b882eca8eb175ec2d
Author:        Joel Stanley <joel@jms.id.au>
AuthorDate:    Thu, 07 Nov 2019 20:12:18 +10:30
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 21 Feb 2020 09:28:38 +01:00

dt-bindings: fttmr010: Add ast2600 compatible

The ast2600 contains a fttmr010 derivative.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20191107094218.13210-5-joel@jms.id.au
---
 Documentation/devicetree/bindings/timer/faraday,fttmr010.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/faraday,fttmr010.txt b/Documentation/devicetree/bindings/timer/faraday,fttmr010.txt
index 1957922..3cb2f4c 100644
--- a/Documentation/devicetree/bindings/timer/faraday,fttmr010.txt
+++ b/Documentation/devicetree/bindings/timer/faraday,fttmr010.txt
@@ -11,6 +11,7 @@ Required properties:
   "moxa,moxart-timer", "faraday,fttmr010"
   "aspeed,ast2400-timer"
   "aspeed,ast2500-timer"
+  "aspeed,ast2600-timer"
 
 - reg : Should contain registers location and length
 - interrupts : Should contain the three timer interrupts usually with
