Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59ABEC35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B36B24673
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582271685;
	bh=38p9MvRGjy//9Vx20f5bGwTQYOMD8UNHHMDJnca5RVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bWVyPFCM+7tYLZvjMAPViafr7QbzOd0a7Le+O25E5aL4LEQLx1bYMoBYUAR45pbrk
	 NEvb2xj33uCnuwkR8CnR9aVqRZf9N4vF2H6ebQjNYJE3hCaarSlLD45IJLl2n/RNy/
	 Ftf8c/yF8PckSt2XBs29SzjP1cwhXo0TcJBqdJH4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730012AbgBUHyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 02:54:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:53286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728602AbgBUHyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 02:54:39 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD7AE20578;
        Fri, 21 Feb 2020 07:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582271679;
        bh=38p9MvRGjy//9Vx20f5bGwTQYOMD8UNHHMDJnca5RVU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qfwcqa7mQbg3YeOtM3SvkYToT4VHE3nwZe4w2wZ+rPEgQFiUOS5bOjJ50nRzedHLO
         T4EpRmqq/SRGm4mk2W1qcIo+JtxxYkQH/pNs6MdlovgaE3zFZOVQXuEBNpcgOTi6FH
         46na3/JTY/Dhc0kCBfOvqyWjdTo7y/624jGBKK/k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 257/399] drm/nouveau/gr/gk20a,gm200-: add terminators to method lists read from fw
Date:   Fri, 21 Feb 2020 08:39:42 +0100
Message-Id: <20200221072427.400888034@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072402.315346745@linuxfoundation.org>
References: <20200221072402.315346745@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Skeggs <bskeggs@redhat.com>

[ Upstream commit 7adc77aa0e11f25b0e762859219c70852cd8d56f ]

Method init is typically ordered by class in the FW image as ThreeD,
TwoD, Compute.

Due to a bug in parsing the FW into our internal format, we've been
accidentally sending Twod + Compute methods to the ThreeD class, as
well as Compute methods to the TwoD class - oops.

Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/nouveau/nvkm/engine/gr/gk20a.c    | 21 ++++++++++---------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gk20a.c b/drivers/gpu/drm/nouveau/nvkm/engine/gr/gk20a.c
index 500cb08dd6080..b57ab5cea9a10 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gk20a.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/gk20a.c
@@ -143,23 +143,24 @@ gk20a_gr_av_to_method(struct gf100_gr *gr, const char *fw_name,
 
 	nent = (fuc.size / sizeof(struct gk20a_fw_av));
 
-	pack = vzalloc((sizeof(*pack) * max_classes) +
-		       (sizeof(*init) * (nent + 1)));
+	pack = vzalloc((sizeof(*pack) * (max_classes + 1)) +
+		       (sizeof(*init) * (nent + max_classes + 1)));
 	if (!pack) {
 		ret = -ENOMEM;
 		goto end;
 	}
 
-	init = (void *)(pack + max_classes);
+	init = (void *)(pack + max_classes + 1);
 
-	for (i = 0; i < nent; i++) {
-		struct gf100_gr_init *ent = &init[i];
+	for (i = 0; i < nent; i++, init++) {
 		struct gk20a_fw_av *av = &((struct gk20a_fw_av *)fuc.data)[i];
 		u32 class = av->addr & 0xffff;
 		u32 addr = (av->addr & 0xffff0000) >> 14;
 
 		if (prevclass != class) {
-			pack[classidx].init = ent;
+			if (prevclass) /* Add terminator to the method list. */
+				init++;
+			pack[classidx].init = init;
 			pack[classidx].type = class;
 			prevclass = class;
 			if (++classidx >= max_classes) {
@@ -169,10 +170,10 @@ gk20a_gr_av_to_method(struct gf100_gr *gr, const char *fw_name,
 			}
 		}
 
-		ent->addr = addr;
-		ent->data = av->data;
-		ent->count = 1;
-		ent->pitch = 1;
+		init->addr = addr;
+		init->data = av->data;
+		init->count = 1;
+		init->pitch = 1;
 	}
 
 	*ppack = pack;
-- 
2.20.1



