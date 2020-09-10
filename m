Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CABC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FD7420770
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DaWHts7u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730328AbgIJIX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730085AbgIJINa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:13:30 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC33C06179E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:13:07 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id b17so2669187pji.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=d6gpDdMtT2tdp8xTHPaHC5JAlYMUQ3HEqBOe763/EsE=;
        b=DaWHts7ul2rTOkzR0fXiKsZlAxJcEryhI52h1vKi4+m0kudoCx3/Q/QNH5H71lJ/c+
         QpYqw9v9/g1q4MtgtVEYPtR1x213rMw/En9kNxknzYnUquuYfsrSQAaAeUx4JuQDWGi0
         Z4a+O/or/BOQwf4zD8fC8FNX0MFFTsNjMSL5ukXvCw3GNGSq4bn3jpNbKbL1TogeNIrK
         S4U1wMBttaOIwMQkQ+91X08YczsrQ+jJdojoMKu2bnSVc8ZSg2eDDGZ6/uxAhMC94oDp
         3sFzh/HL8mlVXPl9CmjOhir3+8Q3sTyntfV9EHVGgLlWgqokpCUbYxgsN+EVJ+FLGm8A
         MpGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d6gpDdMtT2tdp8xTHPaHC5JAlYMUQ3HEqBOe763/EsE=;
        b=RsKAgaVKYg6lkgkOUajQ9T+FhkNEVaL79iVteE4UGXDzpvD1cEbuRVnm8TjKA8pm3F
         qTIwbJ1anUj6mUZDWMG5Qt2hbaBkp1Dqhj6m111GZVZPZhRxi7oO7VjJAznFVBrlTj0/
         gMLs6vb2R4cDJ7EaZbsdxrXtAciCh6mULJ1rfbjqo5r/5fqF0fXqA7mgmQjRvKzMxE3V
         jufYp1zKKQE8zQ2PbNZuH/Y51+f6+Q2tnVg8vTAaGsafQDlytxwA+5h6A5cjuPLD5qWU
         Pzx1LZiM8xhsjCjCTXgOXEHZz/zYlQc4THS8JmEOOZhGh0ienkuzsilctmmpzPnwSDdA
         Nrsg==
X-Gm-Message-State: AOAM531AWbpVWoJbvsZ+Wz1C0c2FW7ZgMX41YeHGGV6VCgUvIGs1i10A
        LcpoNGzAv8rRoX8/FAhHA0F7dorj38R8sQdE
X-Google-Smtp-Source: ABdhPJzLRumIn2jSR9F6g6Ma/7kIPbBNBxbQ/SHx0//ffvTub9IiJiyJ/rOfRzcYF0iYwTW/qPLq6Q==
X-Received: by 2002:a17:90a:5283:: with SMTP id w3mr4332541pjh.201.1599725587386;
        Thu, 10 Sep 2020 01:13:07 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id e1sm2196056pfl.162.2020.09.10.01.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 01:13:06 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        palmer@dabbelt.com, paul.walmsley@sifive.com
Subject: [RFC PATCH v7 15/21] riscv: Use CSR_STATUS to replace sstatus in vector.S
Date:   Thu, 10 Sep 2020 16:12:10 +0800
Message-Id: <7a98a3a727b6fee760a6fe0beb4eb2f5f5e6f920.1599719352.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1599719352.git.greentime.hu@sifive.com>
References: <cover.1599719352.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It should use the same logic here in both m-mode and s-mode.

Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 arch/riscv/kernel/vector.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kernel/vector.S b/arch/riscv/kernel/vector.S
index 4c880b1c32aa..4f0c5a166e4e 100644
--- a/arch/riscv/kernel/vector.S
+++ b/arch/riscv/kernel/vector.S
@@ -32,7 +32,7 @@
 
 ENTRY(__vstate_save)
 	li      status, SR_VS
-	csrs    sstatus, status
+	csrs    CSR_STATUS, status
 
 	csrr    x_vstart, CSR_VSTART
 	csrr    x_vtype, CSR_VTYPE
@@ -53,13 +53,13 @@ ENTRY(__vstate_save)
 	REG_S   x_vl, RISCV_V_STATE_VL(vstatep)
 	REG_S   x_vcsr, RISCV_V_STATE_VCSR(vstatep)
 
-	csrc	sstatus, status
+	csrc	CSR_STATUS, status
 	ret
 ENDPROC(__vstate_save)
 
 ENTRY(__vstate_restore)
 	li      status, SR_VS
-	csrs    sstatus, status
+	csrs    CSR_STATUS, status
 
 	li      m_one, -1
 	vsetvli incr, m_one, e8, m8
@@ -79,6 +79,6 @@ ENTRY(__vstate_restore)
 	csrw    CSR_VSTART, x_vstart
 	csrw    CSR_VCSR, x_vcsr
 
-	csrc	sstatus, status
+	csrc	CSR_STATUS, status
 	ret
 ENDPROC(__vstate_restore)
-- 
2.28.0

