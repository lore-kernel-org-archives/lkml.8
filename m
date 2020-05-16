Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8896C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 11:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 822C3206D8
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 11:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgEPLQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 07:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726202AbgEPLQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 07:16:05 -0400
Received: from omr2.cc.vt.edu (omr2.cc.ipv6.vt.edu [IPv6:2607:b400:92:8400:0:33:fb76:806e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2BCC061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 04:16:04 -0700 (PDT)
Received: from mr4.cc.vt.edu (mr4.cc.vt.edu [IPv6:2607:b400:92:8300:0:7b:e2b1:6a29])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id 04GBG3UT011525
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 07:16:03 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id 04GBFw31032456
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 07:16:03 -0400
Received: by mail-qt1-f200.google.com with SMTP id b22so5492701qto.17
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 04:16:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=k9/obJBd4+HStBtbM+iJUkENP4sXP9nPWm+3p30o3YE=;
        b=ZhKSkIBxlzWdcBEq+U+eAjy4bEPM9e8FRmQIl0xppxDRb/KPQPosmkfkT7D8+gPaIX
         7eZoOyJMlz8+1EuWOup8AdPVXH7NUY1QjMOOYj3/7oOJoOSAQxQ3/gcJTFfIQ9ku8gBv
         Xz7ZWI50H6AFDkw5BsBVsPLssQjYu75GcQDT8My4oi0Cf09bC34lk1NXRAh4rvtQt2sS
         ONFiCaa+hAqn3zUYlDKOSRtXKMmRhRkzZqMLJZ4EfmVYK5ATzP7nXZ0zdgZyVq9pHKpH
         07jkcA9BXN1xjK8t7hSehFSBoIocHop7WbAY35vFr7lDXMZuVGnUxBS1r5qFYVlnjOfY
         5qEQ==
X-Gm-Message-State: AOAM533Op91EMzHKUIfuPSznff8bCjqgHk49O+3kw4Bt+m5so8nApzmO
        W5Q21W5e3xegr39rHiDcQiPW8JVU8l7kmkgnes9EK7Ts31K+0l0kkLPuHfxt52XgY1e0HqubSnx
        HjEKd1Rk/sE1lB/Pw+k4jCd7sUNojJ8hoTak=
X-Received: by 2002:a37:ba86:: with SMTP id k128mr7641081qkf.64.1589627758675;
        Sat, 16 May 2020 04:15:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFTWatd4wMNkz5rY9TLgOZzvFBfELb+KWWmmYd0tmx3z31koM938Hgb1b2AkL91HCSatfSEg==
X-Received: by 2002:a37:ba86:: with SMTP id k128mr7641062qkf.64.1589627758346;
        Sat, 16 May 2020 04:15:58 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id c68sm3601815qke.129.2020.05.16.04.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2020 04:15:57 -0700 (PDT)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     David Howells <dhowells@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>
cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] watch_queue: sample: Update makefile to fix deprecated variables
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Sat, 16 May 2020 07:15:56 -0400
Message-ID: <367178.1589627756@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recent commit started warning for deprecated makefile variables.
Turns out there was an in-tree user, so update it.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

diff --git a/samples/watch_queue/Makefile b/samples/watch_queue/Makefile
index eec00dd0a8df..8511fb6c53d2 100644
--- a/samples/watch_queue/Makefile
+++ b/samples/watch_queue/Makefile
@@ -1,7 +1,7 @@
 # List of programs to build
-hostprogs-y := watch_test
+hostprogs := watch_test
 
 # Tell kbuild to always build the programs
-always := $(hostprogs-y)
+always-y := $(hostprogs)
 
 HOSTCFLAGS_watch_test.o += -I$(objtree)/usr/include

