Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B85C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 15:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ED9F2082F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 15:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730220AbgFHPBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 11:01:31 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:33241 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730194AbgFHPB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 11:01:26 -0400
Received: by mail-lj1-f175.google.com with SMTP id s1so20917933ljo.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 08:01:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lR7SkMxR2WvDhYKg7h/qTpiMFY/yOdg6mP8JNQ15c78=;
        b=iLiFNENYRru5l4ZrkUIkMzdlCD9ukFLPAAE5IOw7SnSVxEzVp1O5dh5N2RyAIXlhPP
         PBUXeDesH4XF0SHlw92eh9JJ3n84JJXdxZ5RgUYWgDuC6Cn0e6UC++NX0zRxXSBWDVCt
         rfScNSk38ccE93njYQ7n5DTczXYGHPaORL8Ug00BerGT1Mxl26/ynr+xTyuJN8E7hsRm
         d7cvhSCIRekVt+7iDmYOsSynSrvlW50ZflFOfkZ1Qwl3clQrVdE/aG1BOw73iajWx+4w
         jKsSe8UiQ7gi/WcIq9JgkwvbW6kV8hSv468a6EIqwHHfZo+AtrmD9oyn5k+yB54Q0h0P
         Uk/A==
X-Gm-Message-State: AOAM531Gza4gQGFngImDurxRW8ai/vtgrvNJYulduAzP0eT/SzYuM3nn
        9R6IJdOGnkKHzBkEVvClTZw=
X-Google-Smtp-Source: ABdhPJyxS9y/hUjXRm6R0Uxf68yVoHH4SPTO73VCz8t8ngQaeVrq1ectHYOH68ht0aomkffk9AQdaA==
X-Received: by 2002:a2e:800b:: with SMTP id j11mr12204281ljg.467.1591628484282;
        Mon, 08 Jun 2020 08:01:24 -0700 (PDT)
Received: from localhost.localdomain ([213.87.137.116])
        by smtp.googlemail.com with ESMTPSA id r16sm279228ljn.106.2020.06.08.08.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 08:01:23 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org,
        cocci@systeme.lip6.fr
Subject: [PATCH v2 4/4] coccinelle: api: add selfcheck for memdup_user rule
Date:   Mon,  8 Jun 2020 18:00:38 +0300
Message-Id: <20200608150038.223747-5-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200608150038.223747-1-efremov@linux.com>
References: <20200608150038.223747-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check that the rule matches vmemdup_user implementation.
memdup_user is out of scope because we are not matching
kmalloc_track_caller() function.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 scripts/coccinelle/api/memdup_user.cocci | 46 ++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/scripts/coccinelle/api/memdup_user.cocci b/scripts/coccinelle/api/memdup_user.cocci
index 8621bd98be1e..78fded83b197 100644
--- a/scripts/coccinelle/api/memdup_user.cocci
+++ b/scripts/coccinelle/api/memdup_user.cocci
@@ -14,13 +14,24 @@ virtual patch
 virtual context
 virtual org
 virtual report
+virtual selfcheck
 
 @initialize:python@
 @@
-filter = frozenset(['memdup_user', 'vmemdup_user'])
+
+definitions = {
+    'memdup_user': 'mm/util.c',
+    'vmemdup_user': 'mm/util.c',
+}
+
+filter = frozenset(definitions.keys())
+coccinelle.filtered = set()
+coccinelle.checked_files = set()
 
 def relevant(p):
-    return not (filter & {el.current_element for el in p})
+    found = filter & {el.current_element for el in p}
+    coccinelle.filtered |= found
+    return not found
 
 @depends on patch@
 expression from,to,size;
@@ -117,3 +128,34 @@ p << rv.p;
 @@
 
 coccilib.report.print_report(p[0], "WARNING opportunity for vmemdup_user")
+
+@script:python depends on selfcheck@
+@@
+coccinelle.checked_files |= set(definitions.values()) & set(cocci.files())
+
+@finalize:python depends on selfcheck@
+filtered << merge.filtered;
+checked_files << merge.checked_files;
+@@
+
+# Don't check memdup_user because the pattern is not capturing
+# kmalloc_track_caller() calls
+del definitions['memdup_user']
+
+# mapping between checked files and filtered definitions
+found_defns = {}
+for files, funcs in zip(checked_files, filtered):
+   for file in files:
+      found_defns[file] = funcs
+
+# reverse mapping of definitions
+expected_defns = {v : set() for v in definitions.values()}
+for k, v in definitions.items():
+    expected_defns[v] |= {k}
+
+for efile, efuncs in expected_defns.items():
+    if efile in found_defns:
+        not_found = efuncs - found_defns[efile]
+        if not_found:
+            print('SELF-CHECK: the pattern no longer matches ' \
+		  'definitions {} in file {}'.format(not_found, efile))
-- 
2.26.2

