Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9A8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD7CA20723
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592944243;
	bh=5sLVfkxX1OyuNix264Kr2X2XLM024ZxQUQ6vj9xVQ7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hOHob/uqb4j4cv+qN2iV+LEZnlCaYCRYkYbSJB3SBasjUdauzs6Cn3OoOlRK0s8OQ
	 BCEtBQk0xAyIc7cJ96tIyZZLwx70Mfpyn2TS/4283XJhQxWBdVEHmUJd6NQ/eD2MYA
	 lxO+B61OuJPt+1RTdeOB/sbGtYIdNCULmr2AVWkU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391161AbgFWUal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:30:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:51030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391152AbgFWUak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:30:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0BBE2070E;
        Tue, 23 Jun 2020 20:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944240;
        bh=5sLVfkxX1OyuNix264Kr2X2XLM024ZxQUQ6vj9xVQ7w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zy9Kew3qVpoh5TAxWkGwzqUDubWPfzGHlPCk+55lEjo0h8RGlFQO/xcR0R8J114pe
         G05yMnEycGrSoPiVk6tXp2VqfDYn/L1vZwq06e3vzj7bgGXUxvBxpRNjUcUE7rEFy5
         1k+rPaJGa2Pnk47+pzgeuK/sYMHGhXrck2PKN09U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 226/314] blktrace: fix endianness in get_pdu_int()
Date:   Tue, 23 Jun 2020 21:57:01 +0200
Message-Id: <20200623195349.729986806@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195338.770401005@linuxfoundation.org>
References: <20200623195338.770401005@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

[ Upstream commit 71df3fd82e7cccec7b749a8607a4662d9f7febdd ]

In function get_pdu_len() replace variable type from __u64 to
__be64. This fixes sparse warning.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/blktrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 9e02e1ce0ac01..23e5f86c99215 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1262,7 +1262,7 @@ static inline __u16 t_error(const struct trace_entry *ent)
 
 static __u64 get_pdu_int(const struct trace_entry *ent, bool has_cg)
 {
-	const __u64 *val = pdu_start(ent, has_cg);
+	const __be64 *val = pdu_start(ent, has_cg);
 	return be64_to_cpu(*val);
 }
 
-- 
2.25.1



