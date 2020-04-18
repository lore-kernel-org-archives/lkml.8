Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E22C3A5A0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6D2921D93
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="BE38AYxc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgDRUVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 16:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728460AbgDRUUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 16:20:33 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC55C061A0F
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:33 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id z6so6784547wml.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EftrLTbqR/l2b79ONhz8hjsbe7wmYvEa3aejci/Zgc8=;
        b=BE38AYxcvrMTfDnM4mqKTivDjpT+AxK12yB1TtSeBaZwVt3Q19svlG9PFwI0QNh2ZL
         5tc1SJqecNYeeS4/L+NLAJzUEFxyNDKnq4Yq9RyHSKt464Ju/oMINfaZSGKid/Bi43oZ
         7phr+Ud3fWHsEdiWDblqgDDFcnjr1xV1jgm+5AfkayBO3K/onaEe/FFgA5Z3wix7DM6c
         0CokXx+COV/XqSaUaWIwpMpZomzI5xOkY7LwokPHTz6Hm9OL4K7nAIBGhz7+xlxLI8v3
         ZQggrZpFPDOEWASWKsHf5kJczKur4hRDDR09NdJ9igDEUhSb5aOCyBHK0ga4BC+11rML
         8JnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EftrLTbqR/l2b79ONhz8hjsbe7wmYvEa3aejci/Zgc8=;
        b=fDoNGMufe3vGAYDPfs+E0VSp2ke1ztdwQfj8yGAGUy7vjmXF2tqForPy9mOGG6xEvT
         cshxqUHRz7v05EG2/uDuWDcb99hV2CtQqV2Rm0ddz5F0B6Yl34866wSXOXlSd5M9r8Ea
         OB1IjZhQynkwQLzDW2Eo+5jxR2xIbr+5FroJ+jbAB0OaNnzZGNXf0HRNLWcwktB+ywB2
         at/+P5+p9Drd+0cQ30T3+wyT69EKo92vfDJy7v+Rsjb5L5EPnln0TQyk7VCT8DqS9HXj
         Ljufd9YSKzmXVFTN9AXi2SjEDVr7W+iGfO8kLlC3kaLNaGFvK34pjQFyd4NaFE1QELVV
         p6tA==
X-Gm-Message-State: AGi0PuadfnL+dJnWvv76U5sF5w+BY2swRtK2L7cHO2i6IpbgJP1wOPMJ
        7LiitCoFfEo4MswCjqcpiDfwl34wsXU=
X-Google-Smtp-Source: APiQypKqr1Rll2QJ2q7MruvT+hMkJ3TObumfckuNmYGJaHraK85X64WsGIf0PnxMQyOMfkEz9ukhYQ==
X-Received: by 2002:a7b:c3d4:: with SMTP id t20mr9994487wmj.170.1587241231287;
        Sat, 18 Apr 2020 13:20:31 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id m1sm31735255wro.64.2020.04.18.13.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 13:20:30 -0700 (PDT)
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
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org
Subject: [PATCHv3 30/50] sh: Remove needless printk()
Date:   Sat, 18 Apr 2020 21:19:24 +0100
Message-Id: <20200418201944.482088-31-dima@arista.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200418201944.482088-1-dima@arista.com>
References: <20200418201944.482088-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently `data' is always an empty line "".
No need for additional printk() call.

Cc: Rich Felker <dalias@libc.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-sh@vger.kernel.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/sh/kernel/dumpstack.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sh/kernel/dumpstack.c b/arch/sh/kernel/dumpstack.c
index 6784b914fba0..2c1a78e5776b 100644
--- a/arch/sh/kernel/dumpstack.c
+++ b/arch/sh/kernel/dumpstack.c
@@ -118,7 +118,6 @@ static int print_trace_stack(void *data, char *name)
  */
 static void print_trace_address(void *data, unsigned long addr, int reliable)
 {
-	printk("%s", (char *)data);
 	printk_address(addr, reliable);
 }
 
-- 
2.26.0

