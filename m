Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D73C35250
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 14:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE702082E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 14:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbgBHOJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 09:09:28 -0500
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:38074 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbgBHOJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 09:09:27 -0500
Received: from localhost.localdomain ([93.22.133.23])
        by mwinf5d31 with ME
        id 0E9R220070WSqZ103E9RbC; Sat, 08 Feb 2020 15:09:26 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 08 Feb 2020 15:09:26 +0100
X-ME-IP: 93.22.133.23
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     oss@buserror.net, galak@kernel.crashing.org,
        benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/2] powerpc/83xx: Add some error handling in 'quirk_mpc8360e_qe_enet10()'
Date:   Sat,  8 Feb 2020 15:09:20 +0100
Message-Id: <20200208140920.7652-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some error handling path, we should call "of_node_put(np_par)" or
some resource may be leaking in case of error.

Fixes: 8159df72d43e ("83xx: add support for the kmeter1 board.")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 arch/powerpc/platforms/83xx/km83xx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/83xx/km83xx.c b/arch/powerpc/platforms/83xx/km83xx.c
index 306be75faec7..bcdc2c203ec9 100644
--- a/arch/powerpc/platforms/83xx/km83xx.c
+++ b/arch/powerpc/platforms/83xx/km83xx.c
@@ -60,10 +60,12 @@ static void quirk_mpc8360e_qe_enet10(void)
 	ret = of_address_to_resource(np_par, 0, &res);
 	if (ret) {
 		pr_warn("%s couldn't map par_io registers\n", __func__);
-		return;
+		goto out;
 	}
 
 	base = ioremap(res.start, resource_size(&res));
+	if (!base)
+		goto out;
 
 	/*
 	 * set output delay adjustments to default values according
@@ -111,6 +113,7 @@ static void quirk_mpc8360e_qe_enet10(void)
 		setbits32((base + 0xac), 0x0000c000);
 	}
 	iounmap(base);
+out:
 	of_node_put(np_par);
 }
 
-- 
2.20.1

