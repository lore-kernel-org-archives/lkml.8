Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D37C433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 11:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 807F420775
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 11:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VNGBFVe5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgGQLeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 07:34:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24147 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726104AbgGQLea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 07:34:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594985669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7UJmD/rvbE9K5xfGmqgRe3dQa77FW0PkN9Ro4ee9Oes=;
        b=VNGBFVe5KvTKKobDJHLUFcxZR4K4QwUho2HXgzZ2k1v9/Ww6JBud7Qj8NSk2hxqvAzAp7d
        Tk3dwRFKCoQAx3XWKlRsRys0EofCplnCQdoPBmGkTCyLYIoDHydYx703YtfSk4pSqX3pBm
        mMYB9+tZc2Fzpze0daAHsQRsh2a3+lo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-Ojscl9VzMgOVNYnht5IPNw-1; Fri, 17 Jul 2020 07:34:26 -0400
X-MC-Unique: Ojscl9VzMgOVNYnht5IPNw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7F65108A;
        Fri, 17 Jul 2020 11:34:24 +0000 (UTC)
Received: from virtlab710.virt.lab.eng.bos.redhat.com (virtlab710.virt.lab.eng.bos.redhat.com [10.19.152.252])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 613FE19C58;
        Fri, 17 Jul 2020 11:34:24 +0000 (UTC)
From:   Cathy Avery <cavery@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com
Subject: [PATCH kvm-unit-tests v2 3/3] svm: INIT intercept test
Date:   Fri, 17 Jul 2020 07:34:22 -0400
Message-Id: <20200717113422.19575-4-cavery@redhat.com>
In-Reply-To: <20200717113422.19575-1-cavery@redhat.com>
References: <20200717113422.19575-1-cavery@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

INIT vcpu 2 and intercept the INIT. This test
will leave the vcpu in an unusable state.

Signed-off-by: Cathy Avery <cavery@redhat.com>
---
 x86/svm_tests.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/x86/svm_tests.c b/x86/svm_tests.c
index 698eb20..b43c19f 100644
--- a/x86/svm_tests.c
+++ b/x86/svm_tests.c
@@ -1939,6 +1939,43 @@ static bool init_startup_check(struct svm_test *test)
     return cpu_online_count == orig_cpu_count;
 }
 
+static volatile bool init_intercept;
+
+static void init_intercept_prepare(struct svm_test *test)
+{
+    init_intercept = false;
+    vmcb_ident(vmcb);
+    vmcb->control.intercept |= (1ULL << INTERCEPT_INIT);
+}
+
+static void init_intercept_test(struct svm_test *test)
+{
+    apic_icr_write(APIC_DEST_SELF | APIC_DEST_PHYSICAL | APIC_DM_INIT | APIC_INT_ASSERT, 0);
+}
+
+static bool init_intercept_finished(struct svm_test *test)
+{
+    vmcb->save.rip += 3;
+
+    if (vmcb->control.exit_code != SVM_EXIT_INIT) {
+        report(false, "VMEXIT not due to init intercept. Exit reason 0x%x",
+               vmcb->control.exit_code);
+
+        return true;
+        }
+
+    init_intercept = true;
+
+    report(true, "INIT to vcpu intercepted");
+
+    return true;
+}
+
+static bool init_intercept_check(struct svm_test *test)
+{
+    return init_intercept;
+}
+
 #define TEST(name) { #name, .v2 = name }
 
 /*
@@ -2255,6 +2292,9 @@ struct svm_test svm_tests[] = {
     { "svm_init_startup_test", smp_supported, init_startup_prepare,
       default_prepare_gif_clear, null_test,
       init_startup_finished, init_startup_check },
+    { "svm_init_intercept_test", smp_supported, init_intercept_prepare,
+      default_prepare_gif_clear, init_intercept_test,
+      init_intercept_finished, init_intercept_check, .on_vcpu = 2 },
     TEST(svm_guest_state_test),
     { NULL, NULL, NULL, NULL, NULL, NULL, NULL }
 };
-- 
2.20.1

