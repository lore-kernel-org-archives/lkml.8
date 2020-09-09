Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7816C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 932C821D40
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="d14jEUS7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbgIJCmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 22:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730111AbgIJCHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 22:07:31 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061e.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::61e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E547C06179B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 16:18:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Um93tfzKjex0nn05zKtdMMBldQKaN/Gt4JmvLuF2/7eoeTI5ITD7rC8vaRTezstXoBtW27jFontLOapnHfIl01BQ77hopZFPUnyFZeZb+twfWEGZWa6uON9DNKofyPQKoMPVsZyXTuQ0V+h5mtbepIW5V4EA9oFipIbnAG552qmr6q2m+yc60rxap4trRkqHRFUDS7vD2pDDm8wyCuTmANsyqBPTON3AFHTgpwnffgxPnIpUMmH+08UDLCPWfUVs6wYsrTLxzDyiO3c52/5VSky18OzNMgOH4C11lz3Tg4aSzuTvSCpD/0y1l44a1GusOn7PmB3+HdAkq8J018UF3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9dODFAEWpJwE7o6RftnyaGtifeCeyXmRhnXRtvEwanU=;
 b=Ql4QSDGJvlIswgedB7fVE7fW3gGPv0oVtkUWYgPiH3L4MauMBGPKQd1NcANOYei03E5k8QAQwYEkffW0AxRgtH10/DYOlUmrzpaWp7CKZnSJLDbiJMZzkZgNFJm90SmNtHrmfirzxHwuWtxSUIMgnC9fcaZIpiD1cO3Ijr2pqeLlCoZzfAWOqdwq/dpxbFj5AZ8nnQbkfNR98zLyZcVyR3HGBohdWDdylRepm2ZkbBu07lttEV6/obwTHWmTuWAKiMKsOXtjWTKWU4vXZWJHcxrXrCPvO4Jb8+ufGgJMxaT5Fq30K5Tfr4WAtrPHQ4YOS+Mt5BeCZT/VD7HuD5fw8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9dODFAEWpJwE7o6RftnyaGtifeCeyXmRhnXRtvEwanU=;
 b=d14jEUS7naU7bReArMR7Zg6W13MsTh4hfmVuqcuKtN3ujUTZjNCvdZO1e3gIvadsFnyUgyG4d0Raz/GV8GhmSQ1b/C9bwdbnG+VTgxrYIn/6etVFhMAY0kuq7bwPnFKaeSBoMDc0Jn+HgWJaCHa6KM5tLPybp7Up0XjAnfsdv6k=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received: from DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20)
 by DM6PR12MB2986.namprd12.prod.outlook.com (2603:10b6:5:39::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.18; Wed, 9 Sep
 2020 22:54:37 +0000
Received: from DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::25a1:ace4:4ca8:167e]) by DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::25a1:ace4:4ca8:167e%8]) with mapi id 15.20.3370.016; Wed, 9 Sep 2020
 22:54:36 +0000
From:   Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        hersenxs.wu@amd.com
Subject: [PATCH 3/3] drm/amd/display: Add pipe_state tracepoint
Date:   Wed,  9 Sep 2020 18:53:52 -0400
Message-Id: <20200909225352.4072030-4-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200909225352.4072030-1-Rodrigo.Siqueira@amd.com>
References: <20200909225352.4072030-1-Rodrigo.Siqueira@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0143.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::22) To DM6PR12MB4124.namprd12.prod.outlook.com
 (2603:10b6:5:221::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60::10ec) by YT1PR01CA0143.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Wed, 9 Sep 2020 22:54:36 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [2607:fea8:56e0:6d60::10ec]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 149ec436-921e-414a-1502-08d85513538f
