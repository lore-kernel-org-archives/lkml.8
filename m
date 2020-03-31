Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51217C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22B712080C
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=massaru-org.20150623.gappssmtp.com header.i=@massaru-org.20150623.gappssmtp.com header.b="WEbQhK9U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731532AbgCaW3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 18:29:10 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40937 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731498AbgCaW3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 18:29:07 -0400
Received: by mail-qk1-f194.google.com with SMTP id l25so25009522qki.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 15:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6nYFV2QWqYi47IsY2NnyndMBRfL9Zb689yvP+ZRhJYQ=;
        b=WEbQhK9UN2CvW9DcH2pEKnkPZxZFQ66KstFZKM4h+j//VHXq4PrK0nS0kMDpen9JyH
         8G7WfaWPzlYy9D7M2q8Ya/+zecQ3uVleocnuvM/goO7i2O9LkxiMkjczGQN6E/cY0Fdf
         eukl1mMNKCk7+x6UJ5Y5svvrFY0qTgqmUdKii7Qp2hJ5UU4L1nZGOmGHOaGauF4SI85b
         zq/V3aJh77372onSSRONdWyJNJtTc0h3pRBV7HCC9+NUlxtTC9UVjOSLZru4m7YRJSR/
         mXX47pjtP9B+U4ZHHeWeXXBIns1Td/Gvc7E5ojSr94dLkemRYH5sV6u8a4c3RzHlm4ks
         t7lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6nYFV2QWqYi47IsY2NnyndMBRfL9Zb689yvP+ZRhJYQ=;
        b=N4fdjepAM3aqYO2EZY0tzIsugxeMAhKslTJuLAEvbF30Mf/zsETzIvmCbM+bwkF2jM
         AUAQthxiJLKC4UxtDtQ5vG6P3BOUXvidqp2ujoOJxV5k0EJBKgxVzsic2ZyGQ5BF5lBq
         OeGVYK9kJJcumtuYjcXGcsbzi48lKAIQwaueCHSU6nTycV9ATfjRmmc6WmkJPrrsElis
         X4gf8vHQumW/X0qEih9RKQlkOyt7UcjEUjzX69C66Jme/Wwpuc93ese+lyz+zFj6KIyS
         kAM8LLkRzzCrZHtcAoPsWUE93bkWHUMdZO8f8i5KwZavI7m+YZ12IsBedYARSM8afCLc
         ZeFA==
X-Gm-Message-State: ANhLgQ3XawK4fS/PhkjmYGQcVnXlQbITdMCoLDMWEIVY51+jE3lav5+h
        0my+p2eR2uKcLwvPa+2NXL1I5w==
X-Google-Smtp-Source: ADFU+vujLgQRKH4PKzJMmO4KEOhtyZLdp/89fmvgK6ikN22LNygxkkodSRrEqDYEtYdVOw+eHiht/w==
X-Received: by 2002:ae9:efce:: with SMTP id d197mr7149016qkg.211.1585693745963;
        Tue, 31 Mar 2020 15:29:05 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id 206sm238659qkn.36.2020.03.31.15.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 15:29:05 -0700 (PDT)
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     linux-doc@vger.kernel.org
Cc:     corbet@lwn.net, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH 2/2] Documentation: filesystems: remove whitespaces
Date:   Tue, 31 Mar 2020 19:28:57 -0300
Message-Id: <97cb61253283b4054e9f00364eb08eeedb5bd95e.1585693146.git.vitor@massaru.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <cover.1585693146.git.vitor@massaru.org>
References: <cover.1585693146.git.vitor@massaru.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
---
 Documentation/filesystems/sysfs-pci.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/sysfs-pci.rst b/Documentation/filesystems/sysfs-pci.rst
index 9b93e7444b15..e4df647ec9db 100644
--- a/Documentation/filesystems/sysfs-pci.rst
+++ b/Documentation/filesystems/sysfs-pci.rst
@@ -71,11 +71,11 @@ don't support mmapping of certain resources, so be sure to check the return
 value from any attempted mmap.  The most notable of these are I/O port
 resources, which also provide read/write access.
 
-The 'enable' file provides a counter that indicates how many times the device 
+The 'enable' file provides a counter that indicates how many times the device
 has been enabled.  If the 'enable' file currently returns '4', and a '1' is
 echoed into it, it will then return '5'.  Echoing a '0' into it will decrease
 the count.  Even when it returns to 0, though, some of the initialisation
-may not be reversed.  
+may not be reversed.
 
 The 'rom' file is special in that it provides read-only access to the device's
 ROM file, if available.  It's disabled by default, however, so applications
-- 
2.21.1

