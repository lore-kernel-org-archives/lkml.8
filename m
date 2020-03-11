Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8D9C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 21:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A236B2074B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 21:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Dt+BHf7W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbgCKVRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 17:17:42 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37453 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729095AbgCKVRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 17:17:42 -0400
Received: by mail-pf1-f194.google.com with SMTP id p14so2051541pfn.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 14:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3LAERohpuvpSm00xKjtaZdoLFyl6wQmyHVk+s3HW4ao=;
        b=Dt+BHf7WqtAzksMgppkm1kzL6sgJlgG6NGzgEwvH3WTT8gIJgWzW08GFsJbZGnIghv
         1xLoE7nGsuKZxrP9SGxRwb0S6uq3PSudZQ03IHeedBogQuKh2dKMRrPwUNPKhm21wG9/
         hqH8tWV8IU+Sk8OtrTWDDxYJdlHuKrt3geVXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3LAERohpuvpSm00xKjtaZdoLFyl6wQmyHVk+s3HW4ao=;
        b=UfLdH76B6Q3/HIDLuraS8OA8UgBC7p52vSkyPqFMJv6sueoiNkDxnTNrtRl03+P9Bv
         upsdYU/vBxkwGfbACkNPP41xxc8ghqK6aVnS85i9a7Ke5LXFocti25I2wII7w9yaFeP4
         g/GwGweckGrHbldwOroMOdjGK7B/zPK88qRTQfHZhzKC2CEOGKEArZgu40pYHdjnInu+
         OgrMr5EFShwITBm3O6nfHL7HuAfC7iEEBIWJK47cN1gWaFPoHyzZC20/nY6gVj/44+EV
         d7EXB7nEpdE+HlZxUeDszEDYmyv0MICJklVuu0HfYbzJ6+qc2IDGwrMX+6kJVpRjzekf
         6SmA==
X-Gm-Message-State: ANhLgQ0EUteD8K43bdhivpWGwRW31AeHf31RJ1uP17Lrqeif8txiDDev
        JDRLzoGd6/rvd3JW+m7Gh+kmmQ==
X-Google-Smtp-Source: ADFU+vsE/tbqMMh99IEondTMGiAXly4iLT4ptHDR79in7ALtrEBOqRXfZNbkKUAuIi/sOEdvmju+dw==
X-Received: by 2002:aa7:880e:: with SMTP id c14mr4676249pfo.76.1583961459854;
        Wed, 11 Mar 2020 14:17:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b9sm22272129pgi.75.2020.03.11.14.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 14:17:37 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] selftests/harness: Handle timeouts cleanly
Date:   Wed, 11 Mar 2020 14:17:31 -0700
Message-Id: <20200311211733.21211-1-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a selftest would timeout before, the program would just fall over
and no accounting of failures would be reported (i.e. it would result in
an incomplete TAP report). Instead, add an explicit SIGALRM handler to
cleanly catch and report the timeout.

Before:

        [==========] Running 2 tests from 2 test cases.
        [ RUN      ] timeout.finish
        [       OK ] timeout.finish
        [ RUN      ] timeout.too_long
        Alarm clock

After:

        [==========] Running 2 tests from 2 test cases.
        [ RUN      ] timeout.finish
        [       OK ] timeout.finish
        [ RUN      ] timeout.too_long
        timeout.too_long: Test terminated by timeout
        [     FAIL ] timeout.too_long
        [==========] 1 / 2 tests passed.
        [  FAILED  ]

-Kees

Kees Cook (2):
  selftests/seccomp: Move test child waiting logic
  selftests/harness: Handle timeouts cleanly

 tools/testing/selftests/kselftest_harness.h | 144 ++++++++++++++------
 1 file changed, 99 insertions(+), 45 deletions(-)

-- 
2.20.1

