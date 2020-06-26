Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C140AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E29B20B80
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZTCAFApe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgFZVKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 17:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgFZVJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 17:09:36 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7054C03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:09:35 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id j3so11224864yba.14
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Nq9F0z4123tt4UqM776+npgcQr2vACSfzkMX0VOkyz8=;
        b=ZTCAFApecEGx44TdgImNQ12qAsrhIjFlqnA7X8OIrt50WQJMdqROa5BvnuDYaE3Lok
         k0Yftw/cS9ECxUbfwTAX99Lpd9yz7y6jnHtBB0aDOCqWldoDru/97LnHSGKESDDgKxlk
         9xdLNvFvVxCLM1TZWYvCMNyDrmmPXKtFf4vogUSxmfH675+a1vyIMc1FOubVKERDE7qT
         9kdv/gVdn6BKAnCWx2ayZphzK6Ug5Ymkk1L+8/qvIJjqaoLD5p3qcuo0W8wff6J2k6XD
         T0qgDLjqpzi8pMoH30nARMyW0khccHFiU17SgAB+7PpX1UNDWCXFmmJy2a9NaPgHv9Wv
         1cDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Nq9F0z4123tt4UqM776+npgcQr2vACSfzkMX0VOkyz8=;
        b=mA+/rbqcjb31EHw+CKYjITFbJwFnlO4D3cdbMNS2oOg7OYV6hq9PwdXlTukl0Em9dQ
         QoPLfU4hBSQjw6MxQLWE3Zg1wfwbcXLH8TF0AG6xWSJXdZojI1rCQOWXMLA9v1S4MP6z
         gR91FWsxnlxVrzdSqv+M+i4FMR+QZXo+HD/ws0MzuG6Hr4b3bW/LNr2Ea2a6a7crs9Lz
         CUzUUXjXqVqWbVTKQLShtuV7GX3lSIMYjO87Lzv3ibEgGiWNUpferOV5adDyDN74xpOl
         1vcebG3rrXAzlITi1e9MJmxX/IQC/YCKbMXs3/FcfyEz0CqlIjCQJA/nfKgYO9pzYKYx
         7M0A==
X-Gm-Message-State: AOAM532+VElTpdzytXMkmsRlSnGma91SE+OYbX2l19m3XWIVtWs94IZs
        pVc1lHFEEEy5G9cAzilEPRI70/JtcyGxMgMKkcrE4g==
X-Google-Smtp-Source: ABdhPJyKnnV47wg6p1lAvgLAC5x+iqxuxiQuXvbI9BMlMWyGeJgFmODnuKaIGhblbFF3wtpirvJDFFjiadtzPLSBo+FHIA==
X-Received: by 2002:a25:dfd6:: with SMTP id w205mr7760830ybg.216.1593205774990;
 Fri, 26 Jun 2020 14:09:34 -0700 (PDT)
Date:   Fri, 26 Jun 2020 14:09:11 -0700
In-Reply-To: <20200626210917.358969-1-brendanhiggins@google.com>
Message-Id: <20200626210917.358969-7-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200626210917.358969-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v5 06/12] arch: xtensa: add linker section for KUnit test suites
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com,
        frowand.list@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        monstr@monstr.eu, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, chris@zankel.net, jcmvbkbc@gmail.com
Cc:     gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com,
        mcgrof@kernel.org, linux-um@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a linker section to xtensa where KUnit can put references to its
test suites. This patch is an early step in transitioning to dispatching
all KUnit tests from a centralized executor rather than having each as
its own separate late_initcall.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 arch/xtensa/kernel/vmlinux.lds.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/xtensa/kernel/vmlinux.lds.S b/arch/xtensa/kernel/vmlinux.lds.S
index d23a6e38f0625..9aec4ef67d0b0 100644
--- a/arch/xtensa/kernel/vmlinux.lds.S
+++ b/arch/xtensa/kernel/vmlinux.lds.S
@@ -216,6 +216,10 @@ SECTIONS
     INIT_RAM_FS
   }
 
+  .kunit_test_suites : {
+  	KUNIT_TEST_SUITES
+  }
+
   PERCPU_SECTION(XCHAL_ICACHE_LINESIZE)
 
   /* We need this dummy segment here */
-- 
2.27.0.212.ge8ba1cc988-goog

