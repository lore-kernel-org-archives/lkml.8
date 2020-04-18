Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC42C2D0EF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 10:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7757C21D82
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 10:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9fIql3m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgDRKKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 06:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725799AbgDRKKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 06:10:09 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87EAC061A0C;
        Sat, 18 Apr 2020 03:10:07 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a25so5846940wrd.0;
        Sat, 18 Apr 2020 03:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Qena3MtWCWW39FG/sL2IEnJF//vW5pRQm5AGBE6pZfs=;
        b=K9fIql3mNM8DUze3LYpJq8hIxn2AbWQHpdVjOEFpNdg53lvoEz1UK9fBmuw3bINzDf
         d+BKyBPyar9YdWtsiom/Mg4JBfehj8B3R1+7oH33sodNU67H74rbsulZEMbQHjr4YSub
         +HTqKKFEojq8XJ+hC5IjCxeCMp366EjOllOO4YjpmxrGLFriF7VEa2A0lZGihbf+qtXf
         gRE3UzCXoggGhRiOBDjeN/sL1qTj85olxCyG4RqsNtxkoz+hOe8W11IyWSgJw8Cl6lEH
         qHjWnln/QBrY5jtSr+Tx+sx1ec5ysNiE3i/OLeKW+AcpjZ8l9NVz6kGlGExLiiyLlkGC
         K2EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Qena3MtWCWW39FG/sL2IEnJF//vW5pRQm5AGBE6pZfs=;
        b=gVDQYrTHCNgvjh6kbMvhqyBA4rp90VtiMaW2A8gQHe7RqyyQGrxUCH8nO3dDvtgi2u
         9Add2vwJQQqfOgtN9e4ZWtpZPhqUa0pc1aA90CV3OZcmWceKlQpoD6S74rfVudV3pj3Q
         dIydF+uFiffRaDC42pXwncSY0L5LFgsB3JLsZgCtfOMg0HSJ92VaMOax9IGx2CGZEWgK
         jHO0Gz1ldDq5iHXyhidgPfop5T2+1T1ryzh4IPm8m+JRfBBNrBGMdQOuCLEI/9EVyw0Z
         +KsbKQCaSuUxqwr5K0gLNRuPbcyWgmqELO6VBsfSKdLM/+NzufHAcK20qqiXTPSqYEaA
         3djA==
X-Gm-Message-State: AGi0PubAG6waSvRSkeQMA+yQRc+Ngi75A77HnNnV6nfx3wWQhDPZQS2v
        jyqFnAq+PbeKMN36WK7wTr8=
X-Google-Smtp-Source: APiQypJsEnFS9Q8J+bi+lqjec6s/dgGbyTxoCgCAdexX5/q13TcVfDXVpTDBzDHeNL+J8l0zlty3vg==
X-Received: by 2002:adf:b1d1:: with SMTP id r17mr6511809wra.85.1587204605462;
        Sat, 18 Apr 2020 03:10:05 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d7a:4700:391d:588b:ee8c:e294])
        by smtp.gmail.com with ESMTPSA id h13sm23790689wrs.22.2020.04.18.03.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 03:10:04 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Boris Brezillon <bbrezillon@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Sebastian Duda <sebastian.duda@fau.de>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH RESEND] MAINTAINERS: adjust to renaming physmap_of_versatile.c
Date:   Sat, 18 Apr 2020 12:09:33 +0200
Message-Id: <20200418100933.8012-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 6ca15cfa0788 ("mtd: maps: Rename physmap_of_{versatile, gemini}
into physmap-{versatile, gemini}") renamed physmap_of_versatile.c to
physmap-versatile.c, but did not adjust the MAINTAINERS entry.

Since then, ./scripts/get_maintainer.pl --self-test complains:

  warning: no file matches F: drivers/mtd/maps/physmap_of_versatile.c

Rectify the ARM INTEGRATOR, VERSATILE AND REALVIEW SUPPORT entry and now
also cover drivers/mtd/maps/physmap-versatile.h while at it.

Co-developed-by: Sebastian Duda <sebastian.duda@fau.de>
Signed-off-by: Sebastian Duda <sebastian.duda@fau.de>
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Boris, please pick or ack this patch.
applies cleanly on current master and next-20200417

v1: https://lore.kernel.org/lkml/20200228063338.4099-1-lukas.bulwahn@gmail.com/
  - was wrongly sent to old boris.brezillon@bootlin.com address
  - got Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c77f02282044..52bb8819230a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1342,7 +1342,7 @@ F:	arch/arm/plat-versatile/
 F:	drivers/clk/versatile/
 F:	drivers/i2c/busses/i2c-versatile.c
 F:	drivers/irqchip/irq-versatile-fpga.c
-F:	drivers/mtd/maps/physmap_of_versatile.c
+F:	drivers/mtd/maps/physmap-versatile.*
 F:	drivers/power/reset/arm-versatile-reboot.c
 F:	drivers/soc/versatile/
 
-- 
2.17.1

