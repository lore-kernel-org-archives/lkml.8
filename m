Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4191EC35246
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 07:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1479B2465B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 07:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vpzib0J5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgA1HUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 02:20:21 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:59553 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbgA1HUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 02:20:18 -0500
Received: by mail-pj1-f74.google.com with SMTP id k8so870263pjs.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 23:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XuQcSLVF/Hrh3GBoBCfa3f7wfs7J5i1pjasDMgobHXc=;
        b=vpzib0J5nj2DND1Cvoora+gxNlK5gAdhGn/MxnEv1DGxNvefQ3cALz+hejiSzvm/kz
         0te1TfEliFbLVQvJUYznkMSGK01039LVFSB9r+iJV1l9dPo+gzbJMyOcH2mgZxmTyt70
         Ylh5PypNoWdZcB1/mA8ew7tua/n8BZNZPi6l0sGOL4enKiRWfvbx0sjlCYm0qzRkNaUE
         JBTFAlidEjkqlvUrc46EMpV+Tyh7821f+lJa1cP65ZKovA0yreplcoZFc3eLrLoJTiDD
         DFfpjDOVoWz5jV5x2/D50lrKtfaFp6mPZAh7QuJTHBiTtuz0ZbzBY2L9w8zfbQIdnPl7
         x44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XuQcSLVF/Hrh3GBoBCfa3f7wfs7J5i1pjasDMgobHXc=;
        b=Ish1qksbsdTIjCLFqYvSQdlU+ue/2WoaQjLeNHK4nXJZCWkgB4grPIqUreNHqLbHXE
         NTy3mSAmKvexfGoOa3mUHh6jMjZrix7TPvuw0vPssz6vPugXg9e05cdjzZISRwzGNZG9
         4uMbQ7VqThsqnmvIUSc+tGP1cDSj+8bvMCtGnSOEraOIrd3cNzTXvHuuZCaM5Er1egye
         8ATjj+Ow0z1ePGMZ9cQMFrd0HPdQq0Y1jK4t9HZXwCWWH3WsEFOUx1mCDKlVrfNKJ0Jg
         DaWel3gJTs7ihJ4hJ03+PRBCosk9/mao/ITGr1c2S7uB37wguIxA81t1NFk/qYEs4NfC
         QURQ==
X-Gm-Message-State: APjAAAV9rC+eQgeTbZ3J0Z3+D13x+T3BkM4p2dVuM2u0orjsh0uc10Ej
        mXtF19l0Y/z8cWU7vASyENmT2rSIFvUP0J0nWPsxkA==
X-Google-Smtp-Source: APXvYqxhr/v1PhdZEF/n7DR85NKPlp1nK8BnB+q0UXQhUtXxUX2SIyir4VRVLjV7DDEFnqw9g+ZcXkVv2G/Rzr1RlAuQdQ==
X-Received: by 2002:a63:1119:: with SMTP id g25mr23427156pgl.359.1580196018089;
 Mon, 27 Jan 2020 23:20:18 -0800 (PST)
Date:   Mon, 27 Jan 2020 23:19:56 -0800
In-Reply-To: <20200128072002.79250-1-brendanhiggins@google.com>
Message-Id: <20200128072002.79250-2-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200128072002.79250-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v1 1/7] vmlinux.lds.h: add linker section for KUnit test suites
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

