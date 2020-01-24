Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C85C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D39B20718
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579859586;
	bh=aact3I6c+oZm65CsIWErj5LOzFRreHh98x1rQVOP7rs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0L+U2QIXukQ/kXRl99TD/+jHAl4Rpkzau1LDZYIcYBUS4zdRKM1biUdp93n2pRx2v
	 SmIjFYiwr9PWD6Fs4E5jD+VdlwyqXFL3q2wljA9ZncsFVAsFXtlZ4OOFfplz76OQ6S
	 F583XECfCdAKtflSCdAUV/OPP9r/gz7WN6CU8n+8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388231AbgAXJxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:53:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:55320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388220AbgAXJxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:53:03 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E83B920718;
        Fri, 24 Jan 2020 09:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579859582;
        bh=aact3I6c+oZm65CsIWErj5LOzFRreHh98x1rQVOP7rs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DMMTbZJB0mHHMt4BuVlkjSceKUBtSKf/pJhE2AU8U+EuWnjo6Y3Wb6I9oDKW0hCNB
         BW3O87BHy1ydOYiyBUFNjDLzvNtlnNZdQmnLBKG+W/yc5AuZbDUIV6hbAJScYVG/Jj
         swmPnEeBaoiTE+waytE648ssun3EU4Vkxg3+QLpk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vladimir Murzin <vladimir.murzin@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 131/343] ARM: 8848/1: virt: Align GIC version check with arm64 counterpart
Date:   Fri, 24 Jan 2020 10:29:09 +0100
Message-Id: <20200124092937.225636396@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092919.490687572@linuxfoundation.org>
References: <20200124092919.490687572@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Murzin <vladimir.murzin@arm.com>

[ Upstream commit 9db043d36bd379f4cc99054c079de0dabfc38d03 ]

arm64 has got relaxation on GIC version check at early boot stage due
to update of the GIC architecture let's align ARM with that.

To help backports (even though the code was correct at the time of writing)
Fixes: e59941b9b381 ("ARM: 8527/1: virt: enable GICv3 system registers")
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/kernel/hyp-stub.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/hyp-stub.S b/arch/arm/kernel/hyp-stub.S
index 60146e32619a5..82a942894fc04 100644
--- a/arch/arm/kernel/hyp-stub.S
+++ b/arch/arm/kernel/hyp-stub.S
@@ -180,8 +180,8 @@ ARM_BE8(orr	r7, r7, #(1 << 25))     @ HSCTLR.EE
 	@ Check whether GICv3 system registers are available
 	mrc	p15, 0, r7, c0, c1, 1	@ ID_PFR1
 	ubfx	r7, r7, #28, #4
-	cmp	r7, #1
-	bne	2f
+	teq	r7, #0
+	beq	2f
 
 	@ Enable system register accesses
 	mrc	p15, 4, r7, c12, c9, 5	@ ICC_HSRE
-- 
2.20.1



