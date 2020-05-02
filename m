Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511B4C3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 04:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C4C621775
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 04:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RApLloiA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgEBE13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 00:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726058AbgEBE12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 00:27:28 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C4BC061A0C;
        Fri,  1 May 2020 21:27:28 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id v2so4406273plp.9;
        Fri, 01 May 2020 21:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+IOXl2jed4M505/IbPFpJG7XBeW1Tzf7RxiMicNF8/I=;
        b=RApLloiAJdVFejIqkp5H8CAgghDiPFSZ4YFJoQjcCPFipTXfw/efoeQ1McWWu2sKIe
         m3bJ7AzDsIepoIn2H0xGa71ram0oTKM0rwFRHH7rDJ2z92sDXP/WUD2W5c3/e8jJvGw9
         zXTO2IqWqBQuPsHoUZTHTYky5gvzplN6u4VpYYYkpvewx90PPscgXYE5eIhHdIkBmrno
         f74SFfGalFEhvskFIg73z6aasqWDwzoFGECKsXZbRcD8mo7Ky54aPxELmIyMoqfRXGKa
         SeyqgBdoSMtWM8YeNFf2nxpEGB5AeugEqIli9us1fON96EkUbFM/3qxluqiUO0Jad7Mb
         moJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+IOXl2jed4M505/IbPFpJG7XBeW1Tzf7RxiMicNF8/I=;
        b=WW3JKTbaxv2kxNbUbJFapfyhMoWAnxrPUae8V0Gl7FxMcIwqYVXoUfuYM3UTXSxVSS
         VZojU11AqYh83kIg4ZwkHTKYPWUvxQb+dH7ENcC9v2t/yEXWMhbp06bEKt//CfX8yimn
         l4mJ2RfEDYWZNQwd6rMz7RIHjXa7/vo/XouURn3B+VT4qJNb/sTicUK2N3UEvzPdHTjp
         qbQhohWTxTAaH8SnD9D3SAgO3b3V8nrYBM2zaQKSBUPT9HjCabcUsaI8VTm/M8KZmfOP
         lG6EFgqO1ejj5TFLFLjHUSBrk8M9leoPUycOk9wHZ9Yh7oXzpWFw8Q7OtuJeV8I2cNDt
         b9Ww==
X-Gm-Message-State: AGi0Pub8j3IcWRI4WJlgon8mfnVXmjgoMEdBzg+Mgis4H2iXgngi1+KH
        tXFD7mQRtwDUkKQBnRwGaV4QKm1a
X-Google-Smtp-Source: APiQypJ8OgkFKATcOXHSRvm9m+ssuT2nkzK4cAFDpb0nnsKEDr/rivHlz3RU3tN/tjTVfhzGYFVUyA==
X-Received: by 2002:a17:90a:d78e:: with SMTP id z14mr3731402pju.125.1588393648159;
        Fri, 01 May 2020 21:27:28 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com. [147.11.224.80])
        by smtp.gmail.com with ESMTPSA id l30sm980021pje.34.2020.05.01.21.27.27
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 01 May 2020 21:27:27 -0700 (PDT)
From:   Bin Meng <bmeng.cn@gmail.com>
To:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bin Meng <bin.meng@windriver.com>
Subject: [PATCH] sh: Drop CONFIG_MTD_M25P80 in sh7757lcr_defconfig
Date:   Fri,  1 May 2020 21:27:23 -0700
Message-Id: <1588393643-31499-1-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bin Meng <bin.meng@windriver.com>

Drop CONFIG_MTD_M25P80 that was removed in
commit b35b9a10362d ("mtd: spi-nor: Move m25p80 code in spi-nor.c")

Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

 arch/sh/configs/sh7757lcr_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sh/configs/sh7757lcr_defconfig b/arch/sh/configs/sh7757lcr_defconfig
index 9f2aed0..1e41a04 100644
--- a/arch/sh/configs/sh7757lcr_defconfig
+++ b/arch/sh/configs/sh7757lcr_defconfig
@@ -36,7 +36,6 @@ CONFIG_IPV6=y
 # CONFIG_FW_LOADER is not set
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
-CONFIG_MTD_M25P80=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
-- 
2.7.4

