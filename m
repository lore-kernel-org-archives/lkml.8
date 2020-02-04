Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6214DC35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 16:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3072E2087E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 16:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ObPyHTm2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbgBDQQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 11:16:50 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41150 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727310AbgBDQQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 11:16:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580833009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=d/1kZYW+amVRWeTIsaypigSvaXiL8dz1iR14XKJQ+1Q=;
        b=ObPyHTm2TC5UwgAEwtWR4zIsfd12JTST/mEWy2p7Uh83//J/AW7+BqPxxKuCfnH8pwyD5T
        L77fhy6iQMRv+Yp5YUl+kFqxIhkEjjXlm81+8SkZX9Kk6bls7aeCgXskbShk7pMtiJxXNu
        t7gXaaopIdyc/IwK9c5F9EknvMM97VA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-mmicGmilN8u6gjkkr9UpgQ-1; Tue, 04 Feb 2020 11:16:43 -0500
X-MC-Unique: mmicGmilN8u6gjkkr9UpgQ-1
Received: by mail-qt1-f200.google.com with SMTP id b5so12714450qtt.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 08:16:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d/1kZYW+amVRWeTIsaypigSvaXiL8dz1iR14XKJQ+1Q=;
        b=IXLbWqAV6Ub6USL2dVgQU3O7laECaJPfaaWmofErDwIUv7eTLWvV4KTeWE1QQXV7TM
         Jl60BZT2R+qNql/h/VyK1iJWxxyK3bTOtoCKyXQEqL55Vn7TNFsInVH+9TiVbbCmZvQi
         McZhSplB52zcR1z2T1vmCppjpCFrHTkVY04Sdb1VM4JdjWvHb2T+B3cri+J8qpAIttaS
         aKatVO2n8azHKfwUYYDRYqdAGdVO+sTfbO8q3dvN8s8FJVLNiqcb8mSYfCbTr+qplZpW
         Dfs1MnXKYeIQXfM52fWKRoBWZKxcMH2MG5j7ssmpRnSbDZq+/Z+skXQEKnPlnbJ4CT3A
         c8jQ==
X-Gm-Message-State: APjAAAXs6/R5Sdwyy1dKliUN8Agaln9EfIo6t8zoSdWJEmp+aRM2Tfgg
        dYMM3xulMryktc3ywWdPtNcLCIZXGVL5+bqQisw4xJafNQITJt+pWWRGB1BMzl0Rhh4i0YliUAE
        gc/7IvLagwenTxFBWjEi/Wr4z
X-Received: by 2002:aed:2047:: with SMTP id 65mr29242862qta.78.1580833003007;
        Tue, 04 Feb 2020 08:16:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqx6q9T58E4rVois1ODbTqp34NKMnQQMv8LOqipqZDrbLugQmaiN1vBOjCzPlV7P4fDCxHzpQg==
X-Received: by 2002:aed:2047:: with SMTP id 65mr29242835qta.78.1580833002741;
        Tue, 04 Feb 2020 08:16:42 -0800 (PST)
Received: from xz-x1.redhat.com ([2607:9880:19c8:32::2])
        by smtp.gmail.com with ESMTPSA id b35sm12386718qtc.9.2020.02.04.08.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 08:16:41 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Ming Lei <ming.lei@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] sched/isolation: Allow "isolcpus=" to skip unknown sub-parameters
Date:   Tue,  4 Feb 2020 11:16:39 -0500
Message-Id: <20200204161639.267026-1-peterx@redhat.com>
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
 kernel/sched/isolation.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 008d6ac2342b..d5defb667bbc 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -169,8 +169,12 @@ static int __init housekeeping_isolcpus_setup(char *str)
 			continue;
 		}
 
-		pr_warn("isolcpus: Error, unknown flag\n");
-		return 0;
+		str = strchr(str, ',');
+		if (str)
+			/* Skip unknown sub-parameter */
+			str++;
+		else
+			return 0;
 	}
 
 	/* Default behaviour for isolcpus without flags */
-- 
2.24.1

