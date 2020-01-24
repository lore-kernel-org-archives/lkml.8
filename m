Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD4FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79CAF214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579859509;
	bh=/n7YcuZlOmzfYT8zxRWGW7Iz53ruotEq+5osQ/b2GX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HYaVVcijz8eznK9NzovZgxId+NPTm5VoWBX8Y6XSwC79T3A42e6U/4vVwGa70woFz
	 ImEbP7hxL13rCCQuZok4TTtlKjmOzkkbSrnxQIUl1DUtXY/a7/oSMc58ArTOhbOuV7
	 s8JLABwsyF1iNT5Z8rEoYuNWZKvBfZVHIjw02M1s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387913AbgAXJvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:51:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:53250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387843AbgAXJvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:51:46 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D683206D5;
        Fri, 24 Jan 2020 09:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579859505;
        bh=/n7YcuZlOmzfYT8zxRWGW7Iz53ruotEq+5osQ/b2GX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hq7uHNxnJf46FNYmf3m4/BKDS+S1PoAJlmKSQKRxowyKI/LXlhfWRBHVaT+VTkUTe
         eZOWA7qBnCldL0ZmTZexFlaIxUSeKuloYEfyu/vpgHPZQjv62XvYNJSxBq4DRq6whL
         1lQ/lDpwcGXiNk3TCM3DOCcM4t4yQ/JaxiJsD6yo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 118/343] drm/nouveau/bios/ramcfg: fix missing parentheses when calculating RON
Date:   Fri, 24 Jan 2020 10:28:56 +0100
Message-Id: <20200124092935.552114926@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092919.490687572@linuxfoundation.org>
References: <20200124092919.490687572@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 13649101a25c53c87f4ab98a076dfe61f3636ab1 ]

Currently, the expression for calculating RON is always going to result
in zero no matter the value of ram->mr[1] because the ! operator has
higher precedence than the shift >> operator.  I believe the missing
parentheses around the expression before appying the ! operator will
result in the desired result.

[ Note, not tested ]

Detected by CoveritScan, CID#1324005 ("Operands don't affect result")

Fixes: c25bf7b6155c ("drm/nouveau/bios/ramcfg: Separate out RON pull value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gddr3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gddr3.c b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gddr3.c
index 60ece0a8a2e1b..1d2d6bae73cd1 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gddr3.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gddr3.c
@@ -87,7 +87,7 @@ nvkm_gddr3_calc(struct nvkm_ram *ram)
 		WR  = (ram->next->bios.timing[2] & 0x007f0000) >> 16;
 		/* XXX: Get these values from the VBIOS instead */
 		DLL = !(ram->mr[1] & 0x1);
-		RON = !(ram->mr[1] & 0x300) >> 8;
+		RON = !((ram->mr[1] & 0x300) >> 8);
 		break;
 	default:
 		return -ENOSYS;
-- 
2.20.1



