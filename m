Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1246BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 13:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1A3B2224D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 13:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vPrchpkK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgHGNhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 09:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgHGNhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 09:37:04 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BC9C061575
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 06:37:03 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a14so1712512wra.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 06:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4LVGnEnOhzHJYp7k/0jPrqpIv6dziA/YJ8laLNioGFM=;
        b=vPrchpkKsG/T8AFiA7Yn7M46PLKiPZDNi/VQkH2XagE4mkxFfqePQ0DxXi+WpJ0U+R
         6+Tigj2zd0aonU/AOQBMGGxh/7cj9dH4jhH2VUrWClb3vy1rnD1tCXk42aJL1AHYH9BG
         Q4Uz5H0srLIX9r+VyELVxP9kuxiAsEbUqq9hEoDmU5/crvFK+xwDOtq3mnLgQkLKHdLX
         ZrLAMvRodPLri/9wPmrIwsmz4cFf505+ZmWsdmEO9LLOySAhCm/VB094CFm7/MxkVVh0
         h70Gf9ij6xNTbK0wO3r9fgqqJItuYk3DK8aD5rK/6yo4wsXCG5VGzupDxsUhheb284q4
         WXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4LVGnEnOhzHJYp7k/0jPrqpIv6dziA/YJ8laLNioGFM=;
        b=bYx48dUjIEkBQ076uRQLnIvw6qM3QX37h9u4lWjpmAdB1lYpjp6xCKRjegoZwvn18L
         GoH8oRM/5PNs1EHus9HQVxTIvH1HWscHOAcTnfFVP5MXAgT5BZhhk8vrNL08WvDhaW3s
         pDeb7eKcZGyJ0+EqdmRouCk3DNt2wltq3GdyzDxq2bxZVgXLU+UjDnmdHXiaDSON0RRu
         gMKM80vYgyrMqhPauSCOOeZO2H1FLZvd1pI3LQFr9FDyGqY9vZIVhUwShoizsvak+PEW
         npOQzDVe2Ud31qlXqpRWUOt1KPGSFQkOzbHIX1hAnRk76gmX7thy5ZtJyPPpFxw3hUQ+
         ZkdQ==
X-Gm-Message-State: AOAM530FUTq91jRXs4yJEp0stzewv7URjZnxeyy7tboBPWXSOfHZIBaJ
        LD/bDAAPXj5rb70P2oNK+XI=
X-Google-Smtp-Source: ABdhPJyy6/1Evq0AWxcj8cS24OPjPyqAVqG2TPNcf52PUYgYZc8VHPTAJXAA/0IWvQkVVjS73ndtbw==
X-Received: by 2002:a5d:630b:: with SMTP id i11mr12856842wru.95.1596807422267;
        Fri, 07 Aug 2020 06:37:02 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:8a1:e63e:700c:859e])
        by smtp.gmail.com with ESMTPSA id k126sm11084609wme.17.2020.08.07.06.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 06:37:01 -0700 (PDT)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Shashank.Sharma@amd.com, daniel.vetter@ffwll.ch,
        alexander.deucher@amd.com
Subject: [PATCH] drm/amdgpu: adjust the pid in the grab_id trace point
Date:   Fri,  7 Aug 2020 15:36:58 +0200
Message-Id: <20200807133658.1866-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200807133658.1866-1-christian.koenig@amd.com>
References: <20200807133658.1866-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trace something useful instead of the pid of a kernel thread here.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
index 5da20fc166d9..07f99ef69d91 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -228,6 +228,7 @@ TRACE_EVENT(amdgpu_vm_grab_id,
 			     ),
 
 	    TP_fast_assign(
+			   __entry->ent.pid = vm->task_info.pid;
 			   __entry->pasid = vm->pasid;
 			   __assign_str(ring, ring->name)
 			   __entry->vmid = job->vmid;
-- 
2.17.1

