Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B0FC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 291BC2464B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgCIQQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 12:16:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:58928 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726788AbgCIQQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 12:16:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 17E1BAB92;
        Mon,  9 Mar 2020 16:16:45 +0000 (UTC)
Received: from localhost (webern.olymp [local])
        by webern.olymp (OpenSMTPD) with ESMTPA id 2bb7b078;
        Mon, 9 Mar 2020 16:16:43 +0000 (WET)
Date:   Mon, 9 Mar 2020 16:16:43 +0000
From:   Luis Henriques <lhenriques@suse.com>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] fscache: drop fscache_cookie_put on duplicated cookies in
 the hash
Message-ID: <20200309161643.GA92486@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When there's a collision due to a duplicate cookie, __fscache_register_netfs
will do an fscache_cookie_put.  This, however, isn't required as
fscache_cookie_get hasn't been executed, and will lead to a NULL pointer as
fscache_unhash_cookie will be called.

Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
 fs/fscache/netfs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/fscache/netfs.c b/fs/fscache/netfs.c
index cce92216fa28..07a55371f0a4 100644
--- a/fs/fscache/netfs.c
+++ b/fs/fscache/netfs.c
@@ -52,7 +52,6 @@ int __fscache_register_netfs(struct fscache_netfs *netfs)
 	return 0;
 
 already_registered:
-	fscache_cookie_put(candidate, fscache_cookie_put_dup_netfs);
 	_leave(" = -EEXIST");
 	return -EEXIST;
 }
