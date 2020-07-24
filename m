Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CB5C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 11:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D32692073E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 11:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595591096;
	bh=vaL4MIz5DQPoUsCUgjLhAzwGrT/Kj4IybNofD8vqINs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t6BhTDuTHRqKROhhRRvD8o892LQ00+F3KGAxdT985O90qYQc02fO7VksXEyTpwD8Q
	 yKWa5pcrzj5PK1JXgSAHGAkDvSQRv+OgxxNLkQ4DlXA1OWmEg3W1bTAiZVoJkAqqMo
	 LshEbDwM8XYIusQB/0nF1PHtbLIXNTB+lDbziVhw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgGXLoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 07:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbgGXLox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 07:44:53 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6827EC0619E4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 04:44:53 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id b13so4428357edz.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 04:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=je/ZaMoLASpjit77E8QX7SAmU2CLl39JJHW08Y95mVc=;
        b=aFwf7AstUXrnTCwGoz3fCy9KJiHtFx2GDx6uN+qdyWkj/WXdcBEMeSL7gNTZs1t++U
         UisJoKrFALZAoiVQEXmkGb1jVwbare6txIB2JzWNZACLTIqQGgd6sAh4tDQHziKpQNJA
         6+JPIDUTmWRtKPveH3rniNetJ6eymOCqYJBrxExnxKbVYN9mQ+q6qcW+1V+ne/eO1RPo
         jRJXEV4D/aA3DRaXtV1q3WtYBN1cjisiHjMbV76fNyFIdsWf89hoxWKvBO8Z4Dhfj+MX
         cvugcfeHeQmed6WVWPBED3EvSIR2u8fjE7BMRxoRmlpnHbDk75PeGV5M8TE0XAlx6xlX
         7o/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=je/ZaMoLASpjit77E8QX7SAmU2CLl39JJHW08Y95mVc=;
        b=ZJMV7DW1pYW/lLrb5eLUOHSR6x7hqIlDKm39VX5Z4jxMms1fQ0ISUTFdhBSFXh2QHm
         G6W+CGo8MjLb2Ox3kkjWkx5VCC7yzsNnQUSbpBwTypcE9BsnjsAVNVYu8vJi/4B3iZUQ
         wnRDtvcgQzYRlXgPZ/ELlAXM5KlWyuSfqAPYSLjGt/yyl15i90HJFmBGytvJlLMIarHM
         aouxan1ZYCMn8maRUh8jOdfxBxtw5xUoykS0ZlCtHkkrrMH0pLEyqS2HeWkrwNMtNLlg
         GHQ+AQGOjZjD2xnMn+UZd8Ogdt9mWalUf8sg4lCsHqdGEcC7Uvd/N6jA39yEM/ZJCbob
         lGqg==
X-Gm-Message-State: AOAM5337AXprRbXAS6X68daF4Mfe3yhW8MIdpbLPPxExO9sappq5IYe8
        JqjHu2kStqFZPb7l5kCbGGAzu2Kd
X-Google-Smtp-Source: ABdhPJxrqXA6irOygMZKAm99/1D1cfEESjaHUaZsqJJ4KHY/ePBdV5kH7yuio5Jcxxl24nS1D9AHvg==
X-Received: by 2002:a50:af45:: with SMTP id g63mr8905200edd.52.1595591091918;
        Fri, 24 Jul 2020 04:44:51 -0700 (PDT)
Received: from localhost.localdomain (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id r5sm580152edx.32.2020.07.24.04.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 04:44:51 -0700 (PDT)
From:   Ingo Molnar <mingo@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Subject: [PATCH 2/3] x86/tsc: Remove unused "US_SCALE" and "NS_SCALE" leftover macros
Date:   Fri, 24 Jul 2020 13:44:17 +0200
Message-Id: <20200724114418.629021-3-mingo@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200724114418.629021-1-mingo@kernel.org>
References: <20200724114418.629021-1-mingo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Last use of them was removed 13 years ago, when the code was converted
to use CYC2NS_SCALE_FACTOR:

  53d517cdbaac: ("x86: scale cyc_2_nsec according to CPU frequency")

The current TSC code uses the 'struct cyc2ns_data' scaling abstraction,
the old fixed scaling approach is long gone.

This cleanup also removes the 'arbitralrily' typo from the comment,
so win-win. ;-)

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/include/asm/tsc.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
index 8a0c25c6bf09..b7b2624fba86 100644
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -7,9 +7,6 @@
 
 #include <asm/processor.h>
 
-#define NS_SCALE	10 /* 2^10, carefully chosen */
-#define US_SCALE	32 /* 2^32, arbitralrily chosen */
-
 /*
  * Standard way to access the cycle counter.
  */
-- 
2.25.1

