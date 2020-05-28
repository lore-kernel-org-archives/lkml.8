Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11008C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E14A62072D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3zmZYdt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407211AbgE1UZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 16:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407160AbgE1UZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 16:25:21 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AF0C08C5C9
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 13:25:21 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id k11so1339510ejr.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 13:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vj9D4U4So1ra9Zm9hnNGo7stdHYSpNs6NtruFkUFgeo=;
        b=E3zmZYdtbercmnJfSvrDDI6ridE33NN+uQsWunqhChJovqMwGKSriLbHoxawbHzEXQ
         +eDlGG+fA9ztHIbiCOTi3LABNqpyYNnj5rQty16iE4a56ajqyvhqfYLOj73qFYuddNGW
         8ZUzrG8teLBMmFdmjnI8S8UdfPO2LPFaoRyNjOSF8zfAHQeiD1/rDFMVdLRsVWy6K7F7
         j/NSYicLtyRZtsA/mERSN/gsKyfqtgPXQylLMsUhDY9q33RNyK8q61PiKFjHDNf1ZTUQ
         P3uozBML58h+Y9jQU1DBJKpBWW9RTYvR1Z89sgeAb/Ejr442gFu1mrco3Y/N0EimtxUp
         /avg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vj9D4U4So1ra9Zm9hnNGo7stdHYSpNs6NtruFkUFgeo=;
        b=GjLibAiOAvcwu5ubT/gWEN04EUwT6t4eonPx4IVxE1Mfzsmg9S0CKv6kI7dK+8BgNM
         ShSmtcPwR+ajbYcXfW+Ed1IN1QC7jNvYorWKenuImKNjy9yeQvPrY2JfARSWyS9SufYh
         Z+gJonuU+SxHB2r+utN9TMQLN/3IPaj94tVypLArEOdDTpQry6VxDaXVd0D0f0+Mye6g
         /lqHetfhG68XyT98KPZJAVZJcqeI6IYYd4PxAN2ZOOXwjkd0MbC+hoGnuNFWh6IcAMI1
         +qZr4bLR5fsqkaYxHinBAiZcT4tkMSrIwhiUwCFQZs7HBuRsU1STenWSO+ChniBhlBhi
         JbIw==
X-Gm-Message-State: AOAM532mCtvVXIz2I4T33q/36ONhpXmDK7icPjfGCeqbWfIZAo5pTyBf
        MPlApl8GKc1NrQySCWKGT0SYwAuc
X-Google-Smtp-Source: ABdhPJyxygYwCMDCDbCkaTPKRLJt/wgk+OPQ2ueKeQAPPaMxlFmzzsViJTXrlmODFu+/OBCcqlMD8w==
X-Received: by 2002:a17:906:1513:: with SMTP id b19mr3523381ejd.1.1590697519720;
        Thu, 28 May 2020 13:25:19 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:d98f:8461:8d2c:e59b])
        by smtp.gmail.com with ESMTPSA id y13sm5692736ejm.107.2020.05.28.13.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 13:25:19 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH 1/2] m68k,nommu: add missing __user in uaccess' __ptr() macro
Date:   Thu, 28 May 2020 22:25:13 +0200
Message-Id: <20200528202514.27175-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200528202514.27175-1-luc.vanoostenryck@gmail.com>
References: <20200528202514.27175-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The assembly for __get_user() & __put_user() uses a macro, __ptr(),
to cast the pointer to 'unsigned long *' but the pointer is always
a __user one and so this cast creates a lot of warnings when using
Sparse.

So, change to the cast to 'unsigned long __user *'.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 arch/m68k/include/asm/uaccess_no.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/include/asm/uaccess_no.h b/arch/m68k/include/asm/uaccess_no.h
index a24cfe4a0d32..9651766a62af 100644
--- a/arch/m68k/include/asm/uaccess_no.h
+++ b/arch/m68k/include/asm/uaccess_no.h
@@ -60,7 +60,7 @@ extern int __put_user_bad(void);
  * aliasing issues.
  */
 
-#define __ptr(x) ((unsigned long *)(x))
+#define __ptr(x) ((unsigned long __user *)(x))
 
 #define __put_user_asm(err,x,ptr,bwl)				\
 	__asm__ ("move" #bwl " %0,%1"				\
-- 
2.26.2

