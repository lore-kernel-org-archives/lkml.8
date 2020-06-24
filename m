Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B415C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AA90206EB
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q+doV4+Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404197AbgFXPCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404182AbgFXPCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:02:01 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66368C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:02:01 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id i4so1274178pjd.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wi0jvksoTHpVyCfm1g7AC1LGQmraHN9CrSpvP+vNrxQ=;
        b=q+doV4+QJo4SQbToZ6CFts6JlJmwHSih6rFDYKWnzMwT2ismKWonlG1ioACjQG9y2T
         WuQ1tuzvxTkHA5eGy8u6zdJFuYmdlJvOuRNbEuqLQqcJEVLdkT+bFHNrKYP3Kdsn+WvJ
         7wR9eiuaAawdmty7se0A2foSPz2LnWVpq7sKy0oWa8tSziNaDqOIiN/YX5deP4ffPwhf
         DYpP/52GEq8QICE5TbvKca7hr7qUQuQU67KfplMVYPkNsTazsIy78nC+Ie2rznB79z0R
         6/QWNKU/jKzvg2zqP1B45GnpOEIfh8feOfehXs7tuYHSG3yuU+MfPVmW7i8UQu2mL5Q4
         8W8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wi0jvksoTHpVyCfm1g7AC1LGQmraHN9CrSpvP+vNrxQ=;
        b=ZJUdPdgj5LaPywUXLhNB6NaiSceb5mOYZ28cFOy/YfPwxsF2QQt24chi/V3TA3BIH3
         bcz+p47vpjrbh2xeNG94bFfhhDNaoXwo+xqUvet6x4y3qCpH7PVeMIOwMJpOLqbCLoB7
         UPVgXYTR6XLxv8oFGntdO33AWwPqD6nDHUcBfliUo43Umf4Mu+2mz2fIEHeC9roE0V/M
         1bWhnrN6CTBtTUlbZjrLioLk8/Ku2ErYF2s5HLqL0JIRU2Hq/YFRf29IQoDk9+oQAeUF
         jCE+SNUTVywPd0fjIsvlDsbaYJQ5EqZlJOGlTZac3vDPf+T4TfrY+c536Yo7Cmf6TIOO
         G8HQ==
X-Gm-Message-State: AOAM532OmrvaTJaPAcqjh8L9MAs1gYAcJ3Kb+OGMP+mcrHnUdUsqOJXp
        HSdjTnH7ZuhlL/ULhblePw==
X-Google-Smtp-Source: ABdhPJycIQtUBi2ck6YMbwEqrTTpRgSmkaqsBpcn8fO7eaJF9vdBD7QAFHcvomHd6q/iBO+H84EXpg==
X-Received: by 2002:a17:902:326:: with SMTP id 35mr28823660pld.301.1593010920918;
        Wed, 24 Jun 2020 08:02:00 -0700 (PDT)
Received: from ip-172-31-41-194.ap-northeast-1.compute.internal (ec2-52-199-21-241.ap-northeast-1.compute.amazonaws.com. [52.199.21.241])
        by smtp.gmail.com with ESMTPSA id i125sm17013705pgd.21.2020.06.24.08.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 08:02:00 -0700 (PDT)
From:   nao.horiguchi@gmail.com
To:     linux-mm@kvack.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, osalvador@suse.de, tony.luck@intel.com,
        david@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
        zeil@yandex-team.ru, naoya.horiguchi@nec.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/15] mm,hwpoison: Un-export get_hwpoison_page and make it static
Date:   Wed, 24 Jun 2020 15:01:28 +0000
Message-Id: <20200624150137.7052-7-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200624150137.7052-1-nao.horiguchi@gmail.com>
References: <20200624150137.7052-1-nao.horiguchi@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

Since get_hwpoison_page is only used in memory-failure code now,
let us un-export it and make it private to that code.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 include/linux/mm.h  | 1 -
 mm/memory-failure.c | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git v5.8-rc1-mmots-2020-06-20-21-44/include/linux/mm.h v5.8-rc1-mmots-2020-06-20-21-44_patched/include/linux/mm.h
index e6ff54a7b284..050e9cffc2ea 100644
--- v5.8-rc1-mmots-2020-06-20-21-44/include/linux/mm.h
+++ v5.8-rc1-mmots-2020-06-20-21-44_patched/include/linux/mm.h
@@ -2995,7 +2995,6 @@ extern int memory_failure(unsigned long pfn, int flags);
 extern void memory_failure_queue(unsigned long pfn, int flags);
 extern void memory_failure_queue_kick(int cpu);
 extern int unpoison_memory(unsigned long pfn);
-extern int get_hwpoison_page(struct page *page);
 #define put_hwpoison_page(page)	put_page(page)
 extern int sysctl_memory_failure_early_kill;
 extern int sysctl_memory_failure_recovery;
diff --git v5.8-rc1-mmots-2020-06-20-21-44/mm/memory-failure.c v5.8-rc1-mmots-2020-06-20-21-44_patched/mm/memory-failure.c
index d2d6010764e7..48feb45047f7 100644
--- v5.8-rc1-mmots-2020-06-20-21-44/mm/memory-failure.c
+++ v5.8-rc1-mmots-2020-06-20-21-44_patched/mm/memory-failure.c
@@ -925,7 +925,7 @@ static int page_action(struct page_state *ps, struct page *p,
  * Return: return 0 if failed to grab the refcount, otherwise true (some
  * non-zero value.)
  */
-int get_hwpoison_page(struct page *page)
+static int get_hwpoison_page(struct page *page)
 {
 	struct page *head = compound_head(page);
 
@@ -954,7 +954,6 @@ int get_hwpoison_page(struct page *page)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(get_hwpoison_page);
 
 /*
  * Do all that is necessary to remove user space mappings. Unmap
-- 
2.17.1