X-MS-TrafficTypeDiagnostic: DM6PR12MB2986:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB29862D555487906DC09D8D2998260@DM6PR12MB2986.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:586;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NheUKLb5WuPWuhCeBeSmhVUB3x/y1Zb90Vm8es5GGRFqBPKQg2u+10QDLY64tKSoYB/omzQiFzp1JAh9Uxao8TjsAL1eJRvyGGvVT+ADKC0NcmeuUcIl7JmFoGbzZtzwUNXhkOcijcl0Eqk69vw+5h4NikhFRYVtnYvObrIsummaUi/ttQwvDCA+Dsd0IGr3Sj1OkialNM62HUwsrVEg9qpzN/fvAYSk9otWxsetGRWVMPFrsS66c0gYFKcoTmqLgYoI2qQhR7joQ6m3nFuE4VNte8sw/Akg8a0IoL3NR8HM/OhV8VVaQ8RVMXm02aYI9pMx2pJh1q5iKRjAluMjpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4124.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(376002)(346002)(39860400002)(2906002)(8936002)(6486002)(6512007)(5660300002)(16526019)(186003)(478600001)(83380400001)(4326008)(8676002)(52116002)(316002)(1076003)(66476007)(6506007)(6666004)(86362001)(2616005)(66556008)(54906003)(36756003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: WZyn81Xpr9Dg4uTqmIw54IeeQJa1KoSaxifg/4sdIOiQllf69Mfv5N5qfaHYIvAq+smjwAUrTGpZsy3APPFBoyh7vcZJI8Pgwvtemugc8ne83D5WYHD1Ja4EAGL20nKiGaOIxpe55pJTm9nhLonKP2oaH41qHYsrDhtXSrS9oBnCJbkNbsxXnXfUsMBu0kfrLFpN7hKQ+4P7i0LF8ZUHPcQbyDQHlP0CLYgLwMg/DRnWyCo6NlejfUyyuXjN0hdRKRMaIaHwEC59Cck+kS1/ggs6o8CgSjrT14bF6ov3mJpSnfd0xCIIrwAD9EOJBwGFHQg7Po8ai4xAyT08qwTRfVGhjAR68raFKW348mmArWSjsHwe9Zj2ZVGVH7fAy3BvzUMI4FC2V5MGKcM1tm70oW2r0QnxpXhgI2zqRqKdEoVeoIjCjP8BRatRJrA4gf81Gx8ig1u0RBuVbycXVPHLkfhr2qBDScdSiujTy0587zomGQ6YM9HbbqEmQdD+DhQoZSIKqYlgRjoBozPHQA7CM12N12RJusJ/fovIaC8TpZ3X1vpE2p2CdZE1eam0e/uFOpkroowjOws0ot+LUHI/DmVatN9if6vDwMY0pENbQKXE5sQr01F+gKx4QjD6LJ4R1LRrLwVr2l5tl+PWTDdRxgYoIvUIlyNpE0L1A2yyvIs=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 149ec436-921e-414a-1502-08d85513538f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 22:54:36.9243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kSKNBQgFs3EpKdbyLtI3o9h28guAqLgnKmSKJDDF0lDFWbr6mYDqy/agyEAjMV9D7sODsCrpnhkgAzSaMABNUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2986
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit introduces a trace mechanism for struct pipe_ctx by adding a
middle layer struct in the amdgpu_dm_trace.h for capturing the most
important data from struct pipe_ctx and showing its data via tracepoint.
This tracepoint was added to dc.c and dcn10_hw_sequencer, however, it
can be added to other DCN architecture.

Co-developed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_trace.h   | 172 ++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  11 ++
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  17 +-
 3 files changed, 195 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
index 5fb4c4a5c349..53f62506e17c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
@@ -376,6 +376,178 @@ TRACE_EVENT(amdgpu_dm_atomic_check_finish,
 		      __entry->async_update, __entry->allow_modeset)
 );
 
