Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45496C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25406206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="RUvuRoaA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgFDIMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 04:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbgFDIMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 04:12:36 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B83C05BD1E
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 01:12:35 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j10so5022871wrw.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 01:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ys1lEmo1OrglME8cWbIXSVFR7KWfyvCPNKiL9IEbmhc=;
        b=RUvuRoaAUx3zoTg0dekOOqbI1T8Sgso/qeY9AgIY+69YkzMVoxVd2zcJLUgcBipdk7
         bfLnFFHUCXlCtl7HOikMZEY9KbeA3ZJCmbGvpYaKPSFaizoR8g1G0iiiWixkm2fyo6ve
         uHh1ScOQIMEnMrZouE9W6fbm6RZuu2BrIaMFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ys1lEmo1OrglME8cWbIXSVFR7KWfyvCPNKiL9IEbmhc=;
        b=Bv6g9ksONfuOc9c9xopWSRevqIj11z3hF3jOIGgit0s0Nz8P88fgbhk3ibkOaiMOT5
         Nh/JtfVh6K4K5g6oCriscAEC6pcCl4Q9VE6T8Qwm8qK/dELuQjvjNj9Bwi6TazZk6tzB
         C+oCMdAWnhwux6Ky5tnN+utmNus3mnhFiCfnsrMiL1mbsSfFnKXpAy3rO+rbr+94mYA7
         tq+0/MoNNgiVLKTA/yQZu+2jyYVJ05Ueww8stpmT1q0BOXjHWTlKVP5aPxrx5glpG7ky
         IoyrOmkNCbpLzighEQIGdXzf7tTZJ3tpsbjZoXypPq2Q2JZ3qtcvqVJxzK2fYsyhAU+l
         I6SA==
X-Gm-Message-State: AOAM530hqrMIfbJrSPulDNM6ta2lzPTNva+KzulIdv8S92fOH3cyp4Ke
        f7EbYQVjSE9qETZwiWpFpwpTcQ==
X-Google-Smtp-Source: ABdhPJyMtbbr4YZr5XgYcavaaABocIWgVVWO+6bIVkLH86w/gWfWScj44NFGJ8WhcZD+YmTAw14Znw==
X-Received: by 2002:a5d:518b:: with SMTP id k11mr3495849wrv.58.1591258354483;
        Thu, 04 Jun 2020 01:12:34 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id f11sm6873305wrj.2.2020.06.04.01.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 01:12:33 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
        amd-gfx@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH 02/18] dma-buf: minor doc touch-ups
Date:   Thu,  4 Jun 2020 10:12:08 +0200
Message-Id: <20200604081224.863494-3-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200604081224.863494-1-daniel.vetter@ffwll.ch>
References: <20200604081224.863494-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just some tiny edits:
- fix link to struct dma_fence
- give slightly more meaningful title - the polling here is about
  implicit fences, explicit fences (in sync_file or drm_syncobj) also
  have their own polling

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 drivers/dma-buf/dma-buf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 01ce125f8e8d..e018ef80451e 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -161,11 +161,11 @@ static loff_t dma_buf_llseek(struct file *file, loff_t offset, int whence)
 }
 
 /**
- * DOC: fence polling
+ * DOC: implicit fence polling
  *
  * To support cross-device and cross-driver synchronization of buffer access
- * implicit fences (represented internally in the kernel with &struct fence) can
- * be attached to a &dma_buf. The glue for that and a few related things are
+ * implicit fences (represented internally in the kernel with &struct dma_fence)
+ * can be attached to a &dma_buf. The glue for that and a few related things are
  * provided in the &dma_resv structure.
  *
  * Userspace can query the state of these implicitly tracked fences using poll()
-- 
2.26.2

