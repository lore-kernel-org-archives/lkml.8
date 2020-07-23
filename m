Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AC0C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 08:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44A0820888
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 08:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595492438;
	bh=EaBKgkLVab34uO4dsoqXLnPdlRXSsluTsnqow7VZchE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=0Y69ZxlOHABjC9+7XIfZADr7pGHxF2bL4KPm7YjyFsPzOPe3r/FHdR2T77B66+jbS
	 1i686L9OOT0+0ERsRxkOb29dM6lrcbROHeDGaoyPrYrzvS0P1VpHUn9Xu69riDGdLd
	 7Aax7XnHxrtxT/OKbfD7wSKp5qQOGhupQhE311yE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgGWIUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 04:20:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:55954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbgGWIUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 04:20:36 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71C97206E3;
        Thu, 23 Jul 2020 08:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595492436;
        bh=EaBKgkLVab34uO4dsoqXLnPdlRXSsluTsnqow7VZchE=;
        h=From:To:Cc:Subject:Date:From;
        b=Z1MEhJ4bQgkvAUr6y16w81kHSJmgHmA6HbXKHjoAIODeLC0/kSWI+X688OQm+afPa
         kmgxZhHGOOQXioIAvgVtivokLsuq7owOOk5T+OmsVuhxxuMWPrLV0xgrDcm8gISY0r
         GZgGEdwFzriRGrjdwGRDSU10GjB9GkQqvCuvFHs4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] sh: clk: Fix assignment from incompatible pointer type for ioreadX()
Date:   Thu, 23 Jul 2020 10:20:17 +0200
Message-Id: <20200723082017.24053-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ioreadX() helpers accept now pointer to const memory so declaration
of read function needs updating.

This fixes build errors like:

    drivers/sh/clk/cpg.c: In function ‘sh_clk_mstp_enable’:
    drivers/sh/clk/cpg.c:49:9: error: assignment from incompatible pointer type [-Werror=incompatible-pointer-types]
        read = ioread8;

Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Dear Andrew,

This was part of my v3 patchset commit 9ab7fb303cc1 ("iomap: Constify
ioreadX() iomem argument (as in generic implementation)") but I think it
was skipped when applying to your tree.

Maybe because it depends on commit 58c4d8659186 ("sh: clkfwk: remove
r8/r16/r32") which landed later?  Anyway it should go through your tree,
I think.
---
 drivers/sh/clk/cpg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/sh/clk/cpg.c b/drivers/sh/clk/cpg.c
index a5cacfe24a42..fd72d9088bdc 100644
--- a/drivers/sh/clk/cpg.c
+++ b/drivers/sh/clk/cpg.c
@@ -40,7 +40,7 @@ static int sh_clk_mstp_enable(struct clk *clk)
 {
 	sh_clk_write(sh_clk_read(clk) & ~(1 << clk->enable_bit), clk);
 	if (clk->status_reg) {
-		unsigned int (*read)(void __iomem *addr);
+		unsigned int (*read)(const void __iomem *addr);
 		int i;
 		void __iomem *mapped_status = (phys_addr_t)clk->status_reg -
 			(phys_addr_t)clk->enable_reg + clk->mapped_reg;
-- 
2.17.1

