Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E979EC33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 05:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B089C24653
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 05:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVnEndIv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbgAUFdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 00:33:02 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:39343 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgAUFdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 00:33:02 -0500
Received: by mail-pj1-f67.google.com with SMTP id e11so888683pjt.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 21:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TBmFapcCP51v12ZDGyzoq6lMJzVpI9tiiDOrivNq+Hg=;
        b=iVnEndIvNGIyZOZ9RqjwdHY9uDVvwBw4JJKU2ax6fZjyC66osU5fz8+e3ZQYYU0NEE
         /sXWEs4x7EMZoOBdyeh4115F08CiB9HGKEa92/u2jNiSy2gSuSsDe6ydMLLcvpNeMBgb
         SaLnIsJJEGr1HmOxSviZU00da9gwohbe0woK8muvcOZwwHAdd2XEC8HgHYNxZZOCnO6g
         dKINdFN6JesG5erfBKiQXSXrTHYkyTfgPoJtILG6h2ITvJQT+hUhKP27578b+kXrBnY2
         8EwwPwfPI/gvoue/1h8csWrXhKnDy0hd/49wXWZ6JPcjmRCyRhuA41Fj7t9X8s8+XAUU
         /o9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TBmFapcCP51v12ZDGyzoq6lMJzVpI9tiiDOrivNq+Hg=;
        b=JXta24dSBQzTg79TsV89EWt42Da+x2dET2W8YeHE7Cncg/Vd5x9lCYbac1fogTb2Rx
         TJo6vg+j5Co8pOI6Ff3H8mffF2LAtp4Q/DzOGJ2LNRshGr/fUkjfPMz3Wu/536cL1vNe
         wNAFRZPrVfK0PjY8vL2RIC5jhcrSU4NFZkUnjxht4IHhhdfeIBYdzpGQ0HC+vOjBRzmS
         PMvke6uK8h8QQFrp8jPd5Q2BEaV3QBmCp1HC73Sl/lt8Jl7etIOD6rkaW0o65mLghZjQ
         IJ10mVSni/7uaS4acJdOvtHBiAqunqI8+Yul3AsHF61Gq1smBu6DdAn8i6jKOUDgFt6m
         /ZxA==
X-Gm-Message-State: APjAAAUzme1jt3kAlUXl8cMi+djLKnfoNFSIspDPUwU1K6nEU4sy0/7A
        7fbZ6GdlOPxTrY048oZ0ZEs=
X-Google-Smtp-Source: APXvYqwKroEhv0VaxPVuiMrNnT6axI9f0V6DunSlymxW6i94xrEU3F5J8TuYo3jxshWCQYteKZDAKQ==
X-Received: by 2002:a17:90a:c301:: with SMTP id g1mr3290728pjt.88.1579584782048;
        Mon, 20 Jan 2020 21:33:02 -0800 (PST)
Received: from ubuntu.localdomain ([218.189.25.99])
        by smtp.gmail.com with ESMTPSA id b1sm31501216pfp.44.2020.01.20.21.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 21:33:01 -0800 (PST)
From:   wangwenhu <wenhu.pku@gmail.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Fontana <rfontana@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        wangwenhu <wenhu.pku@gmail.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc:     trivial@kernel.org, lonehugo@hotmail.com, wenhu.wang@vivo.com
Subject: [PATCH] powerpc/sysdev: fix compile errors
Date:   Mon, 20 Jan 2020 21:31:13 -0800
Message-Id: <20200121053114.89676-1-wenhu.pku@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: wangwenhu <wenhu.wang@vivo.com>

Include arch/powerpc/include/asm/io.h into fsl_85xx_cache_sram.c to
fix the implicit declaration compile errors when building Cache-Sram.

arch/powerpc/sysdev/fsl_85xx_cache_sram.c: In function ‘instantiate_cache_sram’:
arch/powerpc/sysdev/fsl_85xx_cache_sram.c:97:26: error: implicit declaration of function ‘ioremap_coherent’; did you mean ‘bitmap_complement’? [-Werror=implicit-function-declaration]
  cache_sram->base_virt = ioremap_coherent(cache_sram->base_phys,
                          ^~~~~~~~~~~~~~~~
                          bitmap_complement
arch/powerpc/sysdev/fsl_85xx_cache_sram.c:97:24: error: assignment makes pointer from integer without a cast [-Werror=int-conversion]
  cache_sram->base_virt = ioremap_coherent(cache_sram->base_phys,
                        ^
arch/powerpc/sysdev/fsl_85xx_cache_sram.c:123:2: error: implicit declaration of function ‘iounmap’; did you mean ‘roundup’? [-Werror=implicit-function-declaration]
  iounmap(cache_sram->base_virt);
  ^~~~~~~
  roundup
cc1: all warnings being treated as errors

Signed-off-by: wangwenhu <wenhu.wang@vivo.com>
---
 arch/powerpc/sysdev/fsl_85xx_cache_sram.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/sysdev/fsl_85xx_cache_sram.c b/arch/powerpc/sysdev/fsl_85xx_cache_sram.c
index f6c665dac725..29b6868eff7d 100644
--- a/arch/powerpc/sysdev/fsl_85xx_cache_sram.c
+++ b/arch/powerpc/sysdev/fsl_85xx_cache_sram.c
@@ -17,6 +17,7 @@
 #include <linux/of_platform.h>
 #include <asm/pgtable.h>
 #include <asm/fsl_85xx_cache_sram.h>
+#include <asm/io.h>
 
 #include "fsl_85xx_cache_ctlr.h"
 
-- 
2.17.1

