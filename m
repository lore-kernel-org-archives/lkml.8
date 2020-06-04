Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECA2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 527C52072E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ub4mWTHg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbgFDQmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 12:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729115AbgFDQmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 12:42:13 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B57EC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 09:42:13 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id f187so8655866ybc.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 09:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=pofY5UnHBtE2yEYmKDPS6cR9bq/E80+ZeaPnrnMNK98=;
        b=ub4mWTHgAmvJMZjGWw+3krHG/dMMay/tEALCX2G/rPbqjl75Y1uFKqie5t1rgrrhON
         mSo60E/ut95d77LLkZkje/FzRws70wUBRcAvqqI6aATgZOEQANEMIjEbyhsrSIwC/se1
         +gGkOGCIm1IyRrH4kWj4cbjTNvz6C+D4ft584XFWfpJ7iRrH7vNHTY3oULr4Z6pRVU6G
         BavBT5hfTMSMPCNrPtuEOHmz9ygqHX4Urzmv6tacLepDNsToQeLuvQr0aZV2GY+d7uvc
         FqYz0BricpkB/+MN9552QQhFDDWbsbpx/QxKWrc7keuS8FBrMpqkSeSwwHcn2IhJ2wAB
         UILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=pofY5UnHBtE2yEYmKDPS6cR9bq/E80+ZeaPnrnMNK98=;
        b=jNkDN7oAxMaBI8Gq4xoNAM0w9kZVbjTjtyLX0K0oQSRPodaLpDKf32Wy6PRjCbV5QW
         zZqsu5KHkqAdSQn/h2a+wTQ2wGVGHnOoL6GprBQzavyQwim0zm4MNTVZSzxqDI7wyg0b
         xQHXva95fe2futZggOBim/Jjy53/i1VCW2Vm6oZs2aTSTMjmx0xNVW4eSsaMHcTEpHN8
         7N2ZF862v8XTgmR+OU3OQLOloALlfWe4ckJVfNIckU2A61bUh3b3m0fOosDuLvxRZbfA
         sviZhfK7AL0OR53axMB/u4Uz/vuhKM9ikyhXnosJ85B5ozroutt82IyBOSRFcS+4mXsu
         ATwg==
X-Gm-Message-State: AOAM532gGESV17o3QKlIMxrLEewKOGwNL5sytSkVLo9PAftyG+caEEGJ
        BxCCRhClUFSCgCg3SX+GYrt2Ak38cXVcD77cGz5HHturxaPoXV+rZ7Lw1G5h35qmrCawVuZOfAm
        jR0nVI/tBejd00GL/czCV8sY+rwlL1cw9lavtlfMklPVUWGXRmt9fyXANooph9CZTHD06+2g6Q+
        w=
X-Google-Smtp-Source: ABdhPJzuB/YAm+byvdwGw2WfFvD+78kMp/xSR/rtbn2s7vqMXsI0/43mdS+H2sOvX7lbvdCDP2L90nRRZYLC1A==
X-Received: by 2002:a25:5804:: with SMTP id m4mr9094629ybb.488.1591288932392;
 Thu, 04 Jun 2020 09:42:12 -0700 (PDT)
Date:   Thu,  4 Jun 2020 18:41:45 +0200
Message-Id: <20200604164145.173925-1-maennich@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.rc2.251.g90737beb825-goog
Subject: [PATCH] scripts: add dummy report mode to add_namespace.cocci
From:   Matthias Maennich <maennich@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, maennich@google.com,
        Julia Lawall <julia.lawall@inria.fr>,
        YueHaibing <yuehaibing@huawei.com>, jeyu@kernel.org,
        cocci@systeme.lip6.fr, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running `make coccicheck` in report mode using the
add_namespace.cocci file, it will fail for files that contain
MODULE_LICENSE. Those match the replacement precondition, but spatch
errors out as virtual.ns is not set.

In order to fix that, add the virtual rule nsdeps and only do search and
replace if that rule has been explicitly requested.

In order to make spatch happy in report mode, we also need a dummy rule,
as otherwise it errors out with "No rules apply". Using a script:python
rule appears unrelated and odd, but this is the shortest I could come up
with.

Adjust scripts/nsdeps accordingly to set the nsdeps rule when run trough
`make nsdeps`.

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Fixes: c7c4e29fb5a4 ("scripts: add_namespace: Fix coccicheck failed")
Cc: YueHaibing <yuehaibing@huawei.com>
Cc: jeyu@kernel.org
Cc: cocci@systeme.lip6.fr
Cc: stable@vger.kernel.org
Signed-off-by: Matthias Maennich <maennich@google.com>
---
 scripts/coccinelle/misc/add_namespace.cocci | 8 +++++++-
 scripts/nsdeps                              | 2 +-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/scripts/coccinelle/misc/add_namespace.cocci b/scripts/coccinelle/misc/add_namespace.cocci
index 99e93a6c2e24..cbf1614163cb 100644
--- a/scripts/coccinelle/misc/add_namespace.cocci
+++ b/scripts/coccinelle/misc/add_namespace.cocci
@@ -6,6 +6,7 @@
 /// add a missing namespace tag to a module source file.
 ///
 
+virtual nsdeps
 virtual report
 
 @has_ns_import@
@@ -16,10 +17,15 @@ MODULE_IMPORT_NS(ns);
 
 // Add missing imports, but only adjacent to a MODULE_LICENSE statement.
 // That ensures we are adding it only to the main module source file.
-@do_import depends on !has_ns_import@
+@do_import depends on !has_ns_import && nsdeps@
 declarer name MODULE_LICENSE;
 expression license;
 identifier virtual.ns;
 @@
 MODULE_LICENSE(license);
 + MODULE_IMPORT_NS(ns);
+
+// Dummy rule for report mode that would otherwise be empty and make spatch
+// fail ("No rules apply.")
+@script:python depends on report@
+@@
diff --git a/scripts/nsdeps b/scripts/nsdeps
index 03a8e7cbe6c7..dab4c1a0e27d 100644
--- a/scripts/nsdeps
+++ b/scripts/nsdeps
@@ -29,7 +29,7 @@ fi
 
 generate_deps_for_ns() {
 	$SPATCH --very-quiet --in-place --sp-file \
-		$srctree/scripts/coccinelle/misc/add_namespace.cocci -D ns=$1 $2
+		$srctree/scripts/coccinelle/misc/add_namespace.cocci -D nsdeps -D ns=$1 $2
 }
 
 generate_deps() {
-- 
2.27.0.rc2.251.g90737beb825-goog

