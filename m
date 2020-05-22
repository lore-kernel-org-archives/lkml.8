Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BB2C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 20:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BD3520723
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 20:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="dDUvxjbs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731161AbgEVUX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 16:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731017AbgEVUX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 16:23:26 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C38C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 13:23:26 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id q24so5460520pjd.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 13:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7SUIxRwptQ6YWj2W/l7Dp7FzKmS+sjQ+qLVh2r/v7CQ=;
        b=dDUvxjbstbHn7Sjiy+FPAA2PEvxIM7GifOiRJeDAMSbY7yuZnnZssNPrW/E901JJmZ
         OiWeE8x8Dullp8KQX0tfScd3zLgJ5dqFDExo65YjCoSluEuUiua3jP++fR5YzUqru8zI
         NXVTSEKuAtwrG/ZRrJptiR6rdkUh3s0gV2rnNOuBXEHCRFP2f7G+O6Kd7xTEzLo5d7O6
         1kKmpbdn46318RaR3RoKDqSBHERhxohD2GZV8Ws+IOrzVKyuazrQVmIYmUbQkjczdFs6
         4tMUI5bcGqqrmfzKTUnEqt1xwSLASC838o8d/OH5NWXSrzKDy3ZhjDyXw5k2B4zWiXIr
         qkJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7SUIxRwptQ6YWj2W/l7Dp7FzKmS+sjQ+qLVh2r/v7CQ=;
        b=TSyVzoh9Fb3NoQdPl3Um/TNVUnMzkq33/rp5TNJdmNc60CusQKIod5memkX8WF9D8h
         hdCYKUJ4uuWtAhTPA1vweMY19zfU/iWT5XcUOh/eUacLBr4SsrAtqPjt5XbrG8kGFPLN
         HPxngv1aGhoS9N0/at1wHDDo436L/cOagggo5eE/Yn4g1TyIF8sJY++h1iEnCYLZAvWC
         23s2O2WgqOd3eoUWfTshJVaNhmnCyJgioh5kVqdsP2hJS/AuzMsG040bY7si/2FTnw6E
         yGhdhzDLfsjMCdW1V7groa1clZT7OhvAEBd/RDYz8qCRiV0MAUR/eI0/d8ho/xV3eojn
         XcmQ==
X-Gm-Message-State: AOAM530zTialuv73FM15lSmrvTahGkulmmLjwXvMIixzpBKqzEebT357
        wGUmy2r9HIJGCW5gW4IGjzZ4OTo5Grs=
X-Google-Smtp-Source: ABdhPJxHHV8hqa7uaJgKGvaQpHrwfQ3OD8pDgEG5RnHU/xBhEFUUXMnZAbPdGq2y0/Mjy8qPwsjM7w==
X-Received: by 2002:a17:902:b907:: with SMTP id bf7mr16387892plb.136.1590179005767;
        Fri, 22 May 2020 13:23:25 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:e0db:da55:b0a4:601])
        by smtp.gmail.com with ESMTPSA id e19sm7295561pfn.17.2020.05.22.13.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 13:23:25 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 06/11] ext4: flag as supporting buffered async reads
Date:   Fri, 22 May 2020 14:23:06 -0600
Message-Id: <20200522202311.10959-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200522202311.10959-1-axboe@kernel.dk>
References: <20200522202311.10959-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/ext4/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 0d624250a62b..9f7d9bf427b4 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -826,7 +826,7 @@ static int ext4_file_open(struct inode * inode, struct file * filp)
 			return ret;
 	}
 
-	filp->f_mode |= FMODE_NOWAIT;
+	filp->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC;
 	return dquot_file_open(inode, filp);
 }
 
-- 
2.26.2

