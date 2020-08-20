Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C44C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38E0D2076E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="qDhQwNj/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgHTHwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 03:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgHTHwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 03:52:45 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DA3C061757
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 00:52:45 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id l13so1423203ybf.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 00:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ZTZ7FeRGcuK/Hk+zj5oM9AwC2C+E4zSdizznNm3JGaw=;
        b=qDhQwNj/i9PSLJjNFzjvh270vkvMWiwNw4Xn4zB5msBMj/zonYxNr4zdkzs+kHxEKQ
         hsk4cTsctX3LU0jX3+aNU39vbHGAcgDW/7Kabwd7zA09xokQNLQT+l5OUTB18PY3jtc8
         3u1DD2f4zPraIZQBIOQgu9SC/UA+drjB87PyO+//YzeTsLTNXzTI13pixc0NmJ+t1Sig
         PSJynH6yZ+VT6N3palt7khJAXHuQF+GvVTeSVEFGUaZaKJmXq+GuZh7x882Oye0ACLPL
         isTCg2Gonbg6ZOLFRn+07HTT8f9TCbu/pBmgDuj3uzlMTq+fzWAWdRBL05rAShBbUOLe
         hRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZTZ7FeRGcuK/Hk+zj5oM9AwC2C+E4zSdizznNm3JGaw=;
        b=FDj64p61LnxkQ8TjH0OWZQ+3TUG4qL2/x+v7PGEJAC/ixOdsgn/VfYgnbRJk/DWCMj
         KQyzZOyVch0gL/PYjp1ibQ3T7D7DzZxXrEGNz7PXEVIxay/bcHGEli/r12DUBcQAImzH
         sORyFapzK40QgUGi7KmluWgH/GvU1h/q8Ipt9eJO3tU+AfQqLieAe11/XR++FCU5LQ9e
         rViaY8X7ah1Nu4p3SL0N+DO/fhtWID9/hx5HOobMkaciX+0/tXe4I/J/tQag8wWOKSso
         tPVS7/n/AzybaT9zZ+KTOq8oH+FTTjOvGzLxnI+6qxdgrzRwrV5urUhjpI9k9dTwohtO
         AJug==
X-Gm-Message-State: AOAM531iCiEhCRAUvm3Lfg3jSNcOOq1mpZH1CLBIBRd7shKzq3cTUZL4
        XWxxEBwEi3WSnglkK0VXg5FFl9f/Wawc
X-Google-Smtp-Source: ABdhPJzAM44YvcI2eY5BDvZXP1CL91XTwHSk/ficRLHKynUx1ZaTtPmmgHpQyfkf4ayDeiiwEw2CVKu0Zo+Z
X-Received: from furquan.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:13a4])
 (user=furquan job=sendgmr) by 2002:a5b:b45:: with SMTP id b5mr3114667ybr.294.1597909964605;
 Thu, 20 Aug 2020 00:52:44 -0700 (PDT)
Date:   Thu, 20 Aug 2020 00:52:41 -0700
In-Reply-To: <20200820052600.3069895-1-furquan@google.com>
Message-Id: <20200820075241.3160534-1-furquan@google.com>
Mime-Version: 1.0
References: <20200820052600.3069895-1-furquan@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH v2] drivers: gpu: amd: Initialize amdgpu_dm_backlight_caps
 object to 0 in amdgpu_dm_update_backlight_caps
From:   Furquan Shaikh <furquan@google.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Stylon Wang <stylon.wang@amd.com>, Roman Li <roman.li@amd.com>,
        Mikita Lipski <mikita.lipski@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, adurbin@google.com,
        deepak.sharma@amd.com, Furquan Shaikh <furquan@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In `amdgpu_dm_update_backlight_caps()`, there is a local
`amdgpu_dm_backlight_caps` object that is filled in by
`amdgpu_acpi_get_backlight_caps()`. However, this object is
uninitialized before the call and hence the subsequent check for
aux_support can fail since it is not initialized by
`amdgpu_acpi_get_backlight_caps()` as well. This change initializes
this local `amdgpu_dm_backlight_caps` object to 0.

Signed-off-by: Furquan Shaikh <furquan@google.com>
---
v2: Switched to using memset for initialization of object.

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e4b33c67b634..da072998ce48 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2855,6 +2855,8 @@ static void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm)
 #if defined(CONFIG_ACPI)
 	struct amdgpu_dm_backlight_caps caps;
 
+	memset(&caps, 0, sizeof(caps));
+
 	if (dm->backlight_caps.caps_valid)
 		return;
 
-- 
2.28.0.297.g1956fa8f8d-goog

