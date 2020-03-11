Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA081C10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 12:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BAB5222C3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 12:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J1ZrczZY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbgCKMK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 08:10:27 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:35624 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729130AbgCKMK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 08:10:27 -0400
Received: by mail-vk1-f201.google.com with SMTP id g131so864532vke.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 05:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=YodtrD4c+iO7ZsJ4tIPUxivxHJJzFvG5BVbI/GfdvIo=;
        b=J1ZrczZYyKxvFWBu8yTxaf9m6NkUPWLsq7MPPdcAPmS4BQvlawnfj3YdNYsP+NLm/Q
         OocU4IG/wQBnHMTCMvFWfX1ICUioZd7YQI6I7vYv7n7eQ6pmeYgWtesaZa2BmkxXsKIl
         /4zKR/Fae2B/ol+C9cbkMc5mUv1z3BX++G2NYuusSI3o/6y+iSlDK59oAd5b7pa2uS01
         /yyKqZQeie4VBAYfa6Ew6IP026mKYS7PemDiWkAcf833/XxE8N4he/Fp7I87v3HuvEDM
         5zEXKMAFivjA/golRRKhrTQ+SGE85WEbqcOuEMqBRuKAdYhhuBGGTheWkQoHtKpjlA8Z
         XFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=YodtrD4c+iO7ZsJ4tIPUxivxHJJzFvG5BVbI/GfdvIo=;
        b=MowGE4rp5hV8l70h5R/oTnAkkfT+Bi0F+1EtCG4RzHpDijEt/kiFbZKE4UNY2TM9jX
         mfVzQlenQ8Q8+vLSrRBCwMKEsXJ3GV6nej69FqEExEIUDvtXXAEjJZXFA+AkNaSW9rOv
         6WeZ4AIQnvBMc1OOAUOXEV/w9gLtVbwbztxr4XUwkyOmek1eEQvBUw9tp91E+IgesaOA
         mUiyVUWvjrRe4ptfCB7jbVWhbyO8ZjBCmrfi0LJaawRUHCpRRZzSjy5NBv+ExmiqfwV/
         kochlTv44600ulnwwlLfr9V69FL2vmbI22XeeynLA6zCFa8XwPA+lmd/KcEVnrIPveBt
         BxIg==
X-Gm-Message-State: ANhLgQ1GM8J1v6cWTu+xbbEtQ7cUXb/6mxfuR8QXiF0uLfbPoEaSZqJU
        IdHP6DTFiDYw2hgK9HQ+S78nLKQq3Jk=
X-Google-Smtp-Source: ADFU+vtvNwvld4hNXzu4dHEiNmN0mWLQk9delEO/J3qN4PY2cdXlyrvp1yUpGauRN780SIUAj56UlqOcPjs=
X-Received: by 2002:ab0:2a0c:: with SMTP id o12mr1404538uar.72.1583928625509;
 Wed, 11 Mar 2020 05:10:25 -0700 (PDT)
Date:   Wed, 11 Mar 2020 13:10:02 +0100
Message-Id: <20200311121002.241430-1-glider@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH 1/2] nds32: linker script: add SOFTIRQENTRY_TEXT
From:   glider@google.com
To:     green.hu@gmail.com, deanbo422@gmail.com
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        Alexander Potapenko <glider@google.com>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This section is required for lib/stackdepot.c to link, as
filter_irq_stacks() accesses __softirqentry_text_start and
__softirqentry_text_end.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 arch/nds32/kernel/vmlinux.lds.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/nds32/kernel/vmlinux.lds.S b/arch/nds32/kernel/vmlinux.lds.S
index f679d33974366..7a6c1cefe3fe5 100644
--- a/arch/nds32/kernel/vmlinux.lds.S
+++ b/arch/nds32/kernel/vmlinux.lds.S
@@ -47,6 +47,7 @@ SECTIONS
 		LOCK_TEXT
 		KPROBES_TEXT
 		IRQENTRY_TEXT
+		SOFTIRQENTRY_TEXT
 		*(.fixup)
 	}
 
-- 
2.25.1.481.gfbce0eb801-goog

