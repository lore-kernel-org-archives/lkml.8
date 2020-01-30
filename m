Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609F6C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 23:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 320E02083E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 23:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AfGGk98b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbgA3XIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 18:08:35 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:43858 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727617AbgA3XId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 18:08:33 -0500
Received: by mail-pf1-f202.google.com with SMTP id x199so2762684pfc.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 15:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XuQcSLVF/Hrh3GBoBCfa3f7wfs7J5i1pjasDMgobHXc=;
        b=AfGGk98bnxyyqHcpetjQvX41oGap4DIh7+0oNSJEg2O3R1PQCiDZZtdDhFMDnBhxK0
         /1IpRPnzmNWZWCdDA+YmoH11+yZ8yuUmpOyt1a1C6USU6lfL8qgBToLhsSsLZNa22qcw
         DeN090IVkvjCCffCPn/5OAPM2nRoarPWAvvLk+KM9KuY5bXHOlv/eW4GgopiPEam5w1U
         OoY2SAfbLPxbM5Od+4uzT/fCGGx4M5wAozv3qmR20QB92nwmZRbSl5NMzEqnr0ikTRje
         jyRldGQ6k5yB9GzKUFfikjYirdZINEHE5zYwOZsqejJsbcphEn8KaagiB3vqxnjMBUIk
         K+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XuQcSLVF/Hrh3GBoBCfa3f7wfs7J5i1pjasDMgobHXc=;
        b=FM2dpADKklnLpnfExi5nORyofiTccgHdhgbkV23NYlFndkSptMHQUnF3KZBUNdqsTX
         eIWq80VY93Kn7PcLnccUjpwEtrXInSC1uFca3NaJ0S/IKszdLLBYr7suhBdmieWYhimd
         LcErpvuQyOxVFmWh2hdfFeMLtMg1HkakK2iooNYfyIxCkmhFqzI2HIRdh4bG4iNr6ide
         3tCRBZUwPZ/Lphct2Bj8FUdv3u/rdGZiTChwEMeSz+1PGcUu1rF/FVIixQ4nedV428go
         ODbHPGAas1Pygq7/zUN8CdhFUCCDE+wbgNRCAYMeHLmU81SS4ZMg0Q5KZlrBjylkZwMA
         YQdA==
X-Gm-Message-State: APjAAAV6Sd7WJQsLv3PLsC4DZDwLuFb4xnRlLFkuFJFrmRRiNoCvBFyQ
        rkWZzdPTV2bId62BUFbCphRAd7DPshjIfWD/g3q9UA==
X-Google-Smtp-Source: APXvYqzSRoUUWeQ2bKif6Z40xm7qv0HYLPbmPInMedOryPT9s0Chn/fw7nXAk5QeONDTypQImuUErdEfZqufShGTpuizag==
X-Received: by 2002:a63:e649:: with SMTP id p9mr7159890pgj.15.1580425711922;
 Thu, 30 Jan 2020 15:08:31 -0800 (PST)
Date:   Thu, 30 Jan 2020 15:08:06 -0800
In-Reply-To: <20200130230812.142642-1-brendanhiggins@google.com>
Message-Id: <20200130230812.142642-2-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200130230812.142642-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v2 1/7] vmlinux.lds.h: add linker section for KUnit test suites
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com,
        frowand.list@gmail.com
Cc:     gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com,
        mcgrof@kernel.org, knut.omang@oracle.com,
        linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a linker section where KUnit can put references to its test suites.
This patch is the first step in transitioning to dispatching all KUnit
tests from a centralized executor rather than having each as its own
separate late_initcall.

Co-developed-by: Iurii Zaikin <yzaikin@google.com>
Signed-off-by: Iurii Zaikin <yzaikin@google.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 include/asm-generic/vmlinux.lds.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index e00f41aa8ec4f..99a866f49cb3d 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -856,6 +856,13 @@
 		KEEP(*(.con_initcall.init))				\
 		__con_initcall_end = .;
 
+/* Alignment must be consistent with (kunit_suite *) in include/kunit/test.h */
+#define KUNIT_TEST_SUITES						\
+		. = ALIGN(8);						\
+		__kunit_suites_start = .;				\
+		KEEP(*(.kunit_test_suites))				\
+		__kunit_suites_end = .;
+
 #ifdef CONFIG_BLK_DEV_INITRD
 #define INIT_RAM_FS							\
 	. = ALIGN(4);							\
@@ -1024,6 +1031,7 @@
 		INIT_CALLS						\
 		CON_INITCALL						\
 		INIT_RAM_FS						\
+		KUNIT_TEST_SUITES					\
 	}
 
 #define BSS_SECTION(sbss_align, bss_align, stop_align)			\
-- 
2.25.0.341.g760bfbb309-goog

