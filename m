Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E79BC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE743206F4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="nuoWT8CF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729919AbgGMOBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 10:01:12 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:43272 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729703AbgGMOBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 10:01:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1594648871; x=1626184871;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=cKO2gBV4NFrCBzkjEMtV2yh0g8suBsg50yMtHIjBQVE=;
  b=nuoWT8CFOmSTgKITxcjMIisJSSB+dvF85X40gIB7xtayxQZOZMicXfki
   zmKWzXjXk6IxfITSYjVo1eGWghjDV+B5a+8CKDMcB1DTiJRdv6woEGGvn
   S3qFjaEkdoSciI3KiswyH2tQfBfNzOjREQ8wZO1qzA6PKrTwSGzd2vGaT
   kSwF9AdYCfE5dYpFe5JaW9VlJ55/6q7k/hiKdO1BTjChCcu3aP+CHw/l9
   zcMj4kKEGYPi8uOdtPH31pDDBMoTPA9Y4tFBg2NF5lNNVKpacCkChfMEr
   MYveXiyHil6ofUBrDJM3tXIwnyQWpkV2st/cRS60S2eKPLlneK7jv0YgJ
   g==;
IronPort-SDR: TUXjNBF38FIw09OvsLhvbAGrd2n7mxa4PzIM+v9MPM0S2motDq23JJAz459vDeru1gdpCMIse0
 OmZsSz3YiW1PXvY6gLctRMyaE3JpwjzhwcV51CfvS7NfMFBNFA1MpkhSsrFC18jYXt53BzmeCR
 zBI5jYvSrICbNsSp7FNncMjnFx8fKe5eMhEeROmVZ7XL6SqsITP1XZ1H54Jjpa56jzLM4qywca
 MgcA/4sXrL1vsC80F4njto9WSpIWF4+hJ2V9tTvn1u/ycYwQ5azFTd5dWyhUzvBEfbXmt96u6j
 LfY=
X-IronPort-AV: E=Sophos;i="5.75,347,1589266800"; 
   d="scan'208";a="83627572"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jul 2020 07:01:11 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 13 Jul 2020 07:00:40 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Mon, 13 Jul 2020 07:01:08 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <john.stultz@linaro.org>, <tglx@linutronix.de>, <sboyd@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH] timekeeping: correct typo
Date:   Mon, 13 Jul 2020 17:00:45 +0300
Message-ID: <1594648845-17200-1-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct typo in logarithmic_accumulation() description.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 kernel/time/timekeeping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index d20d489841c8..6b436d7a751f 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2001,7 +2001,7 @@ static inline unsigned int accumulate_nsecs_to_secs(struct timekeeper *tk)
  * logarithmic_accumulation - shifted accumulation of cycles
  *
  * This functions accumulates a shifted interval of cycles into
- * into a shifted interval nanoseconds. Allows for O(log) accumulation
+ * a shifted interval nanoseconds. Allows for O(log) accumulation
  * loop.
  *
  * Returns the unconsumed cycles.
-- 
2.7.4

