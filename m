Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3329C433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 09:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3328206D7
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 09:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595668833;
	bh=JxxzWNv/yB8HPIdQYQ+2u7F74+wojGLf2h37gnYQ9Gc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=itQcgn4g/M6aG8SWQTh7VtrpOEeUygZOVfsaH89YZZyKaYkiGW7QJPEikceyOGhQB
	 xXSrRkV+9jI3nOpUroUZA3SNFJJ6evHRwD6rg6zhnxVGdIEueIZFpMwRFjHQJbIH+x
	 QpE04PcW/ft5dhYcBzDMeorBEqO1lpbZhvYyvY5E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbgGYJUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 05:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbgGYJU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 05:20:29 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB63C0619D3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 02:20:29 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id q4so5427447edv.13
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 02:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OzlaLxpOqNvTAJgSGmrl28i6gxj/2ZoN6+rA4dHTnpE=;
        b=GFHNfE0r2IKY55vmDvqv7tp4N0GmzgpUQFa/9hjjxMq6L2FoaCPSufacfDj0j9hlNL
         DR4+wMTdrzrzZRWos9j1Vqy7X17IYoYUKeVAGFeFVuhFwQPtmq0b3YbKH/Qjd4nlc3U6
         EVOS7QUZxyzvTTy8MfPWFBnNis1Ita2/f9J+vOJ1YnyrZPaOLjoCY+/7i6yL3F0pxjtO
         +Juoe+AAcIB3eX7Y2e5Gj6OqicDac/MVt2mIrBbduRvYe6BjWac2FJ96tbF2BSxRC4ft
         tA39yoQgB9gcd5q4YyffJ8mc5C7/b+WJETp+Iia45GqrQj9GCnmEzf/SnbNWkCj+JOjJ
         Bx6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=OzlaLxpOqNvTAJgSGmrl28i6gxj/2ZoN6+rA4dHTnpE=;
        b=bpElTysWeHosBfOb7L+KWYZjNWMleLHARr9HFt+4IE3KzWTNshb9mvNeRMgnR6kxCA
         TLjrjZ8ZbdzCUvMT52qlyqfFfhNYqX5qQXHdJFMytc0MGhzW9RWpK2K5VUeTjKB2eFtn
         MoGmAJbeV6G9p4bpjbxLNA67ujGsjlTYEai7NXVcqMWHxjjYfKUuLlUnGpCYeim8hD0l
         qyMUuAWFC9gpGy0EEzIHOHRaMIGTuCkhbWWLfd1sqSxvhHZTFQrn2IrDLY2bov5Cbmwl
         UCSGBWNcG3jyk0FNzvgaQFom8ios2CbUXscToYOFZ5hC5RDh/SCoEQ9sRFjS95noga+A
         5sPA==
X-Gm-Message-State: AOAM530Vl3I5meXqTb7ITS7xvXkpnCwgrUoA6/Zyoy2Krr7wJJnmabTN
        TpR3HkCkWr+epqhKqRcDqDeUg+9J
X-Google-Smtp-Source: ABdhPJzEw6ubvhKh69aa56sQGwxKMOBW0GdQ3Vd2HPBsVsZDgRAVLhP75DQvoe7OG+hg+hBQA1XILA==
X-Received: by 2002:a05:6402:1d97:: with SMTP id dk23mr12943171edb.1.1595668827779;
        Sat, 25 Jul 2020 02:20:27 -0700 (PDT)
Received: from localhost.localdomain (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id e1sm2549140edn.16.2020.07.25.02.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 02:20:27 -0700 (PDT)
From:   Ingo Molnar <mingo@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Subject: [PATCH 2/2] entry: Correct 'noinstr' attributes
Date:   Sat, 25 Jul 2020 11:19:51 +0200
Message-Id: <20200725091951.744848-3-mingo@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200725091951.744848-1-mingo@kernel.org>
References: <20200725091951.744848-1-mingo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The noinstr attribute is to be specified before the return type in the
same way 'inline' is used.

Similar cases were recently fixed for x86, via:

  7f6fa101dfac: ("x86: Correct noinstr qualifiers")

These 2 cases were carried over by the new generic entry code.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/entry/common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 49ed8b47773a..a6da0e4adf93 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -258,7 +258,7 @@ noinstr void irqentry_exit_to_user_mode(struct pt_regs *regs)
 	exit_to_user_mode();
 }
 
-irqentry_state_t noinstr irqentry_enter(struct pt_regs *regs)
+noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 {
 	irqentry_state_t ret = {
 		.exit_rcu = false,
@@ -335,7 +335,7 @@ void irqentry_exit_cond_resched(void)
 	}
 }
 
-void noinstr irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
+noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
 {
 	lockdep_assert_irqs_disabled();
 
-- 
2.25.1

