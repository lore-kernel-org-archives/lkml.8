Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A2AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E8FD217A0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592584018;
	bh=NBVUODQbI1T1MtGAlUTn/rshWC+w1j++5qEaRVUjYSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oDF9joDYj9jACpfni0lCzEIG3JEZNihbN4s8N4FOIGR0Cc/ALHXp39F5FdTl+S408
	 zQs4YdCKWZw5V3AUJS9mySMeq7SuSj0Lfb67weXWfFSPUrClDa3x3/+K26y7XY2W2z
	 6mjZKzR6jC3mv/6JupMAt8qBvdd0lqL41ar4y2/A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390099AbgFSO4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:56:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:51276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389392AbgFSO4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:56:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBF802158C;
        Fri, 19 Jun 2020 14:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592578578;
        bh=NBVUODQbI1T1MtGAlUTn/rshWC+w1j++5qEaRVUjYSg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UinJH23+5k9vWTENHDz/2sb8okp0HErAMdsfi1OA0GN1sj+ddbTV8R/UBnpW5JFpn
         QeoAouLY5Vp3Iln1CldhXtzOje2SOpzym0Re3M7F5KGbALA+e9do5GAsN5dZ5gjwlX
         HU4u1Gc+uqE6VByq3IFtQX0c2i5Rs2Eg9IphoiNM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Xing Li <lixing@loongson.cn>, Huacai Chen <chenhc@lemote.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.19 075/267] KVM: MIPS: Fix VPN2_MASK definition for variable cpu_vmbits
Date:   Fri, 19 Jun 2020 16:31:00 +0200
Message-Id: <20200619141652.500182542@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141648.840376470@linuxfoundation.org>
References: <20200619141648.840376470@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xing Li <lixing@loongson.cn>

commit 5816c76dea116a458f1932eefe064e35403248eb upstream.

If a CPU support more than 32bit vmbits (which is true for 64bit CPUs),
VPN2_MASK set to fixed 0xffffe000 will lead to a wrong EntryHi in some
functions such as _kvm_mips_host_tlb_inv().

The cpu_vmbits definition of 32bit CPU in cpu-features.h is 31, so we
still use the old definition.

Cc: Stable <stable@vger.kernel.org>
Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Signed-off-by: Xing Li <lixing@loongson.cn>
[Huacai: Improve commit messages]
Signed-off-by: Huacai Chen <chenhc@lemote.com>
Message-Id: <1590220602-3547-3-git-send-email-chenhc@lemote.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/kvm_host.h |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -274,7 +274,11 @@ enum emulation_result {
 #define MIPS3_PG_SHIFT		6
 #define MIPS3_PG_FRAME		0x3fffffc0
 
+#if defined(CONFIG_64BIT)
+#define VPN2_MASK		GENMASK(cpu_vmbits - 1, 13)
+#else
 #define VPN2_MASK		0xffffe000
+#endif
 #define KVM_ENTRYHI_ASID	cpu_asid_mask(&boot_cpu_data)
 #define TLB_IS_GLOBAL(x)	((x).tlb_lo[0] & (x).tlb_lo[1] & ENTRYLO_G)
 #define TLB_VPN2(x)		((x).tlb_hi & VPN2_MASK)


