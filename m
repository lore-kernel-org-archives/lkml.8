Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1045AC54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 12:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE006208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 12:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOzhWLis"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgDWMkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 08:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726117AbgDWMkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 08:40:43 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9439BC08E934
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 05:40:43 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a5so2423408pjh.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 05:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=amyCoKWGFyLuEA/bxEePIhqknTywhDKjHidw5N4fHCQ=;
        b=UOzhWLis/5Nz8tJmAVys3br9RhE4sy7GVnct1RPL6hSxcIhI2v2if8NXJFXEmE0vbZ
         uDA4Pki3P8pYzfZJ2hmnH6t2LJpMndSmyhLlsTk+sN93/fJASU28gVyM2yKhvOinmNIc
         QdPdreHtjwhlkcht7W5x/46WIwLgbKK9B7XmucluDTfPpdVRdFwSRh/A/eSnK2Bi0fd2
         4/j6h/ZSn5BeSqBtiAuqlVl2CLt3dA4M3BHYa9c+UM4svA6X/EMW3hOACEI0fqlLkcUQ
         FsyFLJBjnUcyctQAOt/cHGsh6Z9Qm1udOpphi/vAmiHaq0LI+QyYSeWv9AeD+APEdOak
         s8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=amyCoKWGFyLuEA/bxEePIhqknTywhDKjHidw5N4fHCQ=;
        b=mvt8SEjkfHnpPu/Y9w4qvSp3e/QgE/YxHpXrs6EIKNqLB8ZnXp37lD1ZA6Wl/fcFgm
         FQcxqxjQuIqCIYeHqJBKQKaEnExwshpfB2EMlW/m5myPINxx9pjcL964ocvSx5932fZE
         J3QEL3vO8mCcf8slLFG7z+umpitz9DHZRAldvSx+mHSkQGYtkZ5jeEYxIAq3AMLPc74A
         owqRgzD05U/Wyi/zQmb/qWEa0hMuWeYYWk40eQmbp4Ox6yW/xlO88eR/LIY7zzXQywoE
         A9gMRbauCid0H2rtByDPVcBH77ru4O5yIRnHJp2Ow45rNTnBBu2c87W2R/TNqUCOfPQ8
         9NeQ==
X-Gm-Message-State: AGi0Pua5bfm+eixPFV14lX2lDwW3pL5YDhSqQy1ITEO/2b3ZrUgpjOcZ
        QrqqQNYI9whXmuUzjxVbSF4=
X-Google-Smtp-Source: APiQypIBU1RHd7Jz0L/Z5JqgMCK58fpUqhGBPfLUw9pTFb1n0lqeEkqgxr8qbJrkDhYOyId+kpDVjw==
X-Received: by 2002:a17:90a:f98b:: with SMTP id cq11mr379808pjb.193.1587645643207;
        Thu, 23 Apr 2020 05:40:43 -0700 (PDT)
Received: from localhost.localdomain ([122.181.63.84])
        by smtp.gmail.com with ESMTPSA id u8sm2248237pjy.16.2020.04.23.05.40.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Apr 2020 05:40:42 -0700 (PDT)
From:   Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
To:     bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com
Cc:     Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] x86: fix build warning int-to-pointer-cast
Date:   Thu, 23 Apr 2020 18:09:48 +0530
Message-Id: <1587645588-7130-3-git-send-email-vamshi.k.sthambamkadi@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587645588-7130-1-git-send-email-vamshi.k.sthambamkadi@gmail.com>
References: <1587645588-7130-1-git-send-email-vamshi.k.sthambamkadi@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix warning on x86_32:
arch/x86/boot/compressed/acpi.c:316:9: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]

This is because on 32 bit, cast of acpi_physical_address(u64) to rsdp
pointer in get_acpi_srat_table() triggers this warning.

Signed-off-by: Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
---
 arch/x86/boot/compressed/acpi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index ef2ad72..2fd81f1 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -280,9 +280,9 @@ acpi_physical_address get_rsdp_addr(void)
  */
 #define MAX_ADDR_LEN 19
 
-static acpi_physical_address get_cmdline_acpi_rsdp(void)
+static unsigned long get_cmdline_acpi_rsdp(void)
 {
-	acpi_physical_address addr = 0;
+	unsigned long addr = 0;
 
 #ifdef CONFIG_KEXEC
 	char val[MAX_ADDR_LEN] = { };
@@ -292,7 +292,7 @@ static acpi_physical_address get_cmdline_acpi_rsdp(void)
 	if (ret < 0)
 		return 0;
 
-	if (kstrtoull(val, 16, &addr))
+	if (kstrtoul(val, 16, &addr))
 		return 0;
 #endif
 	return addr;
-- 
2.7.4

