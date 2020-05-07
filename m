Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE016C35280
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 23:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD76E20735
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 23:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588895846;
	bh=PDyygbnoFMpW7tBzZiOkHHNlA1bCTf+Cdlqi+WhL6QY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g7yLGpNNqJIUVbKD2yFD3LRCjZt/iZLB7PkTkJaILXS7NymcWG20sZm9Ox4RYMhH2
	 xaJnU/fkAy+t0T0Om7Arg9ynWFN/02X3mSTRauNXFUCUBP1Wx3iPk1kt8LsxfMkFhz
	 nLCqIby+FgkX5enkvAjnR5ZR16E9YNqPHOZU634Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgEGX5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 19:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727082AbgEGX5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 19:57:18 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14546C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 16:57:18 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id x2so2525668ilp.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 16:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8YERqo/O0CpgSp6GICUF3/1ifgurCUdYJLrnvIdN1x8=;
        b=SYWQJ+YCPO+1BQsW1dytD0nYU7twT//urz+z/iwpvLCo7DTZxbH8ItmxKrLc9qdYKg
         vchJc/AR5zkgXz7tVhtJgTzpxm3klLYK11xHodMifgBsaH9S2RBP9RiaBDbJae5INVSy
         GhkdUNocSR4HsxMBxvtyK/CQR/j60P9DzTuD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8YERqo/O0CpgSp6GICUF3/1ifgurCUdYJLrnvIdN1x8=;
        b=R84HYYqlH1woAcZhFpVXsrRSf98uaSFeymzsjfHEnYVpk1l98/AWNQ9Xggp0TJ0iYg
         2Sr1+2jWrG+pqH+OmG/wJrGt7AnJ69Fmk6P6sF0U4PnZXVQGiTGoWlAVSYwgjTV2T6i9
         zhNc3iEViv62ep/DetsbeZl1LAmLo8WuouqTR1iwB16X1izdjDf6RO1XOxqkWKdi284z
         wWS67s0C+uesA6Xhi1mMDwk9yrHMXiptF/c4oO/L/MI8P5iVZwIvaZJHV6WRmOLjCwP4
         UEFprir4dMQy/EKtEjCKMp+AUxhiDc3QTo3iYB5/dpcV72qotqde/MXm/J2vVy3SlEoV
         eWjw==
X-Gm-Message-State: AGi0PuY5vw6DBaMua4Eec1Ck4+c07W5mFN/aXEfFLVJP1P3V8ccFgOGZ
        3HrBExNzO/9Rk4B9st3JQfiLGQ==
X-Google-Smtp-Source: APiQypKqHlNwMSQC9E2pjfwDU94VGlthfw04mg7vAiNxP1abahKSR5sOWkaEYm0byD44ICMxpXsFSw==
X-Received: by 2002:a92:d801:: with SMTP id y1mr17212948ilm.308.1588895837458;
        Thu, 07 May 2020 16:57:17 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f19sm1369893ioc.9.2020.05.07.16.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 16:57:17 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     viro@zeniv.linux.org.uk, axboe@kernel.dk, zohar@linux.vnet.ibm.com,
        mcgrof@kernel.org, keescook@chromium.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] fs: avoid fdput() after failed fdget() in kernel_read_file_from_fd()
Date:   Thu,  7 May 2020 17:57:10 -0600
Message-Id: <8b2cec548ea7f3b156038873b37bc24084a689ad.1588894359.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1588894359.git.skhan@linuxfoundation.org>
References: <cover.1588894359.git.skhan@linuxfoundation.org>
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
 fs/exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index 06b4c550af5d..ea24bdce939d 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1021,8 +1021,8 @@ int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
 		goto out;
 
 	ret = kernel_read_file(f.file, buf, size, max_size, id);
-out:
 	fdput(f);
+out:
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kernel_read_file_from_fd);
-- 
2.20.1

