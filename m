Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1F8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 20:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C0852082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 20:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r4C8omzl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406419AbgFXU7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 16:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389550AbgFXU6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 16:58:16 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC474C0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 13:58:14 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id o84so3619910ybg.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 13:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hiFp+uoptqOZ2rqi90LxI+MqGbDbXrg3yHQVzKDmQQ4=;
        b=r4C8omzldjna6reCrt2PzuMWWZE3IZ2y3f6lclc933vQMY5LTWLxwFuKexT4JvEe9A
         iElOlRcRe7ONH9zL0N4HZ5GBzncNZey4G1Aoed+ZlwUMSzmLjxbt1S7d8G7s/Q1XyI78
         vPZb6jL2BlxrYw6quFHLcZOJf/UggWPfVY4qEsf4A8F6Bru5l+b/GBLsNWCcwZiYHph+
         Dbsa9CXKlN1jQwhe67MA252WId0W7TqOPepmJ+EVxQyaURVV/mC47v+za56p/w4E8JVC
         87eyLI9ICUIfZX+noq394fm9wzUFuOaDtYoDrAvqofPlXjDofFz5QEHCCF1kl+6cQ/sl
         eR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hiFp+uoptqOZ2rqi90LxI+MqGbDbXrg3yHQVzKDmQQ4=;
        b=nVL4fu45GFD4WfPMeMcgjPNrBNg3U268QynZLSzxFS3G/NBWwzHp7uqhCSxQEsHGUy
         lnXdy7/Pytr02GiIOznJaLueg2T0zm+80ScPpym5bVTEBN6rE9rx+Ayv5LuO80jQbINu
         buXKLOagFoDKekfM9FhOjn2UlTUMB4y7VeAdQewpv1ADr411d6mNhou1mKBHdP+5a3dO
         lp2OaYGQF+V+Q1MDcFtmNFsGT++TX+GjPS+IFKUKCT0Xg3m2erHfWdu8ON5c2/z7vzvj
         8cXPQOJp+58FB5vYeIrgu4ddU5bAc9YEjnx8Th19RBoF27gkRrecD/+5LiUmDP8H9obE
         LbEA==
X-Gm-Message-State: AOAM5330Cw4wZoYYsA/6I7FMvEyB1agMBkwFYZztRt6tRVfnktO+ETNR
        1dBeMn5eLgF523mLs66sudEEKegprv+MfDxQ+JbUlA==
X-Google-Smtp-Source: ABdhPJzw0PE1cr6miTcf36AU/8/D6CtmczIAUZsitjQKI4FCtj13PFtWbSnnwhEssKH9DHeczUteecQfDP7L+Nwm+WqoHA==
X-Received: by 2002:a5b:2c7:: with SMTP id h7mr46550583ybp.162.1593032294101;
 Wed, 24 Jun 2020 13:58:14 -0700 (PDT)
Date:   Wed, 24 Jun 2020 13:55:42 -0700
In-Reply-To: <20200624205550.215599-1-brendanhiggins@google.com>
Message-Id: <20200624205550.215599-4-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200624205550.215599-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v4 03/11] arch: microblaze: add linker section for KUnit test suites
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

Add a linker section to microblaze where KUnit can put references to its
test suites. This patch is an early step in transitioning to dispatching
all KUnit tests from a centralized executor rather than having each as
its own separate late_initcall.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 arch/microblaze/kernel/vmlinux.lds.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/microblaze/kernel/vmlinux.lds.S b/arch/microblaze/kernel/vmlinux.lds.S
index df07b3d06cd6b..4fc32f8979a60 100644
--- a/arch/microblaze/kernel/vmlinux.lds.S
+++ b/arch/microblaze/kernel/vmlinux.lds.S
@@ -128,6 +128,10 @@ SECTIONS {
 
 	__init_end = .;
 
+	.kunit_test_suites : {
+		KUNIT_TEST_SUITES
+	}
+
 	.bss ALIGN (PAGE_SIZE) : AT(ADDR(.bss) - LOAD_OFFSET) {
 		/* page aligned when MMU used */
 		__bss_start = . ;
-- 
2.27.0.212.ge8ba1cc988-goog

