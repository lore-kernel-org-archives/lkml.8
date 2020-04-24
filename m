Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D22C55186
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28F5020776
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrmZBBIC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgDXPxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbgDXPxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:53:41 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9453AC09B048
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 08:53:41 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a32so4021166pje.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 08:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=N0+d74YhkRo0RcT3ihN7Yp1K7rYS7rIY6Vw+q5Iylco=;
        b=MrmZBBIC8M+G4yy4+vJVJKJEGAiam2pvKgOKZkPOmzTrAD9O5lPHsuzy6uXcDvFusQ
         cUb+Hz660fQTAuyvk52y++edasHsMYbDuWR+rDjk95oNG4zsO0/ewtwuaMkJZY4EtmEO
         fihNtSDDVrA02Yexf2/Gho+EvfOUEIjXj0P+rXF+5F22nNBpRC6RviHJURl3g8P05fp/
         2yWw6TyeBXyqjGiFPG6lJpaj+oPQRqsDWLvCFC4+XYp+FFa4UTABs0ciNZlzG+vMFaPw
         ja5BzpzPaxJ0vKHncKUPfYyaEef2OR2ntqU0DB4Eu+HUTeeZpF8vfo1uDzeOSMeseFJO
         udeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=N0+d74YhkRo0RcT3ihN7Yp1K7rYS7rIY6Vw+q5Iylco=;
        b=hXudfFQG3Dax/wCWwTcwUBgeXc0XJYI08T3eBGmhFmCQNpnjOXKO4OIB57C3b1f63C
         nkCUueRVUVLhrjosvrTiQPFmj9+g9o8BXpcNm1AvK75k+LB4BCmYAjjyQCryb0itwQA6
         icGNs6P/V59FOjbL8CISfn54DzZEUt1GGGXWfvjZXHIq8yj11OW3hGmh7xQytsPbT0vr
         QIqWDLNPhKTJ3ksjXVIiqboWJ3suq68FU+Tyiu4pHEMzqFBSZ0LcfEEhGLpBLo8nJWrT
         KHZ/CPdBwYhmcPtajdFZqgfkt7kZUtha4cmY2VfrU9Dqx9V4g3dDVddxFk7cIIORBQ/V
         4LAA==
X-Gm-Message-State: AGi0PuZX8nhHR+4QTFzE4mkhOfsjPDyJy9ggkZQo6fqdrdjGQG1FNvfA
        if1TvG1ransFGhEtmli0y8U=
X-Google-Smtp-Source: APiQypI0xbBs0yDgR9WbZEHtL87BHKaLqDQYsvXWkc/t1gT1RnBvwRJizllKfYpSh24fInXYu2TGhw==
X-Received: by 2002:a17:90a:f985:: with SMTP id cq5mr6875260pjb.193.1587743621107;
        Fri, 24 Apr 2020 08:53:41 -0700 (PDT)
Received: from ubuntu.localdomain ([220.116.27.194])
        by smtp.gmail.com with ESMTPSA id z5sm6071305pfn.142.2020.04.24.08.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 08:53:40 -0700 (PDT)
From:   Youngjun Park <her0gyugyu@gmail.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     gregkh@linuxfoundation.org, her0gyu@naver.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fs: fixup redundant indentation.
Date:   Fri, 24 Apr 2020 08:53:34 -0700
Message-Id: <20200424155334.17053-1-her0gyugyu@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Youngjun Park <her0gyu@naver.com>

Signed-off-by: Youngjun Park <her0gyu@naver.com>

fixup redundant indentation on the label.
---
 fs/kernfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 34366db3620d..7fb5d1e48ef7 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -544,7 +544,7 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 {
 	struct kernfs_open_node *on, *new_on = NULL;
 
- retry:
+retry:
 	mutex_lock(&kernfs_open_file_mutex);
 	spin_lock_irq(&kernfs_open_node_lock);
 
-- 
2.17.1

