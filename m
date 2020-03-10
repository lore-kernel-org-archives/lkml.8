Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AD5C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 657132468D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583844999;
	bh=8NYG1n3xKdhO8T2dlTDUokQeG2/YXy4P9DT44E3uIK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=li1/d5mpM/mCt28l1RmJkb4ksZ3fxVGKmIsj2W/PEPAj4ro2ettb7Q+YLJQHUq3f1
	 P33tilq07LsIaha7bzSQ54WgPxANLOJtiKmtynB9qECkf0WqgyKAEfzdSBoCBRGyjj
	 IUgt7RQxkOhY9E0sg7uDu1GlB1ctUhIMj/vmzmzc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbgCJM4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:56:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:35758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729298AbgCJM4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:56:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D69D20674;
        Tue, 10 Mar 2020 12:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844992;
        bh=8NYG1n3xKdhO8T2dlTDUokQeG2/YXy4P9DT44E3uIK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wFgEGdxgoJAnA8Un1j1JvI9b4+veToeLq8B8DuzR+XO6vwyD1O7LjH9GADnoZh160
         YE0LefKxO/7Ph4VZiMz3QSICHRXV230piZZW4wYeqY7XcXHaU3i55vNXAvLT9tHqdj
         gRd4p01Alk2D+mWjXrLFT81fTgB61Ztk/Dt+EXWU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Sami Tolvanen <samitolvanen@google.com>,
        Todd Kjos <tkjos@google.com>,
        Alistair Delva <adelva@google.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        freedreno@lists.freedesktop.org,
        clang-built-linux@googlegroups.com,
        John Stultz <john.stultz@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Rob Clark <robdclark@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 023/189] drm: msm: Fix return type of dsi_mgr_connector_mode_valid for kCFI
Date:   Tue, 10 Mar 2020 13:37:40 +0100
Message-Id: <20200310123641.816284321@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123639.608886314@linuxfoundation.org>
References: <20200310123639.608886314@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Stultz <john.stultz@linaro.org>

[ Upstream commit 7fd2dfc3694922eb7ace4801b7208cf9f62ebc7d ]

I was hitting kCFI crashes when building with clang, and after
some digging finally narrowed it down to the
dsi_mgr_connector_mode_valid() function being implemented as
returning an int, instead of an enum drm_mode_status.

This patch fixes it, and appeases the opaque word of the kCFI
gods (seriously, clang inlining everything makes the kCFI
backtraces only really rough estimates of where things went
wrong).

Thanks as always to Sami for his help narrowing this down.

Cc: Rob Clark <robdclark@gmail.com>
Cc: Sean Paul <sean@poorly.run>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Alistair Delva <adelva@google.com>
Cc: Amit Pundir <amit.pundir@linaro.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: freedreno@lists.freedesktop.org
Cc: clang-built-linux@googlegroups.com
Signed-off-by: John Stultz <john.stultz@linaro.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Rob Clark <robdclark@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/dsi/dsi_manager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_manager.c b/drivers/gpu/drm/msm/dsi/dsi_manager.c
index 271aa7bbca925..355a60b4a536f 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_manager.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_manager.c
@@ -336,7 +336,7 @@ static int dsi_mgr_connector_get_modes(struct drm_connector *connector)
 	return num;
 }
 
-static int dsi_mgr_connector_mode_valid(struct drm_connector *connector,
+static enum drm_mode_status dsi_mgr_connector_mode_valid(struct drm_connector *connector,
 				struct drm_display_mode *mode)
 {
 	int id = dsi_mgr_connector_get_id(connector);
-- 
2.20.1



