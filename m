Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE38C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90448207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597073614;
	bh=7TiK53xFoSKriDUpsjT7QaIg562K5VM1xyvhfBtoysI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U93tZ0s7rPm+P+z1OZTFlMkLfIJLsOtDrhXmvzPasixe8kLJto70wL+j9gDZrnlRB
	 Xu4OQzOQvuVofjr1C6DtG7MrMZxmUCqDaPnAOt/wRC15ND+nVT7SdpUYGWT09AJbMD
	 05CBbZNOnWDZKtg8v3fh2Zhww+en/fMeCFa8v4vI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbgHJPdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:33:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:36354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728767AbgHJP3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:29:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EDB122B47;
        Mon, 10 Aug 2020 15:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597073388;
        bh=7TiK53xFoSKriDUpsjT7QaIg562K5VM1xyvhfBtoysI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yH9ISboadDNVaByQr+Bbokhko1rDDRLUpialVgzYZ+jx3av2ttaCKGMfqHNTNZdzI
         ezvWTQ616gP8g6Y3LkjfdpdT5XWO1dQ0wYi9D5dlaElLVy5W1Jhriv6r6izGMYUlaC
         iVRR+Eh5c+lxoRoZScDCIBiGeJ2Tb8FWajonIY0E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 20/48] drm/nouveau/fbcon: fix module unload when fbcon init has failed for some reason
Date:   Mon, 10 Aug 2020 17:21:42 +0200
Message-Id: <20200810151805.207630766@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200810151804.199494191@linuxfoundation.org>
References: <20200810151804.199494191@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Skeggs <bskeggs@redhat.com>

[ Upstream commit 498595abf5bd51f0ae074cec565d888778ea558f ]

Stale pointer was tripping up the unload path.

Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nouveau_fbcon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_fbcon.c b/drivers/gpu/drm/nouveau/nouveau_fbcon.c
index 0f64c0a1d4b30..fef38ea146a2a 100644
--- a/drivers/gpu/drm/nouveau/nouveau_fbcon.c
+++ b/drivers/gpu/drm/nouveau/nouveau_fbcon.c
@@ -599,6 +599,7 @@ fini:
 	drm_fb_helper_fini(&fbcon->helper);
 free:
 	kfree(fbcon);
+	drm->fbcon = NULL;
 	return ret;
 }
 
-- 
2.25.1



