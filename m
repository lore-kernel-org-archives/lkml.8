Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7E5C3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 11:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A2A6216FD
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 11:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n2Rys0El"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgEBLE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 07:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726741AbgEBLE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 07:04:57 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08EBC061A0C;
        Sat,  2 May 2020 04:04:57 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id a21so1112883pls.4;
        Sat, 02 May 2020 04:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=F/St9SVY06UhgDIr+fGsnpTEDexQ9xY9XDidakHbAGc=;
        b=n2Rys0El4nQ2GshyQRp27+5szQWwRK9RsmyopPVicyo4O82oGANPNKMhPu/ezNCgox
         MUO91zN6kcME6FE+R8GG0hmal/3y5+KNqTNxYdbzuhKzvjrZBeA0bloforsFLZtkyiZt
         FMOtE1ce0OvgvTLV92qBwelqzHygNezZncPr1j6dX6tI+SCocNpCpOCd4G7uhylxsFNM
         tzElunO6q+kp1TDVR6ChRLom8EcEagBqcD/E/XJ9GRPVod2luY8SdmvNcnQhC9v9eYZc
         1XvtPY0AbD3aCTNBtD6qa3yVqFIdoqJ/mTQTLKpQpzlUzb0lTZucQmOCcXvq7b12ewXg
         bD3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=F/St9SVY06UhgDIr+fGsnpTEDexQ9xY9XDidakHbAGc=;
        b=I3nCw61SKSdDjcWJLranwOHodDBE2EVZnvtd9c8UHq4SOKfbOGU37xOExcpgpa8h4e
         GkkO5UhxW9V+QkgFsd2CUUsyr0wOsOcQoJiY1ukJZxrInWWIkz9MazKg/yILoVoAXnKA
         oPAfN/yRKogESH2S68xOn/m3hEhEF5qTfeAIXmpk8L7EXVd4SxAbYdyvFmxbVZLuHFvL
         W/v8zm6Q/IU2RAMOE+DPGSRqX+Df9loEF97SOZi6Zewz8HkLVnpBIgeMi/X/ISIyFGhV
         zucgNW9FFzXvMrgvCup8DySVUHJgS5pRQIlhe+OkMUen8v3MjF79BD+by26S9dw1i2J1
         coMg==
X-Gm-Message-State: AGi0Puah/h3t8mjwmnv8dQ/VvFc3JPciUZMvJVxIdLU3WECY0J5ose2C
        yCo19iSocKV9cpx0iu6HH4GqM7wI
X-Google-Smtp-Source: APiQypI5l/kQFMQpC5/Ls6LwpVHL7qLrDPNMJXU4hhF00kOOBA+w68vDC26dSIZiRl/P/cRySNtt/w==
X-Received: by 2002:a17:902:7593:: with SMTP id j19mr9044216pll.62.1588417497096;
        Sat, 02 May 2020 04:04:57 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com. [147.11.224.80])
        by smtp.gmail.com with ESMTPSA id w11sm4301133pfq.100.2020.05.02.04.04.56
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 02 May 2020 04:04:56 -0700 (PDT)
From:   Bin Meng <bmeng.cn@gmail.com>
To:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bin Meng <bin.meng@windriver.com>
Subject: [PATCH v2] sh: Replace CONFIG_MTD_M25P80 with CONFIG_MTD_SPI_NOR in sh7757lcr_defconfig
Date:   Sat,  2 May 2020 04:04:43 -0700
Message-Id: <1588417483-30987-1-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bin Meng <bin.meng@windriver.com>

CONFIG_MTD_M25P80 was removed and replaced by CONFIG_MTD_SPI_NOR in
commit b35b9a10362d ("mtd: spi-nor: Move m25p80 code in spi-nor.c")

Signed-off-by: Bin Meng <bin.meng@windriver.com>

---

Changes in v2:
- add CONFIG_MTD_SPI_NOR=y

 arch/sh/configs/sh7757lcr_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/configs/sh7757lcr_defconfig b/arch/sh/configs/sh7757lcr_defconfig
index 9f2aed0..d0933a9 100644
--- a/arch/sh/configs/sh7757lcr_defconfig
+++ b/arch/sh/configs/sh7757lcr_defconfig
@@ -36,7 +36,7 @@ CONFIG_IPV6=y
 # CONFIG_FW_LOADER is not set
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
-CONFIG_MTD_M25P80=y
+CONFIG_MTD_SPI_NOR=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
-- 
2.7.4

