Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CACCC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 20:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B02D2177B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 20:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBC4Vibj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgHGUK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 16:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbgHGUKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 16:10:25 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31821C061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 13:10:25 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id q9so2550092oth.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 13:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UVk3YfTD+RcRn+piTHxLap6HVr+3FCmvlsWk/IZ++2M=;
        b=dBC4VibjdRNSQ1lyKWPhM3r96dR3Zb04I2oCuL5Hw3edbvf178VwhZZiysXkOJy/bZ
         tU7BmI+qYLpp5Bi+mwaLsY+alcQVk4NmtlT7ezwgnyCvqO9A0BqxuvsMppH39DnmIW/l
         24kk4jnJlVDGVFKQIrtDr0gC7ncqIV80uOdJUGAcwvxC7L7JAOP+9r9fhXTEzxhfhVZ9
         6Nhiq3Q1zDM9pOnftsHTfJutn5n39hbw9HHav4b51RaTh/dBqHfr95dB1EWo/3OPGb1Z
         Kxp77r9FAumwJS0Xy17C5B84iDuDanKMYjB0+DdJd6GdDNCVf/CtmKDjR4uLkfid9i/w
         fBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UVk3YfTD+RcRn+piTHxLap6HVr+3FCmvlsWk/IZ++2M=;
        b=h18MqDils54nqPBjFNnSrOpS5dl30fE/8/0pe2F41voZFlshgy8XlIjDFUV6kIXF/z
         n0e1k4sFRY+jT3qOhHdFC6pgrJTgzuaruLQhqK/9DxaHAjNljsqUOU8c87G9b9NvMLHn
         7C0NXlcEBCOr15FriDCyPmUf6zp4iVSBoWcflo27OPla9Rm3Nw5NxIuQrUlT9N0HVnnL
         yT9rTWyYmQlK59arZEdfo4zZiw1eCg70sdn51w51KArrZMIotHid0JmEHzImrZjkuBjx
         kIZ7qdG0/jCdr94CCg+QsWmApFd62egizrTH2fuvZnepXuOzx9afiwD5Py+cQyYovEVO
         R5sQ==
X-Gm-Message-State: AOAM532kHWCgMJH738KStip9QXiK2/35o2t2s6E7ikbB0g9FTSoyKHbj
        ty9vWFbDvsOpvqIVQ2XIfLk=
X-Google-Smtp-Source: ABdhPJzdmPpEGSxIk4dIj8xdyDcKFMwUcApFZZoB9+uVkg9OFAwwUWqlS4jJq5k5VUt80NmokDB5aA==
X-Received: by 2002:a9d:4b90:: with SMTP id k16mr12609702otf.69.1596831024585;
        Fri, 07 Aug 2020 13:10:24 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::af38])
        by smtp.googlemail.com with ESMTPSA id s6sm1835794otq.75.2020.08.07.13.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 13:10:23 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 6/7] dyndbg: add locking around zpool-add loop in zpool-init
Date:   Fri,  7 Aug 2020 14:09:53 -0600
Message-Id: <20200807200957.1269454-7-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200807200957.1269454-1-jim.cromie@gmail.com>
References: <20200807200957.1269454-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit doesnt improve things, last commit was working, next one
still breaks, despite this "fix".  I keep it separate for the
following review, which now stated, will be refuted as needed. ;-)

Locking review:

ddebug_zpool_init(), like other *_init() routines, does no locking
itself.  Unlike them, it runs later, at late_init.  This patch doesnt
fix the kernel panic that HEAD+1 does.

ddebug_callsite_get/put() are called as a pair under mutex-lock for
all 3 callsite users, 2: ddebug_change(), dynamic_emit_prefix(), do
their own ABBA-ish LGPU (Lock-Get-Put-Unlock).

ddebug_proc_show() does the GP part, and is wrapped by
ddebug_proc_start|stop() with LU.

ddebug_add_module() does LU to protect list_add(), HEAD~1 added
ddebug_zpool_add() loop inside that protection.

This commit adds locking to ddebug_zpool_init(), around the loop of
ddebug_zpool_add(), to match the locking in ddebug_add_module().

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index fdf52a26a504..701d3d1fb7e7 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1182,8 +1182,10 @@ static void __init ddebug_zpool_init(void)
 	}
 
 	/* add-module normally does this, but not in time for builtins */
+	mutex_lock(&ddebug_lock);
 	for (iter = __start___dyndbg; iter < __stop___dyndbg; iter++)
 		ddebug_zpool_add(iter);
+	mutex_unlock(&ddebug_lock);
 
 	v2pr_info("total pages: %lu compaction: %lu\n",
 		  zs_get_total_pages(dd_callsite_zpool),
@@ -1280,4 +1282,3 @@ early_initcall(dynamic_debug_init);
 
 /* Debugfs setup must be done later */
 fs_initcall(dynamic_debug_init_control);
-
-- 
2.26.2

