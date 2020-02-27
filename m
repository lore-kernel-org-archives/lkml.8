Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11065C52D45
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE4BE20578
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582812096;
	bh=iXVwXUnzr99/i+tW6fsGq3C1giv6F2HQOb6WXBwSOZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0pQekTJAiWZC+6p1UJEHNj3RA++T43Nw9WUziPILlAL/lnMOYLhLN5aV3aLah3GJb
	 OOi61er0PDcLHcH/cyTHhQQAJVUyU0juaCAKu+M+UaA6o792H4kxsy9dqrj2KefMPN
	 sJis/vekpDOlVhwU64AU+B8moUzXJ6lldkzGqRhE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732957AbgB0OBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:01:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:35640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732948AbgB0OBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:01:33 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C39620801;
        Thu, 27 Feb 2020 14:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812092;
        bh=iXVwXUnzr99/i+tW6fsGq3C1giv6F2HQOb6WXBwSOZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1k+ZJ1P3BBnqJLETNyzwCXGFFOFI5zJgR4TUF2uTPdRbcdbXkdrOewRbo4ZPe3l4+
         hzYPG/jvzsPwiO18DhGW31Vy3DJaxpYMxsoR276+4yQElfSBEoPKbQzFv5vRXeCbWd
         +ElCJs359x9JqCTfO4wmCBUCwQf6i8UGXZWnUQzg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.14 219/237] KVM: apic: avoid calculating pending eoi from an uninitialized val
Date:   Thu, 27 Feb 2020 14:37:13 +0100
Message-Id: <20200227132312.271268878@linuxfoundation.org>
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

From: Miaohe Lin <linmiaohe@huawei.com>

commit 23520b2def95205f132e167cf5b25c609975e959 upstream.

When pv_eoi_get_user() fails, 'val' may remain uninitialized and the return
value of pv_eoi_get_pending() becomes random. Fix the issue by initializing
the variable.

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/lapic.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -566,9 +566,11 @@ static inline bool pv_eoi_enabled(struct
 static bool pv_eoi_get_pending(struct kvm_vcpu *vcpu)
 {
 	u8 val;
-	if (pv_eoi_get_user(vcpu, &val) < 0)
+	if (pv_eoi_get_user(vcpu, &val) < 0) {
 		apic_debug("Can't read EOI MSR value: 0x%llx\n",
 			   (unsigned long long)vcpu->arch.pv_eoi.msr_val);
+		return false;
+	}
 	return val & 0x1;
 }
 


