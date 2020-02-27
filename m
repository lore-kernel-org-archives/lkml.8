Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5598C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 17:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 726B024691
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 17:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aq9warKK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730034AbgB0R2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 12:28:50 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45142 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728413AbgB0R2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 12:28:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582824529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tgd24Z9DDO1trU7ZuAwbZRL98cQ9zB6qUkqBp/ykZi0=;
        b=aq9warKKGRqg+PaVFThQGs3puAt9TT5mQ4pcBL87HfOgqJCHlYoIWk97LuVPFDHoAuAV6m
        2AGl7sJ3sjvZBlON4bot9h76G5JUvGiioL+Fin4qMGLfb6b1cnfZ3bBTaNz/5VcmS09dMh
        jMlJsFVJjm1UY6NZorYNOrbW0iIjwQo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-n7XzXH7EPV6orn2Dq9Tjxg-1; Thu, 27 Feb 2020 12:28:43 -0500
X-MC-Unique: n7XzXH7EPV6orn2Dq9Tjxg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2FDA91005514;
        Thu, 27 Feb 2020 17:28:42 +0000 (UTC)
Received: from millenium-falcon.redhat.com (unknown [10.36.118.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 938956E3EE;
        Thu, 27 Feb 2020 17:28:36 +0000 (UTC)
From:   Mohammed Gamal <mgamal@redhat.com>
To:     kvm@vger.kernel.org, pbonzini@redhat.com
Cc:     sean.j.christopherson@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        linux-kernel@vger.kernel.org, Mohammed Gamal <mgamal@redhat.com>
Subject: [kvm-unit-tests PATCH] x86: access: Add tests for reserved bits of guest physical address
Date:   Thu, 27 Feb 2020 19:28:26 +0200
Message-Id: <20200227172826.22004-1-mgamal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This extends the access tests to also test for reserved bits
in guest physical addresses.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Mohammed Gamal <mgamal@redhat.com>
---
 x86/access.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/x86/access.c b/x86/access.c
index 7303fc3..b98b403 100644
--- a/x86/access.c
+++ b/x86/access.c
@@ -47,6 +47,7 @@ enum {
     AC_PTE_DIRTY_BIT,
     AC_PTE_NX_BIT,
     AC_PTE_BIT51_BIT,
+    AC_PTE_BIT40_BIT,
=20
     AC_PDE_PRESENT_BIT,
     AC_PDE_WRITABLE_BIT,
@@ -56,6 +57,7 @@ enum {
     AC_PDE_PSE_BIT,
     AC_PDE_NX_BIT,
     AC_PDE_BIT51_BIT,
+    AC_PDE_BIT40_BIT,
     AC_PDE_BIT13_BIT,
=20
     AC_PKU_AD_BIT,
@@ -82,6 +84,7 @@ enum {
 #define AC_PTE_DIRTY_MASK     (1 << AC_PTE_DIRTY_BIT)
 #define AC_PTE_NX_MASK        (1 << AC_PTE_NX_BIT)
 #define AC_PTE_BIT51_MASK     (1 << AC_PTE_BIT51_BIT)
+#define AC_PTE_BIT40_MASK     (1 << AC_PTE_BIT40_BIT)
=20
 #define AC_PDE_PRESENT_MASK   (1 << AC_PDE_PRESENT_BIT)
 #define AC_PDE_WRITABLE_MASK  (1 << AC_PDE_WRITABLE_BIT)
@@ -91,6 +94,7 @@ enum {
 #define AC_PDE_PSE_MASK       (1 << AC_PDE_PSE_BIT)
 #define AC_PDE_NX_MASK        (1 << AC_PDE_NX_BIT)
 #define AC_PDE_BIT51_MASK     (1 << AC_PDE_BIT51_BIT)
+#define AC_PDE_BIT40_MASK     (1 << AC_PDE_BIT40_BIT)
 #define AC_PDE_BIT13_MASK     (1 << AC_PDE_BIT13_BIT)
=20
 #define AC_PKU_AD_MASK        (1 << AC_PKU_AD_BIT)
@@ -115,6 +119,7 @@ const char *ac_names[] =3D {
     [AC_PTE_DIRTY_BIT] =3D "pte.d",
     [AC_PTE_NX_BIT] =3D "pte.nx",
     [AC_PTE_BIT51_BIT] =3D "pte.51",
+    [AC_PTE_BIT40_BIT] =3D "pte.40",
     [AC_PDE_PRESENT_BIT] =3D "pde.p",
     [AC_PDE_ACCESSED_BIT] =3D "pde.a",
     [AC_PDE_WRITABLE_BIT] =3D "pde.rw",
@@ -123,6 +128,7 @@ const char *ac_names[] =3D {
     [AC_PDE_PSE_BIT] =3D "pde.pse",
     [AC_PDE_NX_BIT] =3D "pde.nx",
     [AC_PDE_BIT51_BIT] =3D "pde.51",
+    [AC_PDE_BIT40_BIT] =3D "pde.40",
     [AC_PDE_BIT13_BIT] =3D "pde.13",
     [AC_PKU_AD_BIT] =3D "pkru.ad",
     [AC_PKU_WD_BIT] =3D "pkru.wd",
@@ -289,6 +295,14 @@ static _Bool ac_test_legal(ac_test_t *at)
     if (!F(AC_PDE_PSE) && F(AC_PDE_BIT13))
         return false;
=20
+    /*
+     * Shorten the test by avoiding testing too many reserved bit combin=
ations
+     */
+    if ((F(AC_PDE_BIT51) + F(AC_PDE_BIT40) + F(AC_PDE_BIT13)) > 1)
+        return false;
+    if ((F(AC_PTE_BIT51) + F(AC_PTE_BIT40)) > 1)
+        return false;
+
     return true;
 }
=20
@@ -375,7 +389,7 @@ static void ac_emulate_access(ac_test_t *at, unsigned=
 flags)
         at->ignore_pde =3D PT_ACCESSED_MASK;
=20
     pde_valid =3D F(AC_PDE_PRESENT)
-        && !F(AC_PDE_BIT51) && !F(AC_PDE_BIT13)
+        && !F(AC_PDE_BIT51) && !F(AC_PDE_BIT40) && !F(AC_PDE_BIT13)
         && !(F(AC_PDE_NX) && !F(AC_CPU_EFER_NX));
=20
     if (!pde_valid) {
@@ -401,7 +415,7 @@ static void ac_emulate_access(ac_test_t *at, unsigned=
 flags)
     at->expected_pde |=3D PT_ACCESSED_MASK;
=20
     pte_valid =3D F(AC_PTE_PRESENT)
-        && !F(AC_PTE_BIT51)
+        && !F(AC_PTE_BIT51) && !F(AC_PTE_BIT40)
         && !(F(AC_PTE_NX) && !F(AC_CPU_EFER_NX));
=20
     if (!pte_valid) {
@@ -510,6 +524,8 @@ static void __ac_setup_specific_pages(ac_test_t *at, =
ac_pool_t *pool,
 		pte |=3D PT64_NX_MASK;
 	    if (F(AC_PDE_BIT51))
 		pte |=3D 1ull << 51;
+	    if (F(AC_PDE_BIT40))
+                pte |=3D 1ull << 40;
 	    if (F(AC_PDE_BIT13))
 		pte |=3D 1ull << 13;
 	    at->pdep =3D &vroot[index];
@@ -532,6 +548,8 @@ static void __ac_setup_specific_pages(ac_test_t *at, =
ac_pool_t *pool,
 		pte |=3D PT64_NX_MASK;
 	    if (F(AC_PTE_BIT51))
 		pte |=3D 1ull << 51;
+	    if (F(AC_PTE_BIT40))
+                pte |=3D 1ull << 40;
 	    at->ptep =3D &vroot[index];
 	    break;
 	}
@@ -935,6 +953,15 @@ static int ac_test_run(void)
     printf("run\n");
     tests =3D successes =3D 0;
=20
+    if (cpuid_maxphyaddr() >=3D 52) {
+        invalid_mask |=3D AC_PDE_BIT51_MASK;
+        invalid_mask |=3D AC_PTE_BIT51_MASK;
+    }
+    if (cpuid_maxphyaddr() >=3D 41) {
+        invalid_mask |=3D AC_PDE_BIT40_MASK;
+        invalid_mask |=3D AC_PTE_BIT40_MASK;
+    }
+
     if (this_cpu_has(X86_FEATURE_PKU)) {
         set_cr4_pke(1);
         set_cr4_pke(0);
--=20
2.21.1

