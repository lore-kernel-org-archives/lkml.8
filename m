Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5750C07548
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 708E020829
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599733584;
	bh=fgfiyAtrFCoLlnnEOEO9teOqv1JFGl0mGCGkOu01V1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uVZ2oVIe3O3aQH+AjFWRXIAYjMFRMibMDx6szzeIDgHQ+qXy9zegufBBoyl+QtuhQ
	 46+SwhzLDTNvPMolwHyxMZyCQn1caHtOYQT4mhDQ02ZlMnRYu0Nu+uYcgb83JbXlhS
	 cCvzKp89W44exgm4UjiBDtM6/XF6ZCr9K4z7S474=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730926AbgIJK0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 06:26:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:35638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730729AbgIJKY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 06:24:29 -0400
Received: from mail.kernel.org (ip5f5ad5ac.dynamic.kabel-deutschland.de [95.90.213.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB9C4221E5;
        Thu, 10 Sep 2020 10:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599733450;
        bh=fgfiyAtrFCoLlnnEOEO9teOqv1JFGl0mGCGkOu01V1o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kgTflP/83AXdk/kctYAENTpI9SV0gCQGWweaisBNz+c3NXD1Rfmf8dj9mG7TvKviW
         oSdWjSx3WORYJpyFwcotL2FWNBuRectCX2HFf9ik3dypynJbveWPD7bveqqQ67Mj46
         s/EHGbrZbbOiZrrWn+1jo+RTjM2aAnDcAkA4tZNM=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kGJkO-00EIOE-PU; Thu, 10 Sep 2020 12:24:08 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 14/14] gpu: docs: amdgpu.rst: get rid of wrong kernel-doc markups
Date:   Thu, 10 Sep 2020 12:24:07 +0200
Message-Id: <d56b09093b4325c39d6ecf3297f9eb520e9e2897.1599732764.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599732764.git.mchehab+huawei@kernel.org>
References: <cover.1599732764.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported by kernel-doc:
    ./drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c:1: warning: no structured comments found
    ./drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:1: warning: no structured comments found

Those files only contain

	/**
	 * DOC:
	 */

markups, but they're included twice there: one to parse
such markup, and another one to parse internal functions.

In the case of amdgpu_xgmi.c, as it has just one such
markup, we can simply include the file once, and let it
parse the entire file without passing arguments to kernel-doc.

This should place everything altogether.

For amdgpu_ras.c, however, we need to remove the kernel-doc
with just internal. This should be re-introduced if this
file ever gets new non-DOC markups.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/gpu/amdgpu.rst | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/Documentation/gpu/amdgpu.rst b/Documentation/gpu/amdgpu.rst
index 9656f5f5bbcf..d46bfe52b722 100644
--- a/Documentation/gpu/amdgpu.rst
+++ b/Documentation/gpu/amdgpu.rst
@@ -74,10 +74,6 @@ AMDGPU XGMI Support
 ===================
 
 .. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
-   :doc: AMDGPU XGMI Support
-
-.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
-   :internal:
 
 AMDGPU RAS Support
 ==================
@@ -115,9 +111,6 @@ RAS VRAM Bad Pages sysfs Interface
 .. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
    :doc: AMDGPU RAS sysfs gpu_vram_bad_pages Interface
 
-.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
-   :internal:
-
 Sample Code
 -----------
 Sample code for testing error injection can be found here:
-- 
2.26.2

