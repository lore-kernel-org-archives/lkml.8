Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC5BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FD2620738
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597685957;
	bh=D16BKy0lMAy9jb1AgkZenCiQTSco08fFLlYh9bODH3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VgllYrEUpY1bbVFGMwGTSgrzyxnCpwZZ98Of/ydLeoRFwKhuLNCQo3ITW9+XdSN09
	 X8wUeDguvhLgeZhTN6qSYOg4DgjuXdPj3p33rJPojTbiS2/Tz6t1BJze6xhUKOYpvv
	 Yq7N645xcaDLPKXuBot7HRshbYLTVblSndFiA1ZE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388763AbgHQRjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:39:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:54148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731138AbgHQQRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:17:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DC7420825;
        Mon, 17 Aug 2020 16:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597681028;
        bh=D16BKy0lMAy9jb1AgkZenCiQTSco08fFLlYh9bODH3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KqG9cMGLakKbsYNEF60cO326mUc9zbePk/Jk1Oxtgwq/Zeur1a7aBK5fJjIb63GyN
         t+SF/S7MRnIS2CtozmbYK4c1QxU7puDyhOtH31f5WOBp2M7zN+5WtbAulx3w66nEUc
         w2AARPBhxZaUMHusfgyETnnXHi/nyY5CrxwvXmZU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zheng Bin <zhengbin13@huawei.com>,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH 4.19 154/168] 9p: Fix memory leak in v9fs_mount
Date:   Mon, 17 Aug 2020 17:18:05 +0200
Message-Id: <20200817143741.356365865@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143733.692105228@linuxfoundation.org>
References: <20200817143733.692105228@linuxfoundation.org>
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
@@ -515,10 +515,9 @@ void v9fs_session_close(struct v9fs_sess
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


