Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CE3C3524B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 06:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E5C21927
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 06:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCYha+mT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgBDGYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 01:24:54 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:54191 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgBDGYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 01:24:54 -0500
Received: by mail-pj1-f68.google.com with SMTP id n96so883968pjc.3;
        Mon, 03 Feb 2020 22:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Yg+U4g0VQ9JjHK7VoXj7frcUzqQJWVT25c0GFFafzNE=;
        b=lCYha+mTyPJoDO/uh3UJ5TBZ7gWyjEBZUQH1iJX9G5Mpqv2aKv6X8F/qqxMDKMVEFs
         JIeFTY1PnHna2CcffrPvQYQi7GPgT4Kf8bG5uHeVQp8/1gtszewaEpVqIh+Fg2KBG5Io
         TYlFdeQB3xt9PDx5MNKB0Uk0sLHRKF+22/N14Fg5euQJ83OPuV6cxqp/SssSYcQ17p4f
         ylaTAG4wh5xs3XVuP+c3IvxOeVoHG9wDaNdLlFppvjPpTj7cOHMOg7sGKbxOuKcBWvjb
         Ez/UbmZLEnt7a5XtPCzDGPZjfp9dWb1lG6fGJJzzbxRAKYSO1vIjEbyK+Wwk2JMEApK1
         RVjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Yg+U4g0VQ9JjHK7VoXj7frcUzqQJWVT25c0GFFafzNE=;
        b=SrgnbkBNfIjVA1fmQyw9/s9oM4bV0+b9eK5jF3jtOoexU++uyilx2UaWZjy+3BJRqC
         8Spz/uBohnZA4LpWlKb/uF0O2BdeA2weE2VYoNlRVXng7xd3Sg5nldNgBzr954UCyBRS
         91OWc2jA9KXlRE439hGR0uhlRwoTeM6BkT49oZtiYdk7IqqJKKwlekNcpXMDa8Us3g1o
         zWYfJptufbB91c4GDQ0S3ojcd+cmskYxQbi1aYSprCmZ/kFmltS+hIy56WovXojri/Cc
         nJBcP/3grBXn6u75zr1ykavVaVLsvgdl5ipmtvz6v1tM8FGqIycx2izVDU8E60yF3q3c
         237g==
X-Gm-Message-State: APjAAAWsz7dlzqXMwg8PZ5Q1WdnOfMiH/Su6nk8egdCvXB6kbRewuVTS
        ENsf5DZT7R0BvsCHb/dWn4g=
X-Google-Smtp-Source: APXvYqzsiPH3z3QXUkxwg4BrC95Um7h64xg01kTzqkC6l9UapgN5jGvOYlsBYWOnwmsQzEvGtY9low==
X-Received: by 2002:a17:90a:8a0c:: with SMTP id w12mr4177948pjn.61.1580797492983;
        Mon, 03 Feb 2020 22:24:52 -0800 (PST)
Received: from localhost.localdomain ([106.254.212.20])
        by smtp.gmail.com with ESMTPSA id u26sm21880240pfn.46.2020.02.03.22.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 22:24:52 -0800 (PST)
From:   sj38.park@gmail.com
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sjpark@amazon.de>, acme@kernel.org,
        alexander.shishkin@linux.intel.com, amit@kernel.org,
        brendan.d.gregg@gmail.com, brendanhiggins@google.com, cai@lca.pw,
        colin.king@canonical.com, corbet@lwn.net, dwmw@amazon.com,
        jolsa@redhat.com, kirill@shutemov.name, mark.rutland@arm.com,
        mgorman@suse.de, minchan@kernel.org, mingo@redhat.com,
        namhyung@kernel.org, peterz@infradead.org, rdunlap@infradead.org,
        rostedt@goodmis.org, sj38.park@gmail.com, vdavydov.dev@gmail.com,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/11] MAINTAINERS: Update for DAMON
Date:   Tue,  4 Feb 2020 06:23:12 +0000
Message-Id: <20200204062312.19913-12-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200204062312.19913-1-sj38.park@gmail.com>
References: <20200204062312.19913-1-sj38.park@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit updates MAINTAINERS file for DAMON related files.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 56765f542244..bad6ebfe56e5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4611,6 +4611,17 @@ F:	net/ax25/ax25_out.c
 F:	net/ax25/ax25_timer.c
 F:	net/ax25/sysctl_net_ax25.c
 
+DATA ACCESS MONITOR
+M:	SeongJae Park <sjpark@amazon.de>
+L:	linux-mm@kvack.org
+S:	Maintained
+F:	Documentation/admin-guide/mm/data_access_monitor.rst
+F:	include/linux/damon.h
+F:	include/trace/events/damon.h
+F:	mm/damon-test.h
+F:	mm/damon.c
+F:	tools/damon/*
+
 DAVICOM FAST ETHERNET (DMFE) NETWORK DRIVER
 L:	netdev@vger.kernel.org
 S:	Orphan
-- 
2.17.1

