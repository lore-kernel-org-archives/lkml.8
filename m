Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBD0C35280
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 23:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CDCE20735
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 23:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588895843;
	bh=8qfQLw31FShD88rQMGySezZ3vGjAxDMEECPZlWfb3eU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1dICClv3PYrFnbcrNjZ/4tpKBK8FUI2s8OYTVguNHvGuprPkwiFFLTebKZW8mLg2C
	 gv1nEwmmFIGEUGua2wDee73siGyEHps9XzSma+eah05tvHmompNrbqHka/afXCoYHr
	 7gFiV9kNqFU6iyGsc2u8uNd+FhcUThrbP5zFmSDc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgEGX5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 19:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727032AbgEGX5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 19:57:16 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F824C05BD0A
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 16:57:16 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id w6so2656947ilg.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 16:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9TwK4u8Oz+hIVdTAgPTDuNePQX/j9l3iXT78dNtrMzA=;
        b=GSWVCbnYftAggwrWtoofsSVg5KaUUx2c+wWZgyeyBk1u+bCb7nxD9dpZldsclYDu5C
         nX1TB/LfcQ2XeDdI0qzxstB5mqAimi/zyMyP3HLAMdDhpbNd/70j/59+8IbGuIx9uN8x
         mxnl8V6RelTgjF2xQzdPohrldstjbm0beUwI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9TwK4u8Oz+hIVdTAgPTDuNePQX/j9l3iXT78dNtrMzA=;
        b=s70z12XlR0225Tu+fMOfEoZjFOsBMsmrPTA2RJYKLM3surlSRmqSSAFvildsl5BJXM
         prRiXpIQdgvr/rk6sfzTO0EZoAbQwlhTx4ozkVqWfwUko8eKb5ttdG7BQh0K9295sHgC
         oKvglsqb8ALpGRColqJITzm8CqNQ9JUwDgLyLKNEN8yNzt32RPHt3u0kzJX7XP5n+slT
         d0EABtTfCgtJ7Db9VgtQm30q7h4VZKxLrUoBIGmF14GL8BdYPKTa0nI1q8lIq5zdspMb
         lJoYCm81NdENSIiYZ8motJk5n6O8zFuV3/Hm/JmZpD0wJ31ANAzS4SZokr+pQv6GHxC0
         auYg==
X-Gm-Message-State: AGi0PuaPXsJmojCBoilGR+eKnVc4X/k4/OUzbPQR4Tod3h+VmtAHuBP3
        Q6o6W4/x91gGBe8b4a1QNpeXcW8ychw=
X-Google-Smtp-Source: APiQypJBM1xuTwXEsrDaqEq1u3eTWKXejiZiCER3XjowknHOSmHpGwOENdMMt20RM9A8e6EAv2euKA==
X-Received: by 2002:a92:607:: with SMTP id x7mr15916103ilg.218.1588895835927;
        Thu, 07 May 2020 16:57:15 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f19sm1369893ioc.9.2020.05.07.16.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 16:57:15 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     viro@zeniv.linux.org.uk, axboe@kernel.dk, zohar@linux.vnet.ibm.com,
        mcgrof@kernel.org, keescook@chromium.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] fs: avoid fdput() after failed fdget() in ksys_sync_file_range()
Date:   Thu,  7 May 2020 17:57:09 -0600
Message-Id: <31be6e0896eba59c06eb9d3d137b214f7220cc53.1588894359.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1588894359.git.skhan@linuxfoundation.org>
References: <cover.1588894359.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix ksys_sync_file_range() to avoid fdput() after a failed fdget().
fdput() doesn't do fput() on this file since FDPUT_FPUT isn't set
in fd.flags. Fix it anyway since failed fdget() doesn't require
a fdput().

This was introdcued in a commit to add sync_file_range() helper.

Fixes: 22f96b3808c1 ("fs: add sync_file_range() helper")
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 fs/sync.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/sync.c b/fs/sync.c
index 4d1ff010bc5a..faaff835ef12 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -369,10 +369,11 @@ int ksys_sync_file_range(int fd, loff_t offset, loff_t nbytes,
 
 	ret = -EBADF;
 	f = fdget(fd);
-	if (f.file)
+	if (f.file) {
 		ret = sync_file_range(f.file, offset, nbytes, flags);
+		fdput(f);
+	}
 
-	fdput(f);
 	return ret;
 }
 
-- 
2.20.1

