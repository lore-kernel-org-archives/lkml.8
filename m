Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53770C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 18:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20A7222BEA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 18:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pdWPzuv9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgH0SJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 14:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgH0SJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 14:09:27 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4FAC061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 11:09:26 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id f24so5723438edw.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 11:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KREGXn4/t3s7e5CIyfiu4egsTwbGYCgvl0gGhBZG56k=;
        b=pdWPzuv9UrrlIrR12iKDrFKTe42OuIvz52MOw7kgtQPkiZbqI3BGx3to2tNYzRE06U
         Yuz6fPRIrlSkVofdwLHn99mxW59bCEkZMLH1YB0U9YPhbY29ZQDaZ5xFvIa1g42QPACa
         W1CmcjSUsUOjsoEoYdSE0LQBkj56GNh/FTj/CWMUcXz1e/AtJ/0ivdmxSZsONtZdNH6T
         Z1Te5DnZEmQo+9DEV4+eWn4C1hyRcaXFQfl6opbKwwfmAJQxnixz/ufCDC/IAxHQeXTM
         ysI/pUnVBJV3esGTnZFXJU2q+0qsN6qrCsAl12udkzMbmfwnDk/kqcLyc2VhfhjmD0H4
         /TVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KREGXn4/t3s7e5CIyfiu4egsTwbGYCgvl0gGhBZG56k=;
        b=uPyy3Jl+3C+WS4B+WWGLHe281CZ4LNXePklDWzxH0Cr5IGdLTBmiPHhltYI1wT+uA5
         0bS1JvVZf/IeD0bzY4c7VP35XdDpu9SW6itO4IHQqzIDT/AtqcobWumqIIn/ktZ1zIri
         yRidWJpRaay3noWVriQ3fxxg+ofKw//7ZV1pPQNxVqNGb81+2yvQSO/kALGrv9aim+IE
         W+n9FZ8/vF2n5CzuwmkiXji+hbL+LwaHQOssXTMmoZo7rhyzU3y8Kq/JnytBecNk39yQ
         9Ciut/vsusNaU7ixz51JVoZ+lKm4MAmADNqSCSVQIdJZkciPHvWo86phjnR3ryTGlK1N
         R25w==
X-Gm-Message-State: AOAM531crqMupFH3RWCr9huIAFuU71lN0mDGFI6hpxjUGQn4FNUqCt8Y
        FmEQLADbMM9YKVRuL8MZCVw=
X-Google-Smtp-Source: ABdhPJxgXfCljZ338/0s5w5roAsKUHCABrlbcFu09jeXbXunC41ZU3nmyJKDq2fA3OJL5ZRFzkneJg==
X-Received: by 2002:a05:6402:15:: with SMTP id d21mr8934841edu.324.1598551765443;
        Thu, 27 Aug 2020 11:09:25 -0700 (PDT)
Received: from localhost.localdomain (93-103-18-160.static.t-2.net. [93.103.18.160])
        by smtp.gmail.com with ESMTPSA id p9sm2432351ejg.120.2020.08.27.11.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 11:09:24 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2] x86: Use xorl %0,%0 in __get_user_asm
Date:   Thu, 27 Aug 2020 20:09:04 +0200
Message-Id: <20200827180904.96399-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xorl %0,%0 is equivalent to xorq %0,%0 as both will zero the
entire register.  Use xorl %0,%0 for all operand sizes to avoid
REX prefix byte when legacy registers are used and to avoid size
prefix byte when 16bit registers are used.

Zeroing the full register is OK in this use case.  xorl %0,%0 also
breaks register dependency chains, avoiding potential partial
register stalls with 8 and 16bit operands.

The patch lowers the size of .fixup section by 20 bytes.

Changes since v1:
- Rewrite commit message.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/include/asm/uaccess.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index ecefaffd15d4..2bffba2a1b23 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -343,7 +343,7 @@ do {									\
 		     "2:\n"						\
 		     ".section .fixup,\"ax\"\n"				\
 		     "3:	mov %[efault],%[errout]\n"		\
-		     "	xor"itype" %[output],%[output]\n"		\
+		     "	xorl %k[output],%k[output]\n"			\
 		     "	jmp 2b\n"					\
 		     ".previous\n"					\
 		     _ASM_EXTABLE_UA(1b, 3b)				\
-- 
2.26.2

