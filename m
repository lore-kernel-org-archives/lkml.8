Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643A8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 22:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C5312075F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 22:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ex7sKimH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgFKWkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 18:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbgFKWkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 18:40:33 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D5DC08C5C3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 15:40:33 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id h95so2979133pje.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 15:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZjAEn4nKeDwCOI4NoTVgqxZ+RNZ5sAp1L4xhdYv5QUg=;
        b=Ex7sKimHh5q8529081uTPjIXy3tydeTnpuedEdA0ahtsKvI4OrC/MBJYUr2NQTgF91
         R6lEAUuDLP5qln0c2ux+a/i909gvDVZLaqJjvH5t1AWf+EtnO43HmbfxIVxYu/OesNWE
         Dr0opOI6Ljqx7BhT8Doxs3JjHnluY7X7e8oWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZjAEn4nKeDwCOI4NoTVgqxZ+RNZ5sAp1L4xhdYv5QUg=;
        b=rEm2JEmo7RndU3L7o1HfyHFCnLHFoIcj0krJ6kkcEbuB+6IE6JvMBFhSeX0V15aOhZ
         J7/gIJb2uDP12laJYUqhkcyK5ZwgHOvdXK7BXIYNSkRlEtmFLJRDHNun7IIXFhIbo4mU
         0FmikMh594e5sggKrHgHUPWuVTFnl3s0B30KTkW9OvZ37FBtK5jcefkuTym/LUpPOLgt
         sF4eHRzJDVRDlKtCd/5a+29IIKPXQXFEX8UexTwBGLrt/pXCz0oJh9zfpSkUHubiXB66
         Wek2TP8IQ7yysg/b+1ifKdA0g8BYseqKtxPpE9tCQyhb4NxGMpSORJ48B3ncfBszAfpv
         2Apw==
X-Gm-Message-State: AOAM531z7sMXOZoLb5DhgCUNrnd4NpkQXstj981EnoysL2PCZD/IrS60
        xZIM1AbUU9pRuJHbkDWS05shdw==
X-Google-Smtp-Source: ABdhPJwX6Ph4qJI+LNzuibWoNdaSL97FGQGesFlYXUstdH+MslUyCsYkGxySybShSkQ1BB0NGFC9WQ==
X-Received: by 2002:a17:90a:acf:: with SMTP id r15mr10419026pje.171.1591915232843;
        Thu, 11 Jun 2020 15:40:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o1sm3488846pjp.37.2020.06.11.15.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 15:40:31 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] selftests/harness: Switch to TAP output
Date:   Thu, 11 Jun 2020 15:40:21 -0700
Message-Id: <20200611224028.3275174-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I finally got around to converting the kselftest_harness.h API to actually
use the kselftest.h API so all the tools using it can actually report
TAP correctly. As part of this, there are a bunch of related cleanups,
API updates, and additions.

Thanks!

-Kees

Kees Cook (7):
  selftests/clone3: Reorder reporting output
  selftests: Remove unneeded selftest API headers
  selftests/binderfs: Fix harness API usage
  selftests: Add header documentation and helpers
  selftests/harness: Switch to TAP output
  selftests/harness: Fully track XFAIL reports
  selftests/harness: Display signed values correctly

 tools/testing/selftests/clone3/clone3.c       |   2 +-
 .../selftests/clone3/clone3_clear_sighand.c   |   3 +-
 .../testing/selftests/clone3/clone3_set_tid.c |   2 +-
 .../filesystems/binderfs/binderfs_test.c      | 284 +++++++++---------
 tools/testing/selftests/kselftest.h           |  78 ++++-
 tools/testing/selftests/kselftest_harness.h   | 142 ++++++---
 .../pid_namespace/regression_enomem.c         |   1 -
 .../selftests/pidfd/pidfd_getfd_test.c        |   1 -
 .../selftests/pidfd/pidfd_setns_test.c        |   1 -
 .../selftests/uevent/uevent_filtering.c       |   1 -
 10 files changed, 330 insertions(+), 185 deletions(-)

-- 
2.25.1

