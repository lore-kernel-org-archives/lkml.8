Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CD8C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DD0A214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579865499;
	bh=92U63fqsL33Tu72ET5z/ng5mQ73l+6C1Rl4zMKJnV0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=soDTjSvpYe9frZLCPoeWoD8JQ3Ob+g8IEfSuKHaOz5bHylxHXIO7332n0lPauT3X+
	 Q3FrqqIfdCRSIBoWxGrxzaIGQdQOBtwb9UxlNOvPTuCzk5O2x6v0xCtT4aGTIPuLc8
	 WjGkFvBkamSl72QNTbZOjISbJ95Gi3zJFwFtSILA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391902AbgAXLbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:31:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:49926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391877AbgAXLbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:31:31 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7646820704;
        Fri, 24 Jan 2020 11:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579865491;
        bh=92U63fqsL33Tu72ET5z/ng5mQ73l+6C1Rl4zMKJnV0o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BqcLyFuZykiWAJzfyJoEpi7FvBw0UtjY9rVj8ThFvXfPdN6THNf+75easaslBBFdT
         ofbuuRXnZJejvO3rEdq/jHgTUqoIJt4rOK7yYz1s5zxN0bY0k+kqsXqqK9l5aEpz+0
         N9gJIDxlGj8kH4+5xIpyBTvuks1lKPHUHJOzBJcM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jonathan Lemon <jonathan.lemon@gmail.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 543/639] xsk: avoid store-tearing when assigning queues
Date:   Fri, 24 Jan 2020 10:31:53 +0100
Message-Id: <20200124093157.095033868@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index c90854bc3048e..b580078f04d15 100644
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



