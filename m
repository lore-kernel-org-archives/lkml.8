Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5EDC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 09:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33E1B2087D
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 09:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgIAJ14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 05:27:56 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45483 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbgIAJ1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 05:27:49 -0400
Received: by mail-lj1-f196.google.com with SMTP id c2so637710ljj.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 02:27:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bxHj9IkP2gtxX/i6bFF2tG+AqOJbAH96n0YTP0cULME=;
        b=Cv0H7/+k/if0+aIbTp+289k5Wf2HlUZBjSkxItzbUpYHTs0RU4sYGr0kMwV8e7VbTV
         mMX0LfPD0DmA9fp3Iqjc076VwsKg7WCIl4h2LaCOfRzCz+6qsXbDtcOgf7w2lG5rh1FB
         Oa/V8VOpJ73cx9US9xJ3UekpU+mD459AWrDp2mAsDG3A/BIwtjiazQKQDEwkUVrcHyOM
         zegCyN56hkPqBCsNLODm+mTsK9XUbfLu9eRUfXeEFjY7k02/2uHIjP7WV/nfrTWpqFBH
         FF5j0RMorExuIA+tsHKxtiOHQtTIN/o0PxROwg/lwHwhYckcHbRxMwAp/Sb+NScGIaUs
         HhBA==
X-Gm-Message-State: AOAM533iu0dciJUtDIP00+lYKOH1O8abSGus5BjKYtZEZf77cfEu3rzq
        SSLEv+b2lQX7Oov+eOJMhZE=
X-Google-Smtp-Source: ABdhPJx0qGwCOTQ7CSAhelVaFobcO3DyBY2PqNQwxS+oFESnC0sGXMHSiHAzBtv++XLExhGWdojKEA==
X-Received: by 2002:a2e:96cb:: with SMTP id d11mr98310ljj.239.1598952465687;
        Tue, 01 Sep 2020 02:27:45 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru. [37.110.38.130])
        by smtp.googlemail.com with ESMTPSA id t4sm152816ljh.122.2020.09.01.02.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 02:27:44 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     Denis Efremov <efremov@linux.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH] coccinelle: api: kobj_to_dev: don't warn about kobj_to_dev()
Date:   Tue,  1 Sep 2020 12:27:29 +0300
Message-Id: <20200901092729.427515-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exclude kobj_to_dev() definition from warnings.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
No changes in performance. This patch can be squashed to the
original patch with kobj_to_dev.cocci script.

 scripts/coccinelle/api/kobj_to_dev.cocci | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/scripts/coccinelle/api/kobj_to_dev.cocci b/scripts/coccinelle/api/kobj_to_dev.cocci
index cd5d31c6fe76..d0b3b9647c19 100644
--- a/scripts/coccinelle/api/kobj_to_dev.cocci
+++ b/scripts/coccinelle/api/kobj_to_dev.cocci
@@ -15,10 +15,18 @@ virtual org
 virtual patch
 
 
+@initialize:python@
+@@
+filter = frozenset(['kobj_to_dev'])
+
+def relevant(p):
+    return not (filter & {el.current_element for el in p})
+
+
 @r depends on !patch@
 expression ptr;
 symbol kobj;
-position p;
+position p : script:python() { relevant(p) };
 @@
 
 * container_of(ptr, struct device, kobj)@p
@@ -26,9 +34,10 @@ position p;
 
 @depends on patch@
 expression ptr;
+position p : script:python() { relevant(p) };
 @@
 
-- container_of(ptr, struct device, kobj)
+- container_of(ptr, struct device, kobj)@p
 + kobj_to_dev(ptr)
 
 
-- 
2.26.2

