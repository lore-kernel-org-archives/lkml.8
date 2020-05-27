Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7116C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 17:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5ED420663
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 17:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posk.io header.i=@posk.io header.b="B3Jk1Hud"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390957AbgE0RkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 13:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387564AbgE0RkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 13:40:16 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447FEC03E97D
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 10:40:16 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k22so10380064pls.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 10:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=message-id:subject:from:to:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=Rk1xhV7XufxkO/E1iLQ3yEa3ALqyATLWKjuDwexe4Yg=;
        b=B3Jk1Hud+b+F59wbna0Yyx92ZDbqgoGy+IywWGh/04Vvc78f8fVPMvcBEfH/Top/q3
         KxCxyEdfGGUaYF5vbk6B2eeHP9wQdhP3E/h/sxJ/XoKYjr2WLVFi1gFMPWr5RLHjJCLV
         L+HmYXaMSDWQpcLgOuRnO2cV++BAhRsQHZ8gkfRJ+ArNvmmi+FrDii7LZHGkwVON08CO
         o6r1diaC8v8ohqR5s+vLFuxkirwOF9TKuRDUv/7goVceeRPWuEwbJZw/rRUo9yPuViHZ
         nXOWr0qGm87Y1DvGkFdr8c/FlIPpULSYp2u0WY6k7/aP/79f4N2oi4J3Q+f0+FsI2o+k
         NVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=Rk1xhV7XufxkO/E1iLQ3yEa3ALqyATLWKjuDwexe4Yg=;
        b=nIEyCgKbJVtuVI9anMhlvbf2NeXilpShowR8jmLPDFygsFnB4RA7lZw83z/700k3HT
         P4+N3nO9A0qnjAFz0d9B3WPiQ6LzZb0jCzQEBUVIIBAStlJ8rzD7yvPLF5/qZN1MSwn0
         yWNtf69lLfvfC07G2jUI3OQBmtpvQ1diG1Bkx2ckHS7T8e82CjKxWfq6p2piKZ71+/JP
         e49zPFM4Tq04LW6cH/nTKde71rt9uftKO9fChKw6jrYBfgfILUybqUH71oO0HCclTf99
         IPUGtxnrwTSqcda83wrAPudTBIX7Gbp07TRc2+MIr/aLBwkplSM/A96nsboaHA5paQTW
         CD4w==
X-Gm-Message-State: AOAM531HRugQP+ji1PzXfc9peYlL1+L/f8H+e3R7kA/3uoKtmtXlDzWZ
        mTIwFQW9X5E1SuiWBTZGyjogeJKtJXXHlw==
X-Google-Smtp-Source: ABdhPJxzjZxL86XD8n5itdGJFpoSmpa+c/9aBh1Q5bl5oLm/WDw+b2+84UNvphC7GfTOcDb949OKPg==
X-Received: by 2002:a17:90b:110d:: with SMTP id gi13mr6419016pjb.173.1590601215584;
        Wed, 27 May 2020 10:40:15 -0700 (PDT)
Received: from posk-x1c (c-73-202-129-89.hsd1.ca.comcast.net. [73.202.129.89])
        by smtp.gmail.com with ESMTPSA id w190sm2505061pfw.35.2020.05.27.10.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 10:40:15 -0700 (PDT)
Message-ID: <58974e229908b22f5a2e6c52a21ae63149300049.camel@posk.io>
Subject: [PATCH] smp: fix a comment typo.
From:   Peter Oskolkov <posk@posk.io>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Date:   Wed, 27 May 2020 10:40:14 -0700
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From b93e86294d30f58440762106e517d9467f4f3b69 Mon Sep 17 00:00:00 2001
From: Peter Oskolkov <posk@posk.io>
Date: Wed, 27 May 2020 10:23:07 -0700
Subject: [PATCH] smp: fix a comment typo.

Fix a typo in a comment.

Signed-off-by: Peter Oskolkov <posk@posk.io>
---
 include/linux/smp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/smp.h b/include/linux/smp.h
index cbc9162689d0..bb25075a981d 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -182,7 +182,7 @@ static inline int get_boot_cpu_id(void)
 /**
  * raw_processor_id() - get the current (unstable) CPU id
  *
- * For then you know what you are doing and need an unstable
+ * For when you know what you are doing and need an unstable
  * CPU id.
  */
 
-- 
2.25.1


