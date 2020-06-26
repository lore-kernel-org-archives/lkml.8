Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A689EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8127220B1F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hXaHccps"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgFZVJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 17:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbgFZVJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 17:09:45 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BB1C08C5DD
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:09:45 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f16so11187706ybp.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZQcLA3WWQzWhDh7XNic/G9qqCkpVYvgILX+rlRl11MM=;
        b=hXaHccpsp6kZobMdGnxlDV/X7Kry+BeRbEJjo6PSv+TzhSxzNCAbiEQxcpvIu0jQ8L
         aIB48XrQDZ+QiNiXbv0Tr0hmWU0EQYlwTua6pAg7QhnNvNSxDK0ocJXkRunQ2sD015bM
         oWId+r5Af1n9pl4fkKr5IibcQmAmR4apAJ4uZIU8WR1sYqDviwkes3rwyCeWthb9zehf
         XV/5kHzyY6hTubQkZzHttS+P5N1PNpPDj/TZK4Qtvt0SowvIJbhPF2AgJuVdUA0ZlY6e
         4wzcP9dl+iDa2j5rL0VHxTcew55IqQf2LoFk8FR/CBkw5YHjzH7caV82jF3Q9TVQuEgb
         +SDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZQcLA3WWQzWhDh7XNic/G9qqCkpVYvgILX+rlRl11MM=;
        b=DBx4aUfB/hV3scIAldqFNE/QdH96E/6ZpMabAEjyvF1HkuOZs09Io7j2pkSJa3rleW
         4mXLdkuLedInrGyAI4o5QTbAQevh1glLJykprn0c8N3CQFQALOW+VLBFQrwbVs42QDvK
         Pg9Vf8v95IV6P6yq3sPwxJzJNOaxZmaSp1XpQcnf43/29Pzfv9cu0Pphs98ib2i2ATBB
         A9QA4aFotJzWqC05qKt+5WHPMVf5UyDivP56IgULxmKTwz/8tdhTstXuFWdMtconTP9r
         7oQIcLT7iQnkCKSF346reizo4g/DbarPnjFQMVTHOookH3fLeCD1noTGXaq5b+gPv9tF
         GCcA==
X-Gm-Message-State: AOAM5319jvxtnmHzvw+3saYN6BU+ivPdj+USCHjziP7XTtAtbCupl4G/
        /MtJnh0RuIZN/13zyd5DCVyep5ndBfcn/qzH9VUMhQ==
X-Google-Smtp-Source: ABdhPJzEx7RjdPZqzXf9CzhVsQsR591I98jh+msGVdJdnK9Tt6s9k9B5//bn8b4L1M37+n0TvUsc2u0v5Nr7S59GV+16hQ==
X-Received: by 2002:a25:c5c3:: with SMTP id v186mr7751497ybe.233.1593205784533;
 Fri, 26 Jun 2020 14:09:44 -0700 (PDT)
Date:   Fri, 26 Jun 2020 14:09:16 -0700
In-Reply-To: <20200626210917.358969-1-brendanhiggins@google.com>
Message-Id: <20200626210917.358969-12-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200626210917.358969-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v5 11/12] Documentation: Add kunit_shutdown to kernel-parameters.txt
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

Add kunit_shutdown, an option to specify that the kernel shutsdown after
running KUnit tests, to the kernel-parameters.txt documentation.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index fb95fad81c79a..e7d5eb7249e7f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2183,6 +2183,14 @@
 			0: force disabled
 			1: force enabled
 
+	kunit_shutdown=[KERNEL UNIT TESTING FRAMEWORK] Shutdown kernel after
+			running built-in tests. Tests configured as modules will
+			not be run.
+			Default:	(flag not present) don't shutdown
+			poweroff:	poweroff the kernel after running tests
+			halt:		halt the kernel after running tests
+			reboot:		reboot the kernel after running tests
+
 	kvm.ignore_msrs=[KVM] Ignore guest accesses to unhandled MSRs.
 			Default is 0 (don't ignore, but inject #GP)
 
-- 
2.27.0.212.ge8ba1cc988-goog

