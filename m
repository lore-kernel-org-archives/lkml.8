Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A3DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25DCF20708
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579864323;
	bh=ArkTOcEDEJzTLKU7OFO+/djQ9uXumhXoGANpfr55u00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JGulLjSfM5tOAOG+uU5rxj8bWnBppCzXnFXfE4jhWOPmq0Af/S2y9DFsgk8W7N3af
	 y0eaYtlTWVXSLcUPVU7FrjHa58vpK7WWUOJb2Y1PxkGtFRyiJXNZsgzh8mYGriyTqN
	 52t8dudjKXbktES86cTR9D5HMVeTB1+wIAuhfm6o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388613AbgAXLMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:12:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:48156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733280AbgAXLL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:11:59 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FC8D20663;
        Fri, 24 Jan 2020 11:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579864318;
        bh=ArkTOcEDEJzTLKU7OFO+/djQ9uXumhXoGANpfr55u00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gSW9H1zDcfSBkxIbvvChAT82Qn71oxzz/LvKzSwOTUQVJfIagfpPPAR2e/Gfe2fYJ
         AOfS74QLUtMHh0uGPkSx7+7Avrajq4NTnwaKv0aWaQjQ5twEFxYo7TlwXCu+pM6RFB
         Y1rAxzpZH5+39OKm9XjIA/VFo876J3cdmf0lsQ5M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 220/639] drm/nouveau: fix missing break in switch statement
Date:   Fri, 24 Jan 2020 10:26:30 +0100
Message-Id: <20200124093114.498731655@linuxfoundation.org>
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

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 785cf1eeafa23ec63f426d322401054d13abe2a3 ]

The NOUVEAU_GETPARAM_PCI_DEVICE case is missing a break statement and falls
through to the following NOUVEAU_GETPARAM_BUS_TYPE case and may end up
re-assigning the getparam->value to an undesired value. Fix this by adding
in the missing break.

Detected by CoverityScan, CID#1460507 ("Missing break in switch")

Fixes: 359088d5b8ec ("drm/nouveau: remove trivial cases of nvxx_device() usage")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nouveau_abi16.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_abi16.c b/drivers/gpu/drm/nouveau/nouveau_abi16.c
index e67a471331b51..6ec745873bc55 100644
--- a/drivers/gpu/drm/nouveau/nouveau_abi16.c
+++ b/drivers/gpu/drm/nouveau/nouveau_abi16.c
@@ -214,6 +214,7 @@ nouveau_abi16_ioctl_getparam(ABI16_IOCTL_ARGS)
 			WARN_ON(1);
 			break;
 		}
+		break;
 	case NOUVEAU_GETPARAM_FB_SIZE:
 		getparam->value = drm->gem.vram_available;
 		break;
-- 
2.20.1



