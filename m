Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE4EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48D9D20B80
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZVmC9pMZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgFZVJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 17:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbgFZVJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 17:09:47 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E8BC03E97E
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:09:47 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id o15so7470767pgn.15
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/YfJhHqk1scz1aBXF0mupkQea8lbBQgP2jeC+IACUDE=;
        b=ZVmC9pMZrVunA2Fe2R9SmfDjSh6jHe61Xaa87YaHusNTBjJf/LeLbaReVAu2j9TGqG
         DxFNyk3GpI7sLmWMCSdQD7bvz9rONUgJGdF7uQgwV9+yZ/fSaQQKgZ4gmTg7ATax4Vk1
         oV5uEEY5wckV5kA6VI1hcndIeFh/iBm6by2153y7uZEUrlPNuhJOGVBqtgu612iYSDS5
         kqjVhZYud4bB1XAnEHsKMzN8i0QHS6lt4v2+aUunA9LQhB4hkvgOKdZy4uYW9e9c4Pee
         JZVonLmRJ7SKlMenwZofGiFcAJe3AeZZuDV2tMMxx47AoxweQmK1o1oVFzbg31I8w3zR
         nK+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/YfJhHqk1scz1aBXF0mupkQea8lbBQgP2jeC+IACUDE=;
        b=IGyyFrlDv2xwdahl5L2bV3TNNp7JZ0hj+QKdGl6CF8uVR+UvAhN7V6EfhI64At0KWt
         6VZt4sPPSbpVYjl2YKYayE/hETL/esZWa9J/MGLtZidAP6pdY1HCXj6/mOm8g7jeGJct
         orFCCFoEJsdNbKMpcataRbZDzYIDgQyG4b2fKWdrRwrVOoqv2q6MKFReqDw84EcEKeCj
         OtKFq/5w0JCZYOu0phZ5Vm8fVMugcLJQOq2RDKaMjdl3t9r8vgHvI/389m+mwKtu4c4w
         X0Yn40McCWDD+PFwkY2uvHHEy5eYcdT0lcg+8i61MF31++shkqLm3YeEggsCm93lMWln
         0NQg==
X-Gm-Message-State: AOAM531+OJB//Zk2C8/JCTSeuFaeE78eTNyNt2h6PAf8fv5BK/SSdJ/L
        yKEHvc2ouDU9GpUNSWab2LSSxs7i1GxcalydgAJ67Q==
X-Google-Smtp-Source: ABdhPJyHSEr0Zmc7EVSRsW7eDiy4Wfh57qQNf0udG5ob/OtFkSC+pCfiBpVQAOifQwHuQ/h0kM0ynYxDTAXmSlHhH6715Q==
X-Received: by 2002:a65:6707:: with SMTP id u7mr567899pgf.233.1593205786593;
 Fri, 26 Jun 2020 14:09:46 -0700 (PDT)
Date:   Fri, 26 Jun 2020 14:09:17 -0700
In-Reply-To: <20200626210917.358969-1-brendanhiggins@google.com>
Message-Id: <20200626210917.358969-13-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200626210917.358969-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v5 12/12] Documentation: kunit: add a brief blurb about kunit_test_suite
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

Add a brief blurb saying how and when the kunit_test_suite() macro
works to the usage documentation.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 Documentation/dev-tools/kunit/usage.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 3c3fe8b5feccf..961d3ea3ca19a 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -211,6 +211,11 @@ KUnit test framework.
 .. note::
    A test case will only be run if it is associated with a test suite.
 
+``kunit_test_suite(...)`` is a macro which tells the linker to put the specified
+test suite in a special linker section so that it can be run by KUnit either
+after late_init, or when the test module is loaded (depending on whether the
+test was built in or not).
+
 For more information on these types of things see the :doc:`api/test`.
 
 Isolating Behavior
-- 
2.27.0.212.ge8ba1cc988-goog

