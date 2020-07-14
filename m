Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA77C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7353822507
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594753115;
	bh=9QAtD4QYQW1SlkZkkh5EJ3lPChvmKTyOqkTQIYB0UHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XZE5VDz8YT9ZnYWBhybywaYVQ6Jj/8mKWg0rpNs3Er0vAFcrDrhdAT1LEw5NCR2Sn
	 j+9f5d+7JCPfaBOu0G4wqrB1MoFZmJ7CLlda8oyT8WVzNYKUyWvhboiHZlNoIRaPcU
	 o4duTL0myn05D4/xiN+o7KWSzrqReGfaKC0YikvU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731218AbgGNS6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:58:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:56886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731196AbgGNS60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:58:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25AAA22A99;
        Tue, 14 Jul 2020 18:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594753105;
        bh=9QAtD4QYQW1SlkZkkh5EJ3lPChvmKTyOqkTQIYB0UHY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vdf3GeH1+U5aPhxPKOhUx6t7X9kj53QLb7ksrpJMgtEJWl5wILH6FKKXbZt2EeS6d
         qzBqqWqmmA9LO5kAQZwTQLsVwIUZdf4T4TC4eZBOiXhojo4BzEyEZMRqKzCfIZQW6U
         WYbVMDY0tFERG3pWKVHXLzrYWs+lDuT3uzm5J74I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nadav Amit <namit@vmware.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.7 120/166] KVM: x86: bit 8 of non-leaf PDPEs is not reserved
Date:   Tue, 14 Jul 2020 20:44:45 +0200
Message-Id: <20200714184121.583040678@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184115.844176932@linuxfoundation.org>
References: <20200714184115.844176932@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

commit 5ecad245de2ae23dc4e2dbece92f8ccfbaed2fa7 upstream.

Bit 8 would be the "global" bit, which does not quite make sense for non-leaf
page table entries.  Intel ignores it; AMD ignores it in PDEs and PDPEs, but
reserves it in PML4Es.

Probably, earlier versions of the AMD manual documented it as reserved in PDPEs
as well, and that behavior made it into KVM as well as kvm-unit-tests; fix it.

Cc: stable@vger.kernel.org
Reported-by: Nadav Amit <namit@vmware.com>
Fixes: a0c0feb57992 ("KVM: x86: reserve bit 8 of non-leaf PDPEs and PML4Es in 64-bit mode on AMD", 2014-09-03)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/mmu/mmu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4484,7 +4484,7 @@ __reset_rsvds_bits_mask(struct kvm_vcpu
 			nonleaf_bit8_rsvd | rsvd_bits(7, 7) |
 			rsvd_bits(maxphyaddr, 51);
 		rsvd_check->rsvd_bits_mask[0][2] = exb_bit_rsvd |
-			nonleaf_bit8_rsvd | gbpages_bit_rsvd |
+			gbpages_bit_rsvd |
 			rsvd_bits(maxphyaddr, 51);
 		rsvd_check->rsvd_bits_mask[0][1] = exb_bit_rsvd |
 			rsvd_bits(maxphyaddr, 51);


