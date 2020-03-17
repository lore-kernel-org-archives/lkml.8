Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B08C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24E9020736
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584443124;
	bh=7AeRdUFqB8nXUpeMqPPG48ncKguSxkwesFV4prQw9Ak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k7JRQEALZJDN3Q3dz8t2ibiRXfO9ZQMuzoo97VGPjzdy+dx5IzoDZ4pZnys38bAc1
	 /wLmXLwR+Fjmgk79H+snm76N6kALtWUOYzaeYgbadusn/1EnIhKGqZVk485kJ5CKsD
	 8DGr1hFGwFt3GGFOLrJ5CG/ixx6MkhqRvzgi1Zsk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgCQLFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:05:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728415AbgCQLFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:05:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82D0A20658;
        Tue, 17 Mar 2020 11:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584443120;
        bh=7AeRdUFqB8nXUpeMqPPG48ncKguSxkwesFV4prQw9Ak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gyItrkkr8+M4BEqS4HNi8AH97o5T14aSqIfXDiZE86zX442ynmBJ/nYgaD+Fcz4Nv
         +l9K0SGGGNhpF539NAZ95juHhWhPb3i49uTDCNytuBjsQ/SmH1uBo0n3AlqxmdYOlB
         yoqLmFQSfW4j9fN/0sPHakfmiRABB/WYgiao2jgo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tina Zhang <tina.zhang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH 5.4 102/123] drm/i915/gvt: Fix dma-buf display blur issue on CFL
Date:   Tue, 17 Mar 2020 11:55:29 +0100
Message-Id: <20200317103318.045252448@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103307.343627747@linuxfoundation.org>
References: <20200317103307.343627747@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tina Zhang <tina.zhang@intel.com>

commit 259170cb4c84f4165a36c0b05811eb74c495412c upstream.

Commit c3b5a8430daad ("drm/i915/gvt: Enable gfx virtualiztion for CFL")
added the support on CFL. The vgpu emulation hotplug support on CFL was
supposed to be included in that patch. Without the vgpu emulation
hotplug support, the dma-buf based display gives us a blur face.

So fix this issue by adding the vgpu emulation hotplug support on CFL.

Fixes: c3b5a8430daad ("drm/i915/gvt: Enable gfx virtualiztion for CFL")
Signed-off-by: Tina Zhang <tina.zhang@intel.com>
Acked-by: Zhenyu Wang <zhenyuw@linux.intel.com>
Signed-off-by: Zhenyu Wang <zhenyuw@linux.intel.com>
Link: http://patchwork.freedesktop.org/patch/msgid/20200227010041.32248-1-tina.zhang@intel.com
(cherry picked from commit 135dde8853c7e00f6002e710f7e4787ed8585c0e)
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/gvt/display.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/i915/gvt/display.c
+++ b/drivers/gpu/drm/i915/gvt/display.c
@@ -457,7 +457,8 @@ void intel_vgpu_emulate_hotplug(struct i
 	struct drm_i915_private *dev_priv = vgpu->gvt->dev_priv;
 
 	/* TODO: add more platforms support */
-	if (IS_SKYLAKE(dev_priv) || IS_KABYLAKE(dev_priv)) {
+	if (IS_SKYLAKE(dev_priv) || IS_KABYLAKE(dev_priv) ||
+		IS_COFFEELAKE(dev_priv)) {
 		if (connected) {
 			vgpu_vreg_t(vgpu, SFUSE_STRAP) |=
 				SFUSE_STRAP_DDID_DETECTED;


