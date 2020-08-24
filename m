Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB3BC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60BB8206BE
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598262588;
	bh=qTRimv2Y4WfSI/kauU+bdYkYWFNVaPoXDZxXzewNdR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XBHOrPNopbZd2Hjq8v5ncBoz0bs/UNHnZ19svYISa7M23B3wh6iCdxXNbuv0oJ3Wh
	 SDf8ZbqsROKkm2JBV6aojhtJFZ5WJgd7rMhum3yyi5avVbEKKUN1YRgeYmUfUf5n0y
	 5hULkQ1SLUBe+wTblGZAMHO9UcEwwfF+rZsNzwnI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbgHXJtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:49:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:55346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728640AbgHXIja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:39:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7865F2177B;
        Mon, 24 Aug 2020 08:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258369;
        bh=qTRimv2Y4WfSI/kauU+bdYkYWFNVaPoXDZxXzewNdR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nylIPnjOCRcisy97pZIGumMKTLENcVlYQlNwE50kOApvXh2ozo5n1Vui7UvqX6R03
         QKaiZp34pHMlK2CKZcZeT+4D6n4ZyN4EjHJ0Gx0wyVJsMimFm19etlH3JZQvxjnpuN
         8Q9wroKcU3Ct90aGvvmRmb9KYyyE8PmEUOC5VTHU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Kolesa <daniel@octaforge.org>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.7 023/124] drm/amdgpu/display: use GFP_ATOMIC in dcn20_validate_bandwidth_internal
Date:   Mon, 24 Aug 2020 10:29:17 +0200
Message-Id: <20200824082410.560827925@linuxfoundation.org>
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
@@ -3031,7 +3031,7 @@ static bool dcn20_validate_bandwidth_int
 	int vlevel = 0;
 	int pipe_split_from[MAX_PIPES];
 	int pipe_cnt = 0;
-	display_e2e_pipe_params_st *pipes = kzalloc(dc->res_pool->pipe_count * sizeof(display_e2e_pipe_params_st), GFP_KERNEL);
+	display_e2e_pipe_params_st *pipes = kzalloc(dc->res_pool->pipe_count * sizeof(display_e2e_pipe_params_st), GFP_ATOMIC);
 	DC_LOGGER_INIT(dc->ctx->logger);
 
 	BW_VAL_TRACE_COUNT();


