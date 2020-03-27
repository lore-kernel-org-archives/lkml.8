Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42CBC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 15:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B264D20774
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 15:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gmDL5RNc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgC0P3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 11:29:00 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:28055 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726454AbgC0P27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 11:28:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585322938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vfpiXXfWEPPLvr6kg+9Aru1xRL1Af2Vbjo3MlR983yE=;
        b=gmDL5RNcKptO1Pom2hPRKJdFONmkHopoCWjek/OA1eS/tSI3qGI4h7lQ2b8KcFe/FbV3n4
        nKdS0l8nSU7NyV5W9uWFc8wUyOKHlIVOl90I5oGECsBLMn2QyZesh1eLAgDfguDK7hXTfz
        cUzd6uwzzrR4z1lu1ppZ4FYeYupOLxU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-qWhbRwDPMDSG9wdaDg4qOg-1; Fri, 27 Mar 2020 11:28:57 -0400
X-MC-Unique: qWhbRwDPMDSG9wdaDg4qOg-1
Received: by mail-wm1-f72.google.com with SMTP id p18so4496059wmk.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 08:28:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vfpiXXfWEPPLvr6kg+9Aru1xRL1Af2Vbjo3MlR983yE=;
        b=jUdEncw7riwY9oPdtCB1suqFUalD7GA7ht+pLTFJ1WX8AhK1t3HnPXgiArmvhynho0
         gZb27s+W+wdhlrqRK6KPV7IiKcxlK9aIvCBUl3LpFWhC++L1hU9esXsrFWdBP5lKy6wT
         dDQnCIH5U0wl+bbqOBesWFHQssDd207zK3WQjzhjAJ1D2necDAodE7FEj62IeHatF9pE
         7EDouF55jMB4+P/WHnJ3YlfKyNBZ8Ze7hRZUxCIE7P4l271GqZ7ga664UxvlKhHFU6C+
         +SQ65wSKBdfFjmuOvImWsopbY3deNzN6AsdTq/3/89wYq56YyRyERjax6XleFHjh03fO
         lN2w==
X-Gm-Message-State: ANhLgQ042VDTR78ZsDYTNpD8cTLcQpKW2XGcs67r2XgFjAeKLj+RxOEU
        iV+i3j3NjF5lblXMXrR16awgw5KwP/rNPChZr4W3zews9e+u3qnJr7Xcegc31UvHzrKQJl/l0i3
        8UTAmgS7aSqNneyK1HlG8dE8s
X-Received: by 2002:adf:ab12:: with SMTP id q18mr16011945wrc.148.1585322935703;
        Fri, 27 Mar 2020 08:28:55 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtkesJputJ7EGlEKzxucijQUgXsHCZ4A3Nv22bIbhN4vH6Y42M7sO99njxg7VhyJNJrfD23Ug==
X-Received: by 2002:adf:ab12:: with SMTP id q18mr16011930wrc.148.1585322935521;
        Fri, 27 Mar 2020 08:28:55 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:58d:8400:ecf6:58e2:9c06:a308])
        by smtp.gmail.com with ESMTPSA id i8sm8906856wrb.41.2020.03.27.08.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 08:28:54 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH v2 02/10] objtool: check: Remove redundant checks on operand type
Date:   Fri, 27 Mar 2020 15:28:39 +0000
Message-Id: <20200327152847.15294-3-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200327152847.15294-1-jthierry@redhat.com>
References: <20200327152847.15294-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

POP operations are already in code path where destination operand
is OP_DEST_REG. There is no need to check the operand type again.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/check.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 58f4c0525ae8..3ab87e3aa750 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1717,15 +1717,13 @@ static int update_insn_state(struct instruction *insn, struct insn_state *state)
 
 		case OP_SRC_POP:
 		case OP_SRC_POPF:
-			if (!state->drap && op->dest.type == OP_DEST_REG &&
-			    op->dest.reg == cfa->base) {
+			if (!state->drap && op->dest.reg == cfa->base) {
 
 				/* pop %rbp */
 				cfa->base = CFI_SP;
 			}
 
 			if (state->drap && cfa->base == CFI_BP_INDIRECT &&
-			    op->dest.type == OP_DEST_REG &&
 			    op->dest.reg == state->drap_reg &&
 			    state->drap_offset == -state->stack_size) {
 
-- 
2.21.1

