Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B1ACA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 10:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7F3E206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 10:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589364612;
	bh=Giv6qhhKOE/4ls2bNxgjKzXfr4vL7+gBDCYwRrJJEOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KYu+5sm+Y7nGTs0zxh1SnIKZE9Y2gf8dLwj4qhSt9sulQS1QRBJ2XV3/3BPW5g/Kt
	 2bIz9fAie7O4xPoJj3/8tjH1sISNZU8Hqu9XY+M3UeibRrZJgJvtZjScPJW73RZtrL
	 Hoi3iSYu/Z4m5PS8O3Gg1rZkNZZZF+6drU89Oaw4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732685AbgEMKKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 06:10:09 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:39412 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732562AbgEMKKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 06:10:09 -0400
Received: by mail-lf1-f48.google.com with SMTP id h26so13131195lfg.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 03:10:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tb/Z/t7NJwro1mv1kseetNzdMa37wI3AfNN2BeEM4eE=;
        b=ERz9s9QqVQq3ccab6vpnkUdWj4LxVrS/3ZX2s0IsqKHKs5UeYBEHaSkNRke1SdDsOx
         uoffQtf8Ath+8bKWKuzIkD5paKKvUItWHpblobzu0xIy9/xm04G91zls/85PZ7GTo35Q
         npOsN58bEQmfcYMnxRX/HgXl00QMI1ppd4Wowgd1cwgoN57D5IClzb3eYq9m/u+bFPiH
         n2Qsjiue3DaKe7zJpRV9JRU3EissOTDZXphc6CmPcxkrfREfgzxXcl7dN5w3BAMcXJ5x
         roTfn7bmgMNUWast4q4Dku7hCa/q6SNR+wZxneT9f8mLnmPIB27vEP3N3J6nHfD67dFv
         9EhQ==
X-Gm-Message-State: AOAM533cr3sZUKpZRAxhY/LuImYRRXWUM6qnNYpoE4az+qLt/Sf9o0Id
        v/RSm7wDl6ESoii4wU8EKGA=
X-Google-Smtp-Source: ABdhPJyHl4wcv/vQPOmukVL9xWXCc/nyuJ96rUacbtWPHdXwkWE6UtsPeaGHvIYEQu4ERJg9Lq5SoQ==
X-Received: by 2002:a19:4809:: with SMTP id v9mr17773248lfa.60.1589364605483;
        Wed, 13 May 2020 03:10:05 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id h3sm15857288lfk.3.2020.05.13.03.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 03:10:04 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@xi.terra>)
        id 1jYoL0-0002Ou-LF; Wed, 13 May 2020 12:10:06 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/2] x86/apb_timer: drop unused declaration and macro
Date:   Wed, 13 May 2020 12:09:44 +0200
Message-Id: <20200513100944.9171-2-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513100944.9171-1-johan@kernel.org>
References: <20200513100944.9171-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop an extern declaration that has never been used and a no longer
needed macro.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 arch/x86/include/asm/apb_timer.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/include/asm/apb_timer.h b/arch/x86/include/asm/apb_timer.h
index 0a9bf8b77a28..87ce8e963215 100644
--- a/arch/x86/include/asm/apb_timer.h
+++ b/arch/x86/include/asm/apb_timer.h
@@ -25,10 +25,7 @@
 #define APBT_MIN_FREQ          1000000
 #define APBT_MMAP_SIZE         1024
 
-#define APBT_DEV_USED  1
-
 extern void apbt_time_init(void);
-extern int arch_setup_apbt_irqs(int irq, int trigger, int mask, int cpu);
 extern void apbt_setup_secondary_clock(void);
 
 extern struct sfi_timer_table_entry *sfi_get_mtmr(int hint);
-- 
2.26.2

