Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B6AC433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A9A320786
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597692106;
	bh=HWpxdmjKCO69zPhrgx75MpXgrFO+tbzvwbdJu6VUjCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AtTj1sLHhGn9EBWwAt0HOuAdzzFJBKxbjLdLS2/rTYXxw1t91IQDyefMwtcW/8tkL
	 w6yZyL0W5ofRttv9SDcT2RuA9/5mKW8SJCOo7EKEAHo1L3J8d6sFTArh2BVdi5fw4D
	 Soop6HfxZ6ZSwH02tgCnSUa4gzpJkXX94Ia9lJI8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392385AbgHQTVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:21:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:43410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730490AbgHQPgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:36:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4057222E00;
        Mon, 17 Aug 2020 15:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678574;
        bh=HWpxdmjKCO69zPhrgx75MpXgrFO+tbzvwbdJu6VUjCU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZbnS/eYm1PA2Da6IwiHxemVQ1O1deRPSUxGXiDj1KY3WNkBhawFrsgRhIo/w9VcgS
         HlJPgrV21up4WehrLNSKvzqxfbT5/fVfUlZauHxa/LsXDT0Ti7smQHeghrdo6bokGy
         C7MaUUcHAbuqhIdQBvvxtrJ3oaX6hoIX5VhU33mo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pierre Sauter <pierre.sauter@stwm.de>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 380/464] SUNRPC: Fix ("SUNRPC: Add "@len" parameter to gss_unwrap()")
Date:   Mon, 17 Aug 2020 17:15:33 +0200
Message-Id: <20200817143851.978492301@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 986a4b63d3bc5f2c0eb4083b05aff2bf883b7b2f ]

Braino when converting "buf->len -=" to "buf->len = len -".

The result is under-estimation of the ralign and rslack values. On
krb5p mounts, this has caused READDIR to fail with EIO, and KASAN
splats when decoding READLINK replies.

As a result of fixing this oversight, the gss_unwrap method now
returns a buf->len that can be shorter than priv_len for small
RPC messages. The additional adjustment done in unwrap_priv_data()
can underflow buf->len. This causes the nfsd_request_too_large
check to fail during some NFSv3 operations.

Reported-by: Marian Rainer-Harbach
Reported-by: Pierre Sauter <pierre.sauter@stwm.de>
BugLink: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1886277
Fixes: 31c9590ae468 ("SUNRPC: Add "@len" parameter to gss_unwrap()")
Reviewed-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/auth_gss/gss_krb5_wrap.c | 2 +-
 net/sunrpc/auth_gss/svcauth_gss.c   | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/sunrpc/auth_gss/gss_krb5_wrap.c b/net/sunrpc/auth_gss/gss_krb5_wrap.c
index cf0fd170ac189..90b8329fef824 100644
--- a/net/sunrpc/auth_gss/gss_krb5_wrap.c
+++ b/net/sunrpc/auth_gss/gss_krb5_wrap.c
@@ -584,7 +584,7 @@ gss_unwrap_kerberos_v2(struct krb5_ctx *kctx, int offset, int len,
 							buf->head[0].iov_len);
 	memmove(ptr, ptr + GSS_KRB5_TOK_HDR_LEN + headskip, movelen);
 	buf->head[0].iov_len -= GSS_KRB5_TOK_HDR_LEN + headskip;
-	buf->len = len - GSS_KRB5_TOK_HDR_LEN + headskip;
+	buf->len = len - (GSS_KRB5_TOK_HDR_LEN + headskip);
 
 	/* Trim off the trailing "extra count" and checksum blob */
 	xdr_buf_trim(buf, ec + GSS_KRB5_TOK_HDR_LEN + tailskip);
diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 46027d0c903f9..c28051f7d217d 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -958,7 +958,6 @@ unwrap_priv_data(struct svc_rqst *rqstp, struct xdr_buf *buf, u32 seq, struct gs
 
 	maj_stat = gss_unwrap(ctx, 0, priv_len, buf);
 	pad = priv_len - buf->len;
-	buf->len -= pad;
 	/* The upper layers assume the buffer is aligned on 4-byte boundaries.
 	 * In the krb5p case, at least, the data ends up offset, so we need to
 	 * move it around. */
-- 
2.25.1



