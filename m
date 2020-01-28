Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB74CC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0D7A24681
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580221092;
	bh=MN5SoSpRDTZYg4p45Ic50aDKFkzbON1FF6+o9HI5cN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sjYiTT0QeQdEQ/C7fLXq7gzr0zBGd96j9Wa6z/MtEq7DJGWDnTRyT36etVk8MLYd5
	 WmxbYXBC01J6o2PkbFWEUGvzTKkpVcCYpLXSrBBE++k2NPPwKTCKGCWDE5xhulAE7M
	 iIa1oiockA7R4ruHq+NWDfkZ5NK5TZNhk9qa5Log=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730217AbgA1OSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:18:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:41982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730621AbgA1OSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:18:05 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28BEA2071E;
        Tue, 28 Jan 2020 14:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580221084;
        bh=MN5SoSpRDTZYg4p45Ic50aDKFkzbON1FF6+o9HI5cN0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ddOlpuV25sgwJqKco5Jg8yRO22PEiIu3LjqfOzCU4lxIQ/YgjAgDXiCXRAVEyYMsE
         RQ7zjlEB8te6AR54KSgkqdzNVnosuDq7gZNq0vnRvFxfqiFwsV+RLJv5TmeBDr05b2
         eQ8RNBuig13D+Jj8SY05U1hOczVS2Jhi8fCuuo7c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 083/271] drm/nouveau/pmu: dont print reply values if exec is false
Date:   Tue, 28 Jan 2020 15:03:52 +0100
Message-Id: <20200128135858.736277392@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135852.449088278@linuxfoundation.org>
References: <20200128135852.449088278@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit b1d03fc36ec9834465a08c275c8d563e07f6f6bf ]

Currently the uninitialized values in the array reply are printed out
when exec is false and nvkm_pmu_send has not updated the array. Avoid
confusion by only dumping out these values if they have been actually
updated.

Detected by CoverityScan, CID#1271291 ("Uninitialized scaler variable")
Fixes: ebb58dc2ef8c ("drm/nouveau/pmu: rename from pwr (no binary change)")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/memx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/memx.c b/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/memx.c
index e6f74168238c7..2ef9e942f43a2 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/memx.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/memx.c
@@ -87,10 +87,10 @@ nvkm_memx_fini(struct nvkm_memx **pmemx, bool exec)
 	if (exec) {
 		nvkm_pmu_send(pmu, reply, PROC_MEMX, MEMX_MSG_EXEC,
 			      memx->base, finish);
+		nvkm_debug(subdev, "Exec took %uns, PMU_IN %08x\n",
+			   reply[0], reply[1]);
 	}
 
-	nvkm_debug(subdev, "Exec took %uns, PMU_IN %08x\n",
-		   reply[0], reply[1]);
 	kfree(memx);
 	return 0;
 }
-- 
2.20.1



