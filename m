Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19741C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 12:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEE962089D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 12:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590667515;
	bh=ihlDfgG3j3xz4bDy2bhDZn4pw55pV0TlDHOrGsmuZdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=acZIhp59FEobEOgIIcayFw4ms4g6Rf9t2TSq2VtSk0SlXEqoYPgyafaDRUuLoaeeB
	 FgAklkpgp9D8BzUEh1SqgAgBd7Nxx0MdFlzrv1oA+s+n/s7Xo5XIiIIpKPybvddibF
	 76aMrL43JxCyjkxmrK7aPbkRXRx1RDZ8yrwCmnPA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389625AbgE1ME7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 08:04:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:49542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388923AbgE1L5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 07:57:07 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACF4E21532;
        Thu, 28 May 2020 11:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590667027;
        bh=ihlDfgG3j3xz4bDy2bhDZn4pw55pV0TlDHOrGsmuZdM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1NY3feux499ag/YC16+Vy/86BqCc+CzjB71nfPXwqXlWZui+Pr0sbTnLFb7cU3BTN
         TzZEoErNDO4dvztJjG5iKklpp7q1ejk2OWuqnSehVDl8+tnRn68VnWDzaauixpddlh
         ziqnny7GTh+xmU3XrGUhMhlHlywci60rMBW7/7cM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jan Schmidt <jan@centricular.com>,
        Dave Airlie <airlied@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 11/26] drm/edid: Add Oculus Rift S to non-desktop list
Date:   Thu, 28 May 2020 07:56:39 -0400
Message-Id: <20200528115654.1406165-11-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200528115654.1406165-1-sashal@kernel.org>
References: <20200528115654.1406165-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Schmidt <jan@centricular.com>

[ Upstream commit 5a3f610877e9d08968ea7237551049581f02b163 ]

Add a quirk for the Oculus Rift S OVR0012 display so
it shows up as a non-desktop display.

Signed-off-by: Jan Schmidt <jan@centricular.com>
Signed-off-by: Dave Airlie <airlied@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20200507180628.740936-1-jan@centricular.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_edid.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index ea2849338d6c..9b69e55ad701 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -191,10 +191,11 @@ static const struct edid_quirk {
 	{ "HVR", 0xaa01, EDID_QUIRK_NON_DESKTOP },
 	{ "HVR", 0xaa02, EDID_QUIRK_NON_DESKTOP },
 
-	/* Oculus Rift DK1, DK2, and CV1 VR Headsets */
+	/* Oculus Rift DK1, DK2, CV1 and Rift S VR Headsets */
 	{ "OVR", 0x0001, EDID_QUIRK_NON_DESKTOP },
 	{ "OVR", 0x0003, EDID_QUIRK_NON_DESKTOP },
 	{ "OVR", 0x0004, EDID_QUIRK_NON_DESKTOP },
+	{ "OVR", 0x0012, EDID_QUIRK_NON_DESKTOP },
 
 	/* Windows Mixed Reality Headsets */
 	{ "ACR", 0x7fce, EDID_QUIRK_NON_DESKTOP },
-- 
2.25.1

