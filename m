Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CE6C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D48952076B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596457919;
	bh=vU4+VOH5vhPw1PXmzy6dPFNnUjCipOoP9pslkWrjUCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HtSBA7FIGTM0JP7gPruSLXlFJYgNnopKeZvASR1Ct49YxI1wyEOT0e5XV5EGw0dQ2
	 h7d4X5jQUmwxcLHBoy5pLhYbs+Pq/RNJumkcWUxMObIf10Fb+g+X7+9tBWDe5JVao3
	 /oQD3H4Jt5Ck7AcjAeXBNV5V6iipZTQAvIjYU0ic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbgHCMb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:31:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:59686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729229AbgHCMby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:31:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B81F2076B;
        Mon,  3 Aug 2020 12:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596457913;
        bh=vU4+VOH5vhPw1PXmzy6dPFNnUjCipOoP9pslkWrjUCI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UGZKiilTbwBUf4r7jeUIB0jmFo8Cwb2VefdjXPVocxc4no9LIjbMv7Jsb7L8JIHsx
         DlgHXmuQnH26fY3Bxm3dhP19YKfpSHDiHYPEYnwwqnCL71PDPPKlKeJumK9D0S/wWF
         Vr0A1oIAuK0FpKyTDzRn6K5bYOTAHWlyf/tGN2lg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Harry Wentland <harry.wentland@amd.com>,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 08/56] drm/amd/display: prevent memory leak
Date:   Mon,  3 Aug 2020 14:19:23 +0200
Message-Id: <20200803121850.717314936@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200803121850.306734207@linuxfoundation.org>
References: <20200803121850.306734207@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

[ Upstream commit 104c307147ad379617472dd91a5bcb368d72bd6d ]

In dcn*_create_resource_pool the allocated memory should be released if
construct pool fails.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c   | 1 +
 5 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
index 3f76e6019546f..5a2f29bd35082 100644
--- a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
@@ -1001,6 +1001,7 @@ struct resource_pool *dce100_create_resource_pool(
 	if (construct(num_virtual_links, dc, pool))
 		return &pool->base;
 
+	kfree(pool);
 	BREAK_TO_DEBUGGER();
 	return NULL;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
index e5e9e92521e91..17d936c260d97 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
@@ -1344,6 +1344,7 @@ struct resource_pool *dce110_create_resource_pool(
 	if (construct(num_virtual_links, dc, pool, asic_id))
 		return &pool->base;
 
+	kfree(pool);
 	BREAK_TO_DEBUGGER();
 	return NULL;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
index 288129343c778..71adab8bf31b1 100644
--- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
@@ -1287,6 +1287,7 @@ struct resource_pool *dce112_create_resource_pool(
 	if (construct(num_virtual_links, dc, pool))
 		return &pool->base;
 
+	kfree(pool);
 	BREAK_TO_DEBUGGER();
 	return NULL;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
index d43f37d99c7d9..f0f2ce6da8278 100644
--- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
@@ -1076,6 +1076,7 @@ struct resource_pool *dce120_create_resource_pool(
 	if (construct(num_virtual_links, dc, pool))
 		return &pool->base;
 
+	kfree(pool);
 	BREAK_TO_DEBUGGER();
 	return NULL;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
index 6b44ed3697a4f..e6d5568811400 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
@@ -1361,6 +1361,7 @@ struct resource_pool *dcn10_create_resource_pool(
 	if (construct(num_virtual_links, dc, pool))
 		return &pool->base;
 
+	kfree(pool);
 	BREAK_TO_DEBUGGER();
 	return NULL;
 }
-- 
2.25.1



