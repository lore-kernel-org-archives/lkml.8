Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C22DC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 09:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10C092074A
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 09:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAvigIBG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbgEaJTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 05:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgEaJS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 05:18:59 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B6DC061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 02:18:58 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id u26so9905776wmn.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 02:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3LV+Def1c7T48ZEneRWvSMkP3WD/su3mbckNwtB8Qdo=;
        b=EAvigIBGYEjOeLH0Mzn2G2eCzmfNfnX+Vvk0fDFDMdDXude50AJxuihlltZ6i0Hb/T
         EtUPDbYvZiWDVoAmuLyEYRMrhd10C/rs1Xd8VUs7lx78Isfdsxk7TP2xlUuF/XGxAquQ
         Ru58g/HdDAIhsr5WPzTWHc4LRcIwTwbOiHkg6KDmjU5UiySXtZ1y0xH43Jw1bobyqGU4
         TPgTCI+p9VNEItkwHB6t93SQVcwJ4KIpykcAVOBV+LsrMZxrL7wUdAphN1zj3f+NFu4+
         p6zhcGeUTnMiH6PTGG9adfyHW6hIieDd/CobJxs0gGxGHNmJYN23tbbHCvThQepxyIyH
         eHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3LV+Def1c7T48ZEneRWvSMkP3WD/su3mbckNwtB8Qdo=;
        b=idzUryLbyZ6eA+67V5ksgs8di0ofbP4d7CWtTdl02ss5YdxOktAeFF/+1SL1r3ySHW
         7ko1XVSFafHTq5s1sQtcU7JV4JSGbqhaEUfvF2V+oBq+8s6drzK34oEvP3QdRIIKykep
         IqquEoHnR3CP4+7A1BREW7nW1mb4QQlcTS9m0UWIxwFDk2QdvciXMGvWpPn4eP5i7IgD
         JWo//8cI+lNVmEGMtVVSVFAKcSexRYvM5ycYeXtPxkv78e5bEl6sUQuiBAtSumbzgZBI
         e3oJO69ka3/zy9Zp3mHg5NbGpcenzIcmt9hoPcRFeqUcWcWSi483v/kWjWCUMIwpGGzy
         WG4w==
X-Gm-Message-State: AOAM531DA74CD73UOi8Cd4dwRwQzgPsW4ahU9zWk6uOSrHNgD05syrdV
        DEiQ6M5GEwoqeWUwp0dIDJrD1I2W
X-Google-Smtp-Source: ABdhPJzcSk2OgYt3PYr5ORjPjX+8GKPq8Jw9faIgurfMidgxFiP9ULcIHK6aRPtT3omnTPJMRU7iNw==
X-Received: by 2002:a1c:3281:: with SMTP id y123mr16565627wmy.30.1590916736523;
        Sun, 31 May 2020 02:18:56 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id s2sm6411867wmh.11.2020.05.31.02.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2020 02:18:55 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH] habanalabs: correctly cast u64 to void*
Date:   Sun, 31 May 2020 12:15:47 +0300
Message-Id: <20200531091547.6868-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the u64_to_user_ptr(x) kernel macro to correctly cast u64 to void*

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/command_submission.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/command_submission.c b/drivers/misc/habanalabs/command_submission.c
index 75d8302352e5..f82974a916c3 100644
--- a/drivers/misc/habanalabs/command_submission.c
+++ b/drivers/misc/habanalabs/command_submission.c
@@ -789,7 +789,7 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 		size_to_copy = chunk->num_signal_seq_arr *
 				sizeof(*signal_seq_arr);
 		if (copy_from_user(signal_seq_arr,
-					(void __user *) chunk->signal_seq_arr,
+					u64_to_user_ptr(chunk->signal_seq_arr),
 					size_to_copy)) {
 			dev_err(hdev->dev,
 				"Failed to copy signal seq array from user\n");
-- 
2.17.1

