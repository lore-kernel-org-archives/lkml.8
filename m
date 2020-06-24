Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1515DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 20:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE4D920857
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 20:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ur1fLf5i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389665AbgFXU6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 16:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389320AbgFXU6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 16:58:13 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304D4C061796
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 13:58:13 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id n185so2504385qkc.21
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 13:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9cJ18y40uUPYFZL7TN4SHcIdjwmkZDveAIhoXIvPo38=;
        b=Ur1fLf5iHlKMYZXC1PTBS+I+vVSZLrwtsudyGKcS4apEjTlQlWHIVHccmjstZTZ2A0
         XpAesa/HexpPJ9lkMkGhBnF6Qskxhzu2Ugio6H/p+KIiUclPfy8g1bBrcb7XDtFj1fPA
         VhqqvTyBMz+4f1As4j6RChLXUWDpJpaCKf8s+VcdwMv144usfln+/z4SjWwh8S8wWOIT
         zIFXsZgc2COv4+INh8ZCWPZm65Gi+O1lsnv8GiFgvCUD1bjd/Dw8gnuPmXj6lL0ut1uv
         GSJrpDJHuaTL4yqBLz4GZSN4VLUjQGoPlUwe84SvdDiBJQ8E5KFn34V8W7sRUPNHp5K5
         x9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9cJ18y40uUPYFZL7TN4SHcIdjwmkZDveAIhoXIvPo38=;
        b=ZTRqlOu6hU8PeV+eFXQO3qTiUG+CniF608FyczWQcg0JtpkqGbjj5mE1Ase4crNG1q
         6Vf8c0BePB7Or2flApm1/OfQWv/ffJdV0r6XMDxiOedygbTl5ipEJ+Ipbk/vOU+z8Rer
         qvoqdXcWDi6mtI7MWfOhU7zrop9dLg/NSxZgwOJEQloLdfkNtW28xeQUQYtluHaguajL
         iJ2Gx0zK9NwGoOGwlXQSADTkPKBVs0xFJo2UirGOLLWm7BVw6olC6w7p+0M+lMNJeTDU
         OUMQB5+RwzfOSvGTEO8FE6AtTIgbmZnAOVr2frWL8TZ0ereVRqu/bxLrlLis3+DTade6
         0a7w==
X-Gm-Message-State: AOAM533Y6++opGNMPaZhzF12papmUICIkjzjbNMhaR/oeLfBnfwkLGkW
        EbgLKmAR+jI6rXzORHtj8zO6nONHg6KLMObYXN5iSw==
X-Google-Smtp-Source: ABdhPJxiJGG91wgEwxBBSujXoL0BDsw9UNFVENxNw1T3itcMUFGteR1x45PAf5QA98p+dstOOYTnC7ogGU5jYKFNmTfkvg==
X-Received: by 2002:a0c:b346:: with SMTP id a6mr33657229qvf.142.1593032292307;
 Wed, 24 Jun 2020 13:58:12 -0700 (PDT)
Date:   Wed, 24 Jun 2020 13:55:41 -0700
In-Reply-To: <20200624205550.215599-1-brendanhiggins@google.com>
Message-Id: <20200624205550.215599-3-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200624205550.215599-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v4 02/11] arch: arm64: add linker section for KUnit test suites
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

Add a linker section to arm64 where KUnit can put references to its test
suites. This patch is an early step in transitioning to dispatching all
KUnit tests from a centralized executor rather than having each as its
own separate late_initcall.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 arch/arm64/kernel/vmlinux.lds.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 6827da7f3aa54..a1cae9cc655d7 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -181,6 +181,9 @@ SECTIONS
 		INIT_RAM_FS
 		*(.init.rodata.* .init.bss)	/* from the EFI stub */
 	}
+	.kunit_test_suites : {
+		KUNIT_TEST_SUITES
+	}
 	.exit.data : {
 		EXIT_DATA
 	}
-- 
2.27.0.212.ge8ba1cc988-goog

