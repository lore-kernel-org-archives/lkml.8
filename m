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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE56AC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB895206B5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHGfQeun"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbgHHXHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 19:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgHHXHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 19:07:12 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFC1C061756
        for <linux-kernel@vger.kernel.org>; Sat,  8 Aug 2020 16:07:12 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id o1so2927406plk.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Aug 2020 16:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v96ubfgeahRH8xGlTKbAfEYW4ILSGysT4Aem4Y+4DRg=;
        b=UHGfQeunoKI8TNjHKhq6SxtCDj5fRbVumwksNu3M9FGkMO6gL1/x0kIzB8W7Cd6xvC
         Z2Oimsgnq86gMnsjsqtv02x+WZh7c8Ac8OBbb4t0WL06XnuAoslC0tlV3FKYbTAdVFYx
         UByIxR5jVfnlE4BeNlWoopWo2DclOAZ4iK7++jE3Yu44JPdr8B0pi7IBODNeyJZcM1Ip
         CoZp9SADztLGROWzKjp6Argqzxcu6f3GjCMYxQR1dL6Lo83QnnlqKaId+S21rHh33Pd5
         qF5QwOtS633lncxiwnnkIencIZBK53Z00++fFNoNawpu6vc6OexGut+plnUdgyKLjTY/
         7fcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v96ubfgeahRH8xGlTKbAfEYW4ILSGysT4Aem4Y+4DRg=;
        b=M6KvSW3iN0kcork1gfVTzGKMiLgJVNfZfkaQRslKEc1BwSJFw2ihrUCwfyyHyJphH+
         1ibvs4RXCQCWij7mDVGS0E1aTSeA3TyTG4GUIM784eHQZaGyP9kOGcG4r0FGuyEP5KDv
         cFxSYTAchwueEfseE73F+w68flQGoKxckMl+SQJF3tWN2qoZC71aJs9HZhrXBMXLkk4i
         DsC5hk+rve2j/81NwR1RXzBCPPKlXgY9N6ubDCzbhuhAGkwWurh0SI+viGtE/yCZ6GNs
         ACJ7EvlAL+jxZ53SNyJ0KOhsNWADRURqGXp8hi1YxQnrmaEuZkmUU/Lmedij3YEWb85f
         eTEg==
X-Gm-Message-State: AOAM532gldD7hSBnmbZ8UUsq1YPP4I5tn86luLQPutyd2SnhLvRmJy+B
        660lCDBQX6os1htr9VurR5MXZZP7
X-Google-Smtp-Source: ABdhPJxfxpXKG4evtY3F05L1qrOvO5+c1PsTIaEV4Zb/OkJutfClX/gf4pKFJ0ihIvJEGSrLf2F42g==
X-Received: by 2002:a17:90a:8a90:: with SMTP id x16mr19978495pjn.89.1596928032077;
        Sat, 08 Aug 2020 16:07:12 -0700 (PDT)
Received: from localhost (g223.115-65-55.ppp.wakwak.ne.jp. [115.65.55.223])
        by smtp.gmail.com with ESMTPSA id 144sm17368728pfu.114.2020.08.08.16.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2020 16:07:11 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Stafford Horne <shorne@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: [PATCH v3 4/6] openrisc: uaccess: Remove unused macro __addr_ok
Date:   Sun,  9 Aug 2020 08:06:45 +0900
Message-Id: <20200808230647.833047-5-shorne@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200808230647.833047-1-shorne@gmail.com>
References: <20200808230647.833047-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit b48b2c3e5043 ("openrisc: use generic strnlen_user()
function") the macro __addr_ok is no longer used.  It is safe to remove
so this patch removes it.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/include/asm/uaccess.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/openrisc/include/asm/uaccess.h b/arch/openrisc/include/asm/uaccess.h
index 4b59dc9ad300..85a55359b244 100644
--- a/arch/openrisc/include/asm/uaccess.h
+++ b/arch/openrisc/include/asm/uaccess.h
@@ -55,9 +55,6 @@ static inline int __range_ok(unsigned long addr, unsigned long size)
 	return size <= fs && addr <= (fs - size);
 }
 
-/* Ensure that addr is below task's addr_limit */
-#define __addr_ok(addr) ((unsigned long) addr < get_fs())
-
 #define access_ok(addr, size)						\
 ({ 									\
 	__range_ok((unsigned long)(addr), (size));			\
-- 
2.26.2

