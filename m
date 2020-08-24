Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C69C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A6932177B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598258380;
	bh=H66+2aVcp3+femgRf01XpTSicKaJdqIajFZSS8hXtEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Aks7yHQC20xMCPnGBqQxAFTy2dBtojuURc6de/TA6u0f4EZjD/Ecquju73IAYqJPj
	 TH4SRfY7t/shaLHkQl+lfEzF8j1yL7+n26OQciAkm4hX688unsIY/QaQpLCvkRfuT2
	 KId1X8D5rQAuM2+AzsDQTnhzRaWosAqLEYIzSdzs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbgHXIji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:39:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:55572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbgHXIjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:39:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41BFE2177B;
        Mon, 24 Aug 2020 08:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258375;
        bh=H66+2aVcp3+femgRf01XpTSicKaJdqIajFZSS8hXtEU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aTjUFXAABOckao34G4paTid0d4Fso+9cu7MbD8jg43qLt4uEwR3J+rvgriOYCK3vp
         2i6fwj1xHa2B3g8eAXNoGB8QC+8ptmSqPubspvZ65kc4ccajxBCE3h5EQ58mjpghtb
         ay7gRBlmpO36bhTU1XXrVcmZTHAkEvsCUmkPi9xQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jaehyun Chung <jaehyun.chung@amd.com>,
        Alvin Lee <Alvin.Lee2@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.7 025/124] drm/amd/display: Blank stream before destroying HDCP session
Date:   Mon, 24 Aug 2020 10:29:19 +0200
Message-Id: <20200824082410.658901013@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082409.368269240@linuxfoundation.org>
References: <20200824082409.368269240@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jaehyun Chung <jaehyun.chung@amd.com>

commit 79940e4d10df9c737a394630968471c632246ee0 upstream.

[Why]
Stream disable sequence incorretly destroys HDCP session while stream is
not blanked and while audio is not muted. This sequence causes a flash
of corruption during mode change and an audio click.

[How]
Change sequence to blank stream before destroying HDCP session. Audio will
also be muted by blanking the stream.

Cc: stable@vger.kernel.org
Signed-off-by: Jaehyun Chung <jaehyun.chung@amd.com>
Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3113,12 +3113,11 @@ void core_link_disable_stream(struct pip
 			dc_is_virtual_signal(pipe_ctx->stream->signal))
 		return;
 
+	dc->hwss.blank_stream(pipe_ctx);
 #if defined(CONFIG_DRM_AMD_DC_HDCP)
 	update_psp_stream_config(pipe_ctx, true);
 #endif
 
-	dc->hwss.blank_stream(pipe_ctx);
-
 	if (pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST)
 		deallocate_mst_payload(pipe_ctx);
 


