Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B675C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FBAB2051A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="PuFLnGkv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731935AbgCPOnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 10:43:05 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44419 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731589AbgCPOnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 10:43:04 -0400
Received: by mail-pg1-f196.google.com with SMTP id 37so9867320pgm.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 07:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T0qqTPkX+mDcXv1jOokn32GElsZQ+Yr4A6SJDSHq5Kw=;
        b=PuFLnGkvg05+A9SgK7xJ8SaP4m9fp5PyfFn0mFmc76CxWOiGpRu8vpwbGU5ur28qeV
         lVkcwFrOgnghNLd3/NZW6uqZtJUYQHb9li1nPgAp7cn98/S7kYvrwse6xLXFm6I7ySX1
         VFEZoyKc5Zxg8/ZeUOE/dUTuX4cUhbuYE9TNqv+cBE+E88sFQ+EtxEY4wN5pcTa30INZ
         EgVqUk/NjBMFEe3MyHhg0i+iRnIAC9GGb9DnZGsMwpF2wlO0P3DOwuOtB7UDRmnTJgxW
         NmWaZuKmEUJlnKDejcfrN+DRHL/dxnP8z2Ol5G+BgusdCOFIuhXBZ/l6HSgdbdtxdo8v
         tDBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T0qqTPkX+mDcXv1jOokn32GElsZQ+Yr4A6SJDSHq5Kw=;
        b=ELieNFjEo9T38wqPfc4D3/M74MbUjl0/AQIAbDeCl3pQ4It8J9t+TxbB3vwBPyXHC9
         B3JFNb2FhVfhfNNigVGwC9Js97X0SnVMz4lGBZV1wu6KrIaYSRt1HpvR7s0SL8lw+IcS
         kN0lIwBXLlwc+TyWADAhczhaxqAIrZdqC7dRHpFf888mzLCUwU/sVPpK/AzacekBQKsb
         0vU7vs9QrLD2J9tyFDhvx7/+N9DhGyVcyAoD6Qq2dSJjS1SvSdFjNh5ieo9ya2HTrwSk
         +h6EAYEwdifPvpO4EYCJOY6xTY9zUcM7lQP6B7SwZJb89vKGd+o+nO2t3TOIMHHJO+iR
         R5Dw==
X-Gm-Message-State: ANhLgQ2ZEVd97FuCbcYLQU/3EUtviwHjTZblgFUfG5qXlZejxWxJQyJs
        EoBwnx8GqTn5adSmQrc6C5Tq2qJlDy+q0g==
X-Google-Smtp-Source: ADFU+vtV9A9Dnu1i9/nyv01E+pBw4vXUuhWmiNwqDWi1NlPpA+QZFslO9bH3x/EeFADOIxRkO+LSdA==
X-Received: by 2002:a62:6842:: with SMTP id d63mr28679997pfc.113.1584369783065;
        Mon, 16 Mar 2020 07:43:03 -0700 (PDT)
Received: from Mindolluin.aristanetworks.com ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id i2sm81524pjs.21.2020.03.16.07.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 07:43:02 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Subject: [PATCHv2 45/50] x86/amd_gart: Print stacktrace for a leak with KERN_ERR
Date:   Mon, 16 Mar 2020 14:39:11 +0000
Message-Id: <20200316143916.195608-46-dima@arista.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200316143916.195608-1-dima@arista.com>
References: <20200316143916.195608-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's under CONFIG_IOMMU_LEAK option which is enabled by debug config.
Likely the backtrace is worth to be seen - so aligning with log level of
error message in iommu_full().

Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/kernel/amd_gart_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
index 4e5f50236048..c0fdf594709e 100644
--- a/arch/x86/kernel/amd_gart_64.c
+++ b/arch/x86/kernel/amd_gart_64.c
@@ -159,7 +159,7 @@ static void dump_leak(void)
 		return;
 	dump = 1;
 
-	show_stack(NULL, NULL);
+	show_stack_loglvl(NULL, NULL, KERN_ERR);
 	debug_dma_dump_mappings(NULL);
 }
 #endif
-- 
2.25.1

