Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD6FC2D0EC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 19:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0605820748
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 19:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQ1rrBhz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgDGTJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 15:09:11 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:55875 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgDGTJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 15:09:10 -0400
Received: by mail-pj1-f66.google.com with SMTP id fh8so147282pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 12:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LDxb1cWgmjR2rFQEK0+5JpvDE312cPS2zScBr2bujHE=;
        b=OQ1rrBhzVf0fJC3M4ocRBLsWOLwIev84mAm14MNsK1lJKOeqK2JSQPVIN0X4dgWaMe
         PbXUXIhIddautej6PdwCqFJK0e2lTP+L+YB+8ciP3SM72Phf996FeN091bdS6O1f/PBr
         YLZyGadFtUIbyZEbN3BYBn1Jn5n9lT0+Xupjn3WiTbMtGsoYHmNRQf2wJz8SQbTRXH0O
         +r4uXZ2BdTJVFaujA+96JNAFQMG9KGFwXswQnycKHlmBhF/ywFOhBAZpKjy7AYCgIBkN
         TlBcucvVruI8VPia6fG8s30mOQUpw0cIqGf7B9zZhSBO7K3SVw2ItS+k+aejklwUxcx9
         oykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LDxb1cWgmjR2rFQEK0+5JpvDE312cPS2zScBr2bujHE=;
        b=asHGm9l4EDsZ5mQJ06N4VLY5CEciietnsSzbx56j4BQPVeEpl5eK9lpN/Ks7O7kpKu
         Amq1Pw1vr5fdIf+OcQCGpfmiheJXhi0EDvYq5Xnb+ZpK1rRR9Hiix90KrJR52ffcH8GV
         mG+7J7kW2c2DrPooxo7Jryb9FLLJLahF/N6EoWFGiIsmmjQEHtSkm2ROkbAp79jMhX4O
         nEuIk5uQHoX3xLxD3rKH6j0hoE7oKMw8b2kJ/6PTQrR9zm59o6MvUjp2+a6IfaFvirXz
         DNYkkms6JEwvIeJqx+Ddor7Ry6uziNBSkuezwqsLI59ddF8n4M58Tl7+Jnq32atarNks
         55HA==
X-Gm-Message-State: AGi0PuaHXpS/X3bnL8HcqY2COKPbzvcjsifuR5xNGiCZtPTKdNCDWp26
        QltVb11MiNDufzO/Au/cItoFUiSLLpw=
X-Google-Smtp-Source: APiQypIAweHpsgOBRcq92pnGKdIS++5/gxov6spI1gTUH2o53lpimCMwTYCCEJfCGkDl1fke9lad7w==
X-Received: by 2002:a17:902:8a8f:: with SMTP id p15mr3787069plo.45.1586286549841;
        Tue, 07 Apr 2020 12:09:09 -0700 (PDT)
Received: from jiancai.svl.corp.google.com ([2620:15c:2ce:0:b7ed:16a3:9dc0:21bb])
        by smtp.googlemail.com with ESMTPSA id q12sm13833090pgi.86.2020.04.07.12.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 12:09:09 -0700 (PDT)
From:   Jian Cai <caij2003@gmail.com>
Cc:     caij2003@gmail.com, ndesaulniers@google.com, manojgupta@google.com,
        stefan@agner.ch, Russell King <linux@armlinux.org.uk>,
        Enrico Weigelt <info@metux.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH] ARM: replace the sole use of a symbol with its definition
Date:   Tue,  7 Apr 2020 12:05:57 -0700
Message-Id: <20200407190558.196865-1-caij2003@gmail.com>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ALT_UP_B macro sets symbol up_b_offset via .equ to an expression
involving another symbol. The macro gets expanded twice when
arch/arm/kernel/sleep.S is assembled, creating a scenario where
up_b_offset is set to another expression involving symbols while its
current value is based on symbols. LLVM integrated assembler does not
allow such cases, and based on the documentation of binutils, "Values
that are based on expressions involving other symbols are allowed, but
some targets may restrict this to only being done once per assembly", so
it may be better to avoid such cases as it is not clearly stated which
targets should support or disallow them. The fix in this case is simple,
as up_b_offset has only one use, so we can replace the use with the
definition and get rid of up_b_offset.

Signed-off-by: Jian Cai <caij2003@gmail.com>
---
 arch/arm/include/asm/assembler.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 99929122dad7..adee13126c62 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -269,10 +269,9 @@
 	.endif							;\
 	.popsection
 #define ALT_UP_B(label)					\
-	.equ	up_b_offset, label - 9998b			;\
 	.pushsection ".alt.smp.init", "a"			;\
 	.long	9998b						;\
-	W(b)	. + up_b_offset					;\
+	W(b)	. + (label - 9998b)					;\
 	.popsection
 #else
 #define ALT_SMP(instr...)
-- 
2.26.0.292.g33ef6b2f38-goog

