Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFE1C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B08972070E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592944829;
	bh=aJy1wXut2lURQAXKT/zw1Qi3JWbRdii4jqOG+7o93cQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r2vBY+2Q+Mhs92SG/F76wJgoLKa/Am9UwPvT42G6CbxHg+157l9sblBhZRxttw0bU
	 v9KvKVbo4BYY8HABwxpy448t9xr5nTaDgTmEiKhyoU+NdbzntHxXB7kSOWKphZ/QOR
	 YAtraa3OCgYPqfZzV1020+KjqAtRFA9Die0sRkcQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389274AbgFWUk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:40:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:36446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391831AbgFWUkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:40:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCD7720675;
        Tue, 23 Jun 2020 20:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944824;
        bh=aJy1wXut2lURQAXKT/zw1Qi3JWbRdii4jqOG+7o93cQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k1HPB3P0i1/gp4z7Kkxf4bF/iNsztTkkGxkONtUcKvyJR1HlzzEfygfd+gXCMhioH
         P5jMY8E7I+OyEy8HfHWzXMWhA6qpLZHM2TWI1RXSPIcyTvR9sJS+6+sg5K5zOQB/6s
         0+UcRlWKjFhalwx1gynWFHlVED/hKCeOZ2h5TKns=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 140/206] blktrace: fix endianness in get_pdu_int()
Date:   Tue, 23 Jun 2020 21:57:48 +0200
Message-Id: <20200623195323.873758816@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195316.864547658@linuxfoundation.org>
References: <20200623195316.864547658@linuxfoundation.org>
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
index 5c84f7421871d..42027cf4ea91e 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1267,7 +1267,7 @@ static inline __u16 t_error(const struct trace_entry *ent)
 
 static __u64 get_pdu_int(const struct trace_entry *ent, bool has_cg)
 {
-	const __u64 *val = pdu_start(ent, has_cg);
+	const __be64 *val = pdu_start(ent, has_cg);
 	return be64_to_cpu(*val);
 }
 
-- 
2.25.1



