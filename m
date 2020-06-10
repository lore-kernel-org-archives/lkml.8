Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FACC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 20:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC373206F7
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 20:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Nmmaagkv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgFJU04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 16:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgFJU04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:26:56 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF02CC03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 13:26:55 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l17so3050669wmj.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 13:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=aRc2NDXVT0hl+GqEDJOA+TnhB010fZ5nnjfIRwfaqqo=;
        b=NmmaagkvhYZf17uZ0pcXtXQVm3uwzfO81dffISFx26jEWPevoNkXv+zMnP45k7V4MV
         Hfer4PK0gETpDXOJ5CbYYBWh1d/eMVMA5/R4efSYv/INCi0PIbQBbMnOT9om9EGaEgeF
         c7XmDR6gm8nVGr+KDzXdFNUC+CnA3n+nex4bo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aRc2NDXVT0hl+GqEDJOA+TnhB010fZ5nnjfIRwfaqqo=;
        b=QhGyD3xXNtj1tGQDz/itGIwAZyxb0LFUOkzJjTAU3z/U63o3GHQLvgZ3tzmPOc3SLi
         0xmOGLf2PFgIsMhA5V7wYy0+iijPEz8RnLcXw+q0Tmzo6+cwQXGnGDSv7+tQtz1ab7R9
         KJqJPWKGJSmBIyqDbpBt2CQamzKacwxhtmR3WNccylmiNPkAUIzTH0ioQnaMzW6/5Fav
         vmdGO8lP4CCJGu+vRxasNOlIqR2esCxhwQeYvRbEgK5MQrWAFjBHnaio1N+XkJ2B9l83
         NjqUuqIxhz9oY0EzZ+/3MCjmBacOlPgCKsdp9nyLFEUquUpQpDnqeZf6Qu7eQKlE5/1O
         uV6g==
X-Gm-Message-State: AOAM533Y8AOm6uDi6QVk6rY1uBtotitWezLRB3zfR122tFqca6Yvm7YJ
        NCNKxBwfWIfVK9ZwfM73c/EGBg==
X-Google-Smtp-Source: ABdhPJyDsaH7vH9YUkVFKsdibp6/PwNWTvP06WMzzoL8jSrGDCbr3VRcLk8gvb2ShuCIUHaojgIGmQ==
X-Received: by 2002:a1c:b182:: with SMTP id a124mr4576408wmf.114.1591820814528;
        Wed, 10 Jun 2020 13:26:54 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id k26sm978085wmi.27.2020.06.10.13.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 13:26:53 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-kernel@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH] checkpatch: add check for NONNETWORKING_BLOCK_COMMENT_STYLE
Date:   Wed, 10 Jun 2020 13:26:40 -0700
Message-Id: <20200610202640.9020-1-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NETWORKING_BLOCK_COMMENT_STYLE is supported by checkpatch but there
doesn't seem to be any check for the standard block comment style.
Add support for NONNETWORKING_BLOCK_COMMENT_STYLE to check for empty /*
on first line of non-networking block comments.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 scripts/checkpatch.pl | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 524df88f9364..899e380782c0 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3408,6 +3408,16 @@ sub process {
 			     "networking block comments don't use an empty /* line, use /* Comment...\n" . $hereprev);
 		}
 
+# Non-Networking with an empty initial /*
+		if ($realfile !~ m@^(drivers/net/|net/)@ &&
+		    $prevrawline =~ /^\+[ \t]*\/\*[ \t]/ &&
+		    $prevrawline !~ /\*\/[ \t]*$/ &&		#no trailing */
+		    $rawline =~ /^\+[ \t]*\*/ &&
+		    $realline > 2) {
+			WARN("NONNETWORKING_BLOCK_COMMENT_STYLE",
+			     "non-networking block comments use an empty /* on first line\n" . $hereprev);
+		}
+
 # Block comments use * on subsequent lines
 		if ($prevline =~ /$;[ \t]*$/ &&			#ends in comment
 		    $prevrawline =~ /^\+.*?\/\*/ &&		#starting /*
-- 
2.17.1

