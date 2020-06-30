Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C662C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 11:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AFB620663
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 11:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HytoAQ3l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732889AbgF3LKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 07:10:15 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58355 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728534AbgF3LKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 07:10:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593515409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=msnFaJYZDu81wFuqZFTp1ZOR5QC4oyv6dPxquziRN8w=;
        b=HytoAQ3l5t4/mzUdrDO+1cm6r5p4j9FTs+iOJXMGAtfWT7bvzmhuGh8N5rxbmjSU3jE+mT
        qO1fuvk8/H7yjzVvex5h6Jkk1rLPAzpm02tar+MXSeaVXG/D5AoS7AxJKZxBqMYCxn0RZg
        SQAeR0W0uvLd9C9tVh9/WaOVioOUIDI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-VBh_BiGdOGuDy8VESVo1Dw-1; Tue, 30 Jun 2020 07:10:07 -0400
X-MC-Unique: VBh_BiGdOGuDy8VESVo1Dw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B4C28015F4;
        Tue, 30 Jun 2020 11:10:06 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 171861001901;
        Tue, 30 Jun 2020 11:10:06 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     stable@vger.kernel.org, Nadav Amit <namit@vmware.com>
Subject: [PATCH] KVM: x86: bit 8 of non-leaf PDPEs is not reserved
Date:   Tue, 30 Jun 2020 07:10:05 -0400
Message-Id: <20200630111005.457029-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bit 8 would be the "global" bit, which does not quite make sense for non-leaf
page table entries.  Intel ignores it; AMD ignores it in PDEs and PDPEs, but
reserves it in PML4Es.

Probably, earlier versions of the AMD manual documented it as reserved in PDPEs
as well, and that behavior made it into KVM as well as kvm-unit-tests; fix it.

Cc: stable@vger.kernel.org
Reported-by: Nadav Amit <namit@vmware.com>
Fixes: a0c0feb57992 ("KVM: x86: reserve bit 8 of non-leaf PDPEs and PML4Es in 64-bit mode on AMD", 2014-09-03)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 76817d13c86e..6d6a0ae7800c 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4449,7 +4449,7 @@ __reset_rsvds_bits_mask(struct kvm_vcpu *vcpu,
 			nonleaf_bit8_rsvd | rsvd_bits(7, 7) |
 			rsvd_bits(maxphyaddr, 51);
 		rsvd_check->rsvd_bits_mask[0][2] = exb_bit_rsvd |
-			nonleaf_bit8_rsvd | gbpages_bit_rsvd |
+			gbpages_bit_rsvd |
 			rsvd_bits(maxphyaddr, 51);
 		rsvd_check->rsvd_bits_mask[0][1] = exb_bit_rsvd |
 			rsvd_bits(maxphyaddr, 51);
-- 
2.26.2

