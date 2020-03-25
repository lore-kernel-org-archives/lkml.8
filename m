Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8425AC18E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C2652073E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N3LZN0My"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbgCYImk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 04:42:40 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:30197 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727442AbgCYImX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 04:42:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585125742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5HVI2W6fr/+4cyEErTt71G4IXrR6DcIMT5jhV/dd41c=;
        b=N3LZN0My+Qxg4HNYqcqEJiqiVzUWs3la2aQ0bIIOeffocm0ZK/sla2ZQCehJ/ggQUpYA8N
        pymMi7XyKZowTRDgH9d+x6AQmr/0N1JP9vC/uudgAT/wQQUcZgtDlATpZSZQT3QvKUQDeL
        m8ONMg3yY8LWR2rdXs/M/Hvx4uwEgOg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-qPL4pY1sPXu54ysXbQD7hQ-1; Wed, 25 Mar 2020 04:42:20 -0400
X-MC-Unique: qPL4pY1sPXu54ysXbQD7hQ-1
Received: by mail-wr1-f69.google.com with SMTP id i18so790833wrx.17
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 01:42:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5HVI2W6fr/+4cyEErTt71G4IXrR6DcIMT5jhV/dd41c=;
        b=fBajI1XkglEB0vXtkbQUCYl04FikgJrPkJoLkBRHxaunfMfx9ZD5kuc7VIgWrFr0Pa
         kAfQH7fSpAglWp/uOfNhk5EWi8Ph4IyvjwyoDxRLCxA7mBRDJ+7qYNOQxOCi9m0o31q/
         7Yuz0u4+8n+sHAW3vARaDe4S7Un+Go11Db31gX3PhAGxPJwAKs70XnQ7Dpoiv6cLR/FW
         pufev/mn1tPF1HIRf0wkRSquRsZ8SXcjMbzVlCvrljGhZmN9zVYx8UsZzWHIGEZh0p8k
         tRPFrvRpw9KcUkHzgqOrLjU+OhfuEdfWG05p97BJEx8OnJASvS5TptYqHhov+ng1IjMD
         Pegg==
X-Gm-Message-State: ANhLgQ0aAdhqQNOA+M0FyWkJvraG3h+1qNXo4LggQtajv0O0jjN6KCYG
        cxB0r6mB98hHN0WIMH8l3dznLPi9xXo/cvqN4B++pm35Yi2bVsPkvBLfidzCTEjrqIGbHW/I/q3
        gHBv6fuJTiaVx52IfJfb7pgDv
X-Received: by 2002:adf:9465:: with SMTP id 92mr2204017wrq.122.1585125738390;
        Wed, 25 Mar 2020 01:42:18 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vv7BwDD2SdbvU1R3h86Qs9oxq8u1/0pJB6Ih7oQviZ3JSRocjcPar/MmJCMD68sh+RJF3DJMQ==
X-Received: by 2002:adf:9465:: with SMTP id 92mr2204004wrq.122.1585125738252;
        Wed, 25 Mar 2020 01:42:18 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:58d:8400:ecf6:58e2:9c06:a308])
        by smtp.gmail.com with ESMTPSA id f12sm8055323wmf.24.2020.03.25.01.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 01:42:17 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH 06/10] objtool: check: Use arch specific values in restore_reg()
Date:   Wed, 25 Mar 2020 08:41:59 +0000
Message-Id: <20200325084203.17005-7-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200325084203.17005-1-jthierry@redhat.com>
References: <20200325084203.17005-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initial register state is set up by arch specific code. Use the value
the arch code has set when restoring registers from the stack.

Suggested-by: Raphael Gault <raphael.gault@arm.com>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/check.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index b8c288c02c99..7bf4dbc2e31f 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1501,8 +1501,8 @@ static void save_reg(struct insn_state *state, unsigned char reg, int base,
 
 static void restore_reg(struct insn_state *state, unsigned char reg)
 {
-	state->regs[reg].base = CFI_UNDEFINED;
-	state->regs[reg].offset = 0;
+	state->regs[reg].base = initial_func_cfi.regs[reg].base;
+	state->regs[reg].offset = initial_func_cfi.regs[reg].offset;
 }
 
 /*
-- 
2.21.1

