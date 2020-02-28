Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33167C3F2D0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 01:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B98B21556
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 01:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VXCVjRFV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730551AbgB1BVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 20:21:00 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:54894 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730469AbgB1BU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 20:20:59 -0500
Received: by mail-pf1-f202.google.com with SMTP id v14so820369pfm.21
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 17:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gfPIObcjKoc/X97Hku0RqtasQR2kVC34gv6DKj0xOtc=;
        b=VXCVjRFV1YqUz/8wn7l00lvSHg2xQqUpVRtpFdlra5OC8OF0q0/3b0I8oE3nzS0B4c
         tupmvt08U9uuorUzoZ1eYDtNg1U63jqDJ0ibGa1taWf7raFaAzoV4BPv3Tg2m4KnmZov
         V6tpQRa0TMh7UERsCUCTWUWO8SYLoaBeDSCw/OQ+60WXxiMfaBmIcZRNfSDrrnjURMK6
         m5775Jw2akrEorxQ6H656cKfbZOHEhm9xqa5dDLNBIKMPYG/okbS3dxAbLcir1Asizeo
         EmLpGy2DdoKfflEyZLFp6qL14aA0ICqAugWB/JNN5PCwqLQlbpj/EvCmMHCfEdUzY9iN
         cWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gfPIObcjKoc/X97Hku0RqtasQR2kVC34gv6DKj0xOtc=;
        b=cInnXsrawpaurvvwplwHfq4X5ikAb1Wb0Jd0C/zEyfp/ioQdAxF5G8q2MbpCiL6np9
         05UO+fXTkFJg5MvgmpqXchHlabH978ScsdAcw9C9BIjKp7mAPudKbiXBCMxAqkJSO7Gx
         3+wGoG8J258Tq9F56KzK9gTIQctCMAmNBLP0STphzq1pl+AYyC0fSQrCAFPLugHz9ARE
         9imaSEtQJDpeqeWfdslwvwMohg9DzhVRihQrx85xLuYdvEFzDHlZXWqk1taihbb2mkrp
         m7DDb8Y9Pea8wolIB8rnKqwySMRxAoqVEWzvk/jFhVE9FsgINBN/UHQsxCkeS8b94Vi5
         x4Yg==
X-Gm-Message-State: APjAAAUvmtFdJ4v1TKrWZCULv0pjeAw3A7nljLpwLfZ+CGG/Bpk2vzym
        hTaLHLf+cnu2sVpg8oc4o6hq2xcXeBXRiPQp5vV8PA==
X-Google-Smtp-Source: APXvYqypNGxK7wTo1FTf1mIFjhr0aXSAgo4WiptbW+IYOxodMeIGcqOB36P6zCIg73RrYOnWUywb6RzPCsqA6rNjpwfVnA==
X-Received: by 2002:a63:7f17:: with SMTP id a23mr2129453pgd.47.1582852857820;
 Thu, 27 Feb 2020 17:20:57 -0800 (PST)
Date:   Thu, 27 Feb 2020 17:20:30 -0800
In-Reply-To: <20200228012036.15682-1-brendanhiggins@google.com>
Message-Id: <20200228012036.15682-2-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200228012036.15682-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH v3 1/7] vmlinux.lds.h: add linker section for KUnit test suites
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com,
        frowand.list@gmail.com
Cc:     gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com,
        mcgrof@kernel.org, linux-um@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
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
2.25.1.481.gfbce0eb801-goog

