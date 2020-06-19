Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DA6C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4F1621548
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592580024;
	bh=3oEk9mUz7kFZ8N7UDTVPNCIcRQV9ynzwPxO6yqrMMG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sXRIsxe6nhXRPogv4J0ffSHhuxjpGWn1EoQ3Mk78ttHNARlyns9PX0VchjLUBkjFD
	 C5hN1L7jUc6KK/oSpSxoTunne4eXehDi7c74cNpDC7fFmlFO1lpcL4JUbZ839nCb8i
	 X86iCrqFHWodu8dgdEa6l2EekobGzwgN86jFZHIQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392686AbgFSPUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:20:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:48322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392529AbgFSPRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:17:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F02D2080C;
        Fri, 19 Jun 2020 15:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592579863;
        bh=3oEk9mUz7kFZ8N7UDTVPNCIcRQV9ynzwPxO6yqrMMG8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m2eRLeYDChRwGIGfXta1oweNzP3oAgaXbJb4gxV8+KshvB2gOlaqtAygu/wFIKciU
         lw4v+xMcLWGMM4Nv4HHl4v7RibrgjQ9GYndcNb3ySCxmTuuyB01pa6gZFllUzTJMXB
         Lbo3Nr66eknyYaoSISEYyQCDlzeDo/VUVTARCGUk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Eric Bernstein <Eric.Bernstein@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 015/376] drm/amd/display: fix virtual signal dsc setup
Date:   Fri, 19 Jun 2020 16:28:53 +0200
Message-Id: <20200619141711.088125888@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

[ Upstream commit d5bef51f084fccafa984b114ff74a01a64a0e2e3 ]

This prevents dpcd access on virtual links.

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Eric Bernstein <Eric.Bernstein@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
index 51e0ee6e7695..6590f51caefa 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
@@ -400,7 +400,7 @@ static bool dp_set_dsc_on_rx(struct pipe_ctx *pipe_ctx, bool enable)
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	bool result = false;
 
-	if (IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment))
+	if (dc_is_virtual_signal(stream->signal) || IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment))
 		result = true;
 	else
 		result = dm_helpers_dp_write_dsc_enable(dc->ctx, stream, enable);
-- 
2.25.1



