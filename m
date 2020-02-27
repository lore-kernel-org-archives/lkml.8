Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8ADFC52D2E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8002F20801
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582812089;
	bh=eqTpx2ymV4Xda6QZ0MulQd3E23Bcsb+LDGDNlLUsj+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=015boMluRZ4L7EqVoTvK9DMudCfZdXWWtpqTLaBkjK6YiYLRHONls+Oros0BBHZGV
	 drvFKs1Ums5xtWXqadZSq8Vp0gmxrSFKHZm18vTS/CY0QlB8tc4/Avw5T4xjF+qgHE
	 VMKk6up9HGS01rJ5l6eqQf7yf6P7AmE32Ezo9m4M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732928AbgB0OB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:01:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:35468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732912AbgB0OB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:01:26 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C6B524656;
        Thu, 27 Feb 2020 14:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812085;
        bh=eqTpx2ymV4Xda6QZ0MulQd3E23Bcsb+LDGDNlLUsj+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=liwJaeyp/C9V0EXgtoS9RVOvPetl+Qj+qY15fZoTGFGtJEU4upXMj1K6rBzTvB5h8
         FRE97uHCEro9ViYxu8xTg5Apinqwlu8UkcSfuO0smXq81R/ui7Ns8d8c9zZP3mcab3
         u9H/kIe4ebAZ0bFRBsipXF5HljfdIYeb+1u2fr2w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oliver Upton <oupton@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.14 216/237] KVM: nVMX: Refactor IO bitmap checks into helper function
Date:   Thu, 27 Feb 2020 14:37:10 +0100
Message-Id: <20200227132312.065506678@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132255.285644406@linuxfoundation.org>
References: <20200227132255.285644406@linuxfoundation.org>
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
@@ -4991,6 +4991,26 @@ static bool cs_ss_rpl_check(struct kvm_v
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
@@ -8521,23 +8541,17 @@ static int (*const kvm_vmx_exit_handlers
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
 


