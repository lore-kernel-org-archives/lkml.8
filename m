Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A3AC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52BFC217D8
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587043672;
	bh=LfWkDjywQCoxUu+49IHyA0f/oOATnPdQz1zBNlFyEoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=depGUwrUPMfxRJYqERs8lrsD2ghN27fDSfca+/wALj20girz2MQTmGPLOGfnPKU9/
	 2TnApFnYQzut/zUYlLW/QoU23C4HtgMlqUvOGumc9netH9wU4v9Fr4K/skpNOrRMWx
	 BJBarCltaRfSWYd6ber180plHjmRBx5Mdh0o0ZJc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895606AbgDPN1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 09:27:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:34982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2895298AbgDPN0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:26:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EA1E21D79;
        Thu, 16 Apr 2020 13:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587043605;
        bh=LfWkDjywQCoxUu+49IHyA0f/oOATnPdQz1zBNlFyEoo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1yeQ4mO+bOzJ20uWvvR/kbe22OApVKy5pFbPetK5W7gTbTqbQHqYuTDtp/nTBpeAj
         OHJx/bskFCSubWmCHH+N5b5K4mtmNZ49fO2RUSfOAOvgKMOaW/2I6u88hHw0iH2ul5
         u7ahPfVrbWXuGzviPUMpX477YGBhwCgiR6nK4mH4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, chenqiwu <chenqiwu@xiaomi.com>,
        Kees Cook <keescook@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 025/146] pstore/platform: fix potential mem leak if pstore_init_fs failed
Date:   Thu, 16 Apr 2020 15:22:46 +0200
Message-Id: <20200416131245.888112119@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131242.353444678@linuxfoundation.org>
References: <20200416131242.353444678@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: chenqiwu <chenqiwu@xiaomi.com>

[ Upstream commit 8a57d6d4ddfa41c49014e20493152c41a38fcbf8 ]

There is a potential mem leak when pstore_init_fs failed,
since the pstore compression maybe unlikey to initialized
successfully. We must clean up the allocation once this
unlikey issue happens.

Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
Link: https://lore.kernel.org/r/1581068800-13817-1-git-send-email-qiwuchen55@gmail.com
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/pstore/platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 4bae3f4fe829d..dcd9c3163587c 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -802,9 +802,9 @@ static int __init pstore_init(void)
 
 	ret = pstore_init_fs();
 	if (ret)
-		return ret;
+		free_buf_for_compression();
 
-	return 0;
+	return ret;
 }
 late_initcall(pstore_init);
 
-- 
2.20.1



