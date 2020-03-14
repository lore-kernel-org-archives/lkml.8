Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251B8C1975A
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF42220575
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584239103;
	bh=coba9sPlVQlvtDyTnDgcgDbX0FGnfY7UH9T3w2NckRk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=RUMm/jaVvZTF+TXwya9WiDqMubICG0+l93EQK/2BP7vDct7boxU/iRLTH5Y3xuHlt
	 VIYZWfns3brgMtJIwsVf66RKW0d/8wBi0HvaXuo/zb0RW0EHTr/SHp0yHH0rHd5aD1
	 XdcSJEEDTJA1SBFcilPu2j5n/nKrfzSltuIhyPpc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbgCOCZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 22:25:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:39116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727925AbgCOCYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 22:24:13 -0400
Received: from localhost.localdomain (unknown [194.230.155.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65AA920770;
        Sat, 14 Mar 2020 11:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584185730;
        bh=coba9sPlVQlvtDyTnDgcgDbX0FGnfY7UH9T3w2NckRk=;
        h=From:To:Cc:Subject:Date:From;
        b=IHo9UHfgRAZndP5626xncCmMrGNzq2y+l8gtNe7gPnI02TVheNnld8vdjBcxriTDI
         M2SJzpOZCB19uEP/8ffnfke2PZfQgUEchLaOCdRGgX7O9NuV4iofCXktWefIcoL9zy
         sn1T7+L/ilxpKdQW8xsv0quXzPgeE9eqiVtDo1ZI=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Kevin Hilman <khilman@baylibre.com>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] pwm: meson: Fix confusing indentation
Date:   Sat, 14 Mar 2020 12:35:24 +0100
Message-Id: <20200314113524.23031-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix indentation of return block.  Smatch warning:
    drivers/pwm/pwm-meson.c:139 meson_pwm_request() warn: inconsistent indenting

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/pwm/pwm-meson.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 6245bbdb6e6c..8cf9129caa39 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -136,7 +136,7 @@ static int meson_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 			dev_err(dev, "failed to set parent %s for %s: %d\n",
 				__clk_get_name(channel->clk_parent),
 				__clk_get_name(channel->clk), err);
-				return err;
+			return err;
 		}
 	}
 
-- 
2.17.1

