Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1883CC35DEA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 23:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD6EE20700
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 23:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o39UkheK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbgBXX6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 18:58:32 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:52542 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgBXX6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 18:58:32 -0500
Received: by mail-pj1-f68.google.com with SMTP id ep11so454932pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 15:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=6t8fAStxyMBpqFhnRnERlhVNkOeAX250LE3Yg/qJtM8=;
        b=o39UkheKhEstLndzZrMbL+uItsNfKE3pcAHUUmxaDwxXiEUgy5omwFZz8TyaVSnu9U
         aovk8jgepOxixvkDRIp8E/K7ucmeYnK8npXg6riGqFT06hHFpf9/O9afTGUPVIiZlTkH
         IfmYYyfv+8/u9gpTHXxm+iGvXMO6RnLZAL7UNIwFZT0U5Lz2iQki3Bg2+aiMS1/ZsgT2
         FLUeJFA/dUMDPvFkoGSTvfC7WOcxI4SUILbd+plkMJaRWWoq6Kywx0soolVBMDth88C0
         GgKSBEjRWmzxBwpM18lifmRFPXn4qPPAT88Ss/rzFjE/kd1i4YXpn8YdGVyQUUVv+WSn
         rSUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6t8fAStxyMBpqFhnRnERlhVNkOeAX250LE3Yg/qJtM8=;
        b=rh9BUyj3Ogad8Dwg6ihnM1uMcH3qede43pUOFQiPVperoEMikxXb/67fWQbtSJDRAd
         9RdB1Ns+PH3SqDKrbwOnhhiPP8xuepCEjrh5hDYdCil1wVfVbFxKV07bopiT2SVqQ/ni
         Ih8AdHvvy07vFN8QR8dtmOmFSHhc1lhIRqjCuB9PJ0bW9Xj6iB+nmWBzcHasDr2hRvRw
         hhigHEqE/mgirZhPf7fs2Vus3AUHOqddCHoLbQYh75e6LO+q/khiDKJDxtPbxZjiFDDJ
         4vDYvT3jluSFNQlhGkcxdGwYbYcepubV2Vg68vd8/Bl4N60G8NoHe9wnrCrCQKbWpXfl
         1DEQ==
X-Gm-Message-State: APjAAAWw3etKpaWFPUWqHgjNh8iXWckMaabey/JKkUxbcEoauh0PD2r4
        PfaQqtjix4YBWt1TfSm8bAyURCcMXnk=
X-Google-Smtp-Source: APXvYqxgK51lews+aPtRw5PC8+zgnvRIKVb/FG9m/YAhAkl3B9LTwpPt3W1OfC4eiv8dEXuA5NZm6w==
X-Received: by 2002:a17:90a:9285:: with SMTP id n5mr1945580pjo.58.1582588711134;
        Mon, 24 Feb 2020 15:58:31 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id y1sm14000747pgi.56.2020.02.24.15.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 15:58:30 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>
Subject: [RFC][PATCH] checkpatch: Properly warn if Change-Id comes after first Signed-off-by line
Date:   Mon, 24 Feb 2020 23:58:24 +0000
Message-Id: <20200224235824.126361-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quite often, the Change-Id may be between Signed-off-by: lines or
at the end of them. Unfortunately checkpatch won't catch these
cases as it disables in_commit_log when it catches the first
Signed-off-by line.

This has bitten me many many times.

I suspect this patch will break other use cases, so it probably
shouldn't be merged, but I wanted to share it just to help
illustrate the problem.

Cc: Andy Whitcroft <apw@canonical.com>
Cc: Joe Perches <joe@perches.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index a63380c6b0d2..a55340a9e3ea 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2609,7 +2609,8 @@ sub process {
 # Check the patch for a signoff:
 		if ($line =~ /^\s*signed-off-by:/i) {
 			$signoff++;
-			$in_commit_log = 0;
+			#Disabling in_commit_log here breaks Change-Id checking in some cases
+			#$in_commit_log = 0;
 			if ($author ne '') {
 				my $l = $line;
 				$l =~ s/"//g;
-- 
2.17.1

