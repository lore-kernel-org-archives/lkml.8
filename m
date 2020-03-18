Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946F7C4332D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 20:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 633EC208E0
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 20:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584564898;
	bh=xluyj0zuzesqOXbJY4Nak2oA9OlTyRQhQwI56NsHeus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OUGsycURPwTkP5vqIl02p/9PdfdBVsQlC0f7YcymPuTKsLY3akGxGbgWPUZnMt4jK
	 7ZkcPAOSB0m5sBoA8m3Xm1JwUShkXziK4lc10cLUFIa6HbR0t60IjsIDP0Cqv78ffA
	 Gnvsv+i7r1sysojbF+L7yAko07QESCvuoXg0OtL4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgCRUy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 16:54:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:54914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728096AbgCRUy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 16:54:56 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E076E208CA;
        Wed, 18 Mar 2020 20:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584564895;
        bh=xluyj0zuzesqOXbJY4Nak2oA9OlTyRQhQwI56NsHeus=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2Uo3vTEPU9s6IDMS6huZ9T3N5W1V8lf/EbgbqBFrsBloIGcqQs1P5urCkzzOmTPXO
         H+ztXrVb9SsJQpbnlfLfAntm5/o9Ts2ojDLkX1xBL08N4ltfKpGgOo5lPG/X4QFe8l
         vTlcwZFXMtDmxXhKjavu3umXEZF7dR3L3zIP7r68=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dominik Czarnota <dominik.b.czarnota@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 63/73] sxgbe: Fix off by one in samsung driver strncpy size arg
Date:   Wed, 18 Mar 2020 16:53:27 -0400
Message-Id: <20200318205337.16279-63-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200318205337.16279-1-sashal@kernel.org>
References: <20200318205337.16279-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dominik Czarnota <dominik.b.czarnota@gmail.com>

[ Upstream commit f3cc008bf6d59b8d93b4190e01d3e557b0040e15 ]

This patch fixes an off-by-one error in strncpy size argument in
drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c. The issue is that in:

        strncmp(opt, "eee_timer:", 6)

the passed string literal: "eee_timer:" has 10 bytes (without the NULL
byte) and the passed size argument is 6. As a result, the logic will
also accept other, malformed strings, e.g. "eee_tiXXX:".

This bug doesn't seem to have any security impact since its present in
module's cmdline parsing code.

Signed-off-by: Dominik Czarnota <dominik.b.czarnota@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c b/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
index c56fcbb370665..38767d7979147 100644
--- a/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
+++ b/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
@@ -2279,7 +2279,7 @@ static int __init sxgbe_cmdline_opt(char *str)
 	if (!str || !*str)
 		return -EINVAL;
 	while ((opt = strsep(&str, ",")) != NULL) {
-		if (!strncmp(opt, "eee_timer:", 6)) {
+		if (!strncmp(opt, "eee_timer:", 10)) {
 			if (kstrtoint(opt + 10, 0, &eee_timer))
 				goto err;
 		}
-- 
2.20.1

