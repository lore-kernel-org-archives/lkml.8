Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08F6C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 22:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E0992087D
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 22:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soccasys-com.20150623.gappssmtp.com header.i=@soccasys-com.20150623.gappssmtp.com header.b="oLADBgnj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbgIHWMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 18:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbgIHWM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 18:12:26 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B12C061755
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 15:12:25 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id c18so777388wrm.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 15:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soccasys-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=Yx17u9qpzHjKXdddvmUYSRQrMmaNoxSWhGBQhqpFmk0=;
        b=oLADBgnjoVmV6RwXVbieDzvcU+U0SEUp8NZ/eXkkGGraCNioe70tSLaBf7HWC8cyxb
         SQQLyCOD314QepA3Vm5coRMjROPINmUbB9UflL2GnBKL7Dhq7Rh9SG6pQj2lqeHHC/sM
         /xgNLZc/a92eXsjEWQWwcDFfcmL21omAG0m/cVU5rYMDU/bQhEKMu9Uh6M3CitffuTne
         m1SMBTG8yj7cssazpGu1IXAoZ/VmqZ0M8VRfSweJXIytsV/QECgtoQZeFLRj8olzWMlj
         xBU/Y0wRRBgCoQv1pypBvRHqvudVbJIGEXgg+y65poe9jUyn9vR5AQ9qgWZII5PZDwWR
         RKoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Yx17u9qpzHjKXdddvmUYSRQrMmaNoxSWhGBQhqpFmk0=;
        b=XGHvCo2iVjIM3sLKVRmPLXW9u1J8NhyYZMCOdnPS3vsyvZ0yJB8Q09w5Oragiiw5Ci
         BxF+V7qwB8dhjDQdjp9Zx52v3EOUkMaS3p2LZQA63F8tFIbxsEIXWIzGMtO7ZPHBkeFA
         DD7NAVGEt4AJn97y9fmnWUbw8gDbD5cQJ9JXndPI99Qaw4BdCJPiM998A40ziPO+C+3K
         yemR3XEICMooOW09eV3PmbLUHX0RFxpjS59Ep9Q8U7wTum2kQ+VYBdpWUT7wrvW3WuGf
         G3nkK415mAwSpYZijhAY+T2AO5KRp9NMHZHz/+LdwWOJhoz8o75da1fbT8xIgm8WPTsZ
         b2Hw==
X-Gm-Message-State: AOAM530sFDp85wSMLhWgIuxhsJ+mZl5BC1JhPekysvLFqfXF/xO4vLEx
        mn2uGaZBJWFUhWqug/gjrjL4IQ==
X-Google-Smtp-Source: ABdhPJwjQpZuIO9uEr+brI9ofYlkDhuLz2JkNZfKSxvE14S3sakef7+J6ll+sTBv+0fTx3AY45pj/g==
X-Received: by 2002:adf:f24f:: with SMTP id b15mr592629wrp.301.1599603144142;
        Tue, 08 Sep 2020 15:12:24 -0700 (PDT)
Received: from apollo.nxp.com (lns-bzn-61-82-250-74-98.adsl.proxad.net. [82.250.74.98])
        by smtp.gmail.com with ESMTPSA id l10sm1051295wru.59.2020.09.08.15.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 15:12:23 -0700 (PDT)
From:   Laurent Gauthier <laurent.gauthier@soccasys.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     laurent.gauthier@soccasys.com
Subject: [PATCH] HID: hid-debug: fix nonblocking read semantics wrt EIO/ERESTARTSYS
Date:   Wed,  9 Sep 2020 00:11:49 +0200
Message-Id: <20200908221149.8986-1-laurent.gauthier@soccasys.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the file has been open in non-blocking mode, EIO or ERESTARTSYS
would never be returned even if they should (for example when device
has been unplugged, you want EIO and not EAGAIN to be returned).

Move the O_NONBLOCK check after other checks have been performed.

Based on similar to patches hidraw and hiddev by Founder Fang
<founder.fang@gmail.com> and Jiri Kosina <jkosina@suse.cz>.

Signed-off-by: Laurent Gauthier <laurent.gauthier@soccasys.com>
---
 drivers/hid/hid-debug.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index 9453147d020d..d7eaf9100370 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -1101,11 +1101,6 @@ static ssize_t hid_debug_events_read(struct file *file, char __user *buffer,
 		set_current_state(TASK_INTERRUPTIBLE);
 
 		while (kfifo_is_empty(&list->hid_debug_fifo)) {
-			if (file->f_flags & O_NONBLOCK) {
-				ret = -EAGAIN;
-				break;
-			}
-
 			if (signal_pending(current)) {
 				ret = -ERESTARTSYS;
 				break;
@@ -1122,6 +1117,11 @@ static ssize_t hid_debug_events_read(struct file *file, char __user *buffer,
 				goto out;
 			}
 
+			if (file->f_flags & O_NONBLOCK) {
+				ret = -EAGAIN;
+				break;
+			}
+
 			/* allow O_NONBLOCK from other threads */
 			mutex_unlock(&list->read_mutex);
 			schedule();
-- 
2.17.1

