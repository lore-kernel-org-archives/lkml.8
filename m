Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2EB2C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 07:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1CBF20738
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 07:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hONZkQDP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgH2HNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 03:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgH2HNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 03:13:30 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78BDC061236
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 00:13:29 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k13so677405plk.13
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 00:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Rh4ud5jTmfL5cS/C7dCchIDO5q1+ZBSwil0mqRzvrBQ=;
        b=hONZkQDPIqwXG3s/MO8aVRxkuNaIEvDvSn0quqaxTt1WEC9e1x7VwhTDkUfhxOdpUs
         WV1ddj41BrENjiR1ebhsoYjt7JUICzh0FYipgC7VzKVMhY3V+Wd5s9dxsgLvzFFWW/c2
         tV5xoudkHa54lS++0fZABmcYWWIIVYea8lH8B+BC1A1gWOiKNY0bNcURbOQMpPEp/PrC
         UckO52T1ffr0zZqkFVo5RKDMXR3AIESxFwTMcwqTAtofDIC6JlygguoyL7y9vg/3fcL2
         49aRSWMvX4fhLzHGxiwa8KgcB/mjYUr8caI53fuNBEsPBIUtS7ARm3TDYBYiXKMM/vHt
         ZFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Rh4ud5jTmfL5cS/C7dCchIDO5q1+ZBSwil0mqRzvrBQ=;
        b=FzjF2wo0kCaQMjruB84xNeLCmjpLYQ7agYqdyG7HsYCJbCdOgxmPIU1/TNkFrsLhS0
         GWRmXh1XDn4VrzkVNrOsYjvvZnvrFkTR4amaa++3JS+U6L5NtyceCUgxFA08E+gsg09S
         9v05L3Et5DiSyXS4SK7+wCMOFvKmq8LYZ6zao/5Aj30/J74qwAuuIP5DZqSGE8PeXAgX
         q/kg/EVQ24dnzetFuD2Ty1MY4qqFtUZt1DPrDqFrVR8A2i8e3ctQTkr4/Rc7dmgmnscb
         iGHlP/gdOReK83D9dglxbPvyrPHjIgHqeW1oR54r5tJ0oFYTGfmqM2vbz3J1Q0kHb6jL
         wQtQ==
X-Gm-Message-State: AOAM533+Cd8N5WAEykUr7qn5MPOS6t8UwZBuSt/CCiG9OqHXtAGDgSn5
        EfxCksVs4CYxQfuU4XtfEg==
X-Google-Smtp-Source: ABdhPJx7g+ttIXoZnc1jLfVygP5yd+wFwv5JzWPQ50sx8JWo0jvLSBv4yxRHDuN6TPlGqndF42L+cw==
X-Received: by 2002:a17:902:6f01:: with SMTP id w1mr1906429plk.49.1598685208899;
        Sat, 29 Aug 2020 00:13:28 -0700 (PDT)
Received: from localhost.localdomain ([103.85.228.104])
        by smtp.gmail.com with ESMTPSA id e1sm866102pjv.17.2020.08.29.00.13.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Aug 2020 00:13:28 -0700 (PDT)
From:   milan.opensource@gmail.com
To:     mtk.manpages@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Milan Shah <milan.opensource@gmail.com>
Subject: [PATCH] fsync.2: ERRORS: add EIO and ENOSPC
Date:   Sat, 29 Aug 2020 12:43:06 +0530
Message-Id: <1598685186-27499-1-git-send-email-milan.opensource@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Milan Shah <milan.opensource@gmail.com>

This Fix addresses Bug 194757.
Ref: https://bugzilla.kernel.org/show_bug.cgi?id=194757
---
 man2/fsync.2 | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/man2/fsync.2 b/man2/fsync.2
index 96401cd..f38b3e4 100644
--- a/man2/fsync.2
+++ b/man2/fsync.2
@@ -186,6 +186,19 @@ In these cases disk caches need to be disabled using
 or
 .BR sdparm (8)
 to guarantee safe operation.
+
+When
+.BR fsync ()
+or
+.BR fdatasync ()
+returns
+.B EIO
+or
+.B ENOSPC
+any error flags on pages in the file mapping are cleared, so subsequent synchronisation attempts
+will return without error. It is
+.I not
+safe to retry synchronisation and assume that a non-error return means prior writes are now on disk.
 .SH SEE ALSO
 .BR sync (1),
 .BR bdflush (2),
-- 
2.7.4

