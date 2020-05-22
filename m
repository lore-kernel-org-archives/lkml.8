Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBDDC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 20:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6129020759
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 20:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="jrTkj5mN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731095AbgEVUXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 16:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731060AbgEVUXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 16:23:25 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C04C08C5C1
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 13:23:25 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id q16so4832545plr.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 13:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+VWs0Nj9WGghWnCOq/fSx5SIRlxQxiE9MXDVdkqYQzM=;
        b=jrTkj5mNE8rkwflBEeAmIyb8Qnj27z1yhUum3fkVIs00PTWv5KrHY1A5uxtAVi65oK
         sOFOAmMe4Gijz004PQKYcIsCxcGM8MEtjGr0pk5W7S5Os5B7IeWfCmo12ZhXpV02UTQ8
         NMWc32YYKiWXGBAXH68HZNtHCu+Opp2BtHSGYWjZOKcBXiW9cHxFRzCOMyky4/0vjdMn
         5y35f5bHYq9Jg1W8nnVsoOeuzdArBHrHCpynV8TZM5GAjCe8erOkISRTfBQRsoiIsbpk
         A9dSOn4joSJzn6Jw8G+n53yZzeJQBQPsAlw9IQ8Jvjm9ct8cpyOb8gJwVVUsi/r/HQXI
         cDig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+VWs0Nj9WGghWnCOq/fSx5SIRlxQxiE9MXDVdkqYQzM=;
        b=NfvlATdUNyFqfXQYkEc8Z5Ud+5u20wZ014OurPOlF8oXw9dh5268+o0MGPG8p+mRni
         MON9FyKfn+qmfZtV2Q8ACZ0QVtaLDA3YZE6kk9Ai+W7yimrHdMoLo20BiVKNJiR4/Of0
         cvu5GKz5EmOQihDlYuKX5awaO7Ty50nerO57DKFmVXX6FUofNb6ILRejcQVtEyx1e/6r
         52vlbm9L88FSZ8vt+tBzSgrlMlbC2kTP13mAI+NIcoEw98JY6Ya75gXSslp1R/X52ORG
         GeSMLb+OGbcbFu124HxPNicn/IHWw01cgEc7v132G+4kDJLdf0Q0K1pdOC+b56bYy0Zy
         da1w==
X-Gm-Message-State: AOAM530u3M34EzdO8JysO3wA4AV8SEm6nttFmyms3g0ecN1vcH24FXu4
        Gk/wmsdWuUEu8FnBghgdR9aTag==
X-Google-Smtp-Source: ABdhPJyfk1Fi4CeJavhhm5jD+udLfDiANFaIVbhg/UeDmfEmwZxENiHETpIQtctD6WObNUCaWgH+4A==
X-Received: by 2002:a17:90b:1082:: with SMTP id gj2mr6812346pjb.225.1590179004516;
        Fri, 22 May 2020 13:23:24 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:e0db:da55:b0a4:601])
        by smtp.gmail.com with ESMTPSA id e19sm7295561pfn.17.2020.05.22.13.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 13:23:24 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 05/11] fs: add FMODE_BUF_RASYNC
Date:   Fri, 22 May 2020 14:23:05 -0600
Message-Id: <20200522202311.10959-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200522202311.10959-1-axboe@kernel.dk>
References: <20200522202311.10959-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If set, this indicates that the file system supports IOCB_WAITQ for
buffered reads.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/fs.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 82b989695ab9..0ef5f5973b1c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -175,6 +175,9 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 /* File does not contribute to nr_files count */
 #define FMODE_NOACCOUNT		((__force fmode_t)0x20000000)
 
+/* File supports async buffered reads */
+#define FMODE_BUF_RASYNC	((__force fmode_t)0x40000000)
+
 /*
  * Flag for rw_copy_check_uvector and compat_rw_copy_check_uvector
  * that indicates that they should check the contents of the iovec are
-- 
2.26.2

