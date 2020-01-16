Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5C4C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE5A820684
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579199372;
	bh=4FwwNBMxPQsMF1REKzY3u6wC+rgjFHSdFCTiwJQWwUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DKBXCs/nq6HPHOTKovsJEBw9Cuy6+fzNv4cYJ0duIoxxUEJw9UV4nFmaok4DAGpGy
	 lenhkPxih5QPFfGNkUEiwHeWNvIizMM8tEbuDWDnRBwxEJPjoTnWOvXSCDIOaxRe2e
	 kteVLN7ichRY2e0kQNH24KREiESVrqnpPxPuV/WU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392083AbgAPRZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:25:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:33234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391958AbgAPRZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:25:29 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92634246D6;
        Thu, 16 Jan 2020 17:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195528;
        bh=4FwwNBMxPQsMF1REKzY3u6wC+rgjFHSdFCTiwJQWwUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rODUwBemp9DY8gDih+jyUyINvD7khqbzmD6msjLBVn0R5NZN0ISgzkJtMN6L55Z1z
         AM8qo3Kkb/ZUSZu0ABGage3PHXsLWoC9bf0oTKVhoBUcNP8gvKeQRtZEsmIcIMMOEl
         oLjV1tKaN7waTeX/a6w0SOq9E5xsNAUsGMZpk0nI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vladimir Murzin <vladimir.murzin@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.14 124/371] ARM: 8848/1: virt: Align GIC version check with arm64 counterpart
Date:   Thu, 16 Jan 2020 12:19:56 -0500
Message-Id: <20200116172403.18149-67-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116172403.18149-1-sashal@kernel.org>
References: <20200116172403.18149-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 60146e32619a..82a942894fc0 100644
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

