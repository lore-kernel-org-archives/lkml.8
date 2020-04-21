Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72422C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 05:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 475E8208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 05:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+z3Lwkp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgDUFxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 01:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725881AbgDUFxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 01:53:54 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBADC061A0F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 22:53:52 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id b2so7178557ljp.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 22:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z5Z8TxDpfpq46U3YN9YJd2JyxrStWGfHfkoRCinx7nc=;
        b=E+z3Lwkp7GrGVa6EW6FWpo7WynP0tYQAvY5UQdBxXFLEqa5ntyGpEaYZzgq+4yIxWq
         psdcM+Ni5aNXdBGiZPYXCDv4ky9kexaKWXYZ6pDm4uu5Dymt7mcxHIBKh15FdZ6NwDvt
         VNf8x1Pf03iAbqfHmfl4Ws3n7v7AYW2XcUJXO9GZcf4vsdPRvvvgaf1m0OIXBGZsclrD
         Q0CNbMKqALCXutX6nt7Vjcx3EuO7HUtayChRu8C/bpJ1OhsMswPme8t4Gum/6cCy3GvD
         FzKyVn9XGXVU3w5l7Hm5vcZdXH2w2Uy3tpkCtM/BYF29e70MB05RUZcHINlURUUUj2Vp
         +2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z5Z8TxDpfpq46U3YN9YJd2JyxrStWGfHfkoRCinx7nc=;
        b=pgyOJD8yhIF56lGqxdN2R2SuEsUXFtWkjVzHXPTLEWV2xqf0dwJ99OSEh/NonXrg7R
         BvLbs0I0PGQCgNFSYnqDUq6eqjiqYnBDh7xZT+C0alisymjgryJ8hx5wtP4j/p+/7cWr
         Jz8MMXE8Zb8JdU5Exw9u161zs87d0MeLAyhk4X/GZqE1fTJ7KjPfotF4if+yjDxfqyhk
         uyracmYLq9+ir5/Ko3dIGOdw0yxozifz9FRHoVnVNnuj5EwgCrQyJd5MCZoKpr4y1/ux
         9vn50BDXAY2JX7QNvdpwYUS9zdGF0sDpbTcVkOZDB5IKv3yxH+AUjPtUBDqplrNjhZ7N
         XIcQ==
X-Gm-Message-State: AGi0PuYolr4C+qx6U/9LvSmwgQFEHUcIKiFmhiR19h4kz6P3TLMOYUt/
        0r2NZXjNpGa2opDB0hGwkcIalBV7TkA=
X-Google-Smtp-Source: APiQypKcXreMG0batT3DC5sKK6z4zyYUl8/KDAvOZms4pbzE/nFm/3GUlAVhUcGyloeKGEgXMOUSNQ==
X-Received: by 2002:a2e:a548:: with SMTP id e8mr12307260ljn.151.1587448430689;
        Mon, 20 Apr 2020 22:53:50 -0700 (PDT)
Received: from test.lan ([91.105.39.216])
        by smtp.gmail.com with ESMTPSA id o17sm1177930lff.70.2020.04.20.22.53.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Apr 2020 22:53:50 -0700 (PDT)
From:   Evalds Iodzevics <evalds.iodzevics@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, tglx@linutronix.de,
        ben@decadent.org.uk, Evalds Iodzevics <evalds.iodzevics@gmail.com>
Subject: [PATCH v2] x86/microcode/intel: replace sync_core() with native_cpuid_reg(eax)
Date:   Tue, 21 Apr 2020 11:53:44 +0300
Message-Id: <20200421085344.1804-1-evalds.iodzevics@gmail.com>
X-Mailer: git-send-email 2.17.4
In-Reply-To: <20200420120037.1537-1-evalds.iodzevics@gmail.com>
References: <20200420120037.1537-1-evalds.iodzevics@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Intel it is required to do CPUID(1) before reading the microcode
revision MSR. Current code in 4.4 an 4.9 relies on sync_core() to call
CPUID, unfortunately on 32 bit machines code inside sync_core() always
jumps past CPUID instruction as it depends on data structure boot_cpu_data
witch are not populated correctly so early in boot sequence.

It depends on:
commit 5dedade6dfa2 ("x86/CPU: Add native CPUID variants returning a single
datum")

This patch is for 4.4 but also should apply to 4.9

Signed-off-by: Evalds Iodzevics <evalds.iodzevics@gmail.com>
---
 arch/x86/include/asm/microcode_intel.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/microcode_intel.h b/arch/x86/include/asm/microcode_intel.h
index 90343ba50485..92ce9c8a508b 100644
--- a/arch/x86/include/asm/microcode_intel.h
+++ b/arch/x86/include/asm/microcode_intel.h
@@ -60,7 +60,7 @@ static inline u32 intel_get_microcode_revision(void)
 	native_wrmsrl(MSR_IA32_UCODE_REV, 0);
 
 	/* As documented in the SDM: Do a CPUID 1 here */
-	sync_core();
+	native_cpuid_eax(1);
 
 	/* get the current revision from MSR 0x8B */
 	native_rdmsr(MSR_IA32_UCODE_REV, dummy, rev);
-- 
2.17.4

