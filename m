Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE707C47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A788E20870
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588942730;
	bh=zFkS2/g/Apr0wc4izu9ZFX09jKuGiQjn4auE0yk/aQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dkZc9qhfiGpfzv+W9gqJJD2mLhaQDFkN7+3IjtGxsxutWXWn1yQw1ZMDpeUjA3IlN
	 1a4B69LVkViWIKGU61n20PjBOgzURnHj1Ef7dvCyGfvvTg1lyCzP5IVl2lOHBtf67T
	 9aHnY0gLzTfA9CzD2kK1zocDUYctTI+2IUTRY3WI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730169AbgEHMyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:54:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:36190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728746AbgEHMyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:54:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24ACA2496A;
        Fri,  8 May 2020 12:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588942443;
        bh=zFkS2/g/Apr0wc4izu9ZFX09jKuGiQjn4auE0yk/aQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SaVNFmDD3c3W0Hlzy+pNT6YDKg46Z1F5ngYJEujFBuZ46KY6kJl5/P4nMsrfF1wJk
         0is3RM96IItgXgcBPlgAhgXIaSaIIatp4IyEihxOHwTt7+qLzT5n9J4VtMB0Uy344o
         1zyiNDq3oZCzTzqDD5kaScUZ4DK5urTwyJYsZ8bg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhan Liu <zhan.liu@amd.com>,
        Hersen Wu <hersenxs.wu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.4 47/50] Revert "drm/amd/display: setting the DIG_MODE to the correct value."
Date:   Fri,  8 May 2020 14:35:53 +0200
Message-Id: <20200508123049.498428983@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123043.085296641@linuxfoundation.org>
References: <20200508123043.085296641@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhan Liu <Zhan.Liu@amd.com>

commit b73b7f48895a6a944a76a2d8cdd7feee72bb1f0b upstream.

This reverts commit 967a3b85bac91c55eff740e61bf270c2732f48b2.

Reason for revert: Root cause of this issue is found. The workaround is not needed anymore.

Signed-off-by: Zhan Liu <zhan.liu@amd.com>
Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |    9 ---------
 1 file changed, 9 deletions(-)

--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2768,15 +2768,6 @@ void core_link_enable_stream(
 					CONTROLLER_DP_TEST_PATTERN_VIDEOMODE,
 					COLOR_DEPTH_UNDEFINED);
 
-		/* This second call is needed to reconfigure the DIG
-		 * as a workaround for the incorrect value being applied
-		 * from transmitter control.
-		 */
-		if (!dc_is_virtual_signal(pipe_ctx->stream->signal))
-			stream->link->link_enc->funcs->setup(
-				stream->link->link_enc,
-				pipe_ctx->stream->signal);
-
 #ifdef CONFIG_DRM_AMD_DC_DSC_SUPPORT
 		if (pipe_ctx->stream->timing.flags.DSC) {
 			if (dc_is_dp_signal(pipe_ctx->stream->signal) ||


