Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEFEC11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C63D024656
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582814806;
	bh=+QAgU77dISxHZDAmFaB3ZLaxVbIj8objSRqIb1lXI70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t2RM1Rr35KlVsI11CWwPGVv32GUIQQnI6PFmFDeGua3vSHKb8x8GO6Q9YBjF7TqE2
	 3K3IHDLP8kEnQ37mAPSp4amociUN2n2+0tjAy1njirkCQyXd1sCdnZW2mPiW0NVBIb
	 5CmBMstAigKb59NJ2U8dryHTs3zTseBM8+6Yl62k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731828AbgB0Oqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:46:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:40926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730327AbgB0NpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:45:05 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A484246A4;
        Thu, 27 Feb 2020 13:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811104;
        bh=+QAgU77dISxHZDAmFaB3ZLaxVbIj8objSRqIb1lXI70=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m0kj2AsjD5nH/Tz8l0txoUAg6V71XSiqOEEONwir8T7Hj4upjA5APb8bJVx5Fy0JV
         vO6qvFeAnTLeLdi4SXGJjMndQCMXOtUQ1ou212OXLHUc+VjdChrFiSDu0TFNajtCwT
         0OTFvqaoWz2k9+tZ62MWZbQo1UkLwLXITz7vbeH4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oliver Upton <oupton@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.4 103/113] KVM: nVMX: Refactor IO bitmap checks into helper function
Date:   Thu, 27 Feb 2020 14:36:59 +0100
Message-Id: <20200227132228.249434084@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132211.791484803@linuxfoundation.org>
References: <20200227132211.791484803@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Upton <oupton@google.com>

commit e71237d3ff1abf9f3388337cfebf53b96df2020d upstream.

Checks against the IO bitmap are useful for both instruction emulation
and VM-exit reflection. Refactor the IO bitmap checks into a helper
function.

Signed-off-by: Oliver Upton <oupton@google.com>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/vmx.c |   40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -4275,6 +4275,26 @@ static bool cs_ss_rpl_check(struct kvm_v
 		 (ss.selector & SEGMENT_RPL_MASK));
 }
 
+static bool nested_vmx_check_io_bitmaps(struct kvm_vcpu *vcpu,
+					unsigned int port, int size);
+static bool nested_vmx_exit_handled_io(struct kvm_vcpu *vcpu,
+				       struct vmcs12 *vmcs12)
+{
+	unsigned long exit_qualification;
+	unsigned int port;
+	int size;
+
+	if (!nested_cpu_has(vmcs12, CPU_BASED_USE_IO_BITMAPS))
+		return nested_cpu_has(vmcs12, CPU_BASED_UNCOND_IO_EXITING);
+
+	exit_qualification = vmcs_readl(EXIT_QUALIFICATION);
+
+	port = exit_qualification >> 16;
+	size = (exit_qualification & 7) + 1;
+
+	return nested_vmx_check_io_bitmaps(vcpu, port, size);
+}
+
 /*
  * Check if guest state is valid. Returns true if valid, false if
  * not.
@@ -7624,23 +7644,17 @@ static int (*const kvm_vmx_exit_handlers
 static const int kvm_vmx_max_exit_handlers =
 	ARRAY_SIZE(kvm_vmx_exit_handlers);
 
-static bool nested_vmx_exit_handled_io(struct kvm_vcpu *vcpu,
-				       struct vmcs12 *vmcs12)
+/*
+ * Return true if an IO instruction with the specified port and size should cause
+ * a VM-exit into L1.
+ */
+bool nested_vmx_check_io_bitmaps(struct kvm_vcpu *vcpu, unsigned int port,
+				 int size)
 {
-	unsigned long exit_qualification;
+	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
 	gpa_t bitmap, last_bitmap;
-	unsigned int port;
-	int size;
 	u8 b;
 
-	if (!nested_cpu_has(vmcs12, CPU_BASED_USE_IO_BITMAPS))
-		return nested_cpu_has(vmcs12, CPU_BASED_UNCOND_IO_EXITING);
-
-	exit_qualification = vmcs_readl(EXIT_QUALIFICATION);
-
-	port = exit_qualification >> 16;
-	size = (exit_qualification & 7) + 1;
-
 	last_bitmap = (gpa_t)-1;
 	b = -1;
 


