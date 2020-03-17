Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5D8C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 07:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CA1F20674
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 07:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="LM4/ISsz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbgCQHP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 03:15:58 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53836 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgCQHP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 03:15:57 -0400
Received: by mail-wm1-f67.google.com with SMTP id 25so20218174wmk.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 00:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MFz/fOJixvWzcvSU4go/rFHGmxjYPGKF/Ch+nsy/6+A=;
        b=LM4/ISszOBUpkchVKZxUKcKxPDaf5/m4Dl5b4wiHzO82d/D9d4+nUiQ6z9VY3uYUuI
         PN4xZI8u/KohR+5cUA1tPX95LVGypE1HZVY5ff0vAw9R0qH77EOdFyHKY+A8noP5dpwU
         G/bY7gkrq6QYKrLNTmPicsPFOhkbbdpODFKCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MFz/fOJixvWzcvSU4go/rFHGmxjYPGKF/Ch+nsy/6+A=;
        b=Lnu3ShVpGOA0nKLInmHM1B/9gl8OJSBhxSTjh36zVvqCkAME2njxw09r5BKKJPKsYm
         cj0tWEGhSikFNhpCbRoyN1fMu4hiVWOTHkT7m6eJ0dzJ2rR+JBucSp4yzngICXYZatGt
         SkPnl4JX+HDVdYFpfAdQGDjXZZ8mijxukW19JZF47xMnw3QpIn1+i7Nnm7plyHYi8QeG
         tXteRlggjSZ9XHskEaOTIeqtCzmLU5K28WxJ0j40YpfZVtXlQBN8gIiYCarnWFL8Qzib
         0qSYcsVL2mX7AVkLn35djQgBxsWLt0+GY5uMuEeO+lqzxBe4Z8nE1YH/MZnkR5oRLiI+
         iynw==
X-Gm-Message-State: ANhLgQ0deKaPJrDFqoJn/qUm2JzvVpPUTjTpTGt08PDeBAranTHRSCFY
        6IzJcVil2ZxiYcucBoZsxp74r0GPJyaw4I9J
X-Google-Smtp-Source: ADFU+vshR5dL7XEFTVt5fsXsNS9srnBWqq1zc+uhfogGkq31eM9oA0HMTXTh3QU5dIxWcXYALTZGrQ==
X-Received: by 2002:a05:600c:2250:: with SMTP id a16mr3486950wmm.57.1584429353745;
        Tue, 17 Mar 2020 00:15:53 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 9sm2707769wmx.32.2020.03.17.00.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 00:15:53 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, Joe Perches <joe@perches.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH] MAINTAINERS: Better regex for dma_buf|fence|resv
Date:   Tue, 17 Mar 2020 08:15:47 +0100
Message-Id: <20200317071547.1008622-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're getting some random other stuff that we're not relly interested
in, so match only word boundaries. Also avoid the capture group while
at it.

Suggested by Joe Perches.

Cc: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linaro-mm-sig@lists.linaro.org
Cc: Joe Perches <joe@perches.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3005be638c2c..fc5d5aa53147 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5025,7 +5025,7 @@ F:	include/linux/dma-buf*
 F:	include/linux/reservation.h
 F:	include/linux/*fence.h
 F:	Documentation/driver-api/dma-buf.rst
-K:	dma_(buf|fence|resv)
+K:	'\bdma_(?:buf|fence|resv)\b'
 T:	git git://anongit.freedesktop.org/drm/drm-misc
 
 DMA-BUF HEAPS FRAMEWORK
-- 
2.25.1

