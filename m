Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F45C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 21:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0CED206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 21:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580507753;
	bh=1A/9cnzC44tFaknofjEmkdfZvzu/ud3zUk02qKrPtn8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=M9cE+lzX+jzY78T8RGEH5kwd1mRTHD800lkcryMHYRBapBFeHWgON3cl5oZKjtmmD
	 Mgxmpk9+WbVO+5x5FpEB21O8FBw9vS/TlrRLpHYQRpb3qCgjTbo68QwgfpICgZv350
	 HZ2xAjmCuix7ZiExpx9kUs6wOlrvbUdYG+2Swivw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgAaVzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 16:55:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:56148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726488AbgAaVzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 16:55:45 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6419A21734;
        Fri, 31 Jan 2020 21:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580507745;
        bh=1A/9cnzC44tFaknofjEmkdfZvzu/ud3zUk02qKrPtn8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=0/qLbNJYOfInBh+HE4XD/86jA4D+J0AgF394vpOpBylYU1TejlAdLrCPNjaYp4X4L
         IK1uJQzZB2FrW/U24Z3j8Ay6o1+l/+X8I8n9AoltHIIHq3M7SQE5quFM+3JjE0agPU
         bGdnNHrdUJWdqL7Xcw0QdCi5wMVvhrjRpSjQm3cE=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH 3/4] tracing: Remove useless code in dynevent_arg_pair_add()
Date:   Fri, 31 Jan 2020 15:55:33 -0600
Message-Id: <7880a1268217886cdba7035526650195668da856.1580506712.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1580506712.git.zanussi@kernel.org>
References: <cover.1580506712.git.zanussi@kernel.org>
In-Reply-To: <cover.1580506712.git.zanussi@kernel.org>
References: <cover.1580506712.git.zanussi@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The final addition to q is unnecessary, since q isn't ever used
afterwards.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace_dynevent.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index f9cfcdc9d1f3..204275ec8d71 100644
--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -322,7 +322,7 @@ int dynevent_arg_pair_add(struct dynevent_cmd *cmd,
 		pr_err("field string is too long: %s\n", arg_pair->rhs);
 		return -E2BIG;
 	}
-	cmd->remaining -= delta; q += delta;
+	cmd->remaining -= delta;
 
 	return ret;
 }
-- 
2.14.1

