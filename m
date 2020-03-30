Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D9AC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 12:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E3A20675
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 12:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pi64xMQ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbgC3MhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 08:37:18 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39532 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730227AbgC3MhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 08:37:16 -0400
Received: by mail-wm1-f65.google.com with SMTP id e9so9778276wme.4;
        Mon, 30 Mar 2020 05:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uf0TDgv1/qWtsH3KLO7savy+BV3YM3XxU5+nWmfqf/U=;
        b=pi64xMQ+vFHsfxixMKtMcBQSGKBdz5o3dNXDvpU39w9dLPmxx0JUvHzNhnRxrVBWBD
         L/Wc1ip80v8dBBAvskXs1mHj73E1dh0LnhTixL67A6MkuYn+FFRljKmp/s01rPCNeg3T
         h7NkCBoy9V0ESrXxEDON1H6d2JO65RhCBA5XTBBwttCn9euPFG1R2sSBxeb3GcGpJ2Pi
         5bOTOHnZwWM+Q+6HYLAlhvusmYdQuxkM7EhZ5BMCcS38oM0KjlK84ZvK8CchvCt28RQu
         2vz2Lt98FFJcxlW8fvw7iSvTjovbUfQbuan0mpHvSSok4lAVMxbBX1zAMWW0wufDIgDM
         FmTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uf0TDgv1/qWtsH3KLO7savy+BV3YM3XxU5+nWmfqf/U=;
        b=TeshRPXXkKLU9fSZpCYq2A6UoHL0uYsuM0+r7yESOra9IK0mmTBD1Et0/vdjTzGLJt
         10cMTXc/kzZYkK3C2k08JVnprGgQCIIXicM5Jjrrrft0gS71JCnSGloOoGUaC5ZIeiRZ
         jJIMYibd2lEZJk318mfM/9ggOFkQUyBjG2w33wlluyM7VVPT6GlEVVHF1A7va3Ffwdjv
         kkl1q1DCgT/QTZafORz5nP3SUs2OVI6EM6CjbydkaMLfj90wmbotpAEUGzbC+OYM3Nyt
         d2tleSnnbzq5kcx5nWRY7IGI3ttv0x9pZpwkIeisZrxEI08Ot0IGzXstT/sjfFJPu5kl
         43zQ==
X-Gm-Message-State: ANhLgQ134IBfPFSqfrtYH6pl6KRRJJpJOBWehAq0SvwIk0RdlcrgiLaA
        7zhmeEaMpnDzezQeaO9Sg47EMEic
X-Google-Smtp-Source: ADFU+vuJKZ66TgfwAiekux803DmjgENE+YLTl2RZmGmIACs+MBdQUYNhAaR/e6JLDRwpHqCUZu4p+w==
X-Received: by 2002:a7b:cf09:: with SMTP id l9mr13275910wmg.11.1585571833746;
        Mon, 30 Mar 2020 05:37:13 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a16sm19889486wmm.20.2020.03.30.05.37.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Mar 2020 05:37:13 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     willy@infradead.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 4/9] XArray: don't expect to have more nr_values than count
Date:   Mon, 30 Mar 2020 12:36:38 +0000
Message-Id: <20200330123643.17120-5-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200330123643.17120-1-richard.weiyang@gmail.com>
References: <20200330123643.17120-1-richard.weiyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nr_values is expected to be smaller than count, use a more strict
boundary to do this check.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 lib/xarray.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/xarray.c b/lib/xarray.c
index 1a092c87fca5..e08a0388a156 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -744,7 +744,7 @@ static void update_node(struct xa_state *xas, struct xa_node *node,
 	node->count += count;
 	node->nr_values += values;
 	XA_NODE_BUG_ON(node, node->count > XA_CHUNK_SIZE);
-	XA_NODE_BUG_ON(node, node->nr_values > XA_CHUNK_SIZE);
+	XA_NODE_BUG_ON(node, node->nr_values > node->count);
 	xas_update(xas, node);
 	if (count < 0)
 		xas_delete_node(xas);
-- 
2.23.0

