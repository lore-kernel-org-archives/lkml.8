Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC97C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A404D206B5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LoE/fjBS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgHHXHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 19:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgHHXHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 19:07:00 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1F7C061756
        for <linux-kernel@vger.kernel.org>; Sat,  8 Aug 2020 16:07:00 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id u128so3096710pfb.6
        for <linux-kernel@vger.kernel.org>; Sat, 08 Aug 2020 16:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=emiTgggaIF+BQrqHX2Ti87z5PsPZiDji49xQXoUlCVA=;
        b=LoE/fjBSi9f+qG08SnhKBMIqj5SRCNf06QZHLO8LAHjwjeV3QfzjitC8SoIve96p8d
         9mpz5ZfGO2qcYXm0rAMBYSJECHZcVksa+xs6tHM4l04EFKO/0BDSzScMxeygHhqnHzbX
         AXEwTvbdhNHHopLBXpgWeTRBFOSUP0uh2DQiUUgSjKMhl0syXgVvxkcYoTfjzoEKE2NK
         DXxtv/TjtV7FUCeGThWxxq1pA/eIMCNScbcwvxup1Y9MCUa8GnRcA+8IRufBSf9PlCrZ
         Xd38U0VJCb4hvZQXSwU2DOysRVfA6547D3G7t/QWwvHoJgwwisS1JgqF6mHYOSew7A0X
         aJDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=emiTgggaIF+BQrqHX2Ti87z5PsPZiDji49xQXoUlCVA=;
        b=WVhqtCKfJ5vs1kJQXVipwRsJxx1c+lewG7qKyMpxlvPSL28+OXBov4I6DAqhkN8Hcd
         TJgQEx3IQ6lek0y1ezDgI5V23oW+fai2Oa1UQanwABTDu3ZzhnWUzZRx581YfUw9twVt
         aTCe0TNQS8L9TNAFtvdcZesCVOGw6mi6GzoKqfzI2L7CpbIjHjK6eNMM5wV0vo1v3A2o
         IPunBZFz/qHapsygeiSDdiXGMdVsWUri74pjs2CrzDEf1374jo/pKyzK+4/nmCt/3LfN
         /Z6yQIrAiWfr1JsRVJPxHkJJL8pldfGZOKelkIh/rgt8ZNXDd1Koy2Ve/Sdh7BRU5CtQ
         FWSQ==
X-Gm-Message-State: AOAM531aEp2wo2jfESAkdRTnWMSteErXqWhqeEZfF65L6e7cFgjpv1sN
        FPr9Ub0u4MX/QVS9sPe2sIKGlhy2
X-Google-Smtp-Source: ABdhPJwc8Q9LMIsXZW8Gug+sjrx5goq3Q3xh0H9aatHbSvWaZlDxI8HC7TJrpGzpLUj0+DZqeIopIA==
X-Received: by 2002:a63:b709:: with SMTP id t9mr16476983pgf.376.1596928020053;
        Sat, 08 Aug 2020 16:07:00 -0700 (PDT)
Received: from localhost (g223.115-65-55.ppp.wakwak.ne.jp. [115.65.55.223])
        by smtp.gmail.com with ESMTPSA id d24sm19470570pfq.72.2020.08.08.16.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2020 16:06:59 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Stafford Horne <shorne@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        openrisc@lists.librecores.org
Subject: [PATCH v3 1/6] openrisc: io: Fixup defines and move include to the end
Date:   Sun,  9 Aug 2020 08:06:42 +0900
Message-Id: <20200808230647.833047-2-shorne@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200808230647.833047-1-shorne@gmail.com>
References: <20200808230647.833047-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This didn't seem to cause any issues, but while working on fixing up
sparse annotations for OpenRISC I noticed this.  This patch moves the
include of asm-generic/io.h to the end of the file.  Also, we add
defines of ioremap and iounmap, that way we don't get duplicate
definitions from asm-generic/io.h.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
Changes since v2:
 - none
Changes since v1:
 - Add linux/types.h include following report from kbuild

 arch/openrisc/include/asm/io.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/openrisc/include/asm/io.h b/arch/openrisc/include/asm/io.h
index db02fb2077d9..7d6b4a77b379 100644
--- a/arch/openrisc/include/asm/io.h
+++ b/arch/openrisc/include/asm/io.h
@@ -14,6 +14,8 @@
 #ifndef __ASM_OPENRISC_IO_H
 #define __ASM_OPENRISC_IO_H
 
+#include <linux/types.h>
+
 /*
  * PCI: can we really do 0 here if we have no port IO?
  */
@@ -25,9 +27,12 @@
 #define PIO_OFFSET		0
 #define PIO_MASK		0
 
-#include <asm-generic/io.h>
-
+#define ioremap ioremap
 void __iomem *ioremap(phys_addr_t offset, unsigned long size);
+
+#define iounmap iounmap
 extern void iounmap(void *addr);
 
+#include <asm-generic/io.h>
+
 #endif
-- 
2.26.2

