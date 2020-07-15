Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960F8C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 03:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7198C2070E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 03:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=massaru-org.20150623.gappssmtp.com header.i=@massaru-org.20150623.gappssmtp.com header.b="r83DgT29"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgGODL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 23:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbgGODL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 23:11:27 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E62FC061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 20:11:27 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id d27so627284qtg.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 20:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=43tn4SCdUQPE+RtWwrBeE6OYYiz+sN9YblVYLrd3cSI=;
        b=r83DgT29XWRfj/E7kT6DQYKdCfnI9xI/0edg/bbFkV//C89wvNTd4nIGL/BjrPYIWC
         tvFQi2YYH4+gOuGYcFnVDui7pyAX77p2sV/fCKLn0+80JLmbDB8KYA2MYENTAN4mBcr3
         m3/1fScIkCh8vnuV2VqtumrP7DHivlE2HhB0zm+0VMZuQVgv1yXJuJ9hyZXZaU9bHYpq
         HHpIxZm3rtMT/yRX7tvMg7/N2m9ffCf6LD2oepP8UHxOcpq4DamHysbUISrm7oGUbKHc
         GnJEe4LUjs6ErJS+KTAhjR+Qer6Dsx/R1xoehGnGR1d0rOpqP4FUq8ZAqwSvPvsg1JjS
         TsDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=43tn4SCdUQPE+RtWwrBeE6OYYiz+sN9YblVYLrd3cSI=;
        b=ZP38ww+fLWro1xbEyIPc5E0GaCAEE8TGaw/oVcNCxlxY2DVDhen71qfIkHBwLHOYyk
         JRpHuMg/CUIquVnLzohYIedaQh2zigo1j3PlLfCZPEmfNjgRuVTpMkg7rpiUAiG2mhtq
         KM5jy5292SzTZCK98niTaWHtncJWYEHG6oRsHWAGEWMKoIJXOE2+d3QW1m86rvFWcOMY
         9aMDYipqyzfjf30VCwkY62UAhTz9omHMXMI3s8Cs9hEoMI4lILBtnTdnEh6zspyL6RuG
         7dzfIrAJ4GuFTNWbn9vPY2QrRGLXVoAvCTArVFEEuHO1ex6T1q2Ynb8uEeWrYIYbm8gn
         jqtA==
X-Gm-Message-State: AOAM531WTN4/VhKPbzZAzfE5CXh39zypB+/uAzjDoyLZhW7fNjFjnVkb
        qhsH3tSdtbhHaiXpDq4GlkymoQ==
X-Google-Smtp-Source: ABdhPJz+ERBPdgPWk+4c+xiGhT5xApaA/bLt7Vj/xp0Mu7m61aF81TVotdoVo7ixAdGzSmR3E69gqw==
X-Received: by 2002:ac8:40cd:: with SMTP id f13mr7767036qtm.373.1594782686419;
        Tue, 14 Jul 2020 20:11:26 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id x29sm1269229qtx.74.2020.07.14.20.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 20:11:24 -0700 (PDT)
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     kunit-dev@googlegroups.com
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com, keescook@chromium.org,
        davidgow@google.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [RFC 0/3] kunit: add support to use modules
Date:   Wed, 15 Jul 2020 00:11:17 -0300
Message-Id: <20200715031120.1002016-1-vitor@massaru.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, KUnit does not allow the use of tests as a module.
This prevents the implementation of tests that require userspace.

This patchset makes this possible by introducing the use of
the root filesystem in KUnit. And it allows the use of tests
that can be compiled as a module

Vitor Massaru Iha (3):
  kunit: tool: Add support root filesystem in kunit-tool
  lib: Allows to borrow mm in userspace on KUnit
  lib: Convert test_user_copy to KUnit test

 include/kunit/test.h                        |   1 +
 lib/Kconfig.debug                           |  17 ++
 lib/Makefile                                |   2 +-
 lib/kunit/try-catch.c                       |  15 +-
 lib/{test_user_copy.c => user_copy_kunit.c} | 196 +++++++++-----------
 tools/testing/kunit/kunit.py                |  37 +++-
 tools/testing/kunit/kunit_kernel.py         | 105 +++++++++--
 7 files changed, 238 insertions(+), 135 deletions(-)
 rename lib/{test_user_copy.c => user_copy_kunit.c} (55%)


base-commit: 725aca9585956676687c4cb803e88f770b0df2b2
prerequisite-patch-id: 582b6d9d28ce4b71628890ec832df6522ca68de0
-- 
2.26.2

