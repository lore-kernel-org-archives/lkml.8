Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28325C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 09:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0258720716
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 09:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbgC0JgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 05:36:24 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48436 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbgC0JgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 05:36:24 -0400
Received: from mail-wm1-f71.google.com ([209.85.128.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1jHlPb-0008Iz-7T
        for linux-kernel@vger.kernel.org; Fri, 27 Mar 2020 09:36:23 +0000
Received: by mail-wm1-f71.google.com with SMTP id m4so4133113wmi.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 02:36:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ap78OtXZq7aQJZ6TMPBs7AlXvQ7dSNaiueS9qsI4mxo=;
        b=cHgCoYr/N4gnhFw3e64rnbeFZSsJIWWCVb6jr/fH1dWujN7OB2UN57D3dlof/PnT0X
         tebs8GMikXmIl1M1H8cVuJOUVaHsswXruS3U6ztzzy1aG92ljdYXdHs/4OVLqk3/G6oF
         d+5tKVyqAeebVif/bIaKi7Y1bwll/Q4E5sqkFV0Uqa2OMih7o3PSYhi4jITFpomkxqaS
         4SLW9PFw/Z908wnFybI5mhBKOZa55ZIH0zhWBM9JC2okH16BYCdbMG9cBrYrNr4z5GV6
         Bp00kbZc5C0UESOX6tShTzU4JRtUWbZLpsORkaMdmLLM0Igu0PV3T88I/60KeA6F8U6K
         JyWg==
X-Gm-Message-State: ANhLgQ3Db77b7pjOXlY5lt2HV57hbjGyTTKeIyRUpMe8EL1DAkJmRsId
        EupnlsrYwwtxhasMQgom0R6SfQolgb6cfMGIIVEQVNtf62c56OOyMtz2ZDEeMDnEHINUbjWx9XA
        T2wOT5CpiKHREXTrJS9NtFHOVyeQ7715Vd8elVMoMZw==
X-Received: by 2002:adf:f8c1:: with SMTP id f1mr3211177wrq.345.1585301782619;
        Fri, 27 Mar 2020 02:36:22 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvx5Ju256H8lihDv+l/wpn/owlEL5RgRyERZjbHzg4A1aOGeFUlR72YVLLEH15UgqMSh/gGzQ==
X-Received: by 2002:adf:f8c1:: with SMTP id f1mr3211156wrq.345.1585301782361;
        Fri, 27 Mar 2020 02:36:22 -0700 (PDT)
Received: from localhost (host87-23-dynamic.53-79-r.retail.telecomitalia.it. [79.53.23.87])
        by smtp.gmail.com with ESMTPSA id c23sm7673665wrb.79.2020.03.27.02.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 02:36:21 -0700 (PDT)
Date:   Fri, 27 Mar 2020 10:36:20 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kselftest/runner: avoid using timeout when timeout is
 disabled
Message-ID: <20200327093620.GB1223497@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid using /usr/bin/timeout unnecessarily if timeout is set to 0
(disabled) in the "settings" file for a specific test.

NOTE: without this change (and adding timeout=0 in the corresponding
settings file - tools/testing/selftests/seccomp/settings) the
seccomp_bpf selftest is always failing with a timeout event during the
syscall_restart step.

Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 tools/testing/selftests/kselftest/runner.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index e84d901f8567..2cd3c8def0f6 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -32,7 +32,7 @@ tap_prefix()
 tap_timeout()
 {
 	# Make sure tests will time out if utility is available.
-	if [ -x /usr/bin/timeout ] ; then
+	if [ -x /usr/bin/timeout ] && [ $kselftest_timeout -gt 0 ] ; then
 		/usr/bin/timeout "$kselftest_timeout" "$1"
 	else
 		"$1"
-- 
2.25.1

