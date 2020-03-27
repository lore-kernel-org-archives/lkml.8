Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA1D0C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 15:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC1F2078B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 15:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NYGVYV/j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgC0P3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 11:29:15 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:60513 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727899AbgC0P3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 11:29:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585322953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DqyLEln8MlRX0yU5qAej6sWIn5pQhYJbT0VIEM4XDoI=;
        b=NYGVYV/javeB3UblFcF/1oKRWzcuxmBFVeoHBGWBVzcfmMRdpBjnnqIehbK1GLMFUEeiTj
        3hSxP2GEf0VP3Yr3hH2/qib9wHrCnVweK7OCktpluYaraE1iWNDtxdItfNk3BU2w2/vLho
        u+H4/SZJYfrGvU1cGcccF/pWA2u+lBU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-DTaWfmRMP6qhrELjsOrBRw-1; Fri, 27 Mar 2020 11:29:11 -0400
X-MC-Unique: DTaWfmRMP6qhrELjsOrBRw-1
Received: by mail-wr1-f70.google.com with SMTP id d17so4681594wrs.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 08:29:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DqyLEln8MlRX0yU5qAej6sWIn5pQhYJbT0VIEM4XDoI=;
        b=D+4kPqomuZ0sAp7Ri5UU+bXmWmSJA3I5S/Eg1sLHwseTpPT7i/2Lt8hfASoqmrESqG
         m5d2xnMO8hQKRyKEyFKSJYQ+rtxjCUYtfJ/mo005HLGsbwPI/ad6UA/NHN2W7Wtbkpg0
         K8KQEYsdW/RPyPA0U3LF3UyZgTpWo0ofgZl/VEJW05yh0omJgZv36yt3cjQNuOBGKCwd
         GEkBWIGdNkEt2lL6IsaHHO5HbTX7cXZXDfr4k9OqCh+1UJ9CC02VoyeIvkUbBJkGbPdD
         sDpjw9e70zI6TTyk/7xE3qAIkhgdCrvYKAqgFtBQWXSfVgYB7a65C3GzVqwbHI+wAzjk
         pmnA==
X-Gm-Message-State: ANhLgQ096RzIlonxhdDFQma77iQPYcay3PjDpVAR2yI8Y/oB5iNj2ik2
        vy2GRCN7sv7SqH7XndPbBUkJkSVWOrRF3koLAiIcw7gvTnRod+00549fXolwaP8KVKN5pws4153
        DeBV/jp2uTZfSOj+UjMtb3O61
X-Received: by 2002:adf:f24c:: with SMTP id b12mr15252744wrp.162.1585322949250;
        Fri, 27 Mar 2020 08:29:09 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvRS2M639SIw+HSs7oPd9t1G/CBd6L5Zod30djYUu6R5CBADBxp6kNbRCUmccWdf6/J8EkFvw==
X-Received: by 2002:adf:f24c:: with SMTP id b12mr15252738wrp.162.1585322949068;
        Fri, 27 Mar 2020 08:29:09 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:58d:8400:ecf6:58e2:9c06:a308])
        by smtp.gmail.com with ESMTPSA id i8sm8906856wrb.41.2020.03.27.08.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 08:29:08 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH v2 06/10] objtool: check: Use arch specific values in restore_reg()
Date:   Fri, 27 Mar 2020 15:28:43 +0000
Message-Id: <20200327152847.15294-7-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200327152847.15294-1-jthierry@redhat.com>
References: <20200327152847.15294-1-jthierry@redhat.com>
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
index 6af14a55490d..65809c74f6a8 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1488,8 +1488,8 @@ static void save_reg(struct insn_state *state, unsigned char reg, int base,
 
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

