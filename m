Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE43C2BB55
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 10:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9918A20753
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 10:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgDJKDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 06:03:03 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60105 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgDJKDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 06:03:03 -0400
Received: from mail-wm1-f71.google.com ([209.85.128.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1jMqV4-0003SV-Aq
        for linux-kernel@vger.kernel.org; Fri, 10 Apr 2020 10:03:02 +0000
Received: by mail-wm1-f71.google.com with SMTP id f8so640841wmh.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 03:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Z3P5ra7nIgSjErTUHVmG2gVsvgQADuW5sfZ4PtTp618=;
        b=GxWkhB7Wy3Igiw72UkP/nkR3jq7za2kszsrQbmj7XiWYv+0Ks8cQrhS1ovGSbs9iq8
         NQAuP8vwlPzU2OXvBNH6qihzfUc0msP+FxRulgWSwTfVOvKMfwvkdYCmZx4OzZlWbyjc
         7aDwOlk/l1XtsE6UE1b+WoNQGegT3ccHqroiKLwfMln6EmJjqjmttuTkpmh9ss7n3Yck
         rZyBn1nUS6Aw+g9a4W239JaYFZhl7yC24HWnGJcRYE9v3AKu66G/kkESdBmZ4aDnVOcN
         KhztPdwtKSizOYkXy7mn3gwdzqgcX5GwH5mEwpwUNwF8a2GDYjk9+fymcnX9xqqcuOZC
         GsyA==
X-Gm-Message-State: AGi0PubGlsb8qfDZoVoJcYaWDbf18FfMomsW8ZkqOJyMhaApca+3hYFZ
        XjRs4uPJ3N4HYS9lv3YNFL9uDSWYBnZlf/PL6ELuWO9bH6iIT4lNbJNSJPviDYABVnd07KreDt0
        mjC2DlM4tq3j2JAkfJHdH2U9XSKC6bZ60tnKeDltmRQ==
X-Received: by 2002:a1c:6787:: with SMTP id b129mr4574991wmc.165.1586512981979;
        Fri, 10 Apr 2020 03:03:01 -0700 (PDT)
X-Google-Smtp-Source: APiQypJk4lRxcFGUzlhlWkYg2asplSW+TWRRfdgc31OMNALo4BRjm4RdCfBoPSErXWDJWfmQ9WWwhQ==
X-Received: by 2002:a1c:6787:: with SMTP id b129mr4574957wmc.165.1586512981640;
        Fri, 10 Apr 2020 03:03:01 -0700 (PDT)
Received: from localhost (host123-127-dynamic.36-79-r.retail.telecomitalia.it. [79.36.127.123])
        by smtp.gmail.com with ESMTPSA id k84sm2243972wmk.2.2020.04.10.03.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 03:03:01 -0700 (PDT)
Date:   Fri, 10 Apr 2020 12:02:59 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kselftest/runner: allow to properly deliver signals to tests
Message-ID: <20200410100259.GA457752@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While running seccomp_bpf, kill_after_ptrace() gets stuck if we run it
via /usr/bin/timeout (that is the default), until the timeout expires.

This is because /usr/bin/timeout is preventing to properly deliver
signals to ptrace'd children (SIGSYS in this case).

This problem can be easily reproduced by running:

 $ sudo make TARGETS=seccomp kselftest
 ...

 # [ RUN      ] TRACE_syscall.skip_a#
 not ok 1 selftests: seccomp: seccomp_bpf # TIMEOUT

The test is hanging at this point until the timeout expires and then it
reports the timeout error.

Prevent this problem by passing --foreground to /usr/bin/timeout,
allowing to properly deliver signals to children processes.

Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 tools/testing/selftests/kselftest/runner.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index e84d901f8567..676b3a8b114d 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -33,7 +33,7 @@ tap_timeout()
 {
 	# Make sure tests will time out if utility is available.
 	if [ -x /usr/bin/timeout ] ; then
-		/usr/bin/timeout "$kselftest_timeout" "$1"
+		/usr/bin/timeout --foreground "$kselftest_timeout" "$1"
 	else
 		"$1"
 	fi
-- 
2.25.1

