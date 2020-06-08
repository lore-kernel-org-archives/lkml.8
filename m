Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A08C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 20:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1A342078C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 20:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KYzOYiQt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgFHUia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 16:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbgFHUi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 16:38:29 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0F4C08C5C3
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 13:38:28 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k186so22326414ybc.19
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 13:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5otuoY2gGErOy9A+cbCl1OR8KmTp9iNB+S30IArJGxY=;
        b=KYzOYiQt3FGzO24Ji/cgJDS2qf8jKUBMSw0hou1XPe1iZ0NlVNuyLLK6BVkY7wpIEr
         4nju/eU6yQqj6iQg3Pj88h6aC9XpeUhO6aRvg/Z3EHx1d3uJqRlPI36O1665sP+Riv3V
         ORNQ/AVH79J0kEBSAxKrGpHIofF7rH4KVneMUC+7Lz8w5qRoCdxfnJ7Bs5IV5yMtTbtq
         +z/X8TVEvqXJL+EzAMEnLS03+TpJtP2O5tmH70OLnKM6p5Fv0DS2LhNfQRWuO3vIAsHd
         VrTGN6E7yLxjULQgMxXdaUowGrlPR4ev7g6d3XZ4mLcwIUCfXE4ic5pRxQymDSQFJ4Ja
         MnZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5otuoY2gGErOy9A+cbCl1OR8KmTp9iNB+S30IArJGxY=;
        b=HZU3ipCnrlz+5o+i3XM6gZsSXeF9qPjj1M6TiIxar9vWBy27uNveaRn0hNSJphQ2tc
         t/NHZpGcp+95DxipsYWhJL687GFlErOxsBvpkKgSkCansNmYhMgMst8y7VThahmEJJ7k
         1EqlyI1gwHw44WkChikh2MpgkYsldqx7V3bliC+S5KUjgOYLa976faBGW2bOfwN7imb0
         b5S6XgJb+Pc+nyJYiptyy0YxUUI7iJsiPPpFD15vOzl7ajpMzq/2iuy4TQJZ4nr/doRO
         sDvHKJdwZC/iF2Y62CLiz14LeBfh5Ma4N5y36c1okmcxTjak2I2qUO+GCXVdEeqFpgYZ
         GEqg==
X-Gm-Message-State: AOAM533sNpZEXaX+GghcQOJiNFXxJTjnrMlqvlM+1mYxBaPEl27rDZOd
        PcX3xEXDZV+VZe/Lv5mMwCyPwPXo116GnKM3T9w=
X-Google-Smtp-Source: ABdhPJwMCfh6+j1JcOF7Ui/FzLouS0/CmQh3VYSy0Ww5vOQqYGp9/ZKrVXazWyjuLYCs7jqttRbM/Z4w4upIk0lRVbk=
X-Received: by 2002:a5b:54e:: with SMTP id r14mr956210ybp.93.1591648707480;
 Mon, 08 Jun 2020 13:38:27 -0700 (PDT)
Date:   Mon,  8 Jun 2020 13:38:17 -0700
In-Reply-To: <CAKwvOdnBhHnhUZ9MHgqEQ4nEyzHWUH+DPV-J0KoYyWNEnsDHbg@mail.gmail.com>
Message-Id: <20200608203818.189423-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <CAKwvOdnBhHnhUZ9MHgqEQ4nEyzHWUH+DPV-J0KoYyWNEnsDHbg@mail.gmail.com>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH v2] arm64: acpi: fix UBSAN warning
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>, stable@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Enrico Weigelt <info@metux.net>,
        Allison Randal <allison@lohutok.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Will reported a UBSAN warning:

UBSAN: null-ptr-deref in arch/arm64/kernel/smp.c:596:6
member access within null pointer of type 'struct acpi_madt_generic_interrupt'
CPU: 0 PID: 0 Comm: swapper Not tainted 5.7.0-rc6-00124-g96bc42ff0a82 #1
Call trace:
 dump_backtrace+0x0/0x384
 show_stack+0x28/0x38
 dump_stack+0xec/0x174
 handle_null_ptr_deref+0x134/0x174
 __ubsan_handle_type_mismatch_v1+0x84/0xa4
 acpi_parse_gic_cpu_interface+0x60/0xe8
 acpi_parse_entries_array+0x288/0x498
 acpi_table_parse_entries_array+0x178/0x1b4
 acpi_table_parse_madt+0xa4/0x110
 acpi_parse_and_init_cpus+0x38/0x100
 smp_init_cpus+0x74/0x258
 setup_arch+0x350/0x3ec
 start_kernel+0x98/0x6f4

This is from the use of the ACPI_OFFSET in
arch/arm64/include/asm/acpi.h. Replace its use with offsetof from
include/linux/stddef.h which should implement the same logic using
__builtin_offsetof, so that UBSAN wont warn.

Link: https://lore.kernel.org/lkml/20200521100952.GA5360@willie-the-truck/
Cc: stable@vger.kernel.org
Reported-by: Will Deacon <will@kernel.org>
Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes V1 -> V2:
* Just fix one of the two warnings, specific to arm64.
* Put warning in commit message.

 arch/arm64/include/asm/acpi.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index b263e239cb59..a45366c3909b 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -12,6 +12,7 @@
 #include <linux/efi.h>
 #include <linux/memblock.h>
 #include <linux/psci.h>
+#include <linux/stddef.h>
 
 #include <asm/cputype.h>
 #include <asm/io.h>
@@ -31,14 +32,14 @@
  * is therefore used to delimit the MADT GICC structure minimum length
  * appropriately.
  */
-#define ACPI_MADT_GICC_MIN_LENGTH   ACPI_OFFSET(  \
+#define ACPI_MADT_GICC_MIN_LENGTH   offsetof(  \
 	struct acpi_madt_generic_interrupt, efficiency_class)
 
 #define BAD_MADT_GICC_ENTRY(entry, end)					\
 	(!(entry) || (entry)->header.length < ACPI_MADT_GICC_MIN_LENGTH || \
 	(unsigned long)(entry) + (entry)->header.length > (end))
 
-#define ACPI_MADT_GICC_SPE  (ACPI_OFFSET(struct acpi_madt_generic_interrupt, \
+#define ACPI_MADT_GICC_SPE  (offsetof(struct acpi_madt_generic_interrupt, \
 	spe_interrupt) + sizeof(u16))
 
 /* Basic configuration for ACPI */
-- 
2.27.0.278.ge193c7cf3a9-goog

