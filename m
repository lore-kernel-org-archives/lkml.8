Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A998C352A4
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 22:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F17D42082E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 22:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkdMkDwP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgBIWtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 17:49:16 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42719 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgBIWtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 17:49:16 -0500
Received: by mail-wr1-f66.google.com with SMTP id k11so5232285wrd.9
        for <linux-kernel@vger.kernel.org>; Sun, 09 Feb 2020 14:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U5nFVCPFUZVGZ9tjWv0oFjWi+FTaJwKQRZfFYGfUUUg=;
        b=dkdMkDwPHQZKdjKUazNR6GkUXsK9lmR3gMf4pkpx2kZKucImYBGi9cfyx1VVT174f0
         GAE9ssVObVEdRk5VfcljHgo3DYEn9E1Plcc5EHDO5CmcTVqoRiRO8pcu/aD+rmvHdj5H
         egDBesNa+cdTpBYdXCdmRunwscECV5h+ycph1QwFPoFwcnVWY4MDvuGprlHGQCbBHjzT
         WqaznMG2Vq0soLlnJXEagGCnGy6GbBVlAI1yKsT/RGZkD8sPkv44TUFRXHj+Vh3xZ8Y4
         rEa7YRysRY1WvzPX2pLXe8dsl0Il7jIO+Vry9A9+4Fcs8Auc/ztpcyGj/kle2Nt1bQ2V
         1ieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U5nFVCPFUZVGZ9tjWv0oFjWi+FTaJwKQRZfFYGfUUUg=;
        b=bbfsSCqRd8L4eEa2x9lElnJwYJgxX04xaMHS1joXa9R34jSq0Qm5ub6NTggDe/WTCD
         gjsploC/9HR5NS3KIheigIyEB5sL8adk3AYzKh8gW4dQUkU4hF+P0xkm3UEj04lIOuo9
         C0KK+78ckeJyBZyEPWEmX35I8wiwLAbro+eIbv7fPVeTK899VVVkj3YlFuIWQ6Zri0ZI
         2qSbD5L9kAP4pu+dXeAAD4IsRMkfDzQMXT+Hy2HYjn0gdN53vU68vGEL/uf+vVwbIpea
         OFeWVKRpBYh65j+gzId5z6ObWJMDbxTPzQu07h50HeduX9Vg1+T5DVWJ3txoEd6e46qL
         Modg==
X-Gm-Message-State: APjAAAXtScDJSGacQWmtAQe9MZOAswLmf0MeUPLVrMV35PlGJJsJQfK/
        InXK2dysV8z0WnI70cb2DQ==
X-Google-Smtp-Source: APXvYqzO+y20pyXml6UJKB8Yw0sld+pLD9TNTWs0/S2aD2ieM13bT5qAjumg6QWgRYsGwyKeaA/qGA==
X-Received: by 2002:a5d:448c:: with SMTP id j12mr12604749wrq.125.1581288553707;
        Sun, 09 Feb 2020 14:49:13 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id k10sm13694884wrd.68.2020.02.09.14.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 14:49:13 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, akpm@linux-foundation.org,
        dvyukov@google.com, glider@google.com, aryabinin@virtuozzo.com,
        Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH 10/11] kasan: add missing annotation for end_report()
Date:   Sun,  9 Feb 2020 22:49:04 +0000
Message-Id: <38efa7c3a66dd686be64d149e198f2fddc3e7383.1581282103.git.jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1581282103.git.jbi.octave@gmail.com>
References: <0/11> <cover.1581282103.git.jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports a warning at end_report()

warning: context imbalance in end_report() - unexpected lock

The root cause is a missing annotation at end_report()

Add the missing annotation __releases(&report_lock)

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 mm/kasan/report.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 5451624c4e09..8adaa4eaee31 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -87,7 +87,7 @@ static void start_report(unsigned long *flags) __acquires(&report_lock)
 	pr_err("==================================================================\n");
 }
 
-static void end_report(unsigned long *flags)
+static void end_report(unsigned long *flags)  __releases(&report_lock)
 {
 	pr_err("==================================================================\n");
 	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
-- 
2.24.1

