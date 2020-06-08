Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7ABFC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 12:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B816D2076A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 12:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SyrMTg4C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbgFHM2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 08:28:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54732 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729668AbgFHM2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 08:28:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591619288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=doJb+BFq2ilT0TcFaJV9XXbdzU0736Qzn44EvVkZi5Y=;
        b=SyrMTg4CzbE2mEVF2vQUDlzWdezZ1b9AvISnjOfs3i3KtRfGkdSqB86oMqcr0FQVTXnveD
        IZwhyLxlJY+H+ltM9Z/qe5fHZd1DaJi30TOddMJKLZJMZYos0HOpJV92iq5nzxdWqALBJP
        fq+Y5m4cNn3lwlHRFcDk0L/sfFwROxI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-VRvOFpKsOvS0YdI6eH3r4A-1; Mon, 08 Jun 2020 08:28:05 -0400
X-MC-Unique: VRvOFpKsOvS0YdI6eH3r4A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2EF841005510;
        Mon,  8 Jun 2020 12:28:04 +0000 (UTC)
Received: from virtlab710.virt.lab.eng.bos.redhat.com (virtlab710.virt.lab.eng.bos.redhat.com [10.19.152.252])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 81E30768BB;
        Mon,  8 Jun 2020 12:28:03 +0000 (UTC)
From:   Cathy Avery <cavery@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com
Subject: [PATCH kvm-unit-tests 2/2] svm: INIT intercept test
Date:   Mon,  8 Jun 2020 08:28:00 -0400
Message-Id: <20200608122800.6315-3-cavery@redhat.com>
In-Reply-To: <20200608122800.6315-1-cavery@redhat.com>
References: <20200608122800.6315-1-cavery@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
index c1abd55..a4dbe91 100644
--- a/x86/svm_tests.c
+++ b/x86/svm_tests.c
@@ -1789,6 +1789,43 @@ static bool virq_inject_check(struct svm_test *test)
     return get_test_stage(test) == 5;
 }
 
+static volatile bool init_intercept;
+
+static void init_signal_intercept_prepare(struct svm_test *test)
+{
+
+    vmcb_ident(vmcb);
+    vmcb->control.intercept |= (1ULL << INTERCEPT_INIT);
+    init_intercept = false;
+}
+
+static void init_signal_test(struct svm_test *test)
+{
+    apic_icr_write(APIC_DEST_SELF | APIC_DEST_PHYSICAL | APIC_DM_INIT | APIC_INT_ASSERT, 0);
+}
+
+static bool init_signal_finished(struct svm_test *test)
+{
+    vmcb->save.rip += 3;
+
+    if (vmcb->control.exit_code != SVM_EXIT_INIT) {
+        report(false, "VMEXIT not due to init intercept. Exit reason 0x%x",
+               vmcb->control.exit_code);
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
+static bool init_signal_check(struct svm_test *test)
+{
+    return init_intercept;
+}
+
 #define TEST(name) { #name, .v2 = name }
 
 /*
@@ -1950,6 +1987,9 @@ struct svm_test svm_tests[] = {
     { "virq_inject", default_supported, virq_inject_prepare,
       default_prepare_gif_clear, virq_inject_test,
       virq_inject_finished, virq_inject_check },
+    { "svm_init_signal_intercept_test", default_supported, init_signal_intercept_prepare,
+      default_prepare_gif_clear, init_signal_test,
+      init_signal_finished, init_signal_check, .on_vcpu = 2 },
     TEST(svm_guest_state_test),
     { NULL, NULL, NULL, NULL, NULL, NULL, NULL }
 };
-- 
2.20.1

