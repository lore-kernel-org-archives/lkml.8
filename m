Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B22C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE0012071E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587551913;
	bh=0y/5BMQGM3DYpHq4BrRPiLOjAhM4y++Aic+mXtCHW3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wKF40x9wWt5ws9b9zqfIMmWaS0wHgyAqHibt88AEVJW5L/La4Ch68GtpcLdceWHPn
	 fUCmX09lJklCoJ3i2nNKE7UPMgqORp+vBauTG519QxzdizPs7CfXidte2nToWNcZE/
	 uAOWJkVGdtMtTxzkfODBuKQyEJnpOQfxtvnfLo+M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731482AbgDVKic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:38:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:58354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729916AbgDVKWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:22:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F2BE20780;
        Wed, 22 Apr 2020 10:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550913;
        bh=0y/5BMQGM3DYpHq4BrRPiLOjAhM4y++Aic+mXtCHW3s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rLmId7krcogdJgacgP0luF/J+v6pM1dd3xKSBLMONM/yKS9/l5VxVD7V8ytU7ToHq
         JpT1UaBlxmRbpxa/ZX0jtR1GxV71jVHKFfbtTmruHA4ULfEC1N9mM6EIZ2je1qvWmb
         +2r8u8Ym94rKoShk05VNkh6u8nI6+DelqAWemzMk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Li RongQing <lirongqing@baidu.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>
Subject: [PATCH 5.6 008/166] xsk: Fix out of boundary write in __xsk_rcv_memcpy
Date:   Wed, 22 Apr 2020 11:55:35 +0200
Message-Id: <20200422095049.026646752@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095047.669225321@linuxfoundation.org>
References: <20200422095047.669225321@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li RongQing <lirongqing@baidu.com>

commit db5c97f02373917efe2c218ebf8e3d8b19e343b6 upstream.

first_len is the remainder of the first page we're copying.
If this size is larger, then out of page boundary write will
otherwise happen.

Fixes: c05cd3645814 ("xsk: add support to allow unaligned chunk placement")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Jonathan Lemon <jonathan.lemon@gmail.com>
Acked-by: Björn Töpel <bjorn.topel@intel.com>
Link: https://lore.kernel.org/bpf/1585813930-19712-1-git-send-email-lirongqing@baidu.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/xdp/xsk.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -131,8 +131,9 @@ static void __xsk_rcv_memcpy(struct xdp_
 		u64 page_start = addr & ~(PAGE_SIZE - 1);
 		u64 first_len = PAGE_SIZE - (addr - page_start);
 
-		memcpy(to_buf, from_buf, first_len + metalen);
-		memcpy(next_pg_addr, from_buf + first_len, len - first_len);
+		memcpy(to_buf, from_buf, first_len);
+		memcpy(next_pg_addr, from_buf + first_len,
+		       len + metalen - first_len);
 
 		return;
 	}


