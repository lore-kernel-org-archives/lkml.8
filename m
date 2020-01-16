Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A01C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 850B22073A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579200163;
	bh=7pl7lK1KOW0b4GqLq3o0CUIRMgonuai131WNRNpX6/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p7xS/rCOEi1kq4hew9ZonPgH81brPuJThlw8pZtiYnWPkxh+p27qkkjP6+Q6X+L1g
	 Y2M0weX5qM4ru9F7+13ZdMtHJadaukeRfainifFrym8jSVZqMeDj3oKHsK2Jla5C3O
	 DDwc+8N2XwW++4m1ynbTTDk2do7/6eKEjUPO3fIU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436960AbgAPSmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:42:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:52014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389471AbgAPRLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:11:25 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 959DD21D56;
        Thu, 16 Jan 2020 17:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194685;
        bh=7pl7lK1KOW0b4GqLq3o0CUIRMgonuai131WNRNpX6/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2JctedowzlH7nwWDLpBfsG/QRNICScbDHiUM1hga5P3d+hAM42hbomrEQPYVnHKj+
         LebhAxNZ11paoKWtVmdJG0ANnPzGiiheAFpbXsssnv3LQGWmhPStUoJpGsGMAHPkcT
         iRJLtgfhf80Bo7VkSEaJjdZCD59PzEQo7vlZ3R/g=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 529/671] xsk: avoid store-tearing when assigning queues
Date:   Thu, 16 Jan 2020 12:02:47 -0500
Message-Id: <20200116170509.12787-266-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Björn Töpel <bjorn.topel@intel.com>

[ Upstream commit 94a997637c5b562fa0ca44fca1d2cd02ec08236f ]

Use WRITE_ONCE when doing the store of tx, rx, fq, and cq, to avoid
potential store-tearing. These members are read outside of the control
mutex in the mmap implementation.

Acked-by: Jonathan Lemon <jonathan.lemon@gmail.com>
Fixes: 37b076933a8e ("xsk: add missing write- and data-dependency barrier")
Signed-off-by: Björn Töpel <bjorn.topel@intel.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xdp/xsk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index c90854bc3048..b580078f04d1 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -320,7 +320,7 @@ static int xsk_init_queue(u32 entries, struct xsk_queue **queue,
 
 	/* Make sure queue is ready before it can be seen by others */
 	smp_wmb();
-	*queue = q;
+	WRITE_ONCE(*queue, q);
 	return 0;
 }
 
-- 
2.20.1

