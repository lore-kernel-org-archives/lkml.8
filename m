Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74136C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 03:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3749A20870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 03:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A3WtOevg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbgBJDgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 22:36:16 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38816 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbgBJDgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 22:36:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=YED1e9ddcBHEMTRB+MRyGgPo3Zksjl28+thmW+vX5Bs=; b=A3WtOevgYkQjKuuO+it1iqKqoL
        HJ19apeHFz55ACaNLQNBZVmg6XoDtlZg9VvLirmzvuuBAQcD8lHuAiBUe0ncKigdx2l5BcptHZFv6
        IArnZv742ikXdIsd+T1kv8WQKITKJVKjVCn3k8qiWoF0F7AQ2m+nFuNeaaXHjSdKgEeeusBAffdbE
        05oqDbiyp8Zc18q+tCy0bQzuOixeSCW4Gn9Sm+F8Q55ZoapSs9UCtetGqfAG7XJ0Mt2qyWY0IeAsk
        zRDF5l3JWvFipQHPI1q+SeNhTBocxhGe6DxZH8BEWh5zyDBLYX+K5guxWbss+z60bHPZwj+GbuzXp
        a9grfJzw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j0zrq-00030j-VS; Mon, 10 Feb 2020 03:36:15 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] linux/pipe_fs_i.h: fix kernel-doc warnings after @wait was
 split
Message-ID: <0956ab21-9b9a-4d1e-fe43-b853d1602781@infradead.org>
Date:   Sun, 9 Feb 2020 19:36:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix kernel-doc warnings in struct pipe_inode_info after @wait was
split into @rd_wait and @wr_wait.

../include/linux/pipe_fs_i.h:66: warning: Function parameter or member 'rd_wait' not described in 'pipe_inode_info'
../include/linux/pipe_fs_i.h:66: warning: Function parameter or member 'wr_wait' not described in 'pipe_inode_info'

Fixes: 0ddad21d3e99 ("pipe: use exclusive waits when reading or writing")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 include/linux/pipe_fs_i.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- lnx-56-rc1.orig/include/linux/pipe_fs_i.h
+++ lnx-56-rc1/include/linux/pipe_fs_i.h
@@ -29,7 +29,8 @@ struct pipe_buffer {
 /**
  *	struct pipe_inode_info - a linux kernel pipe
  *	@mutex: mutex protecting the whole thing
- *	@wait: reader/writer wait point in case of empty/full pipe
+ *	@rd_wait: reader wait point in case of empty pipe
+ *	@wr_wait: writer wait point in case of full pipe
  *	@head: The point of buffer production
  *	@tail: The point of buffer consumption
  *	@max_usage: The maximum number of slots that may be used in the ring

