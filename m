Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539BAC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 17:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3235F20675
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 17:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+DoMyTT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbgGGRrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 13:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbgGGRrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 13:47:45 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C17C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 10:47:44 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id l12so47463546ejn.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 10:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wJMrhqAOZI1rAIGmuz3pNpw1lglfVRNdM18u67Z4R9s=;
        b=O+DoMyTTlYXbeSxcqJk1RyCWLV123gw/XuJGBKLldr7Kg84n9la7ucrEL9OOvxiKPs
         RaUbwWyEKxzMlt0HtkECU63yvq5dQ1i3I+jBfCU0Xoe8TeT6P1KxG6ucPQzREWMKTVWr
         wKwQe5HMzVd0B0aXl6/L9DbtPAbpsKgpaWkXiBFO0dYJHKeXIoHnI0k0VUHb0YDjvbGk
         luS8tL5s1T/+LLtn+6yKX7u5xJu6kSEe48RCfI/WyZlxq3njmA14LDn8nkYeZQCFY4ES
         QxJDv9aAo43/oEaNhSrIGDjcbn3UQheqmMKLBoatp+0SkS5wch3/RMToTsBGeqbHd92l
         DdYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wJMrhqAOZI1rAIGmuz3pNpw1lglfVRNdM18u67Z4R9s=;
        b=AFA84ZhZKWgTncu6/ZvMW1alfJU59gUDOCAV8NA/HB6gBl2RvexMsAOkgoY0cqQTEB
         4QPUkHfqQpAWk5Ejl67O2/ZJmbxmDQrPAGZ2Q5Z4d8GX8l+ohNk87GdehQADhRMB0Dkz
         qul8+W4wzrxIZjBocvuKjQGR8V7rvUITKdrpOP07hVzo9Y22ujVkyG+yXfLhWlNoC+6C
         hJc8Ub4b6RIrGVri1WWGx+r9XP+0eP+dWNeIUdyzP8j4c5/25o00OOEIJHBNUdHCIQhJ
         2PCVsl1PpCSnxEl2yJaywufa8g4BuescrO+cZLoQrEkNaZ2zMlunW1EEcBRSQkM7CQSS
         gHWg==
X-Gm-Message-State: AOAM532VXmyXeLrEnD9i7i9GBMcvCKAzwb1X/o0xABGK6H1XK+7K7IIS
        bP/y6OtZrwJBg/tSVpzDGUI=
X-Google-Smtp-Source: ABdhPJztWlpGa4X/U1fr4ztkJNe79eHQUH5qajp3MPCcS+rcPIltKHdLIOlOr2n8lOOdH+ljsZQgJw==
X-Received: by 2002:a17:907:7283:: with SMTP id dt3mr50246240ejc.195.1594144063495;
        Tue, 07 Jul 2020 10:47:43 -0700 (PDT)
Received: from localhost.localdomain (93-103-18-160.static.t-2.net. [93.103.18.160])
        by smtp.gmail.com with ESMTPSA id q17sm658636ejd.20.2020.07.07.10.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 10:47:42 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>
Subject: [PATCH] x86/cpu: Use XGETBV and XSETBV mnemonics in fpu/internal.h
Date:   Tue,  7 Jul 2020 19:47:22 +0200
Message-Id: <20200707174722.58651-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current minimum required version of binutils is 2.23,
which supports XGETBV and XSETBV instruction mnemonics.

Replace the byte-wise specification of XGETBV and
XSETBV with these proper mnemonics.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/x86/include/asm/fpu/internal.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 845e7481ab77..fbc7a333b28e 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -636,9 +636,7 @@ static inline u64 xgetbv(u32 index)
 {
 	u32 eax, edx;
 
-	asm volatile(".byte 0x0f,0x01,0xd0" /* xgetbv */
-		     : "=a" (eax), "=d" (edx)
-		     : "c" (index));
+	asm volatile("xgetbv" : "=a" (eax), "=d" (edx) : "c" (index));
 	return eax + ((u64)edx << 32);
 }
 
@@ -647,8 +645,7 @@ static inline void xsetbv(u32 index, u64 value)
 	u32 eax = value;
 	u32 edx = value >> 32;
 
-	asm volatile(".byte 0x0f,0x01,0xd1" /* xsetbv */
-		     : : "a" (eax), "d" (edx), "c" (index));
+	asm volatile("xsetbv" :: "a" (eax), "d" (edx), "c" (index));
 }
 
 #endif /* _ASM_X86_FPU_INTERNAL_H */
-- 
2.26.2

