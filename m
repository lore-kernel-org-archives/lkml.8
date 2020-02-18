Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098C8C3402F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 02:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD5F4215A4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 02:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581993728;
	bh=ENuIonxA9t7MXcbRtsH6Z/8DcbDtTbt/JJI0qGNDi04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=quc5DKQ+nyIUxSF8EicuVYwtrshCTE2RAEsw7L+lR9Y05aaRnZd6rGM7CQTr7Dwfb
	 9iSbl/fqv6f6UKxd4i3TW7qXIZlDD/rJsWTO4CU6iuxYz94P1lHhGzGTwGaYYHUoxE
	 7xY59W8s7+nQduX8Wl3tA00Tz9XiY/jkvhD9XnWE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgBRCmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 21:42:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:54474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726569AbgBRCl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 21:41:58 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B285B22527;
        Tue, 18 Feb 2020 02:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581993717;
        bh=ENuIonxA9t7MXcbRtsH6Z/8DcbDtTbt/JJI0qGNDi04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xy6vTA9/gmquwU0JXvdXa55QQ+rrtT+sN9tqiQ7Ngxu5eFnb/3uwUe5Vg+xFDt4fw
         o5SNKjg3UWFgBTOgKldUbe0e8u3VebqnTpyKpTYjkHluh+TGeUCaVGdC8jsAxHYv2D
         NpL1X/+/O2HMsct1pwzPPtke9R9phj0OYEZKwyvU=
From:   Sasha Levin <sashal@kernel.org>
To:     mingo@kernel.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, jolsa@redhat.com,
        alexey.budankov@linux.intel.com, songliubraving@fb.com,
        acme@redhat.com, allison@lohutok.net,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 11/11] tools/lib/lockdep: call lockdep_init_task on init
Date:   Mon, 17 Feb 2020 21:41:33 -0500
Message-Id: <20200218024133.5059-12-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200218024133.5059-1-sashal@kernel.org>
References: <20200218024133.5059-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We now have to explicitly call lockdep_init_task() when starting up.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/lockdep/preload.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/lib/lockdep/preload.c b/tools/lib/lockdep/preload.c
index 8f1adbe887b2f..578fdeda9422c 100644
--- a/tools/lib/lockdep/preload.c
+++ b/tools/lib/lockdep/preload.c
@@ -9,6 +9,8 @@
 #include "include/liblockdep/mutex.h"
 #include "../../include/linux/rbtree.h"
 
+extern struct task_struct *__curr(void);
+
 /**
  * struct lock_lookup - liblockdep's view of a single unique lock
  * @orig: pointer to the original pthread lock, used for lookups
@@ -421,6 +423,8 @@ __attribute__((constructor)) static void init_preload(void)
 	if (__init_state == done)
 		return;
 
+	lockdep_init_task(__curr());
+
 #ifndef __GLIBC__
 	__init_state = prepare;
 
-- 
2.20.1

