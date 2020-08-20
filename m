Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61B6C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A002F207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597924167;
	bh=bVvddrK+qoU01hUbXwqrKFPxQVIC31GFgroVKcw9PwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LabCO4Od30JBrv9RDfLU9iwu+ALUwhHFcZ0kjUUnIqyVrTOOrXEZyOEp+eRaqCS1p
	 jqY0bTFh20epWp3qvnX2dw/wzTC1Iy7gSSr1if9/ekNWnHejK99UQ46hN8x6Bhi5Q3
	 ikmpv5szHZmqL164RrjiHmfISQp8BYBAdKs2yQKQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730755AbgHTLtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:49:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:56738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730342AbgHTKDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:03:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEEB422BED;
        Thu, 20 Aug 2020 10:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917825;
        bh=bVvddrK+qoU01hUbXwqrKFPxQVIC31GFgroVKcw9PwE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bg4nfh1O6fPkUP0ueIZJDSonq+ZGIOVn7NI0I33gPAHD+gR7twQA1ICV4/C9YGpfA
         qxairE6BRfY1dXAnFrL8jj7B9QXCUoATlFPX5NTTPpk/c0qv030HIKIOO39lGMpb/e
         BHemHSXK5XkNAiOi5bi7vw37nlF+VXZMQalSYu1g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zheng Bin <zhengbin13@huawei.com>,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH 4.9 164/212] 9p: Fix memory leak in v9fs_mount
Date:   Thu, 20 Aug 2020 11:22:17 +0200
Message-Id: <20200820091610.685184882@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091602.251285210@linuxfoundation.org>
References: <20200820091602.251285210@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zheng Bin <zhengbin13@huawei.com>

commit cb0aae0e31c632c407a2cab4307be85a001d4d98 upstream.

v9fs_mount
  v9fs_session_init
    v9fs_cache_session_get_cookie
      v9fs_random_cachetag                     -->alloc cachetag
      v9ses->fscache = fscache_acquire_cookie  -->maybe NULL
  sb = sget                                    -->fail, goto clunk
clunk_fid:
  v9fs_session_close
    if (v9ses->fscache)                        -->NULL
      kfree(v9ses->cachetag)

Thus memleak happens.

Link: http://lkml.kernel.org/r/20200615012153.89538-1-zhengbin13@huawei.com
Fixes: 60e78d2c993e ("9p: Add fscache support to 9p")
Cc: <stable@vger.kernel.org> # v2.6.32+
Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/9p/v9fs.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -457,10 +457,9 @@ void v9fs_session_close(struct v9fs_sess
 	}
 
 #ifdef CONFIG_9P_FSCACHE
-	if (v9ses->fscache) {
+	if (v9ses->fscache)
 		v9fs_cache_session_put_cookie(v9ses);
-		kfree(v9ses->cachetag);
-	}
+	kfree(v9ses->cachetag);
 #endif
 	kfree(v9ses->uname);
 	kfree(v9ses->aname);


