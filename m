Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D9BC83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 09:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92386206C0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 09:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="idA6rB5H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgD1Jig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 05:38:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39892 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727042AbgD1Jif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 05:38:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588066713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JYgk4WQs5SibHW6L5TgH57ZE7ZY/F3zn07jRdMCtPjU=;
        b=idA6rB5H+hEemJYEfvxrWlV5DRLKgFz6n3F1C0MAKDLDK6r4Cv3qoVTY1vo+UTq3Y1wCEe
        LMDBDlb4vJFsL1mTYlPXsAiXGbL2UcfUd35YOzAaKuKxrUR4Fk4prjHQwDUiIi7BoNYBGm
        kpvvGRfp4x1ZtUyQQGOANvppzAg8xq0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-EB9WstHMML2atkltMfJrrg-1; Tue, 28 Apr 2020 05:38:32 -0400
X-MC-Unique: EB9WstHMML2atkltMfJrrg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE1D9468;
        Tue, 28 Apr 2020 09:38:30 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.195.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8B2405D715;
        Tue, 28 Apr 2020 09:38:28 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH v2 1/3] x86/xen: Split HVM vector callback setup and interrupt gate allocation
Date:   Tue, 28 Apr 2020 11:38:22 +0200
Message-Id: <20200428093824.1451532-2-vkuznets@redhat.com>
In-Reply-To: <20200428093824.1451532-1-vkuznets@redhat.com>
References: <20200428093824.1451532-1-vkuznets@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a preparatory change for making alloc_intr_gate() __init split
xen_callback_vector() into callback vector setup via hypercall
(xen_setup_callback_vector()) and interrupt gate allocation
(xen_alloc_callback_vector()).

xen_setup_callback_vector() is being called twice: on init and upon
system resume from xen_hvm_post_suspend(). alloc_intr_gate() only
needs to be called once.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/xen/suspend_hvm.c       |  2 +-
 arch/x86/xen/xen-ops.h           |  2 +-
 drivers/xen/events/events_base.c | 28 +++++++++++++++++-----------
 3 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/arch/x86/xen/suspend_hvm.c b/arch/x86/xen/suspend_hvm.c
index e666b614cf6d..5152afe16876 100644
--- a/arch/x86/xen/suspend_hvm.c
+++ b/arch/x86/xen/suspend_hvm.c
@@ -13,6 +13,6 @@ void xen_hvm_post_suspend(int suspend_cancelled)
 		xen_hvm_init_shared_info();
 		xen_vcpu_restore();
 	}
-	xen_callback_vector();
+	xen_setup_callback_vector();
 	xen_unplug_emulated_devices();
 }
diff --git a/arch/x86/xen/xen-ops.h b/arch/x86/xen/xen-ops.h
index 45a441c33d6d..1cc1568bfe04 100644
--- a/arch/x86/xen/xen-ops.h
+++ b/arch/x86/xen/xen-ops.h
@@ -55,7 +55,7 @@ void xen_enable_sysenter(void);
 void xen_enable_syscall(void);
 void xen_vcpu_restore(void);
=20
-void xen_callback_vector(void);
+void xen_setup_callback_vector(void);
 void xen_hvm_init_shared_info(void);
 void xen_unplug_emulated_devices(void);
=20
diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events=
_base.c
index 3a791c8485d0..eb35c3cda9a6 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -1639,26 +1639,30 @@ EXPORT_SYMBOL_GPL(xen_set_callback_via);
 /* Vector callbacks are better than PCI interrupts to receive event
  * channel notifications because we can receive vector callbacks on any
  * vcpu and we don't need PCI support or APIC interactions. */
-void xen_callback_vector(void)
+void xen_setup_callback_vector(void)
 {
-	int rc;
 	uint64_t callback_via;
=20
 	if (xen_have_vector_callback) {
 		callback_via =3D HVM_CALLBACK_VECTOR(HYPERVISOR_CALLBACK_VECTOR);
-		rc =3D xen_set_callback_via(callback_via);
-		if (rc) {
+		if (xen_set_callback_via(callback_via)) {
 			pr_err("Request for Xen HVM callback vector failed\n");
 			xen_have_vector_callback =3D 0;
-			return;
 		}
-		pr_info_once("Xen HVM callback vector for event delivery is enabled\n"=
);
-		alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR,
-				xen_hvm_callback_vector);
 	}
 }
+
+static __init void xen_alloc_callback_vector(void)
+{
+	if (!xen_have_vector_callback)
+		return;
+
+	pr_info("Xen HVM callback vector for event delivery is enabled\n");
+	alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR, xen_hvm_callback_vector);
+}
 #else
-void xen_callback_vector(void) {}
+void xen_setup_callback_vector(void) {}
+static inline void xen_alloc_callback_vector(void) {}
 #endif
=20
 #undef MODULE_PARAM_PREFIX
@@ -1692,8 +1696,10 @@ void __init xen_init_IRQ(void)
 		if (xen_initial_domain())
 			pci_xen_initial_domain();
 	}
-	if (xen_feature(XENFEAT_hvm_callback_vector))
-		xen_callback_vector();
+	if (xen_feature(XENFEAT_hvm_callback_vector)) {
+		xen_setup_callback_vector();
+		xen_alloc_callback_vector();
+	}
=20
 	if (xen_hvm_domain()) {
 		native_init_IRQ();
--=20
2.25.3

