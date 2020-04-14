Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD3FC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E63702076C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L6GM5cBJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633325AbgDNUmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 16:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729251AbgDNUmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 16:42:45 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA33C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 13:42:45 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 71so787298pgg.23
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 13:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2I4WctQI04EdVNnfO5lBoNqQ0BOagrVFsoryQp+bCLA=;
        b=L6GM5cBJqkKVg5zJHTT3FNf5PifBt04sqQpo6G+cq90o8x9xVr9Zmhkf7uJMX6SA8l
         C4oDGWtZ6a4Xt52qk9koWnkHKLhZXLh/CrxmKzWMMRN/BPDrTzweb2634OSKWci8MzbT
         e5Te+HFfxMc5Qc3FVrCso5I1UKg/TUFv8LZysVg7D7Q7ozxQIuetn42l8vwgCezfuA8W
         l42PmfDaeD+RWBh3pzpMpzfXeTDXRHWhossBAGJlq2/vHyiHIny2+STqv7glSmF9f+4B
         nW4uCxMQWyQa+1yeSY2zYhj1faxNF3ckLdMnF8DXPzcDWVsYmLk3AgMDjG60L7jACpEt
         k+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2I4WctQI04EdVNnfO5lBoNqQ0BOagrVFsoryQp+bCLA=;
        b=EkFqdchVQa3JqkhZczUdcar6umlfGAdKt/GvgERRkln/qCShT+kX47lQVZ5LKZPKKL
         +RZNbaHtWuybJfd7Y2U09Q16DN4E9MvHbZjPsgjwTI5Pj0gQ+q7v2cTJax/tfuWYW6Dl
         SyFsMwmmYKlgqIClU6VxLkOVNTbKU6jQTvXYM96J/qqC4luGgyg4hY3GzxCRz4NBSUKg
         lU37Jp4VqPQcXR7MbQS+Lq+5UC421jTfVtpe4T3MzHj7RZW1l1Kspms0ISLL29rjjHJz
         vrzbtH7Ph1rIG6/Vz5LYQroq5uVBn6tZnvXRtZM99rVfc0uDYO/Au118cvIutr8c4A6O
         7HDQ==
X-Gm-Message-State: AGi0Puby+0cehpbcYpUp2d3pk3/YGN1WEEFy63KKhdqrS9q9tb7QNxfC
        2HneiZ/kFDRXJJea1g/yr42NtDOdFmm+Eaos6mvWPQ==
X-Google-Smtp-Source: APiQypJzWAJm5j7iwmdejE8yFesxbFduUzJRhz3WDXDmtbZpHCJ0E8FSgVtgYRMEJWgRaApGIHBybA+XIbEp/X+jPyRY3g==
X-Received: by 2002:a17:90a:be18:: with SMTP id a24mr2099925pjs.92.1586896964526;
 Tue, 14 Apr 2020 13:42:44 -0700 (PDT)
Date:   Tue, 14 Apr 2020 13:42:40 -0700
Message-Id: <20200414204240.186377-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH v1] kobject: make sure parent is not released before children
From:   Brendan Higgins <brendanhiggins@google.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, naresh.kamboju@linaro.org,
        sakari.ailus@linux.intel.com, andy.shevchenko@gmail.com,
        hdegoede@redhat.com, rafael.j.wysocki@intel.com,
        linux-kselftest@vger.kernel.org, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, andriy.shevchenko@linux.intel.com,
        shuah@kernel.org, anders.roxell@linaro.org,
        lkft-triage@lists.linaro.org, linux@rasmusvillemoes.dk,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Previously, kobjects were released before the associated kobj_types;
this can cause a kobject deallocation to fail when the kobject has
children; an example of this is in software_node_unregister_nodes(); it
calls release on the parent before children meaning that children can be
released after the parent, which may be needed for removal.

So, take a reference to the parent before we delete a node to ensure
that the parent is not released before the children.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Fixes: 7589238a8cf3 ("Revert "software node: Simplify software_node_release() function"")
Link: https://lore.kernel.org/linux-kselftest/CAFd5g44s5NQvT8TG_x4rwbqoa7zWzkV0TX+ETZoQdOB7OwXCPQ@mail.gmail.com/T/#m71f37f3985f2abd7209c8ca8e0fa4edc45e171d6
Co-developed-by: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---

This patch is based on the diff written by Heikki linked above.

Heikki, can you either reply with a Signed-off-by? Otherwise, I can
resend with me as the author and I will list you as the Co-developed-by.

Sorry for all the CCs: I just want to make sure everyone who was a party
to the original bug sees this.

---
 lib/kobject.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/kobject.c b/lib/kobject.c
index 83198cb37d8d..5921e2470b46 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -663,6 +663,7 @@ EXPORT_SYMBOL(kobject_get_unless_zero);
  */
 static void kobject_cleanup(struct kobject *kobj)
 {
+	struct kobject *parent = kobj->parent;
 	struct kobj_type *t = get_ktype(kobj);
 	const char *name = kobj->name;
 
@@ -680,6 +681,9 @@ static void kobject_cleanup(struct kobject *kobj)
 		kobject_uevent(kobj, KOBJ_REMOVE);
 	}
 
+	/* make sure the parent is not released before the (last) child */
+	kobject_get(parent);
+
 	/* remove from sysfs if the caller did not do it */
 	if (kobj->state_in_sysfs) {
 		pr_debug("kobject: '%s' (%p): auto cleanup kobject_del\n",
@@ -693,6 +697,8 @@ static void kobject_cleanup(struct kobject *kobj)
 		t->release(kobj);
 	}
 
+	kobject_put(parent);
+
 	/* free name if we allocated it */
 	if (name) {
 		pr_debug("kobject: '%s': free name\n", name);

base-commit: 8632e9b5645bbc2331d21d892b0d6961c1a08429
-- 
2.26.0.110.g2183baf09c-goog

