Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B73C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 21:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFA64206F1
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 21:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hi0vkaNb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbgEaVZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 17:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbgEaVZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 17:25:19 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F1AC061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 14:25:19 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id m7so3440249plt.5
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 14:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kmVcIZYi7tq7zlqymQfKPZksyT7vem5YyJXZwNg7lQI=;
        b=Hi0vkaNb3GGHsrGSHuugf23wMme3NulEbti4IQ2YbCAxsNXhjSIK18vi4krqQtD748
         KlfjlmpzdclLel58WqNjIC3NIyaQ6cdZ1mXH2TZkMkGkybPkCFvZhuTrfoqSjunUFZBf
         hCN2zTPhLp4V5tLQDFup9ovG9HG60b+K7KZxg7zKtI7V+J2KCPTsK0ZWd4H6hYCMRAy4
         rXJAZpcbyFXgasgeFH/dHFDG2DHSzD5E0NvVePECR7Cd/33DHFIiQeUrG7G3SPZlXLrU
         COJ7eEIkZiPxPO/JQZWcDBLXXv8+A+lckF4rlYeDvuQIqia0MoINLgl00dMq4UOMh0ny
         KAbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kmVcIZYi7tq7zlqymQfKPZksyT7vem5YyJXZwNg7lQI=;
        b=H/0Z2u4vkfLKKAhj0JNLfJkn6IaKs9RHW324KMlpirRIYnyGKUa9JCRurVbxSKMbn/
         5NJR7EesDsVLdocN3H73cqp2IdcvsINWxWavdT9FaO26KdgFpV63uPtSYR/FW4t2wTX+
         5szOFGXqvDH+0YkWkZVl6k1vG89sqrE/bCvoGudq7DrCNt8j2PORrOE4Oftx3bxF724T
         7Gkx6ygLtALwf8A2/80B1Pok4C/zDHKC5Qk/KL+JOPEQqZEpN0YBnftM78tmVTOejz+d
         q8wbZfm1lpdJ92nd0NlbE0oJnl4yRzLdFb/lY1mNPTWfEJlFznxnDFSOmPau/65uvMav
         qn4A==
X-Gm-Message-State: AOAM530WBplxxVxkRQiGu+1l2vur3feDtOX7FotL2I6aPcFehAkd4BQI
        4oG1ooP8N8HB/xO1enmv/Tl5D937
X-Google-Smtp-Source: ABdhPJyCKe8XsHvPArE0LgfpWKQ4EQsDmdIikKnUbwOQcDDzDzGOK97zYwmHwRNcvc2gHnsf4rnU3g==
X-Received: by 2002:a17:902:720c:: with SMTP id ba12mr16829465plb.97.1590960318237;
        Sun, 31 May 2020 14:25:18 -0700 (PDT)
Received: from localhost (g228.115-65-196.ppp.wakwak.ne.jp. [115.65.196.228])
        by smtp.gmail.com with ESMTPSA id i21sm11122876pgn.20.2020.05.31.14.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2020 14:25:17 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: [PATCH] openrisc: Fix issue with argument clobbering for clone/fork
Date:   Mon,  1 Jun 2020 06:24:59 +0900
Message-Id: <20200531212500.826332-1-shorne@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Working on the OpenRISC glibc port I found that sometimes clone was
working strange.  That the tls data argument sent in r7 was always
wrong.  Further investigation revealed that the arguments were getting
clobbered in the entry code.  This patch removes the code that writes to
the argument registers.  This was likely due to some old code hanging
around.

This patch fixes this up for clone and fork.  This fork clobber is
harmless but also useless so remove.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/entry.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/openrisc/kernel/entry.S b/arch/openrisc/kernel/entry.S
index e4a78571f883..c6481cfc5220 100644
--- a/arch/openrisc/kernel/entry.S
+++ b/arch/openrisc/kernel/entry.S
@@ -1166,13 +1166,13 @@ ENTRY(__sys_clone)
 	l.movhi	r29,hi(sys_clone)
 	l.ori	r29,r29,lo(sys_clone)
 	l.j	_fork_save_extra_regs_and_call
-	 l.addi	r7,r1,0
+	 l.nop
 
 ENTRY(__sys_fork)
 	l.movhi	r29,hi(sys_fork)
 	l.ori	r29,r29,lo(sys_fork)
 	l.j	_fork_save_extra_regs_and_call
-	 l.addi	r3,r1,0
+	 l.nop
 
 ENTRY(sys_rt_sigreturn)
 	l.jal	_sys_rt_sigreturn
-- 
2.26.2

