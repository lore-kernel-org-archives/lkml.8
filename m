Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E31C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 14:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D48220663
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 14:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="qymYWIhB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731259AbgGAOC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 10:02:28 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:16326 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731069AbgGAOC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 10:02:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1593612148; x=1625148148;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=5zs5lyxU5AtUdWhiM9M4OnXzAKmqv7biVE/Gy/y7dYc=;
  b=qymYWIhBE249CPHiO7/xKER7PcOnbQjc1tVkv7Sf5xLWwaFuiAnhD+B/
   Eg1UBEXAjKh96i/oKDN0CyCM5ywgq/3vy7M2+JkfQddKN+m3/JCgZl3z0
   V7z3IqXuIyT8xxJryKD4MycoX9UMDkeK85BUaXbjxjgnB/OqqnCmP4T9E
   4=;
IronPort-SDR: /W76JCUcLQtk7wQg9wwmfEH4BUJ0N5VwiTtPu0r4q1nWt0lIbl7VZ5lLBHNJhWL0Do5IzhbSQw
 5Haek1aXZJcQ==
X-IronPort-AV: E=Sophos;i="5.75,300,1589241600"; 
   d="scan'208";a="48368723"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 01 Jul 2020 14:02:20 +0000
Received: from EX13MTAUWC001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com (Postfix) with ESMTPS id AA33CA26D8;
        Wed,  1 Jul 2020 14:02:16 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 1 Jul 2020 14:02:15 +0000
Received: from u79c5a0a55de558.ant.amazon.com (10.43.162.85) by
 EX13D20UWC001.ant.amazon.com (10.43.162.244) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 1 Jul 2020 14:02:13 +0000
From:   Alexander Graf <graf@amazon.com>
To:     <kvmarm@lists.cs.columbia.edu>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        "Julien Thierry" <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH] KVM: arm64: Change default caching mode for {PEND,PROP}BASER.outer
Date:   Wed, 1 Jul 2020 16:02:06 +0200
Message-ID: <20200701140206.8664-1-graf@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.85]
X-ClientProxiedBy: EX13D06UWA003.ant.amazon.com (10.43.160.13) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PENDBASER and PROPBASER define the outer caching mode for LPI tables.
The memory backing them may not be outer sharable, so we mark them as nC
by default. This however, breaks Windows on ARM which only accepts
SameAsInner or RaWaWb as values for outer cachability.

We do today already allow the outer mode to be set to SameAsInner
explicitly, so the easy fix is to default to that instead of nC for
situations when an OS asks for a not fulfillable cachability request.

This fixes booting Windows in KVM with vgicv3 and ITS enabled for me.

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 arch/arm64/kvm/vgic/vgic-mmio-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
index d2339a2b9fb9..5c786b915cd3 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
@@ -389,7 +389,7 @@ u64 vgic_sanitise_outer_cacheability(u64 field)
 	case GIC_BASER_CACHE_nC:
 		return field;
 	default:
-		return GIC_BASER_CACHE_nC;
+		return GIC_BASER_CACHE_SameAsInner;
 	}
 }
 
-- 
2.17.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



