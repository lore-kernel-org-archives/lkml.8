Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E552C18E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 09:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 764422076A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 09:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8A3l0X0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbgCYJIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 05:08:42 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42096 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgCYJIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 05:08:40 -0400
Received: by mail-wr1-f67.google.com with SMTP id h15so1861741wrx.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 02:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=afugKYwAFd8RIjB02GefkanDSF4I40fGZACjXYFZuvM=;
        b=N8A3l0X0NYWYEhPlpQP/+iv/Y0Vene5U0OT2pZ8Y592F4PnmV4TPrBAuYTOXyW3w9O
         Sj2pD3Y+E4dN/71GlxXT7Ox4C9O9sX9HH8r4UKCPHefbeDz36/ll05FmBYWWvVZoNVYT
         65DCrSfJ7Sx7eyCbjn4yjhQw0oAV1htzqwj8a3HkWKlKN8bOSBsWacfeQ+I16Spf5tkY
         osgCMfOmu12YOlvPORg7J05FsbvWfBmny5xh1zfZeY7qF3UphPwQEA5PutNn19NfAMkX
         TusJn2c4GDwDF8VPgo2ZSqwJMWV6Mm2Mqk/zGFPSZ5RhwwtK4PLuieU9q2fW8jkG9+0L
         ugGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=afugKYwAFd8RIjB02GefkanDSF4I40fGZACjXYFZuvM=;
        b=gVmr8gRjpmxp4Gp49DRbiQ9TZr6GZrXqWtGWy09cOPna7ZJ99+beE/lD+88ItwBAV4
         Euh/kz+aoRVlcTZw5SHh2ACgb8VgRoC6p4JAWDhnYX0HF5kxXALqt1+L0rRhQaRcZYIg
         t6au6yAhYq9sisATllHW+ejbqpntQYEbs4ZIPEVdmV8dSIS0OHMJy8nmd68ywsgbOdbB
         OG2mZ6pU/QINuvjT+lPAeFxU6/9j4cFLhAxeBTtblGOlqc3f4Z0adpagEUkW7FSjkYtK
         wIpCeE6E1+MjvPxwriDC31yB7OYp04qsGgdC9NdiBLXaR1Dk02OyY5a3mlN3lr+yaUx9
         AfrA==
X-Gm-Message-State: ANhLgQ2SXnEOASOv6jz2bqVatvboQ0ZMjBo86EdUZoATPJ1y/MElCxJm
        Zbw+B2NbVoTKMg6z6955Qt0=
X-Google-Smtp-Source: ADFU+vtNxVoilqqyVG5ulxzKb1TzStqeHOA53Zlr5aY/seDzTHSCFa6Rzv9dSOnd4deF0AXX/BR+YA==
X-Received: by 2002:adf:ce0d:: with SMTP id p13mr2269121wrn.8.1585127319134;
        Wed, 25 Mar 2020 02:08:39 -0700 (PDT)
Received: from wasp.lan (250.128.208.46.dyn.plus.net. [46.208.128.250])
        by smtp.googlemail.com with ESMTPSA id 127sm8565048wmd.38.2020.03.25.02.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 02:08:38 -0700 (PDT)
From:   Shane Francis <bigbeeshane@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     amd-gfx-request@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, bigbeeshane@gmail.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        mripard@kernel.org, airlied@linux.ie, David1.Zhou@amd.com
Subject: [PATCH v4 1/3] drm/prime: use dma length macro when mapping sg
Date:   Wed, 25 Mar 2020 09:07:39 +0000
Message-Id: <20200325090741.21957-2-bigbeeshane@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200325090741.21957-1-bigbeeshane@gmail.com>
References: <20200325090741.21957-1-bigbeeshane@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As dma_map_sg can reorganize scatter-gather lists in a
way that can cause some later segments to be empty we should
always use the sg_dma_len macro to fetch the actual length.

This could now be 0 and not need to be mapped to a page or
address array

Signed-off-by: Shane Francis <bigbeeshane@gmail.com>
---
 drivers/gpu/drm/drm_prime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index 86d9b0e45c8c..1de2cde2277c 100644
--- a/drivers/gpu/drm/drm_prime.c
+++ b/drivers/gpu/drm/drm_prime.c
@@ -967,7 +967,7 @@ int drm_prime_sg_to_page_addr_arrays(struct sg_table *sgt, struct page **pages,
 
 	index = 0;
 	for_each_sg(sgt->sgl, sg, sgt->nents, count) {
-		len = sg->length;
+		len = sg_dma_len(sg);
 		page = sg_page(sg);
 		addr = sg_dma_address(sg);
 
-- 
2.26.0

