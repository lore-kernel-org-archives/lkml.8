Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7327CC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 21:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41BB12145D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 21:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="otua9GyR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgGDVLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 17:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbgGDVLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 17:11:47 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB03C061794
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 14:11:47 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d10so13846847pls.5
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 14:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J6EJlawjImDE63imtxxJcgcytWPaMqFso/hm17V2M4g=;
        b=otua9GyRB3AOXdss6qXm7gsiZ44Nja4IiddEnzSevFVuPTBUx7L8uQlwWyWBpnzk6L
         i5UNY+Mko6Cb8M3jivPN4n9GOK28L3NkBHQtimB1C+MkqZ1rI+KUjSjLToDG9HkVLHjc
         nzX8n0SegZufIB5fEfYkOPQkJ2Y6YcbYgwHNKTk/kyBQx64d3b1+4E/yXeHy56mgrtUF
         pjKMbgAYXVFfevwciWSsb1CIJZBk+y9W37avzqOVnpkao2et3K7JbsvtURmf/6Fq+wfB
         DscczvyMGhhLixNFzWO33bwbGxYDSt2B2A0ysQAEJv8qi68qHpBRimFkC+PnSz4CfUnT
         hMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J6EJlawjImDE63imtxxJcgcytWPaMqFso/hm17V2M4g=;
        b=UM0WLY1TGKt6sX9H1SO+lRbyCWpqZvamX5JyDaFA7For9ldyWNXDMEuC4wZGJP+Im1
         X3xc14FBu/dgAzmTOxUex5jYsD/KcDCshCc9VS2uKp/4rj8DMEc59tPIWG/8A/ppuTPY
         4HQ2J0RJeDjlfT5zEzfqVPrah9f3U2XEJlS/PBJMiqpzCbSHfFGplXNLbrTZb99IsNjW
         GzQ0Y2hJdQxQcVB3ZqdugnvCqUYCrKzzrUao10GgGPZFCbPa7wMjCEYOlEdMpShnyDoj
         uMuEa77vzJgbWATO1FanlzivIZww8k80CRSzzuBHzxRDjKq1xaIv1lMOyBJNMg3CmNsu
         75Og==
X-Gm-Message-State: AOAM5315Er6BJlfTpwGZQaFljVlx69xzEU4SCRe+bafOl/Yx/CEwrNdZ
        S8Lju7t1v8+VI8aDM1wFZ+ybd7HF+t8=
X-Google-Smtp-Source: ABdhPJypCNMagu9ONuK7HxU5+66uo/7c98pozb1tC1erONTN6pfRGt9sGcQlGwcV0bI5KXXFYCqkgQ==
X-Received: by 2002:a17:902:7b89:: with SMTP id w9mr24274087pll.175.1593897106786;
        Sat, 04 Jul 2020 14:11:46 -0700 (PDT)
Received: from localhost (g2.222-224-226.ppp.wakwak.ne.jp. [222.224.226.2])
        by smtp.gmail.com with ESMTPSA id t1sm14905119pje.55.2020.07.04.14.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 14:11:46 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        openrisc@lists.librecores.org
Subject: [PATCH] openrisc: Add support for external initrd images
Date:   Sun,  5 Jul 2020 06:11:34 +0900
Message-Id: <20200704211136.601768-1-shorne@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In OpenRISC we set the initrd_start and initrd_end based on the symbols
we setup in vmlinux.lds.S.  However, this is not needed if we use the
generic linker description in INIT_DATA_SECTION.

Removing our own initrd setup reduces code, but also the generic code
supports loading external initrd images.  A bootloader can load a rootfs
image into memory and we can configure devicetree to load it with:

        chosen {
                bootargs = "earlycon";
                stdout-path = "uart0:115200";
                linux,initrd-start = < 0x08000100 >;
                linux,initrd-end = < 0x08200000 >;
        };

Reported-by: Mateusz Holenko <mholenko@antmicro.com>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/setup.c       |  8 +++++---
 arch/openrisc/kernel/vmlinux.lds.S | 12 ------------
 2 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
index 8aa438e1f51f..b18e775f8be3 100644
--- a/arch/openrisc/kernel/setup.c
+++ b/arch/openrisc/kernel/setup.c
@@ -292,13 +292,15 @@ void __init setup_arch(char **cmdline_p)
 	init_mm.brk = (unsigned long)_end;
 
 #ifdef CONFIG_BLK_DEV_INITRD
-	initrd_start = (unsigned long)&__initrd_start;
-	initrd_end = (unsigned long)&__initrd_end;
 	if (initrd_start == initrd_end) {
+		printk(KERN_INFO "Initial ramdisk not found\n");
 		initrd_start = 0;
 		initrd_end = 0;
+	} else {
+		printk(KERN_INFO "Initial ramdisk at: 0x%p (%lu bytes)\n",
+		       (void *)(initrd_start), initrd_end - initrd_start);
+		initrd_below_start_ok = 1;
 	}
-	initrd_below_start_ok = 1;
 #endif
 
 	/* setup memblock allocator */
diff --git a/arch/openrisc/kernel/vmlinux.lds.S b/arch/openrisc/kernel/vmlinux.lds.S
index 60449fd7f16f..22fbc5fb24b3 100644
--- a/arch/openrisc/kernel/vmlinux.lds.S
+++ b/arch/openrisc/kernel/vmlinux.lds.S
@@ -96,18 +96,6 @@ SECTIONS
 
         __init_end = .;
 
-	. = ALIGN(PAGE_SIZE);
-	.initrd			: AT(ADDR(.initrd) - LOAD_OFFSET)
-	{
-		__initrd_start = .;
-		*(.initrd)
-		__initrd_end = .;
-		FILL (0);
-                . = ALIGN (PAGE_SIZE);
-	}
-
-        __vmlinux_end = .;            /* last address of the physical file */
-
 	BSS_SECTION(0, 0, 0x20)
 
         _end = .;
-- 
2.26.2