+#ifndef _AMDGPU_DM_TRACE_STRUCTS_DEFINED_
+#define _AMDGPU_DM_TRACE_STRUCTS_DEFINED_
+
+struct amdgpu_dm_trace_pipe_state {
+	int pipe_idx;
+	const void *stream;
+	int stream_w;
+	int stream_h;
+	int dst_x;
+	int dst_y;
+	int dst_w;
+	int dst_h;
+	int src_x;
+	int src_y;
+	int src_w;
+	int src_h;
+	int clip_x;
+	int clip_y;
+	int clip_w;
+	int clip_h;
+	int recout_x;
+	int recout_y;
+	int recout_w;
+	int recout_h;
+	int viewport_x;
+	int viewport_y;
+	int viewport_w;
+	int viewport_h;
+	int flip_immediate;
+	int surface_pitch;
+	int format;
+	int swizzle;
+	unsigned int update_flags;
+};
+
+#define fill_out_trace_pipe_state(trace_pipe_state, pipe_ctx) \
+	do { \
+		trace_pipe_state.pipe_idx	= (pipe_ctx)->pipe_idx; \
+		trace_pipe_state.stream		= (pipe_ctx)->stream; \
+		trace_pipe_state.stream_w	= (pipe_ctx)->stream->timing.h_addressable; \
+		trace_pipe_state.stream_h	= (pipe_ctx)->stream->timing.v_addressable; \
+		trace_pipe_state.dst_x		= (pipe_ctx)->plane_state->dst_rect.x; \
+		trace_pipe_state.dst_y		= (pipe_ctx)->plane_state->dst_rect.y; \
+		trace_pipe_state.dst_w		= (pipe_ctx)->plane_state->dst_rect.width; \
+		trace_pipe_state.dst_h		= (pipe_ctx)->plane_state->dst_rect.height; \
+		trace_pipe_state.src_x		= (pipe_ctx)->plane_state->src_rect.x; \
+		trace_pipe_state.src_y		= (pipe_ctx)->plane_state->src_rect.y; \
+		trace_pipe_state.src_w		= (pipe_ctx)->plane_state->src_rect.width; \
+		trace_pipe_state.src_h		= (pipe_ctx)->plane_state->src_rect.height; \
+		trace_pipe_state.clip_x		= (pipe_ctx)->plane_state->clip_rect.x; \
+		trace_pipe_state.clip_y		= (pipe_ctx)->plane_state->clip_rect.y; \
+		trace_pipe_state.clip_w		= (pipe_ctx)->plane_state->clip_rect.width; \
+		trace_pipe_state.clip_h		= (pipe_ctx)->plane_state->clip_rect.height; \
+		trace_pipe_state.recout_x	= (pipe_ctx)->plane_res.scl_data.recout.x; \
+		trace_pipe_state.recout_y	= (pipe_ctx)->plane_res.scl_data.recout.y; \
+		trace_pipe_state.recout_w	= (pipe_ctx)->plane_res.scl_data.recout.width; \
+		trace_pipe_state.recout_h	= (pipe_ctx)->plane_res.scl_data.recout.height; \
+		trace_pipe_state.viewport_x	= (pipe_ctx)->plane_res.scl_data.viewport.x; \
+		trace_pipe_state.viewport_y	= (pipe_ctx)->plane_res.scl_data.viewport.y; \
+		trace_pipe_state.viewport_w	= (pipe_ctx)->plane_res.scl_data.viewport.width; \
+		trace_pipe_state.viewport_h	= (pipe_ctx)->plane_res.scl_data.viewport.height; \
+		trace_pipe_state.flip_immediate = (pipe_ctx)->plane_state->flip_immediate; \
+		trace_pipe_state.surface_pitch	= (pipe_ctx)->plane_state->plane_size.surface_pitch; \
+		trace_pipe_state.format		= (pipe_ctx)->plane_state->format; \
+		trace_pipe_state.swizzle	= (pipe_ctx)->plane_state->tiling_info.gfx9.swizzle; \
+		trace_pipe_state.update_flags	= (pipe_ctx)->update_flags.raw; \
+	} while (0)
+
+#endif /* _AMDGPU_DM_TRACE_STRUCTS_DEFINED_ */
+
+TRACE_EVENT(amdgpu_dm_dc_pipe_state,
+	    TP_PROTO(const struct amdgpu_dm_trace_pipe_state *pipe_state),
+	    TP_ARGS(pipe_state),
+	    TP_STRUCT__entry(
+			     __field(int, pipe_idx)
+			     __field(const void *, stream)
+			     __field(int, stream_w)
+			     __field(int, stream_h)
+			     __field(int, dst_x)
+			     __field(int, dst_y)
+			     __field(int, dst_w)
+			     __field(int, dst_h)
+			     __field(int, src_x)
+			     __field(int, src_y)
+			     __field(int, src_w)
+			     __field(int, src_h)
+			     __field(int, clip_x)
+			     __field(int, clip_y)
+			     __field(int, clip_w)
+			     __field(int, clip_h)
+			     __field(int, recout_x)
+			     __field(int, recout_y)
+			     __field(int, recout_w)
+			     __field(int, recout_h)
+			     __field(int, viewport_x)
+			     __field(int, viewport_y)
+			     __field(int, viewport_w)
+			     __field(int, viewport_h)
+			     __field(int, flip_immediate)
+			     __field(int, surface_pitch)
+			     __field(int, format)
+			     __field(int, swizzle)
+			     __field(unsigned int, update_flags)
+	),
+
+	TP_fast_assign(
+		       __entry->pipe_idx = pipe_state->pipe_idx;
+		       __entry->stream = pipe_state->stream;
+		       __entry->stream_w = pipe_state->stream_w;
+		       __entry->stream_h = pipe_state->stream_h;
+		       __entry->dst_x = pipe_state->dst_x;
+		       __entry->dst_y = pipe_state->dst_y;
+		       __entry->dst_w = pipe_state->dst_w;
+		       __entry->dst_h = pipe_state->dst_h;
+		       __entry->src_x = pipe_state->src_x;
+		       __entry->src_y = pipe_state->src_y;
+		       __entry->src_w = pipe_state->src_w;
+		       __entry->src_h = pipe_state->src_h;
+		       __entry->clip_x = pipe_state->clip_x;
+		       __entry->clip_y = pipe_state->clip_y;
+		       __entry->clip_w = pipe_state->clip_w;
+		       __entry->clip_h = pipe_state->clip_h;
+		       __entry->recout_x = pipe_state->recout_x;
+		       __entry->recout_y = pipe_state->recout_y;
+		       __entry->recout_w = pipe_state->recout_w;
+		       __entry->recout_h = pipe_state->recout_h;
+		       __entry->viewport_x = pipe_state->viewport_x;
+		       __entry->viewport_y = pipe_state->viewport_y;
+		       __entry->viewport_w = pipe_state->viewport_w;
+		       __entry->viewport_h = pipe_state->viewport_h;
+		       __entry->flip_immediate = pipe_state->flip_immediate;
+		       __entry->surface_pitch = pipe_state->surface_pitch;
+		       __entry->format = pipe_state->format;
+		       __entry->swizzle = pipe_state->swizzle;
+		       __entry->update_flags = pipe_state->update_flags;
+	),
+	TP_printk("pipe_idx=%d stream=%p rct(%d,%d) dst=(%d,%d,%d,%d) "
+		  "src=(%d,%d,%d,%d) clip=(%d,%d,%d,%d) recout=(%d,%d,%d,%d) "
+		  "viewport=(%d,%d,%d,%d) flip_immediate=%d pitch=%d "
+		  "format=%d swizzle=%d update_flags=%x",
+		  __entry->pipe_idx,
+		  __entry->stream,
+		  __entry->stream_w,
+		  __entry->stream_h,
+		  __entry->dst_x,
+		  __entry->dst_y,
+		  __entry->dst_w,
+		  __entry->dst_h,
+		  __entry->src_x,
+		  __entry->src_y,
+		  __entry->src_w,
+		  __entry->src_h,
+		  __entry->clip_x,
+		  __entry->clip_y,
+		  __entry->clip_w,
+		  __entry->clip_h,
+		  __entry->recout_x,
+		  __entry->recout_y,
+		  __entry->recout_w,
+		  __entry->recout_h,
+		  __entry->viewport_x,
+		  __entry->viewport_y,
+		  __entry->viewport_w,
+		  __entry->viewport_h,
+		  __entry->flip_immediate,
+		  __entry->surface_pitch,
+		  __entry->format,
+		  __entry->swizzle,
+		  __entry->update_flags
+	)
+);
+
 #endif /* _AMDGPU_DM_TRACE_H_ */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index dc463d99ef50..0c9f177e5827 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2644,6 +2644,17 @@ void dc_commit_updates_for_stream(struct dc *dc,
 		}
 	}
 
