Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B52DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEF8C2070A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TI8Zc7pt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbgFZU7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 16:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgFZU7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 16:59:46 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB32FC03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 13:59:45 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id r18so5442698pgk.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 13:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=vzE/LHOrs411ALZFAPX5s4XQ3VOyYMCpxKznqqbDvQ4=;
        b=TI8Zc7pt4AdbPofHKO372L5Kta8OeeO3t3PXk/6qhNeAO+yCbS0Doy0WS9y2bVqgZ/
         tI4T3y1zUN+TnjuQXTcXv8tWquNbcXAoocAEuAFcTaqkXpiPwLgebf3YagDWZMlxOhlz
         4G0CXBgXdsf2kQOWXSTX3CW+pV7onm4JkG2bo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=vzE/LHOrs411ALZFAPX5s4XQ3VOyYMCpxKznqqbDvQ4=;
        b=TfIPwUwQBx4VA8mzuK15FA78xvdf83Qmrf3sSKqC/sSGui7k6gr+t6E+mTgUmawQJ8
         8VbDJ4l9PRzDe8v/YEy6dhN9Q/hvPad5B7tX8p1ut4XwstfftWotKuAHMUbOK5Tqx78j
         ZKrS0/WuPOZGHs9nV7qaBqin52ybPD4an6F8G0NvQyGBOBWHZSI4N3bo+nUvXkmqVPU1
         FF3wL2dirsWgguQ/9BXTBUbY3XG6H5jgIa1CaJPwzpZG4Ao5zcIRQzJMspc1fnM/vpvc
         G3yHfzuembpK7NcLAUhG1agPRZlqrdPU6A7DhmBQpTCrJ0ccvdVuLVmO7lK6ky9kH1Gm
         Btqw==
X-Gm-Message-State: AOAM532n5ondUtp7DpTcoBoDSHlRjC/Sy+tQNOdUxAio5N9vg4538z7J
        irHotLG3k30ZtsH8KZuKXUrRKw==
X-Google-Smtp-Source: ABdhPJy9ZcI5XAF6R6FENmskB+t4X3sgpFeAprNtq3GGr6iredh9lEzDpleAFN9acuLpA/roa4lVGA==
X-Received: by 2002:a63:c44b:: with SMTP id m11mr522600pgg.404.1593205185366;
        Fri, 26 Jun 2020 13:59:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b4sm5673856pfr.149.2020.06.26.13.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 13:59:44 -0700 (PDT)
Date:   Fri, 26 Jun 2020 13:59:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/lkdtm: Use "comm" instead of "diff" for dmesg
Message-ID: <202006261358.3E8AA623A9@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of full GNU diff (which smaller boot environments may not have),
use "comm" which is more available.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Link: https://lore.kernel.org/lkml/CA+G9fYtHP+Gg+BrR_GkBMxu2oOi-_e9pATtpb6TVRswv1G1r1Q@mail.gmail.com
Fixes: f131d9edc29d ("selftests/lkdtm: Don't clear dmesg when running tests")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/lkdtm/run.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/lkdtm/run.sh b/tools/testing/selftests/lkdtm/run.sh
index 8383eb89d88a..5fe23009ae13 100755
--- a/tools/testing/selftests/lkdtm/run.sh
+++ b/tools/testing/selftests/lkdtm/run.sh
@@ -82,7 +82,7 @@ dmesg > "$DMESG"
 ($SHELL -c 'cat <(echo '"$test"') >'"$TRIGGER" 2>/dev/null) || true
 
 # Record and dump the results
-dmesg | diff --changed-group-format='%>' --unchanged-group-format='' "$DMESG" - > "$LOG" || true
+dmesg | comm -13 "$DMESG" - > "$LOG" || true
 
 cat "$LOG"
 # Check for expected output
-- 
2.25.1


-- 
Kees Cook
