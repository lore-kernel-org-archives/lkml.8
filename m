Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB8BC54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 14:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B13D62071E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 14:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="o941UkGJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgDXOz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 10:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726717AbgDXOz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 10:55:27 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4F3C09B045
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 07:55:27 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id x26so4730277pgc.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 07:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SjOuEDkqyCRoQlGb4r++HBQnM1FePx7k1uf7opXgrlY=;
        b=o941UkGJMnQqHReNMbWxL/s8PxT7Ra9iuzc/rTi6AtklATqfagsoaIerZb4wffLG5F
         lzSYOwYjYqPg3Xr5oTHI3OmLPnG6PAnnyTlhS+ek2U1Qsq/ysubk0lB2C76z+e8TYhQY
         jay5eaXVB37EXo7ewPRPv1NSQ0Narw4Ofb/gw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SjOuEDkqyCRoQlGb4r++HBQnM1FePx7k1uf7opXgrlY=;
        b=Gr6twHPri5SH0Yerl0GOALCfe5wUpy6CEc9bDRrMFGMPOUQ3KJ4TWGYkehdpzwxm2w
         KSSZO4x3JsL+rybC4YRZtiQfbAkxEwSlritzoCeLK+faZ1Fh+QaO1JkyaGUJ0hh39DH/
         IYaoUQQ9pco9RJqzxNLtOZ/xKyHB2g0lbmfHjzKlW1Ka7xX9GeiDP5FktO8r5m2xPxQ9
         mYA5YiSPjkpdc/+wglom/jA/KCRgxmqkRBmGcKMEg2YCkPq1ovGStAsQbwD+itHYVozk
         XBngI++i+WkC3auYN7aKcR9RPtCoof3Pp0b4fXW8iVEHjhccsbCqYMPmdDxYTpfbjWAb
         T2IA==
X-Gm-Message-State: AGi0Puak98AngjO/Xm3N/g3UHKaNIiMnn98asC0q5FZf1cfKtib5m9xp
        rqE+aB8KnEFeEiS+OJQ42FZA+g6f7jQ=
X-Google-Smtp-Source: APiQypJAVNWj9fQBBoGPE6iHQ7TBvOGfksNnnLg93WhVg5iX6nGDZGRRCvk/6/c/yw/BgNehCNS2pw==
X-Received: by 2002:aa7:92cc:: with SMTP id k12mr7642619pfa.184.1587740126558;
        Fri, 24 Apr 2020 07:55:26 -0700 (PDT)
Received: from localhost (2001-44b8-1113-6700-fd06-aa7b-7508-4b8b.static.ipv6.internode.on.net. [2001:44b8:1113:6700:fd06:aa7b:7508:4b8b])
        by smtp.gmail.com with ESMTPSA id 1sm5978738pff.151.2020.04.24.07.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 07:55:25 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, kasan-dev@googlegroups.com
Cc:     dvyukov@google.com, christophe.leroy@c-s.fr,
        Daniel Axtens <dja@axtens.net>
Subject: [PATCH v4 0/2] Fix some incompatibilites between KASAN and FORTIFY_SOURCE
Date:   Sat, 25 Apr 2020 00:55:19 +1000
Message-Id: <20200424145521.8203-1-dja@axtens.net>
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

The patches address each reason in turn.

v4: Drop patch 3, it turns out I created that issue in patch 1!
    Include David's Tested-by.

v3: resend with Reviewed-bys, hopefully for inclusion in 5.8.

v2: - some cleanups, don't mess with arch code as I missed some wrinkles.
    - add stack array init (patch 3)

Daniel Axtens (2):
  kasan: stop tests being eliminated as dead code with FORTIFY_SOURCE
  string.h: fix incompatibility between FORTIFY_SOURCE and KASAN

 include/linux/string.h | 60 +++++++++++++++++++++++++++++++++---------
 lib/test_kasan.c       | 29 +++++++++++++-------
 2 files changed, 67 insertions(+), 22 deletions(-)

-- 
2.20.1