+	for (i = 0; i < MAX_PIPES; ++i) {
+		struct pipe_ctx *pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[i];
+
+		if (pipe_ctx->plane_state) {
+			struct amdgpu_dm_trace_pipe_state pipe_state_trace;
+
+			fill_out_trace_pipe_state(pipe_state_trace, pipe_ctx);
+			trace_amdgpu_dm_dc_pipe_state(&pipe_state_trace);
+		}
+	}
+
 	commit_planes_for_stream(
 				dc,
 				srf_updates,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 8ca94f506195..464d0ad093b9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1020,15 +1020,22 @@ static bool dcn10_hw_wa_force_recovery(struct dc *dc)
 
 }
 
-
 void dcn10_verify_allow_pstate_change_high(struct dc *dc)
 {
-	static bool should_log_hw_state; /* prevent hw state log by default */
-
 	if (!hubbub1_verify_allow_pstate_change_high(dc->res_pool->hubbub)) {
-		if (should_log_hw_state) {
-			dcn10_log_hw_state(dc, NULL);
+		int i;
+
+		for (i = 0; i < MAX_PIPES; ++i) {
+			struct pipe_ctx *pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[i];
+
+			if (pipe_ctx->plane_state) {
+				struct amdgpu_dm_trace_pipe_state pipe_state_trace;
+
+				fill_out_trace_pipe_state(pipe_state_trace, pipe_ctx);
+				trace_amdgpu_dm_dc_pipe_state(&pipe_state_trace);
+			}
 		}
+
 		BREAK_TO_DEBUGGER();
 		if (dcn10_hw_wa_force_recovery(dc)) {
 		/*check again*/
-- 
2.28.0

