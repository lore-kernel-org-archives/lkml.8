Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A127C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 05:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 063C82072F
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 05:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UkwhbhqO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387860AbgCLFm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 01:42:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53918 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387837AbgCLFmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 01:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=gFogYY0/ImH1QufcGk6my12bIHUguG4a5p71bzDoCOs=; b=UkwhbhqOAz87LxbUSVhtkWzVvM
        MBrHjo2j2hz1s7U8WycJh4oUvDONSmz86VBpGj57m+963BcjnHP/SCwe1hOqgFvOTEFw7sZNo6TDg
        UD9k83tzSyfQBRZNnDi3+5NblrKyGk37ipjwHkihxAyVEiREaj0SN7N2fgTneyAMc+UMg90hgpz9k
        UByP278mvDVthyNfX5v5affR6EyQWVwRXTIbvwdzXmCG4vXUeyjeqrKRmF5lNyeafkYk3Mi7N5cIp
        +ajv7BfLamoJfVBdpFnlsFFFHXOPfuEIQpL8+y0gKMLoTBUEMyvvuKze4F0SrsAcRfsDqX5Yr07og
        a7uqDCiQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCGcP-0004dW-EG; Thu, 12 Mar 2020 05:42:53 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] drm: amd/acp: fix broken menu structure
Message-ID: <6c252c3d-5d0a-2a2f-4b8c-60d7622d1146@infradead.org>
Date:   Wed, 11 Mar 2020 22:42:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix the Kconfig dependencies so that the menu is presented
correctly by adding a dependency on DRM_AMDGPU to the "menu"
Kconfig statement.  This makes a continuous dependency on
DRM_AMDGPU in the DRM AMD menus and eliminates a broken menu
structure.

Fixes: a8fe58cec351 ("drm/amd: add ACP driver support")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: David (ChunMing) Zhou <David1.Zhou@amd.com>
Cc: Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>
Cc: amd-gfx@lists.freedesktop.org
---
 drivers/gpu/drm/amd/acp/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next.orig/drivers/gpu/drm/amd/acp/Kconfig
+++ linux-next/drivers/gpu/drm/amd/acp/Kconfig
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: MIT
 menu "ACP (Audio CoProcessor) Configuration"
+	depends on DRM_AMDGPU
 
 config DRM_AMD_ACP
 	bool "Enable AMD Audio CoProcessor IP support"

