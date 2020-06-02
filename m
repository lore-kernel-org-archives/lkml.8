Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51983C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 05:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 310BD206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 05:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MNwj43DN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgFBFm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 01:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgFBFm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 01:42:28 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34D9C03E97D
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 22:42:28 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z7so15606232ybn.21
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 22:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=bk5osaVJiGNv6HMFDDoa1BeWBizOC8AFnfdcBnX83HE=;
        b=MNwj43DNaxUfUwQ0rovjHIMZ1fTtleyHscFem2vWH5sI07j7Uv41fBVGKRbTXU0oWw
         j1F4Pwb5+/QYPcVef9jk/i96jtWKgFNe7jRGGUQ6bUOFkLugEihxCBRPmTWNOUioFbFe
         Bd8sM/zraHTpC736DqEwu7g+TQJW61V4ToQakrrYqLPOzbH64L+bUmz6QAUwBq47rLUd
         NhUQR19oBeZ+ny6qikeZL/jYnxwgLcDqHoIzqqLGOKfCg8+73A3BvSjxs7k/ppWJ8w/U
         U5xSqOSp4Tef13PWaNBeZ0un/Tk32Tc5lZ3FaTkFDgU2HKq6pLF+29weT6bmc/e6XCYt
         pofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=bk5osaVJiGNv6HMFDDoa1BeWBizOC8AFnfdcBnX83HE=;
        b=pNl0YCdQTwVOZVzaMf9NV7uQtJHPQOamVRrgngGiIUg9LUUUfsV7i9jvQ3l/rdAcFE
         DgaR4vrm9lIx5tmDwhRFD7hQsqUnvhK4iixB/vsQLtVV3+nrIxNekb4U3mm8NAjCXHsX
         nfnKySOjwbA1EaOLBizf/0b1RcL2ZSWTGv4R0R84bp4f7WAb5dBXwWB3Cd6GWEu1egUq
         c/KLX0Ehs4G+1HzG5d8eADtKebci6aOKgaQakvtaNb3Tlmx4dZponcvbV3t4Khwr4wng
         RcWnoVvefDAQ4WoG466vs3K2ee7Fz2SCTnZ23YA/j6xf8ogB6IXDnhQr7xmwYqTsNzbj
         JihQ==
X-Gm-Message-State: AOAM532oQan33UNaekqdiHdTtizxw5enj1VgVWGn9OKCNx3GPjP87CpN
        pM74h3dBxoKfQyoxiWs8jwBRCgwnXCTEMw==
X-Google-Smtp-Source: ABdhPJx9vDHTXUY+CzoW3/vdoqwLoI1FfZ6/ud5mLimm+OjfZFVFhjoAVLYr/Go8lxvT6G+52qhwMG5A9nIiHQ==
X-Received: by 2002:a25:d295:: with SMTP id j143mr6686782ybg.65.1591076547649;
 Mon, 01 Jun 2020 22:42:27 -0700 (PDT)
Date:   Mon,  1 Jun 2020 22:42:16 -0700
Message-Id: <20200602054216.93122-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.rc2.251.g90737beb825-goog
Subject: [PATCH] Documentation: kunit: Add some troubleshooting tips to the FAQ
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        alan.maguire@oracle.com, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an FAQ entry to the KUnit documentation with some tips for
troubleshooting KUnit and kunit_tool.

These suggestions largely came from an email thread:
https://lore.kernel.org/linux-kselftest/41db8bbd-3ba0-8bde-7352-083bf4b947ff@intel.com/T/#m23213d4e156db6d59b0b460a9014950f5ff6eb03

Signed-off-by: David Gow <davidgow@google.com>
---
 Documentation/dev-tools/kunit/faq.rst | 32 +++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/dev-tools/kunit/faq.rst b/Documentation/dev-tools/kunit/faq.rst
index ea55b2467653..40109d425988 100644
--- a/Documentation/dev-tools/kunit/faq.rst
+++ b/Documentation/dev-tools/kunit/faq.rst
@@ -61,3 +61,35 @@ test, or an end-to-end test.
   kernel by installing a production configuration of the kernel on production
   hardware with a production userspace and then trying to exercise some behavior
   that depends on interactions between the hardware, the kernel, and userspace.
+
+KUnit isn't working, what should I do?
+======================================
+
+Unfortunately, there are a number of things which can break, but here are some
+things to try.
+
+1. Try running ``./tools/testing/kunit/kunit.py run`` with the ``--raw_output``
+   parameter. This might show details or error messages hidden by the kunit_tool
+   parser.
+2. Instead of running ``kunit.py run``, try running ``kunit.py config``,
+   ``kunit.py build``, and ``kunit.py exec`` independently. This can help track
+   down where an issue is occurring. (If you think the parser is at fault, you
+   can run it manually against stdin or a file with ``kunit.py parse``.)
+3. Running the UML kernel directly can often reveal issues or error messages
+   kunit_tool ignores. This should be as simple as running ``./vmlinux`` after
+   building the UML kernel (e.g., by using ``kunit.py build``). Note that UML
+   has some unusual requirements (such as the host having a tmpfs filesystem
+   mounted), and has had issues in the past when built statically and the host
+   has KASLR enabled. (On older host kernels, you may need to run ``setarch
+   `uname -m` -R ./vmlinux`` to disable KASLR.)
+4. Make sure the kernel .config has ``CONFIG_KUNIT=y`` and at least one test
+   (e.g. ``CONFIG_KUNIT_EXAMPLE_TEST=y``). kunit_tool will keep its .config
+   around, so you can see what config was used after running ``kunit.py run``.
+   It also preserves any config changes you might make, so you can
+   enable/disable things with ``make ARCH=um menuconfig`` or similar, and then
+   re-run kunit_tool.
+5. Finally, running ``make ARCH=um defconfig`` before running ``kunit.py run``
+   may help clean up any residual config items which could be causing problems.
+
+If none of the above tricks help, you are always welcome to email any issues to
+kunit-dev@googlegroups.com.
-- 
2.27.0.rc2.251.g90737beb825-goog

