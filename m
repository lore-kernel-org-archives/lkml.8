Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760D6C18E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F4F2206F6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="arcA/iPT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbgCYImT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 04:42:19 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:55993 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727439AbgCYImR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 04:42:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585125736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=51rxB8X3LKaSO6kBzN9NJ6oqx+pGV1s+xW9wpseYzBI=;
        b=arcA/iPT1FPkLTTjcGDbX8/SCCJwrysFvCO1z7uLW9QFHpWVxUMz9uHFWwLajxzME3mKUa
        6yGEHZGVx7AQjLEDWE3FjaGytdwGDkGB5+KmcW1doJwUusGfLdS0+DoidjfedRksaCr3Lw
        Y7vDryxmSKrjwLFw4zGNGQOB2/X3abs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-i-P3sYwcMYGVdpeI8y2huw-1; Wed, 25 Mar 2020 04:42:15 -0400
X-MC-Unique: i-P3sYwcMYGVdpeI8y2huw-1
Received: by mail-wm1-f70.google.com with SMTP id s15so414388wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 01:42:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=51rxB8X3LKaSO6kBzN9NJ6oqx+pGV1s+xW9wpseYzBI=;
        b=Dr2X1bTS5BY65X7y+umTZgMypnsVVmS1LdgysUvfohrW32Vl/R6BpAyExoD+nawbIc
         kQkak4Ky5Ibn9xl1lQQduB2j5CNZmZ/49zZpWJejQHaA3FLROoMj+ff4ITNhvOWn4NGo
         3S/Me27+VtlYjfhScYm7n5aOuPazjd5E5scgcBs9elX8pwfGglnE2lFBtBOdvIc61j2c
         C8B8SQ2+RLPbvz4HK2g2yIe+l2+g3f0+5yP1osDCsnhYYiXcTttt9nJvhw2ARlbHbL34
         KMfDtjZtLPIonGkh7ndzptS0JmgwrIx1X14avtbEGRBhFClWcNauyDCprJPwXTbNZkFC
         DHLA==
X-Gm-Message-State: ANhLgQ0p7gds+BFmBHRRisF+UbrdGPX2jjVHAHzrDn1Np1w2EbB3+lbf
        DrFAyYJx1Me0m57NDaEZHp0HN+/JDCTdX9z4Jn5k8rBDLGe1GwVqJVIMR1UBVedB2UohnkS4uSH
        aaKjDVHOhkjOstUB7T5fZiLZZ
X-Received: by 2002:a1c:cc11:: with SMTP id h17mr2294031wmb.39.1585125733289;
        Wed, 25 Mar 2020 01:42:13 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vunehZfMGxMtiujBipZmQcbXxqUR5oj9EJKFM3KDdVL1gHpq0KQEHuRUPgVUODbCAiYcbc85g==
X-Received: by 2002:a1c:cc11:: with SMTP id h17mr2293985wmb.39.1585125732758;
        Wed, 25 Mar 2020 01:42:12 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:58d:8400:ecf6:58e2:9c06:a308])
        by smtp.gmail.com with ESMTPSA id f12sm8055323wmf.24.2020.03.25.01.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 01:42:11 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH 02/10] objtool: check: Remove redundant checks on operand type
Date:   Wed, 25 Mar 2020 08:41:55 +0000
Message-Id: <20200325084203.17005-3-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200325084203.17005-1-jthierry@redhat.com>
References: <20200325084203.17005-1-jthierry@redhat.com>
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
index a2c62bc82907..44a3abbb0b0b 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1730,15 +1730,13 @@ static int update_insn_state(struct instruction *insn, struct insn_state *state)
 
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

