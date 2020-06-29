Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F852C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5C1D206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593467719;
	bh=ue/TOYNTeUlIw1lHZQKDweXd+oqqOYXRjPf3N8LD+RU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kce47tq5LO8oXNrSx/eH7S+kkDFDdBdtZhcTAj2UMzDUOXMxgc0Ai2HaxLD0Mwz1g
	 seblh68U1qAiUhLFC6yk+4nZB1/Y67xQOo/gl3BUF3nCFnz8wwSo0+dbtZRfX3IYHx
	 IfqD7yMOhuKuMVw5eNKnA7AvLv8YOyui8xyJ6FIg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391541AbgF2VzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:55:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:56886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726503AbgF2Sfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:35:31 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 537EC247DE;
        Mon, 29 Jun 2020 15:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593444147;
        bh=ue/TOYNTeUlIw1lHZQKDweXd+oqqOYXRjPf3N8LD+RU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CPylx21kQXt5BskxOsUi9F4KORfjEyfTCNOqxnEtPc5DnUBn5WcoRn13lDp1pFFMQ
         NrsCMxgsobpJW3VfAdE82TswFsMGPuD87a3J9A5poGajzebrHT+PJseJhGsufLluH2
         kM2UFeEmNXqSGpKFh7FnVAx/FBCfnsN0y+2tpV68=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Adam Ford <aford173@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.7 252/265] drm/panel-simple: fix connector type for LogicPD Type28 Display
Date:   Mon, 29 Jun 2020 11:18:05 -0400
Message-Id: <20200629151818.2493727-253-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629151818.2493727-1-sashal@kernel.org>
References: <20200629151818.2493727-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.7.7-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.7.7-rc1
X-KernelTest-Deadline: 2020-07-01T15:14+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adam Ford <aford173@gmail.com>

commit efb94790852ae673b18efde1b171d284689ff333 upstream.

The LogicPD Type28 display used by several Logic PD products has not
worked since v5.6.

The connector type for the LogicPD Type 28 display is missing and
drm_panel_bridge_add() requires connector type to be set.

Signed-off-by: Adam Ford <aford173@gmail.com>
Fixes: 0d35408afbeb ("drm/panel: simple: Add Logic PD Type 28 display support")
Cc: Adam Ford <aford173@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v5.6+
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20200615131934.12440-1-aford173@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/panel/panel-simple.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 00c1a8dc4ce8f..db91b3c031a13 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2297,6 +2297,7 @@ static const struct panel_desc logicpd_type_28 = {
 	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
 	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE |
 		     DRM_BUS_FLAG_SYNC_DRIVE_NEGEDGE,
+	.connector_type = DRM_MODE_CONNECTOR_DPI,
 };
 
 static const struct panel_desc mitsubishi_aa070mc01 = {
-- 
2.25.1

