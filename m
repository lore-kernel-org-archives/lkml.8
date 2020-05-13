Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53280C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 23:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58A2A20659
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 23:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589412813;
	bh=o4SffnyBQtJYzmelvm+jWmTeQeY3ikObh+hvX3njdKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1/Tcw3VyiNSWrmqoIoOnEmVwjqyEwaI+U6GJBTdAZRG+krLGlFJKcsH4Y5wXRCpo/
	 1Lxx0TtDE76D4DAPLCqR1rUKGMEj+iJk76R4X1/V8KUh/Xo4dDjRsk29/wX3Xt1kuc
	 IvfomC7sz3PGIqve9J2imqzfR/9x9Kbgrw8FQB2w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732712AbgEMXdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 19:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732686AbgEMXd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 19:33:26 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417D7C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 16:33:26 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id b18so1505517ilf.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 16:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rUaoIVjv4yJVbgEJs+kFc4h5MmRY+QZnwp3EBlQupL0=;
        b=AOn02sBOw6rI0NNLd1GC3BYjmQUvTLcSjrXTztEWRq4Mny7gHvSQOuXcwhB1DG1zIK
         LmPDcv1PHxtRSmYDIijCw9gFwewYx+4zHXeb/92tPn+NLTkDe2hv3JoOuj5gSt0U/HAW
         nx7JRGerb5+ePP9ev2iBS9ORAjzvvAougqm0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rUaoIVjv4yJVbgEJs+kFc4h5MmRY+QZnwp3EBlQupL0=;
        b=hdTMKLgXgMw6VAUSCcXwgbcvvgNCAWk5OLO2LrzSMTt67dm7eTUE6W83027yiWAgxk
         FASc2UvM+SsBIIdL4iqpQb7j6vf7Dfl0lbkZbPLrdj1Jw4yqZ9O7cVM9Y03+RqhQ3S4w
         KN+fjjUZWU0PkbmqMroLiGzeK60UWu34hbcZivHqggiXYmsWepFeii4NtW63FA73lXYr
         18LqROWWzb2YL8BPexV+98bAx8Rhc5nD74QgDsBvccqut3AX0JX1zMDLKm7XBca/0GhW
         64ZbBfxQWncrx/40sFcG9OzP8LcFlJBLFSlk4jzXtwd2S7ApkYdgtnqAAEoJawRHG8nv
         h91w==
X-Gm-Message-State: AOAM531BvN+fx84poiKIZF8Y1uLXEEYVdKZl72rdffqha4zC5xTXbUIn
        wqyeRGWrGhMt8LrTXTQHyrHxgA==
X-Google-Smtp-Source: ABdhPJynTVyMUoEORJzVp73FPhPB3uH0FFgzNgJAcDr5KLrfmAGEm4I66Y+wJYXBhHODi+pkS0ENQw==
X-Received: by 2002:a92:d186:: with SMTP id z6mr1906821ilz.119.1589412805697;
        Wed, 13 May 2020 16:33:25 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id b1sm398072ilr.23.2020.05.13.16.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 16:33:25 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     viro@zeniv.linux.org.uk, axboe@kernel.dk, zohar@linux.vnet.ibm.com,
        mcgrof@kernel.org, keescook@chromium.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] fs: avoid fdput() after failed fdget() in kernel_read_file_from_fd()
Date:   Wed, 13 May 2020 17:33:21 -0600
Message-Id: <62659de2dbf32e8c05cff7fe09f6efd24cfaf445.1589411496.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1589411496.git.skhan@linuxfoundation.org>
References: <cover.1589411496.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix kernel_read_file_from_fd() to avoid fdput() after a failed fdget().
fdput() doesn't do fput() on this file since FDPUT_FPUT isn't set
in fd.flags. Fix it anyway since failed fdget() doesn't require
a fdput().

This was introduced in a commit that added kernel_read_file_from_fd() as
a wrapper for the VFS common kernel_read_file().

Fixes: b844f0ecbc56 ("vfs: define kernel_copy_file_from_fd()")
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 fs/exec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 06b4c550af5d..16a3d3192d6a 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1015,14 +1015,14 @@ int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
 			     enum kernel_read_file_id id)
 {
 	struct fd f = fdget(fd);
-	int ret = -EBADF;
+	int ret;
 
 	if (!f.file)
-		goto out;
+		return -EBADF;
 
 	ret = kernel_read_file(f.file, buf, size, max_size, id);
-out:
 	fdput(f);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kernel_read_file_from_fd);
-- 
2.25.1

