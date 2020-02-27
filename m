Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DEDC52D52
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DF2E24697
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582812148;
	bh=tOmoxyHH7aI3s0hZrRZfclMTF0zSrdSwaBsKgAUc8u8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R7pvooPVn1stZctL4rk1Ck11wgHPerAY45pGXY9HWLEE+f6Z0uR+IR92Dkk2004oM
	 wn+htqgl22333IPSUkB5l6jBZTtujBbqxKcY9uPl0H92rzfnM4BQyB8JUisNY6LuSo
	 UtkGqEOu3DZwDBCrfPeI0iBGzJP5GS2S0H1s752I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733124AbgB0OC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:02:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:37056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733111AbgB0OCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:02:24 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C49A21D7E;
        Thu, 27 Feb 2020 14:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812143;
        bh=tOmoxyHH7aI3s0hZrRZfclMTF0zSrdSwaBsKgAUc8u8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZBSXXHaCmlGhVIVpyYhpnfPVOUfSzTGtW24w8XeOPxSTB5qDcZOXJv/Xzk8k/OIiO
         OR55dtaZ3WfDvIeQS29g+6LC51tU5i8ktXMtiUThQWxvNQKGmflK5eRSDWUwpwveq1
         G0J94fs26RPGFMbF639atFUS2LsDpan8nMeetn0g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miaohe Lin <linmiaohe@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.14 200/237] KVM: x86: dont notify userspace IOAPIC on edge-triggered interrupt EOI
Date:   Thu, 27 Feb 2020 14:36:54 +0100
Message-Id: <20200227132310.995652885@linuxfoundation.org>
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

commit 7455a8327674e1a7c9a1f5dd1b0743ab6713f6d1 upstream.

Commit 13db77347db1 ("KVM: x86: don't notify userspace IOAPIC on edge
EOI") said, edge-triggered interrupts don't set a bit in TMR, which means
that IOAPIC isn't notified on EOI. And var level indicates level-triggered
interrupt.
But commit 3159d36ad799 ("KVM: x86: use generic function for MSI parsing")
replace var level with irq.level by mistake. Fix it by changing irq.level
to irq.trig_mode.

Cc: stable@vger.kernel.org
Fixes: 3159d36ad799 ("KVM: x86: use generic function for MSI parsing")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/irq_comm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kvm/irq_comm.c
+++ b/arch/x86/kvm/irq_comm.c
@@ -427,7 +427,7 @@ void kvm_scan_ioapic_routes(struct kvm_v
 
 			kvm_set_msi_irq(vcpu->kvm, entry, &irq);
 
-			if (irq.level && kvm_apic_match_dest(vcpu, NULL, 0,
+			if (irq.trig_mode && kvm_apic_match_dest(vcpu, NULL, 0,
 						irq.dest_id, irq.dest_mode))
 				__set_bit(irq.vector, ioapic_handled_vectors);
 		}


