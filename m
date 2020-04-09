Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C059FC2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 13:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 933652083E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 13:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="U0UZJXOe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgDINqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 09:46:22 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:35682 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgDINqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 09:46:21 -0400
Received: by mail-pj1-f66.google.com with SMTP id mn19so1308207pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 06:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ALRgRwayDOlRm4S4HcDIOKGfniGPEmV1GEg/TDbG97k=;
        b=U0UZJXOey1JuGiw+K6HY6gbPV+FWGEzhtVbTIFboBDLb59FgOmirVAPn0mnr6pjEKl
         Nnm48ig5KQr491qk/E4taCtN1aNuiZk6HKu/95b/1WnR84tsbtZ7LP3oXt+sKcq/nTgJ
         4lGvLuj6SS0Cu+QAl6vx0Z8N5x1+TFw/AFJvpYL7DzN7+geGWW102rIphnRKgIcT4whH
         geiBxh01j9x4GNAGTfu5AYRg3BkDPX28nVRru0g5mwQst1m+YEk4iT0mi4i+MmGLN/8E
         57ayplDYbW/2JhL5/mCxvM1VmHakqrm28BZJ72JX31p4W8Yv7dZK5/B3143BF0dDaOWy
         yr+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ALRgRwayDOlRm4S4HcDIOKGfniGPEmV1GEg/TDbG97k=;
        b=eW1LpEOqbybgRtwY1GePbKOyGxIkbQ1PICntu38kxbj9mQoJOlUrH5lx3GGGzqzv8h
         YUtILdxfgO6ezn3oKd24ijY2pZ7LyVbm/gEVhpUO3qiBgOK/1Gf4tD3DUc8NiWPKqynt
         bm2Po4XnQJ0cSnUAEexLqfBRd9AVPyRhIQbDIix5Q0PkiDILmB44WiUIC0/GZnR/GqIs
         JTrLfo2N4VLPTDsN1Q4jnt54w9U+VWwDSaeBBuvI4lP7vkYTx85dqibUO30NeQjUrQZb
         at7MU6X4BwCPDP3vOpOB2/50OVnL6jNl78QSoTekHPOToGjpNKaVXSMe1mb7fFLFyPar
         R6bA==
X-Gm-Message-State: AGi0PuZNTc65vMFI1xHnMGnoV9AO6KkatZv6iDkKZ5WfqOEYMdH9VUpU
        9zKRFpKQCq1vMVieD5CwPEI/Qg==
X-Google-Smtp-Source: APiQypJTJnizBSc/GwQ1IxY2bOQ+OmvhYa0t2OxZxF8YEmMgafP8T6H3g9l2ILhhL4XB/BTCtFlWag==
X-Received: by 2002:a17:90a:f011:: with SMTP id bt17mr9747347pjb.3.1586439980764;
        Thu, 09 Apr 2020 06:46:20 -0700 (PDT)
Received: from Smcdef-MBP.lan ([103.136.221.72])
        by smtp.gmail.com with ESMTPSA id u15sm5324193pgj.34.2020.04.09.06.46.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Apr 2020 06:46:20 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] seqlock: Use while instead of if+goto in __read_seqcount_begin
Date:   Thu,  9 Apr 2020 21:45:58 +0800
Message-Id: <20200409134558.90863-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The creators of the C language gave us the while keyword. Let's use
that instead of synthesizing it from if+goto.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/seqlock.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 8b97204f35a77..7bdea019814ce 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -125,12 +125,8 @@ static inline unsigned __read_seqcount_begin(const seqcount_t *s)
 {
 	unsigned ret;
 
-repeat:
-	ret = READ_ONCE(s->sequence);
-	if (unlikely(ret & 1)) {
+	while (unlikely((ret = READ_ONCE(s->sequence)) & 1))
 		cpu_relax();
-		goto repeat;
-	}
 	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);
 	return ret;
 }
-- 
2.11.0

