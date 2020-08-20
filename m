Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4288BC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11AED2078D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597918280;
	bh=tpC6nHZoH1PnEAHCP82qYae3GdmxlAsc2q+a/13Zj6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FxOv3BSE+ZjgSCduPxvnZmR24zELlbUBysQ3kqilCPeVH0K+QI7vb9+HrmBWE6645
	 0anhmbkfZYtEIPbaOZa9eXZvsfuSk71fMf/hYD6v9q52m5ZlqtkrAQlw11+L2WXo1z
	 IfOXr5kdO3WHYkDwItkvFKknx51DRW5M3Iji3SVM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730954AbgHTKLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:11:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:47954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730174AbgHTKKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:10:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65C85206DA;
        Thu, 20 Aug 2020 10:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918244;
        bh=tpC6nHZoH1PnEAHCP82qYae3GdmxlAsc2q+a/13Zj6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tPzBsBCaaWBV3KGlja92Emhx/ITCED1dg3MEnneMZw6UTodeAUiVzh52Mp61qRHmQ
         xgoxkc93M7EY4t61TJ9q1T2/uoRnHmO0xhzJjuMVzcDe1gWORVMvNbB5v3mVbh4ajZ
         R3N4dXZOM0Cd1fHc/VqcncaA3yiqzZL7jKVtsJ9s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tom Rix <trix@redhat.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 103/228] drm/bridge: sil_sii8620: initialize return of sii8620_readb
Date:   Thu, 20 Aug 2020 11:21:18 +0200
Message-Id: <20200820091612.761057152@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091607.532711107@linuxfoundation.org>
References: <20200820091607.532711107@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

[ Upstream commit 02cd2d3144653e6e2a0c7ccaa73311e48e2dc686 ]

clang static analysis flags this error

sil-sii8620.c:184:2: warning: Undefined or garbage value
  returned to caller [core.uninitialized.UndefReturn]
        return ret;
        ^~~~~~~~~~

sii8620_readb calls sii8620_read_buf.
sii8620_read_buf can return without setting its output
pararmeter 'ret'.

So initialize ret.

Fixes: ce6e153f414a ("drm/bridge: add Silicon Image SiI8620 driver")
Signed-off-by: Tom Rix <trix@redhat.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20200712152453.27510-1-trix@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/sil-sii8620.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/sil-sii8620.c b/drivers/gpu/drm/bridge/sil-sii8620.c
index 0cb69ee94ac16..b93486892f4ae 100644
--- a/drivers/gpu/drm/bridge/sil-sii8620.c
+++ b/drivers/gpu/drm/bridge/sil-sii8620.c
@@ -167,7 +167,7 @@ static void sii8620_read_buf(struct sii8620 *ctx, u16 addr, u8 *buf, int len)
 
 static u8 sii8620_readb(struct sii8620 *ctx, u16 addr)
 {
-	u8 ret;
+	u8 ret = 0;
 
 	sii8620_read_buf(ctx, addr, &ret, 1);
 	return ret;
-- 
2.25.1



