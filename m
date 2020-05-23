Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF692C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 18:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4B4C20735
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 18:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="asMd1oaZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387867AbgEWS6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 14:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728825AbgEWS6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 14:58:08 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7804C061A0E
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 11:58:08 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id k7so6441368pjs.5
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 11:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7SUIxRwptQ6YWj2W/l7Dp7FzKmS+sjQ+qLVh2r/v7CQ=;
        b=asMd1oaZIyB4OBJhuDDS6Qm6IETRfR3fCCxP9jAEJSZo3FYau0gIpI9b/WsuE4N1KX
         RhGUBNuuUrL+ZAlmaNkDbor8+W1ob/cE5h/o3evKIKCN9RWGAgjkY9nVj4AsDXFEOxvN
         jC7XVMjV1it0HHmhL0OxZuSDp/Abrk9rCOqaJil6/D6M7OiW2AtqylxkNCV9an6DjayG
         vOHDb15eEsnEy1dDiJMsIiXcTlcRPgEl8h11Wp/ZpqB/5F1uv0rEg/I9CQ+o05PMPjC4
         Y320pJtBGjmXFef+eP+mcAHwtpvSBcWWOC2sJdIvszbOHJlfXMWF9y09acccBUgWfqzA
         3Y1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7SUIxRwptQ6YWj2W/l7Dp7FzKmS+sjQ+qLVh2r/v7CQ=;
        b=TuJ0bEAyXkWpNgEDc6dhCLdqDKtW1LDh5h+FlxggmgV1SEgy0SIy5x+vl2vxEGvuGA
         vE9VT+dqwygHgYnI86NK6LnMSKfjoxw0fGP4RmGz/NJnCeNR4eMfuZV0v6wLt0koszog
         c/F5g8HW7AGEAcVJwPqS5W8ZWr1kDwN7UOU9RHhTOrcvq7fZKtZyVD4KWA3waB2JqU43
         0ghz0y9O307IZkRDHRrPQplKeM0rC3ilBR4A8I/a+H7vwjjoLisFeeyELUl/OwAXoIfD
         DmylTQ1S06R9EtB0PJrWRfvzgoieeA0qT/Hl83TO1eTfiK9zlwl9I4oY03Wr5jl+6y8c
         3gOA==
X-Gm-Message-State: AOAM530eePK7Ykpxd6yjb0PENTwnMsAp28KuM2XphJ03GNPheiAVsxQ9
        aMVy67pW8FNIU5I0bvXz3ic+4g==
X-Google-Smtp-Source: ABdhPJxN9tF6/2bYMLjdUOX4WlnRkytgiqQRjaUtCQS8ug7GAw+E2pO4OMfyhBqrcqoO8mwzIxyTZw==
X-Received: by 2002:a17:902:b718:: with SMTP id d24mr6737530pls.185.1590260288366;
        Sat, 23 May 2020 11:58:08 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:c94:a67a:9209:cf5f])
        by smtp.gmail.com with ESMTPSA id 25sm9297319pjk.50.2020.05.23.11.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 11:58:07 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 07/12] ext4: flag as supporting buffered async reads
Date:   Sat, 23 May 2020 12:57:50 -0600
Message-Id: <20200523185755.8494-8-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523185755.8494-1-axboe@kernel.dk>
References: <20200523185755.8494-1-axboe@kernel.dk>
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

