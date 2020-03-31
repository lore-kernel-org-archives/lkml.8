Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A13C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 20:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC497207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 20:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPFEqw8w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731214AbgCaUrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 16:47:15 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54757 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728091AbgCaUrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 16:47:14 -0400
Received: by mail-wm1-f68.google.com with SMTP id c81so4077831wmd.4;
        Tue, 31 Mar 2020 13:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c7p8MysdDuh7IMQkQ+063sPhCrY4RFITEay/wtusJ2U=;
        b=JPFEqw8wKxEqSum6mmJuLJcG4jrP2pUQ6+5RJfKi6tvyn9SvbEK1IgHl/gLd/RHpuJ
         pXQGmgYCxHJDS1YHZ+HMre+eXzN70cF/GPh+ETMRSho1yRmmPXeIsuE5+eXGB+KRFSOs
         47SXy4JlJSX1PY5cbAE0yHzoO1nGxwAU4paKuTJti9LDzwL0S4KGqEwrr+OwjqWBTqCg
         5rb7YFgiXXCwIkZFebdJbsV3SQZW1dz84PmMSaan81/fVELm9djPjGhUOf9Q/9Duafdo
         nhBTh2p/IK9ulNMvWVlTidMtpUFNxi1ua0L4lTtCkDKTwDOMpQh6wPY30ExmVgJnddCf
         RwXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c7p8MysdDuh7IMQkQ+063sPhCrY4RFITEay/wtusJ2U=;
        b=H909ht0WNdWmueahNBEomQRCMOxY3t7WU41KrkGKpqcUaTWU2GV8Y1bbK0+76xVJw1
         hwUQn3Zh7kX2q8dj+wRcXatpzj/2bXUyl4SyypQLQqGlene3CfbkzRiPBMtHxtZUaP2e
         IlbAHBuOdvlgE3ZYJaiGxvX/kaTxRRQZh8iWYAYKQnFVQOhlgige+Xjk8uCpEhqiGQ4z
         uMsOqCjQDtzqawNgeIYQIgO1GEzeP7qwGuK6o/aWXUv3EJAS2mskSBcHZF6Hmw43KHeA
         DwpKjy+w6bNV1f6pR5FyHLoec0Z7f0pQOdWVprrilp0S3lYLA+Rqa2nbvTLDAmn443rx
         kcaA==
X-Gm-Message-State: AGi0Puag2VrAU9f+YeBNeOlmbj44w9Nc1WSySUn1nunpUSobWNdjHCD6
        KnTFL1ySB5dfvbtZL6hoereHaA+LfA==
X-Google-Smtp-Source: APiQypJv3+uzff3F0r0obQE5h3bvrzCKTrEZGxelkvSt/Wp774j1YeWtu+BkE7bRKbMIPpkki1T8OA==
X-Received: by 2002:a1c:7215:: with SMTP id n21mr703832wmc.2.1585687632527;
        Tue, 31 Mar 2020 13:47:12 -0700 (PDT)
Received: from ninjahost.lan (host-92-23-85-227.as13285.net. [92.23.85.227])
        by smtp.gmail.com with ESMTPSA id o9sm28335491wrx.48.2020.03.31.13.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 13:47:12 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     boqun.feng@gmail.com, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org (open list:FSNOTIFY: FILESYSTEM
        NOTIFICATION INFRASTRUCTURE)
Subject: [PATCH 2/7] fsnotify: Add missing annotation for fsnotify_finish_user_wait()
Date:   Tue, 31 Mar 2020 21:46:38 +0100
Message-Id: <20200331204643.11262-3-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200331204643.11262-1-jbi.octave@gmail.com>
References: <0/7>
 <20200331204643.11262-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports a warning at fsnotify_finish_user_wait()

warning: context imbalance in fsnotify_finish_user_wait()
	- wrong count at exit

The root cause is the missing annotation at fsnotify_finish_user_wait()
Add the missing __acquires(&fsnotify_mark_srcu) annotation.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 fs/notify/mark.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index 1d96216dffd1..44fea637bb02 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -350,6 +350,7 @@ bool fsnotify_prepare_user_wait(struct fsnotify_iter_info *iter_info)
 }
 
 void fsnotify_finish_user_wait(struct fsnotify_iter_info *iter_info)
+	__acquires(&fsnotify_mark_srcu)
 {
 	int type;
 
-- 
2.24.1

