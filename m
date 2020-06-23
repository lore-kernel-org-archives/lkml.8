Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006C8C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C602020781
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592945148;
	bh=Yi0rkYte0Ul8/AyWWV2kwBrjlTBSzJEKQoFAOQiac0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xI+AykSxloPtIf4FFwqHahFd6ddo/fqeeyfo1u2Sibrxu0UZzTZk+L57BbHlem2iN
	 X8gE+9NgRrXZLB2rl1VBLvGF5YeReDenZskAjJK0y9r4zJK00syL8UUo6ttg95xV4L
	 vaXqFdE8iK5qHm6X0yi0Ck8DGJvGregwwSw9B9bw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392770AbgFWUpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:45:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:43048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392286AbgFWUpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:45:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 284F320836;
        Tue, 23 Jun 2020 20:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592945131;
        bh=Yi0rkYte0Ul8/AyWWV2kwBrjlTBSzJEKQoFAOQiac0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F2MvZg5Fub9ZVPWKd/owkSBDIwJPn+XNOpSCKj7fn2HItt3+wSvJHIrbzwm0R5Cjq
         YguxtcUasYHCj0D88M1vMEwUpv9Cje/IYrzk+sKUS7GMJ87Emx41gol7my09lyHB4o
         IUeCiP9Q8JAWNWPqfyjWRp1AB3oMnj7x2RcFy094=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Heidelberg <david@ixit.cz>,
        Dmitry Osipenko <digetx@gmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 051/136] power: supply: smb347-charger: IRQSTAT_D is volatile
Date:   Tue, 23 Jun 2020 21:58:27 +0200
Message-Id: <20200623195306.244298966@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195303.601828702@linuxfoundation.org>
References: <20200623195303.601828702@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Osipenko <digetx@gmail.com>

[ Upstream commit c32ea07a30630ace950e07ffe7a18bdcc25898e1 ]

Fix failure when USB cable is connected:
smb347 2-006a: reading IRQSTAT_D failed

Fixes: 1502cfe19bac ("smb347-charger: Fix battery status reporting logic for charger faults")

Tested-by: David Heidelberg <david@ixit.cz>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: David Heidelberg <david@ixit.cz>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/smb347-charger.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply/smb347-charger.c
index 072c5189bd6d1..0655dbdc7000d 100644
--- a/drivers/power/supply/smb347-charger.c
+++ b/drivers/power/supply/smb347-charger.c
@@ -1141,6 +1141,7 @@ static bool smb347_volatile_reg(struct device *dev, unsigned int reg)
 	switch (reg) {
 	case IRQSTAT_A:
 	case IRQSTAT_C:
+	case IRQSTAT_D:
 	case IRQSTAT_E:
 	case IRQSTAT_F:
 	case STAT_A:
-- 
2.25.1



