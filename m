Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548E5C2BA17
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AEEA2072E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RRn91FPf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389180AbgDBO7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 10:59:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35170 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388782AbgDBO7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 10:59:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585839579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Yqap4whYtfmJejxzuBxb/FdAQnMsGBhBjZtdGx1iIUk=;
        b=RRn91FPfKVirv7wPkWNQxQXmgbFuAnYqnP5sHAFIDVRhmvh1usHNBA+cfjF0d40x4Tfa+X
        tc47JNu9Bh53pZxULSoNs58hk/jiuQo3H51s9EC0okJiwBmWrS8reNGiPQrLaRyV4hDXp/
        2zvTGsQ0hPeq695Quk3xykctwyTP68M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-RAU6iGq9NS-vzIWr7BGaNw-1; Thu, 02 Apr 2020 10:59:38 -0400
X-MC-Unique: RAU6iGq9NS-vzIWr7BGaNw-1
Received: by mail-wr1-f70.google.com with SMTP id v17so1580072wro.21
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 07:59:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yqap4whYtfmJejxzuBxb/FdAQnMsGBhBjZtdGx1iIUk=;
        b=GyF9058hMj/owJBzkEBQldfmbChGfLdhrKqNgRp2NGt1ZTJvDPyKAOMT26s1dnPBzm
         cc7Mte/H98KLIfHLkGNwyAdjLtw7HMR/4xuosHNS/FwEsfxGRKsHwib8Lm/t9b4H5cHl
         ++O1gx4Rzy+A4tFVpEvPGdtB/bFtQonjfienKOdnojhOHyLxGiluF7MtN8qMUJZYkSAI
         96pstt6QIkO+2Xur5bMNr9Qz4uyKLDATVuMbkESCEqbt/3lz58BAAAHwKDw2UFsyhBac
         QMcBmIO7OBgGoiFu3Gyt9+B72H+0hM2bYiJL0esS+BUqZxa7J/dGnk+QSjw8aC8SPBEy
         etoA==
X-Gm-Message-State: AGi0PuZBPf/ML+PHmubhbZUqWrtQjaTZZighE19CpIhCCrbyGPVy3feg
        LltueTG+KCdxDHWsod1NzwylCjiLn6+X2r4TPLauDBWGlNmjpo0b+64HZ8wViLplFvu7CuCkW/P
        0N2dSvbPBehbC/IVatDxQ0ISA
X-Received: by 2002:adf:e744:: with SMTP id c4mr3767379wrn.133.1585839573538;
        Thu, 02 Apr 2020 07:59:33 -0700 (PDT)
X-Google-Smtp-Source: APiQypK3Oo6MLesIzVPde3UkEXepI21m0scERK4nlg2Qpodmma+whmcrF38HqppY2MVQPBGZT11SRw==
X-Received: by 2002:adf:e744:: with SMTP id c4mr3767358wrn.133.1585839573260;
        Thu, 02 Apr 2020 07:59:33 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id r17sm588857wrg.71.2020.04.02.07.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 07:59:32 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Ming Lei <ming.lei@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2] sched/isolation: Allow "isolcpus=" to skip unknown sub-parameters
Date:   Thu,  2 Apr 2020 10:59:29 -0400
Message-Id: <20200402145929.102587-1-peterx@redhat.com>
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
v2:
- only allow isalpha() for sub-parameters [tglx]
---
 kernel/sched/isolation.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 008d6ac2342b..c2e8b4a778d6 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -149,6 +149,9 @@ __setup("nohz_full=", housekeeping_nohz_full_setup);
 static int __init housekeeping_isolcpus_setup(char *str)
 {
 	unsigned int flags = 0;
+	char *par;
+	int len;
+	bool illegal = false;
 
 	while (isalpha(*str)) {
 		if (!strncmp(str, "nohz,", 5)) {
@@ -169,8 +172,21 @@ static int __init housekeeping_isolcpus_setup(char *str)
 			continue;
 		}
 
-		pr_warn("isolcpus: Error, unknown flag\n");
-		return 0;
+		/*
+		 * Skip unknown sub-parameter and validate that it is not
+		 * containing an invalid character.
+		 */
+		for (par = str, len = 0; *str && *str != ','; str++, len++)
+			if (!isalpha(*str))
+				illegal = true;
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

