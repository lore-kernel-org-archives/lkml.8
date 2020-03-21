Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177F7C4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 06:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD94820732
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 06:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qLbxc/xy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbgCUGmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 02:42:32 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:47098 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727824AbgCUGmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 02:42:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id j17so6600899wru.13;
        Fri, 20 Mar 2020 23:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6jwYi+4smvXpVmrJrlCNrUCQ6TbLycTN4aAVHLYtEcY=;
        b=qLbxc/xyJkaMd31ImtrVXGmY8aoSdkbThQE6UnMCnH7JaMVwcP4cYHI8+c7QPkkvYO
         zPjpG6Vg+gwbiRi3kvYGCHE8s6aTgILjcx74heIq7gHhAu6Ji/71vD+USpqEPHOrhBVB
         2X+S/YOiYfCmore9+jCcd0yhfl7VlNhpVMsuOGBDaZV/GtyJTlbyDe5zC9imvitplxaJ
         YRCNRXXKhnyD6Wa4Pt+p67YknAmbAOih+TyIhyMNbWe0W4bseHXmGNNzfBgVOUE58cKW
         tZjJdJ1eKq0QGABwVMGbeVqJ0P0TtQ1uXGkTqsopkMTUuWED6CZL9WV3u10dJE7W4W6V
         ZWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6jwYi+4smvXpVmrJrlCNrUCQ6TbLycTN4aAVHLYtEcY=;
        b=fK8R2qb/Uv6NpSvOOMfTMgPjF9xWK2Ug4kAw0nBCZAyunChySKNzTxygbeBqcoq8D8
         4hLQEQtyCObRxNjDyiiUZ0ksGCZEPecmias84oRqpprF0TzVAbCTBxg+al8y4uonoJmc
         Cpm/0g5IvppR9R8LiL20zY3N/jqlt6YAPB6NR6SyBTrePtu62igUQhJfYlqiFC1hVT+t
         MmCCISMNW/UPuDJY5bC0i103bzaOgiGa9sJcEg97jGBjrtqIGCWAHM0l1YvGCaDluvdr
         I8nGfIuye88m+P59EEw+1melRQcmrkVCB44MyjN6pZiIvjvPjPFwR/JsDnT4qdn5OuI6
         B1HQ==
X-Gm-Message-State: ANhLgQ0bCzx1L7nYSTcmZJpPU5LIXY8aJzzqr/4ZG5BozmehXJW8Ddgn
        RBAoHAKVw5o8cQrLBcT1oMA=
X-Google-Smtp-Source: ADFU+vuR82I6jdQEXvp8/i3BFcsKQ5kIC/3RfxJfhRkmcC28/6Y1EcInIoAYgazpWuhDC8DKZ9sGfA==
X-Received: by 2002:a05:6000:d1:: with SMTP id q17mr15985822wrx.409.1584772948918;
        Fri, 20 Mar 2020 23:42:28 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d49:b100:ccc3:14ec:86ef:bd24])
        by smtp.gmail.com with ESMTPSA id k126sm11356619wme.4.2020.03.20.23.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 23:42:28 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Boris Brezillon <bbrezillon@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Vladimir Zapolskiy <vz@mleia.com>, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: update entry after SPI NOR controller move
Date:   Sat, 21 Mar 2020 07:42:17 +0100
Message-Id: <20200321064217.6179-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a0900d0195d2 ("mtd: spi-nor: Prepare core / manufacturer code
split") moved all SPI NOR controller drivers to a controllers/
sub-directory. However, the moved nxp-spifi.c file was referenced in the
ARM/LPC18XX ARCHITECTURE entry in MAINTAINERS.

Hence, since then, ./scripts/get_maintainer.pl --self-test complains:

  warning: no file matches F: drivers/mtd/spi-nor/nxp-spifi.c

Update the file entry in MAINTAINERS to its new location.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on next-20200320
Boris, Tudor, please pick this trivial patch. Not urgent.

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 50e8b900c0ae..3822efce14bc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1948,7 +1948,7 @@ F:	Documentation/devicetree/bindings/i2c/i2c-lpc2k.txt
 F:	arch/arm/boot/dts/lpc43*
 F:	drivers/i2c/busses/i2c-lpc2k.c
 F:	drivers/memory/pl172.c
-F:	drivers/mtd/spi-nor/nxp-spifi.c
+F:	drivers/mtd/spi-nor/controllers/nxp-spifi.c
 F:	drivers/rtc/rtc-lpc24xx.c
 N:	lpc18xx
 
-- 
2.17.1

