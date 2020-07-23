Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E166C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 19:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A9BF20737
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 19:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3kY6blop";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u1FkQZyy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbgGWTJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 15:09:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60556 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728397AbgGWTJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 15:09:47 -0400
Date:   Thu, 23 Jul 2020 19:09:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595531385;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oSc07fS9Ne+RWv/klpUpFgdFQ8Ko/InkZRuDM+nirFE=;
        b=3kY6blopT53zSQek5C2qjzejUW+tDTpQ8Q7dkQTgNiq3M1LCMeXAd6TaGpmG9Y2zi7gl+4
        9LlVVVd1G+E+GqHiuoYhBXd7VqDTkTjJ0UAqUCNpZf0mPezM9j2pavgh4kdNKPz8+QPFWc
        VDkXSFcNxq4oaYkISrgEyk307v7ORYh6tXJKtXXN/KigJ+2oNL9kigPYFr/6sgzkPSSVIY
        HjNhmTgvtbjy+3pMqkdvMdmfRtG6IgeTDShKxS57M1cNaNVmsJLqiH53TLMyJSgKgxTa7j
        nTEm7psYR+j87cPfmSXJIpEzUuOsc1XDJRL8A5ivvSIwIvfT30q1LnCL7SGQsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595531385;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oSc07fS9Ne+RWv/klpUpFgdFQ8Ko/InkZRuDM+nirFE=;
        b=u1FkQZyy24dg3PyaCsVkJDkZLuEcqtebQ815MaiuNm66g3bvFtB0ojK8JYGvr4EkEHaX90
        fwbgwy8VOxlLVbAA==
From:   "tip-bot2 for Kamel Bouhara" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] ARM: at91: add atmel tcb capabilities
Cc:     Kamel Bouhara <kamel.bouhara@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200710230813.1005150-5-alexandre.belloni@bootlin.com>
References: <20200710230813.1005150-5-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Message-ID: <159553138526.4006.6977454971655283035.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     738c58ccac386bb068cba2446bd9dbabeae09b62
Gitweb:        https://git.kernel.org/tip/738c58ccac386bb068cba2446bd9dbabeae09b62
Author:        Kamel Bouhara <kamel.bouhara@bootlin.com>
AuthorDate:    Sat, 11 Jul 2020 01:08:08 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sat, 11 Jul 2020 18:57:03 +02:00

ARM: at91: add atmel tcb capabilities

Some atmel socs have extra tcb capabilities that allow using a generic
clock source or enabling a quadrature decoder.

Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200710230813.1005150-5-alexandre.belloni@bootlin.com
---
 include/soc/at91/atmel_tcb.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/soc/at91/atmel_tcb.h b/include/soc/at91/atmel_tcb.h
index c3c7200..1d7071d 100644
--- a/include/soc/at91/atmel_tcb.h
+++ b/include/soc/at91/atmel_tcb.h
@@ -36,9 +36,14 @@ struct clk;
 /**
  * struct atmel_tcb_config - SoC data for a Timer/Counter Block
  * @counter_width: size in bits of a timer counter register
+ * @has_gclk: boolean indicating if a timer counter has a generic clock
+ * @has_qdec: boolean indicating if a timer counter has a quadrature
+ * decoder.
  */
 struct atmel_tcb_config {
 	size_t	counter_width;
+	bool    has_gclk;
+	bool    has_qdec;
 };
 
 /**
