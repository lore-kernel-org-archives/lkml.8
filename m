Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042E2C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 13:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB2CB2076E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 13:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0nSr2tS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgCRNRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 09:17:10 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38385 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbgCRNRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 09:17:10 -0400
Received: by mail-pg1-f193.google.com with SMTP id x7so13676591pgh.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 06:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2+U35ps0aH14e4QA9fUiYELl4BDn2bd+PIQVIun5WPY=;
        b=h0nSr2tSTlQIXvitLaXqVjVhyptb+pIh5uW38ibDY+gEeDJbqjb/cQfml6h4ZIAHD4
         hVC+EwORVwMojzkyIVXx+tZ7/5kaIne4/j5EMLj0Iy8a/WiQbvuhK4QiBnqJZ5k/hE3u
         1nBXP5KVIo+8UyJmEyT9j9rs5xk6v/cm2lLWaklmUJi0yR2gEUkCJ0N90Ulq0taAyLsK
         85nn1cHmsO4JHOfO5A24RK+NPCG+Qb2Pn4pxR43FrlFBJUja2GOAHo6wr35UcbBv0Qvp
         urZlq7OjYIQhF+ipvHtuVpmug77wR3pPODyGaaNV5TKhAR/QOBQwNQyyOLxCnM6OQT1o
         bSGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2+U35ps0aH14e4QA9fUiYELl4BDn2bd+PIQVIun5WPY=;
        b=iSLKAKY7m/dAT6IA5k14D3vf7Vc7cvfv3Ay7W1KuftMoLkQn86ThykU/Rz9VvT6C/D
         cxkDyaU8Ej6+N3I4HaMVlVbQrb4fuB8DgHBc0cncnx/eBePLOHZWLotC5vouLtgVO93M
         AfCxVgs8BBackv2dJyHW09uQEPKrB0vUDEuWVC4UFhvp7qJSQVJwXm8yuZ4aQjr+IYfJ
         RX/yeqm0/A89nWJZKC9ItFm5OQn268FyDSF9tCD6c+Qortun1FLBYhjTSJBRnJgdfSYf
         G2v/UZj9pV+btil0LsmiJmhOuATn0MzacdSIyF5SWjm2sqEDpPKOsJJmbGuq6G/SCr4o
         ZRGA==
X-Gm-Message-State: ANhLgQ2WIVKAQj5Z00I72DQk+bumWBV+KjDqSQq4tO5paWSBBQ3F3Z1L
        o6M8UNbkhwmT2vQSnLM2BtL3hkIg
X-Google-Smtp-Source: ADFU+vsTr5Mjb/W9VzG8oSt1VbdU5m6ZOzenwBs8ZuyKA6uu35mje+fFq/dhhtuMH/VVdatIUgYC1g==
X-Received: by 2002:a63:375b:: with SMTP id g27mr4528506pgn.151.1584537428184;
        Wed, 18 Mar 2020 06:17:08 -0700 (PDT)
Received: from localhost (g44.115-65-203.ppp.wakwak.ne.jp. [115.65.203.44])
        by smtp.gmail.com with ESMTPSA id q20sm6573937pfh.89.2020.03.18.06.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 06:17:07 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        openrisc@lists.librecores.org
Subject: [PATCH] openrisc: Remove obsolete show_trace_task function
Date:   Wed, 18 Mar 2020 22:17:02 +0900
Message-Id: <20200318131703.17601-1-shorne@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function show_trace_task() was removed during linux 2.5 development
and replaced with show_stack().  This was never impemented for openrisc
but must have got in via copying from another architecture.  Just remove
it.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/traps.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
index 932a8ec2b520..c11aa2e17ce0 100644
--- a/arch/openrisc/kernel/traps.c
+++ b/arch/openrisc/kernel/traps.c
@@ -55,13 +55,6 @@ void show_stack(struct task_struct *task, unsigned long *esp)
 	unwind_stack(NULL, esp, print_trace);
 }
 
-void show_trace_task(struct task_struct *tsk)
-{
-	/*
-	 * TODO: SysRq-T trace dump...
-	 */
-}
-
 void show_registers(struct pt_regs *regs)
 {
 	int i;
-- 
2.21.0

