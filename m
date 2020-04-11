Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9949DC2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 07:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77ECC2084D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 07:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgDKHaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 03:30:10 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:40043 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgDKHaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 03:30:09 -0400
Received: from localhost.localdomain ([93.22.135.18])
        by mwinf5d37 with ME
        id RKW6220070Pz5GD03KW6Eh; Sat, 11 Apr 2020 09:30:08 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 11 Apr 2020 09:30:08 +0200
X-ME-IP: 93.22.135.18
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     elder@kernel.org, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] soc: qcom: ipa: Add a missing '\n' in a log message
Date:   Sat, 11 Apr 2020 09:30:04 +0200
Message-Id: <20200411073004.8404-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Message logged by 'dev_xxx()' or 'pr_xxx()' should end with a '\n'.

Fixes: a646d6ec9098 ("soc: qcom: ipa: modem and microcontroller")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/ipa/ipa_modem.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ipa/ipa_modem.c b/drivers/net/ipa/ipa_modem.c
index 55c9329a4b1d..ed10818dd99f 100644
--- a/drivers/net/ipa/ipa_modem.c
+++ b/drivers/net/ipa/ipa_modem.c
@@ -297,14 +297,13 @@ static void ipa_modem_crashed(struct ipa *ipa)
 
 	ret = ipa_endpoint_modem_exception_reset_all(ipa);
 	if (ret)
-		dev_err(dev, "error %d resetting exception endpoint",
-			ret);
+		dev_err(dev, "error %d resetting exception endpoint\n", ret);
 
 	ipa_endpoint_modem_pause_all(ipa, false);
 
 	ret = ipa_modem_stop(ipa);
 	if (ret)
-		dev_err(dev, "error %d stopping modem", ret);
+		dev_err(dev, "error %d stopping modem\n", ret);
 
 	/* Now prepare for the next modem boot */
 	ret = ipa_mem_zero_modem(ipa);
-- 
2.20.1

