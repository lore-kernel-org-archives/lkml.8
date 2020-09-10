Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44ABEC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF85F2074B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="gFxw0O2i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730176AbgIJIZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730077AbgIJIOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:14:11 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023B1C0617A3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:13:21 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id c3so540566plz.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WcdZYdMEIHKAJf7V6BNJ8N7QqP1cj59N2jvisfvLOK4=;
        b=gFxw0O2iyGtEjTc+9vvle+GWK8/rBNO9iGBU3yKPmjiPdrqufT2gnaJRq4oZm/lkEm
         +6apTQDPsbANW06VDwmJhuHosOE+pvEIwBCAE/JP7aseIrCBlV/nYsxBaMjvKjrY6o0D
         Kx1sqytMU01sbHmiNizSeDM0UVbAPNpm+8hegfub/N48P8g4aUTZNW7Xya1fWsexfhui
         CDoGZYyepKxkKIuRc89Zh5dL/ZEj4KaO6RfYdLm6ZC4LgTUdME6v9Oh5YhChKWEN+uUQ
         YPVRzuedyo4meFqusFzwrf0VwAlebw1osL9j5OAKnddoZZfqGLKpVBQk7Kq+7IGALsv4
         Oa2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WcdZYdMEIHKAJf7V6BNJ8N7QqP1cj59N2jvisfvLOK4=;
        b=H2RKv3FtM9Dd616jab9FE94Gh65u8vLP6lZy/4G0+goLU+VkOFaNHXq2GxW4D+XATY
         IxGdq6E8cr2s/wNu3tzYnxpHhm+i/fTdPcgTKJJyl/l8ocEpZKU02kJ3DYMG/EAFawNc
         0uV/AobjZdqtbl44AD0meHaPx+DAKSAicRNBVlZasdigAj9vBNiiLXjG2ILR1/mg5ZBy
         u0MPfJnJVbf0bL5YYeXo63wdXQRjueXOASFEuIHVtPtbIpvW8HDwZkHKJP19ntZnx461
         IBSGCJZFvqbOb0LMzFm5KcxXFJS2TL8Lb+sXhDVnOmlt4xiISA2EBcLJFwIZwg7BA6Uu
         jAnQ==
X-Gm-Message-State: AOAM532RSSIi39Gx90dHML57wdMyiG8ZQ+7vcJBGU0ceBZqoCioVdwLe
        PsWjgGo0O6RqFGDLtagZKexlng==
X-Google-Smtp-Source: ABdhPJyl9mhInSAGTEcKRk8ImSnnn8MjUxLE01XUnaBOgRsFK19fKG9dgkD37JtwLKBEt0MAbI48Jg==
X-Received: by 2002:a17:902:aa85:b029:d0:cbe1:e70d with SMTP id d5-20020a170902aa85b02900d0cbe1e70dmr4616487plr.27.1599725600536;
        Thu, 10 Sep 2020 01:13:20 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id e1sm2196056pfl.162.2020.09.10.01.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 01:13:20 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        palmer@dabbelt.com, paul.walmsley@sifive.com
Cc:     Andrew Waterman <andrew@sifive.com>
Subject: [RFC PATCH v7 21/21] riscv: Optimize task switch codes of vector
Date:   Thu, 10 Sep 2020 16:12:16 +0800
Message-Id: <50eb3d9d0a92d6faa39e9fedb941863426daca76.1599719352.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1599719352.git.greentime.hu@sifive.com>
References: <cover.1599719352.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replacees 2 instructions with 1 instruction to do the same thing
. rs1=x0 with rd != x0 is a special form of the instruction that sets vl to
MAXVL.

Suggested-by: Andrew Waterman <andrew@sifive.com>
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 arch/riscv/kernel/vector.S | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/kernel/vector.S b/arch/riscv/kernel/vector.S
index 4f0c5a166e4e..f7223c81b11a 100644
--- a/arch/riscv/kernel/vector.S
+++ b/arch/riscv/kernel/vector.S
@@ -27,8 +27,7 @@
 #define x_vl     t2
 #define x_vcsr   t3
 #define incr     t4
-#define m_one    t5
-#define status   t6
+#define status   t5
 
 ENTRY(__vstate_save)
 	li      status, SR_VS
@@ -38,8 +37,7 @@ ENTRY(__vstate_save)
 	csrr    x_vtype, CSR_VTYPE
 	csrr    x_vl, CSR_VL
 	csrr    x_vcsr, CSR_VCSR
-	li      m_one, -1
-	vsetvli incr, m_one, e8, m8
+	vsetvli incr, x0, e8, m8
 	vse8.v   v0, (datap)
 	add     datap, datap, incr
 	vse8.v   v8, (datap)
@@ -61,8 +59,7 @@ ENTRY(__vstate_restore)
 	li      status, SR_VS
 	csrs    CSR_STATUS, status
 
-	li      m_one, -1
-	vsetvli incr, m_one, e8, m8
+	vsetvli incr, x0, e8, m8
 	vle8.v   v0, (datap)
 	add     datap, datap, incr
 	vle8.v   v8, (datap)
-- 
2.28.0

