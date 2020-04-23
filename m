Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3073C55191
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 15:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D254A20776
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 15:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="OVK4+lyU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbgDWPpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 11:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729139AbgDWPpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 11:45:10 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D5CC09B040
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 08:45:10 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 145so3118200pfw.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 08:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sHxljxjTpk2oBVN9jqQPNFsunhe5JYr63Xg+w6BjEk0=;
        b=OVK4+lyUyi3K2XxNxns66uFwMhNrBdcne/S7/UEjlw0E22jAQTHxvEqLBeqPOAPxFK
         X+jjDj0hqNMQkWzrHiZfGWnwvGlMB24GNj07YjCI2D3rKZ+5K+DDH+ZhzWUfOxvMYHc+
         bbZBn3S1ZiSTV5hTJmxP8lKXGmBJdbONugF2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sHxljxjTpk2oBVN9jqQPNFsunhe5JYr63Xg+w6BjEk0=;
        b=jTObNV3jnOQXlEnQmOznJO8A/wSpJzttEvaGHnK1tWvS3/DHlq2qX/Lv8ZkvsZT0us
         Dj48JylvMCKzqtfyaQPIWtRoXxORrz9xmUI7TQnpyz4n70mFvaFO/eVMLCLunzOxwsLl
         bI+bb7z7fFbPU/MgzV+r8T3zUL0WsqZEPAKTZJEevMVWYouCj6fJsjH18oJTYULiwhxM
         VcSPom7zZxuQeIPrYLakSFYQHfu/VmS5IHfwVpgWT83DO1mZIz+kbtTgFbcn/FfcVD+W
         1kOh2QloO2ae+lNUiqLb0CZfoDuCowDMc8En4zDItKa9HWdNytu3bwNihaezz48e2ADE
         OQCQ==
X-Gm-Message-State: AGi0PuYJedGq7SbAA6KhxKFUA+7OsZS53Rr/51yhzdkQHNOTdvj+OW2n
        Kf38XpZMBa+MSObfQ4Q0OqgdfDzDtDw=
X-Google-Smtp-Source: APiQypL2rXvy7qGsCVugJpqQ0AJTu54mjBe+WV8wdzmBABoHEz5ipyihDvyYwh/78HYmZ4bBDKu+Ww==
X-Received: by 2002:a63:7805:: with SMTP id t5mr4611238pgc.141.1587656709247;
        Thu, 23 Apr 2020 08:45:09 -0700 (PDT)
Received: from localhost (2001-44b8-111e-5c00-7979-720a-9390-aec6.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:7979:720a:9390:aec6])
        by smtp.gmail.com with ESMTPSA id u15sm2645383pjm.47.2020.04.23.08.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 08:45:08 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, kasan-dev@googlegroups.com
Cc:     dvyukov@google.com, christophe.leroy@c-s.fr,
        Daniel Axtens <dja@axtens.net>
Subject: [PATCH v3 0/3] Fix some incompatibilites between KASAN and FORTIFY_SOURCE
Date:   Fri, 24 Apr 2020 01:45:00 +1000
Message-Id: <20200423154503.5103-1-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3 KASAN self-tests fail on a kernel with both KASAN and FORTIFY_SOURCE:
memchr, memcmp and strlen. I have observed this on x86 and powerpc.

When FORTIFY_SOURCE is on, a number of functions are replaced with
fortified versions, which attempt to check the sizes of the
operands. However, these functions often directly invoke __builtin_foo()
once they have performed the fortify check.

This breaks things in 2 ways:

 - the three function calls are technically dead code, and can be
   eliminated. When __builtin_ versions are used, the compiler can detect
   this.

 - Using __builtins may bypass KASAN checks if the compiler decides to
   inline it's own implementation as sequence of instructions, rather than
   emit a function call that goes out to a KASAN-instrumented
   implementation.

The patches address each reason in turn. Finally, test_memcmp used a
stack array without explicit initialisation, which can sometimes break
too, so fix that up.

v3: resend with Reviewed-bys, hopefully for inclusion in 5.8.

v2: - some cleanups, don't mess with arch code as I missed some wrinkles.
    - add stack array init (patch 3)

Daniel Axtens (3):
  kasan: stop tests being eliminated as dead code with FORTIFY_SOURCE
  string.h: fix incompatibility between FORTIFY_SOURCE and KASAN
  kasan: initialise array in kasan_memcmp test

 include/linux/string.h | 60 +++++++++++++++++++++++++++++++++---------
 lib/test_kasan.c       | 32 +++++++++++++---------
 2 files changed, 68 insertions(+), 24 deletions(-)

-- 
2.20.1

