Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C971C35677
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E75DA24699
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582814667;
	bh=Xosha2si2gA+YtJP6cPHMRHvPd5rRJ+tgfnyNFwyd8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NbGEYhJaCEUsnfibr7ylNJmY9WJDyolhDJJRruv2Rn6BdB8ubWhldTu1a/dXEjGdM
	 Bp0hJl581CoTEZZN4ofbNlG0NX5dyw5pz3POQbQj8NnWSZiz3vjS1v47ccMbnzawJ9
	 9DkIk7jc3SFSTmc2nANdvGgEI4xE2cuKc+SH2riE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730804AbgB0NsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:48:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:44638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730161AbgB0NsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:48:03 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C277320801;
        Thu, 27 Feb 2020 13:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811282;
        bh=Xosha2si2gA+YtJP6cPHMRHvPd5rRJ+tgfnyNFwyd8I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rwTkPj+zrZHUS63AqQS1msr3Xi4KKGLyFHUdfzi0Yfi9ajBep74kBN3NnS22Pfu7i
         KcOsvk5r+ddW2Sbbpg29yqwDR2FenlkzMWIindQT4x8GM3/csJ8WV1sCjG3qibmv1d
         gcGUIp+tBPxTIgi3RzalLYJj8r0DcVdt845Uo75U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, yu kuai <yukuai3@huawei.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 045/165] drm/amdgpu: remove 4 set but not used variable in amdgpu_atombios_get_connector_info_from_object_table
Date:   Thu, 27 Feb 2020 14:35:19 +0100
Message-Id: <20200227132237.778120965@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132230.840899170@linuxfoundation.org>
References: <20200227132230.840899170@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: yu kuai <yukuai3@huawei.com>

[ Upstream commit bae028e3e521e8cb8caf2cc16a455ce4c55f2332 ]

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c: In function
'amdgpu_atombios_get_connector_info_from_object_table':
drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c:376:26: warning: variable
'grph_obj_num' set but not used [-Wunused-but-set-variable]
drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c:376:13: warning: variable
'grph_obj_id' set but not used [-Wunused-but-set-variable]
drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c:341:37: warning: variable
'con_obj_type' set but not used [-Wunused-but-set-variable]
drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c:341:24: warning: variable
'con_obj_num' set but not used [-Wunused-but-set-variable]

They are never used, so can be removed.

Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
Signed-off-by: yu kuai <yukuai3@huawei.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
index 26afdffab5a06..ac8885562919d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -336,17 +336,9 @@ bool amdgpu_atombios_get_connector_info_from_object_table(struct amdgpu_device *
 		path_size += le16_to_cpu(path->usSize);
 
 		if (device_support & le16_to_cpu(path->usDeviceTag)) {
-			uint8_t con_obj_id, con_obj_num, con_obj_type;
-
-			con_obj_id =
+			uint8_t con_obj_id =
 			    (le16_to_cpu(path->usConnObjectId) & OBJECT_ID_MASK)
 			    >> OBJECT_ID_SHIFT;
-			con_obj_num =
-			    (le16_to_cpu(path->usConnObjectId) & ENUM_ID_MASK)
-			    >> ENUM_ID_SHIFT;
-			con_obj_type =
-			    (le16_to_cpu(path->usConnObjectId) &
-			     OBJECT_TYPE_MASK) >> OBJECT_TYPE_SHIFT;
 
 			/* Skip TV/CV support */
 			if ((le16_to_cpu(path->usDeviceTag) ==
@@ -371,14 +363,7 @@ bool amdgpu_atombios_get_connector_info_from_object_table(struct amdgpu_device *
 			router.ddc_valid = false;
 			router.cd_valid = false;
 			for (j = 0; j < ((le16_to_cpu(path->usSize) - 8) / 2); j++) {
-				uint8_t grph_obj_id, grph_obj_num, grph_obj_type;
-
-				grph_obj_id =
-				    (le16_to_cpu(path->usGraphicObjIds[j]) &
-				     OBJECT_ID_MASK) >> OBJECT_ID_SHIFT;
-				grph_obj_num =
-				    (le16_to_cpu(path->usGraphicObjIds[j]) &
-				     ENUM_ID_MASK) >> ENUM_ID_SHIFT;
+				uint8_t grph_obj_type=
 				grph_obj_type =
 				    (le16_to_cpu(path->usGraphicObjIds[j]) &
 				     OBJECT_TYPE_MASK) >> OBJECT_TYPE_SHIFT;
-- 
2.20.1



