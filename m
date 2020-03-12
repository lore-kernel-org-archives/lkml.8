Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09CBC2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 04:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C9262071C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 04:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6BiP+Ar"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbgCLEDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 00:03:44 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:54191 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgCLEDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 00:03:44 -0400
Received: by mail-pj1-f66.google.com with SMTP id l36so1978997pjb.3;
        Wed, 11 Mar 2020 21:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=El9/kMaRun8cNDKHiGXwDb9mYCvC+j95alwi3VTkHO8=;
        b=Z6BiP+Arj/npEyOxf3kBzFjjcDUbTnWTN4+h1h5VpG9unqtBqvgtmhWZIwLTW5SfSJ
         pI/+gMve4SgGY4k7Kh8vCESx2Jg9VLVDWtKTU4ZCVYl6j20S50w+0ShNGWBfCU3r2y+9
         C2oOEMj+RzEGHMe1oJYvbstOzGmtoMZ3XNNdji0eQXlm7vHFF1X5fK4KofctHy+zMlzN
         +r8DYDZaeZM68a+m3nlYTFjuAQZ7Gn9f3MOiWYG412ZAD4YzFDO14xY97VyBomyUx2fH
         shuyNWRDZZj4xOuks6gU0FsJpTPIIx3ScmdDZTub7KZKyPYfHQfr4hNybDlBp1imQXXO
         31cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=El9/kMaRun8cNDKHiGXwDb9mYCvC+j95alwi3VTkHO8=;
        b=guzyHLSc2vZFnbx5fVGLAnEyL1lwXmc0BH8WEVRlRZWDKaH4ZbYOgRGi9RoLkT9XQJ
         NpIj4ySG2MAlIFWhWoRiD4107QMfoqfxRixiHTMJnwiC5HRF4g7GrOGB3klRpO7otVIB
         fq3LzvGCLQFrkpKNdduxhnpDZ9pW+7KL06SsH9N50znKMtH1MjtjxdiVmKTdxoANErCL
         HuxHqBY0dif31Zqk9sV3Hw92NmJUbU0jKNu23rgKQyZ+iW3WolzQnpCOTrLQeSCOKA0Z
         WGONbsr7JGWr5edOqrGEj3/p0IA8LsZDBlEfBaf7gkw8fzdNZcLkmiqxthmE6ZpStJgt
         AKuA==
X-Gm-Message-State: ANhLgQ0TA7jXV+NGLIaXebf6M+131gnvRe3WrMYJeo5K93muhzlVRoFU
        9vKTqX1JcpIcYe2H8TrLLLg=
X-Google-Smtp-Source: ADFU+vtACbTJhOyggMgvahlE5ckXx2R+TddbmiPE1wUYrsBYPu2rJbaJhTZVgvXpcVpCNEJ5Aktbjg==
X-Received: by 2002:a17:90a:b111:: with SMTP id z17mr2086819pjq.115.1583985823186;
        Wed, 11 Mar 2020 21:03:43 -0700 (PDT)
Received: from masabert (i118-21-156-233.s30.a048.ap.plala.or.jp. [118.21.156.233])
        by smtp.gmail.com with ESMTPSA id d2sm7258910pjo.45.2020.03.11.21.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 21:03:42 -0700 (PDT)
Received: by masabert (Postfix, from userid 1000)
        id 3085E236036A; Thu, 12 Mar 2020 13:03:40 +0900 (JST)
From:   Masanari Iida <standby24x7@gmail.com>
To:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc:     Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] selftests/ftrace: Fix typo in trigger-multihist.tc
Date:   Thu, 12 Mar 2020 13:03:37 +0900
Message-Id: <20200312040337.7631-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix a spelling typo in trigger-multihist.tc

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 .../selftests/ftrace/test.d/trigger/trigger-multihist.tc        | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-multihist.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-multihist.tc
index 18fdaab9f570..68ff3f45c720 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-multihist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-multihist.tc
@@ -23,7 +23,7 @@ if [ ! -f events/sched/sched_process_fork/hist ]; then
     exit_unsupported
 fi
 
-echo "Test histogram multiple tiggers"
+echo "Test histogram multiple triggers"
 
 echo 'hist:keys=parent_pid:vals=child_pid' > events/sched/sched_process_fork/trigger
 echo 'hist:keys=parent_comm:vals=child_pid' >> events/sched/sched_process_fork/trigger
-- 
2.26.0.rc0

