Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285A6C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED37120B80
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u6J8VuAH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbgFZVJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 17:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgFZVJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 17:09:34 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CD9C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:09:32 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b14so4621847ybq.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0vYZtvNiMw5LFIFKa+iHi1yqO9mFLTJ7LRF4fjft6YQ=;
        b=u6J8VuAHahXAYfZui4sfoaT0dsrVB0g/njRZ5MIakf/7bSZWFoZur8+vHZjZIgvkyd
         rsiis3HuL4AzSgVfpTFGOsNv9/7tHGdL61VbY11KBuBRNquuaThfognGBSG6XDHhjVrh
         liuTo+mvfU3D58KkhDomQtYXookl7U6ajEKfETHE1nWaRN0/gzOUI4z4bMwjPWQ6R2G4
         zVR7MS6jsimbRTLQK965Ww+Cp//ng+4aqqoiGzs9geOb61x+qHK6AUxwcP2HuU1S8dLP
         OEv3lAQzqQIPWit38K3OJmKJ+ONf/s2+d2jSKX83GtbI8ZYL+/awT6qOEcyz2uNC8LpH
         kbaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0vYZtvNiMw5LFIFKa+iHi1yqO9mFLTJ7LRF4fjft6YQ=;
        b=XmTHxhZdI/JYejspbnMHhgfZrKjJPoksOFfEO3LD8Q2477U+IQixBoXJjcHz69LS5S
         gFD5SJp64AmzrC1pt1GTs+aY1WYOyZWqqucavv29pOIl0M2BGaWs+U2ipO7x8Upiuxpz
         kwLMTwCOL4D/fD9G6CGkGl29j+qQmmACNbIjLWJHmbvjNhI3zrQJROHM/1Q7eOItiChM
         6oHK1IIuB0eiQgWxYJ3AActNeZMsULDqmWD2SnQhLL4CxY9GoHGNDEB6ofdMMxkKkm/Z
         uAbapBQaE1qz1+CvbHTfXQiFtAK/DjPzBVURVLziI0idIOqwPk+zaBsQjOERWrLnIIT6
         tc+w==
X-Gm-Message-State: AOAM532n2NXBb9cH8WKSrAusdUNVrhI0NohZaBVzEFBK+k6g5pS0zZtJ
        mWm5jIFDptoG15WZOcFyStwLh/8bBRZMkvMhW2RSXw==
X-Google-Smtp-Source: ABdhPJx4P+f9DA00o4x+xqsn5YNYZSrsnifEZc+MXGWM1Q+GQ6+KAVyhHfpoUwDaYub8VfOW5n9UfKxOSH6ZQNhne0KQ9w==
X-Received: by 2002:a25:99c8:: with SMTP id q8mr7798153ybo.3.1593205771432;
 Fri, 26 Jun 2020 14:09:31 -0700 (PDT)
Date:   Fri, 26 Jun 2020 14:09:09 -0700
In-Reply-To: <20200626210917.358969-1-brendanhiggins@google.com>
Message-Id: <20200626210917.358969-5-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200626210917.358969-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v5 04/12] arch: powerpc: add linker section for KUnit test suites
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

Add a linker section to powerpc where KUnit can put references to its test
suites. This patch is an early step in transitioning to dispatching all
KUnit tests from a centralized executor rather than having each as its
own separate late_initcall.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 arch/powerpc/kernel/vmlinux.lds.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 326e113d2e456..0cc97dbfde0ad 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -202,6 +202,10 @@ SECTIONS
 		CON_INITCALL
 	}
 
+	.kunit_test_suites : {
+		KUNIT_TEST_SUITES
+	}
+
 	. = ALIGN(8);
 	__ftr_fixup : AT(ADDR(__ftr_fixup) - LOAD_OFFSET) {
 		__start___ftr_fixup = .;
-- 
2.27.0.212.ge8ba1cc988-goog

