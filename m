Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F44C2BA18
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 22:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ACAE206CC
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 22:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GLM1PJED"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388569AbgDCWf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 18:35:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56406 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388538AbgDCWfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 18:35:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585953324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=L9gTAgQvkcuTKrZ/zg3IMmKkiFJtMXRY4VRyptxXDt0=;
        b=GLM1PJEDjOQEV3o6XjjeP73PP4VytjSbyO9uDqQkrfOcBzhKbDBZw/ChX6bXMkmPUyvE8M
        h28PuaN8+omIEZQFfb0eHW0sVEF7L5GoJcZLXrHsLARlVhWe6DPlBOI6kK2jDp5XE4tV28
        YwwHEn0TpBrd/WdhwhFaEdn4mLl3o4s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-G25tKQ4JN3-7AG5W1sA9xw-1; Fri, 03 Apr 2020 18:35:22 -0400
X-MC-Unique: G25tKQ4JN3-7AG5W1sA9xw-1
Received: by mail-wm1-f72.google.com with SMTP id f8so3432102wmh.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 15:35:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L9gTAgQvkcuTKrZ/zg3IMmKkiFJtMXRY4VRyptxXDt0=;
        b=agbKn0pIQDiEAHageDTFDO1mhWFt5bfw6rM5yws9MMRGKPUSNn1y5vIEoBzOTF8HAw
         OFROccS1lnS69jyCWHJmCXmIMBiFREshvnFBMnOpje1j7nNnhphg4EMJJv08SJw0Z7Ji
         zoqyaLwxl13YX2j7jLyP1Apx7106OJmfzZcx9bYJCoRixsAwbEQGoCIbSkt/L9YB8GEu
         2dEkC98cHuPwSB6v0yGyrEF/p2T+BFYAIhPwk+Ibl4pxhp/KCV2ak8ZlF5ffbafG4UQ5
         Ze/bQzCYL9dGQQveNBbvdlpTpbqrRypIrqymHCIB/D+6iK4l8XOZH1B8GXw/XoI8theU
         rhMQ==
X-Gm-Message-State: AGi0PuZhI+Tx1hPCNFS3BpwrHY9NaJkv3qFMOYm/LpAPEsDpazgtX32t
        r617WKP/S2nJK9KQyEOC+UhRj4J/qixbWCx8BlWuOEV/97j0o86+vm84Wi9DJL6NjrJNylO+095
        Zf5+xCjEv2mzErnO03OBKyVTL
X-Received: by 2002:a7b:cb59:: with SMTP id v25mr11381309wmj.13.1585953321575;
        Fri, 03 Apr 2020 15:35:21 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ9SBLZWXF+ffoephI8dFGNfKXSMkeFHtg+tAuSUpkNicFkIwtdvNoAC0B7kMnQqHYTXhg/dw==
X-Received: by 2002:a7b:cb59:: with SMTP id v25mr11381295wmj.13.1585953321388;
        Fri, 03 Apr 2020 15:35:21 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::3])
        by smtp.gmail.com with ESMTPSA id n11sm15173121wrg.72.2020.04.03.15.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 15:35:20 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Ming Lei <ming.lei@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v3] sched/isolation: Allow "isolcpus=" to skip unknown sub-parameters
Date:   Fri,  3 Apr 2020 18:35:17 -0400
Message-Id: <20200403223517.406353-1-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "isolcpus=" parameter allows sub-parameters to exist before the
cpulist is specified, and if it sees unknown sub-parameters the whole
parameter will be ignored.  This design is incompatible with itself
when we add more sub-parameters to "isolcpus=", because the old
kernels will not recognize the new "isolcpus=" sub-parameters, then it
will invalidate the whole parameter so the CPU isolation will not
really take effect if we start to use the new sub-parameters while
later we reboot into an old kernel. Instead we will see this when
booting the old kernel:

    isolcpus: Error, unknown flag

The better and compatible way is to allow "isolcpus=" to skip unknown
sub-parameters, so that even if we add new sub-parameters to it the
old kernel will still be able to behave as usual even if with the new
sub-parameter is specified.

Ideally this patch should be there when we introduce the first
sub-parameter for "isolcpus=", so it's already a bit late.  However
late is better than nothing.

CC: Ming Lei <ming.lei@redhat.com>
CC: Ingo Molnar <mingo@redhat.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Juri Lelli <juri.lelli@redhat.com>
CC: Luiz Capitulino <lcapitulino@redhat.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
v3:
- add brackets for for loop
- move "illegal" a bit higher, which may look tiny bit nicer
- also allow '_'
v2:
- only allow isalpha() for sub-parameters [tglx]
---
 kernel/sched/isolation.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 008d6ac2342b..808244f3ddd9 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -149,6 +149,9 @@ __setup("nohz_full=", housekeeping_nohz_full_setup);
 static int __init housekeeping_isolcpus_setup(char *str)
 {
 	unsigned int flags = 0;
+	bool illegal = false;
+	char *par;
+	int len;
 
 	while (isalpha(*str)) {
 		if (!strncmp(str, "nohz,", 5)) {
@@ -169,8 +172,22 @@ static int __init housekeeping_isolcpus_setup(char *str)
 			continue;
 		}
 
-		pr_warn("isolcpus: Error, unknown flag\n");
-		return 0;
+		/*
+		 * Skip unknown sub-parameter and validate that it is not
+		 * containing an invalid character.
+		 */
+		for (par = str, len = 0; *str && *str != ','; str++, len++) {
+			if (!isalpha(*str) && *str != '_')
+				illegal = true;
+		}
+
+		if (illegal) {
+			pr_warn("isolcpus: Invalid flag %.*s\n", len, par);
+			return 0;
+		}
+
+		pr_info("isolcpus: Skipped unknown flag %.*s\n", len, par);
+		str++;
 	}
 
 	/* Default behaviour for isolcpus without flags */
-- 
2.24.1

