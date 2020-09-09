Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACFFC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2908C2087C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599670710;
	bh=yzB+d7fsBNW/xSDG/RMpAspI15Iy1YK0UWi4pZQJoaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GqtRvwp/T/nzZTOKD8UWCpxZNl0WCxfVsHnsYbGtRXFV7VFzsHDXDHw3ddUIz/64Q
	 EWk50mDzcP2rhU93PkIjcS/F7Fp6y0lz9L3lrOmy6nyg0NgyJOFXTMJvwRhBeClJtk
	 WETUmCHy51oKJjxbEO3YMOznLlzBLoWIbwQqx1/Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731014AbgIIQ6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:58:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:51428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730670AbgIIPvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:51:19 -0400
Received: from mail.kernel.org (ip5f5ad5d6.dynamic.kabel-deutschland.de [95.90.213.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B493E2225F;
        Wed,  9 Sep 2020 14:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599660665;
        bh=yzB+d7fsBNW/xSDG/RMpAspI15Iy1YK0UWi4pZQJoaE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MAjOoXZhNvRdq6EQxUMm+baa0PhklM8T1a3mhfHhyiN828aKt3zggdmZxH9pg9KeH
         b68k0SX0iPm1+zTXhzKCYDItlvlFMuqe76FqR44ZyHdIYaf6Exh74oP0BPCkG0Bgg4
         DHYgX0Pu1tYtCQcemOQcLuTRr+P9nVBeQ0rl55Wc=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kG0oR-00DUXv-Ss; Wed, 09 Sep 2020 16:11:03 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 30/30] docs: amdgpu: fix a warning when building the documentation
Date:   Wed,  9 Sep 2020 16:11:01 +0200
Message-Id: <80b3a6005f8010a1b80d77ed9113056688b0fdea.1599660067.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599660067.git.mchehab+huawei@kernel.org>
References: <cover.1599660067.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported by Sphinx:

	Documentation/gpu/amdgpu.rst:200: WARNING: Inline emphasis start-string without end-string.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/gpu/amdgpu.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/gpu/amdgpu.rst b/Documentation/gpu/amdgpu.rst
index 29ca5f5feb35..9656f5f5bbcf 100644
--- a/Documentation/gpu/amdgpu.rst
+++ b/Documentation/gpu/amdgpu.rst
@@ -197,8 +197,8 @@ pp_power_profile_mode
 .. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
    :doc: pp_power_profile_mode
 
-*_busy_percent
-~~~~~~~~~~~~~~
+\*_busy_percent
+~~~~~~~~~~~~~~~
 
 .. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
    :doc: gpu_busy_percent
-- 
2.26.2

