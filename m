Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5DCC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1988F2064A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="REJMFVTR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632753AbgDNULq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 16:11:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40784 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2632745AbgDNULU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 16:11:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586895079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t7aLyIzVIv8UgnZXzETONCOSTJxW/XfBuHyqu3EQW8M=;
        b=REJMFVTRzqqgH2MPSVwB6xIsV1MvOURq56YVLpo51esxAVP4YUDnYZ54JL1eTJHfSBmZ86
        9lZR/sQa8gWoxKHg4lUFxvLjV9GZrDoxZXH0PipoL6E+m5+C6qjoMvOc2SeVheyFMtNswu
        4rbE0zDCjikzGg7E1iBdKDHMGvdCJuM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-T-VB9X6nO8ODzdUku_1Fng-1; Tue, 14 Apr 2020 16:11:13 -0400
X-MC-Unique: T-VB9X6nO8ODzdUku_1Fng-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E5221088398;
        Tue, 14 Apr 2020 20:11:12 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-113-69.rdu2.redhat.com [10.10.113.69])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 883765DA66;
        Tue, 14 Apr 2020 20:11:11 +0000 (UTC)
From:   Cathy Avery <cavery@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com
Cc:     vkuznets@redhat.com, wei.huang2@amd.com
Subject: [PATCH 1/2] KVM: SVM: Implement check_nested_events for NMI
Date:   Tue, 14 Apr 2020 16:11:06 -0400
Message-Id: <20200414201107.22952-2-cavery@redhat.com>
In-Reply-To: <20200414201107.22952-1-cavery@redhat.com>
References: <20200414201107.22952-1-cavery@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Migrate nested guest NMI intercept processing
to new check_nested_events.

Signed-off-by: Cathy Avery <cavery@redhat.com>
---
 arch/x86/kvm/svm/nested.c | 21 +++++++++++++++++++++
 arch/x86/kvm/svm/svm.c    |  2 +-
 arch/x86/kvm/svm/svm.h    | 15 ---------------
 3 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 90a1ca939627..1ba8ef46b0b5 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -764,6 +764,20 @@ int nested_svm_check_exception(struct vcpu_svm *svm,=
 unsigned nr,
 	return vmexit;
 }
=20
+static bool nested_exit_on_nmi(struct vcpu_svm *svm)
+{
+	return (svm->nested.intercept & (1ULL << INTERCEPT_NMI));
+}
+
+static void nested_svm_nmi(struct vcpu_svm *svm)
+{
+	svm->vmcb->control.exit_code =3D SVM_EXIT_NMI;
+	svm->vmcb->control.exit_info_1 =3D 0;
+	svm->vmcb->control.exit_info_2 =3D 0;
+
+	svm->nested.exit_required =3D true;
+}
+
 static void nested_svm_intr(struct vcpu_svm *svm)
 {
 	svm->vmcb->control.exit_code   =3D SVM_EXIT_INTR;
@@ -793,6 +807,13 @@ int svm_check_nested_events(struct kvm_vcpu *vcpu)
 		return 0;
 	}
=20
+	if (vcpu->arch.nmi_pending && nested_exit_on_nmi(svm)) {
+		if (block_nested_events)
+			return -EBUSY;
+		nested_svm_nmi(svm);
+		return 0;
+	}
+
 	return 0;
 }
=20
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 2be5bbae3a40..84c338c55348 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3053,7 +3053,7 @@ static int svm_nmi_allowed(struct kvm_vcpu *vcpu)
 	int ret;
 	ret =3D !(vmcb->control.int_state & SVM_INTERRUPT_SHADOW_MASK) &&
 	      !(svm->vcpu.arch.hflags & HF_NMI_MASK);
-	ret =3D ret && gif_set(svm) && nested_svm_nmi(svm);
+	ret =3D ret && gif_set(svm);
=20
 	return ret;
 }
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index df3474f4fb02..9be2b890ff3c 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -369,21 +369,6 @@ void disable_nmi_singlestep(struct vcpu_svm *svm);
 #define NESTED_EXIT_DONE	1	/* Exit caused nested vmexit  */
 #define NESTED_EXIT_CONTINUE	2	/* Further checks needed      */
=20
-/* This function returns true if it is save to enable the nmi window */
-static inline bool nested_svm_nmi(struct vcpu_svm *svm)
-{
-	if (!is_guest_mode(&svm->vcpu))
-		return true;
-
-	if (!(svm->nested.intercept & (1ULL << INTERCEPT_NMI)))
-		return true;
-
-	svm->vmcb->control.exit_code =3D SVM_EXIT_NMI;
-	svm->nested.exit_required =3D true;
-
-	return false;
-}
-
 static inline bool svm_nested_virtualize_tpr(struct kvm_vcpu *vcpu)
 {
 	return is_guest_mode(vcpu) && (vcpu->arch.hflags & HF_VINTR_MASK);
--=20
2.20.1

