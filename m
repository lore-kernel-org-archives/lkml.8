Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFB0C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ACE92077C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579197177;
	bh=toTgmiI4hSwzDMFAAKNj0Km93inH4SEVtN/A21b5UVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=msMyKN8+ULSg3+zZWpt1/LkkhCO2q4nXfAsMwRiMQagCnSCuQVDFXt8/xhxZP8oHZ
	 HGePsUYBCwKj6e8E9zM4K5nxwb6uV/ngmyqgmSaX1sYKxTl9vHHKvXDwBPCHX8jkB0
	 cnt/gZrlWCvHyGDbDaHiPiJEUHQhfl5ODttOUjBI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406257AbgAPRw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:52:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:36738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406115AbgAPRpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:45:12 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DB6C24773;
        Thu, 16 Jan 2020 17:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196711;
        bh=toTgmiI4hSwzDMFAAKNj0Km93inH4SEVtN/A21b5UVU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dj7NjDNhhBzxkapd1vEa4/kBqKanPLCfhJTkZiEJNHWDB+aUQXtrT9NaTfHwluGUn
         cwKJkFJLXGg1AgPxiIN4JHF45pwBZn1N4w+TWdyHAP6VDnS94lwbWhWCnv1rk1eJJj
         Gh8fxugwm39BVd30IGJQ/eM/bsE4la9rjGpmM6Us=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.4 101/174] drm/msm/mdp5: Fix mdp5_cfg_init error return
Date:   Thu, 16 Jan 2020 12:41:38 -0500
Message-Id: <20200116174251.24326-101-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116174251.24326-1-sashal@kernel.org>
References: <20200116174251.24326-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>

[ Upstream commit fc19cbb785d7bbd1a1af26229b5240a3ab332744 ]

If mdp5_cfg_init fails because of an unknown major version, a null pointer
dereference occurs.  This is because the caller of init expects error
pointers, but init returns NULL on error.  Fix this by returning the
expected values on error.

Fixes: 2e362e1772b8 (drm/msm/mdp5: introduce mdp5_cfg module)
Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Rob Clark <robdclark@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/mdp/mdp5/mdp5_cfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/mdp/mdp5/mdp5_cfg.c b/drivers/gpu/drm/msm/mdp/mdp5/mdp5_cfg.c
index bb1225aa2f75..89305ad3cde2 100644
--- a/drivers/gpu/drm/msm/mdp/mdp5/mdp5_cfg.c
+++ b/drivers/gpu/drm/msm/mdp/mdp5/mdp5_cfg.c
@@ -547,7 +547,7 @@ struct mdp5_cfg_handler *mdp5_cfg_init(struct mdp5_kms *mdp5_kms,
 	if (cfg_handler)
 		mdp5_cfg_destroy(cfg_handler);
 
-	return NULL;
+	return ERR_PTR(ret);
 }
 
 static struct mdp5_cfg_platform *mdp5_get_config(struct platform_device *dev)
-- 
2.20.1

