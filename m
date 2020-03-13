Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E116BC4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 18:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B15C620674
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 18:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MObsCsyp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgCMSDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 14:03:39 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:40807 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbgCMSDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 14:03:39 -0400
Received: by mail-pl1-f201.google.com with SMTP id p25so6004903pli.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 11:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=CVDLXdUW9/akpoopZJqSktk5WLr6W64dr/oZNQEBp/M=;
        b=MObsCsypvEE1MVadLaUVcsrSK/urgDj61mS4IUBEA19KCPVwDapvXoJrDw07lrU9y6
         1P1D2/BMkTsNI8qHkYq6j3zwFsmfPLTgUhSA+iRFjpXi/1usMOM5J3fZhISLRzqGvNJA
         3hhYJr4rvjnGGQnoSTBU5OgppfdpZsP3WC6BWzdpF3AYRtR6ShdgaHYLhxleEKAgekiP
         rOkGzcM5BfH7ZAQBrlCDJQZ2Vou6tKG1ddvu9JdvrAQmRzMjBO8u7ZKWxa6SRMKynVmL
         yC3mNqboLg/0/3VAz1Gyu2yLuRwoY6fy7FsvfYjGisLymWOgsISUpXKBD9msodpoTZcs
         9QTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=CVDLXdUW9/akpoopZJqSktk5WLr6W64dr/oZNQEBp/M=;
        b=nhwA7UWcQmjhPBcj6Fo/uNmdrn1uLcxxIfFcIxU4DTkqufjt+dAT4PiDqq+hJVlHMs
         xGZckEvScvj8ghSWAfDLt1q9AXlpWgm5GkgDaojwb4jmVwxXVSsHYGRj0MOV4zuHkHvG
         Jf1oteyPSsOBfAnzvapSdMpPsvLc5/TfrGXWozUzo6Vt7sHnM63DFyZogTpPFAXeanyG
         Z2qzBu4mJk/DvIPj+iFjEafLelJiZujinQRYUySBJTMiyw0jBTW/BOQDCvUMZTXWOIik
         K5MUPWUtT8+/5VFD3dl9LquGGmkZFXHtqB/WSS1CvRLFzSLt+vN4H7vXIsFpcnTgd7+d
         GVcg==
X-Gm-Message-State: ANhLgQ0D5F5YUQfqfhDxcg1iF2LLz47c5TSjfP3aj3oGsv/jOZkkDUmQ
        1DHaJ4CbzWQ62c5rVFwXRZizNZK+33KB
X-Google-Smtp-Source: ADFU+vsta7Nltn3U0edYg3zcSAuqrGro5jNKtDzH8XuEdkV3HeVzf/XYWpcCo3hZ4umzeJdqfLXU86N5LJ7H
X-Received: by 2002:a17:90a:af81:: with SMTP id w1mr11210453pjq.14.1584122618151;
 Fri, 13 Mar 2020 11:03:38 -0700 (PDT)
Date:   Fri, 13 Mar 2020 11:03:33 -0700
Message-Id: <20200313180333.75011-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH v3] Input: Allocate keycode for "Selective Screenshot" key
From:   Rajat Jain <rajatja@google.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Harry Cutts <hcutts@chromium.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, dtor@google.com
Cc:     Rajat Jain <rajatja@google.com>, rajatxjain@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New chromeos keyboards have a "snip" key that is basically a selective
screenshot (allows a user to select an area of screen to be copied).
Allocate a keycode for it.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v3: Rename KEY_SNIP to KEY_SELECTIVE_SNAPSHOT
V2: Drop patch [1/2] and instead rebase this on top of Linus' tree.

 include/uapi/linux/input-event-codes.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 0f1db1cccc3fd..c4dbe2ee9c098 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -652,6 +652,8 @@
 /* Electronic privacy screen control */
 #define KEY_PRIVACY_SCREEN_TOGGLE	0x279
 
+#define KEY_SELECTIVE_SCREENSHOT	0x280
+
 /*
  * Some keyboards have keys which do not have a defined meaning, these keys
  * are intended to be programmed / bound to macros by the user. For most
-- 
2.25.1.481.gfbce0eb801-goog

