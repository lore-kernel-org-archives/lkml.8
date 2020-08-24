Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B0AC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32CCD20738
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598262020;
	bh=WPMxQiXaIVKU9BE9M+GjN7jGrzR1Z1QBgsw1OK0nLUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V36ZHjtFN9y7PcxhmoRnSWLmbMg9gZ23np0ty2y0KJHCXjhZaNtUxDXYYGzOcvgGB
	 5fb6ObVkYbkM5PlCMwk7qMsSNtkqYG5Ebk9Vs1rwyJFdcwC+0j0YMQOJ3y8IIr+kmo
	 yh2t5vThxfhUnG9Xdv8vM4d6qPCPz6huRem7U3LQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbgHXIqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:46:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:44046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728882AbgHXIqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:46:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0D12207D3;
        Mon, 24 Aug 2020 08:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258768;
        bh=WPMxQiXaIVKU9BE9M+GjN7jGrzR1Z1QBgsw1OK0nLUg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FxCivM+huFX8ak2nXjaRMLmVW8YfTynbMXNdDtm5a5k7IaYaHxKjNoWEW+rSM/UCv
         IcXDe+7sKnjQqZjG2lGw5P3Yl6OiRgISW0mzVNvUImg/+56sxxpKzYkju/gzOYIcJm
         d3/o6httiWumR51oPsCV9p+u58jyhHhjI8s5rRFg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Kolesa <daniel@octaforge.org>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.4 036/107] drm/amdgpu/display: use GFP_ATOMIC in dcn20_validate_bandwidth_internal
Date:   Mon, 24 Aug 2020 10:30:02 +0200
Message-Id: <20200824082406.911184133@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082405.020301642@linuxfoundation.org>
References: <20200824082405.020301642@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Kolesa <daniel@octaforge.org>

commit f41ed88cbd6f025f7a683a11a74f901555fba11c upstream.

GFP_KERNEL may and will sleep, and this is being executed in
a non-preemptible context; this will mess things up since it's
called inbetween DC_FP_START/END, and rescheduling will result
in the DC_FP_END later being called in a different context (or
just crashing if any floating point/vector registers/instructions
are used after the call is resumed in a different context).

Signed-off-by: Daniel Kolesa <daniel@octaforge.org>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -2845,7 +2845,7 @@ static bool dcn20_validate_bandwidth_int
 	int vlevel = 0;
 	int pipe_split_from[MAX_PIPES];
 	int pipe_cnt = 0;
-	display_e2e_pipe_params_st *pipes = kzalloc(dc->res_pool->pipe_count * sizeof(display_e2e_pipe_params_st), GFP_KERNEL);
+	display_e2e_pipe_params_st *pipes = kzalloc(dc->res_pool->pipe_count * sizeof(display_e2e_pipe_params_st), GFP_ATOMIC);
 	DC_LOGGER_INIT(dc->ctx->logger);
 
 	BW_VAL_TRACE_COUNT();


