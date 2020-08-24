Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFADC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC9DC2074D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598260946;
	bh=nstCH6mn71s6+t+b0/T4hwQQsqc+bqiv7+SPeqwEVLc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ITcFu7ht3Y34K0TKXbaOt8snmQfbhWblOK/jlLw3atBVCiOvpIXg/2LiNMhy0VJYV
	 ey5RKWuqn0p+28zfY5Q+54DFF+dGbIKBy4yJJMoaJsoIAtH7wAk1tOw8xnishz+fNe
	 D4DPRxYUIyPeXU9G/WunlcHwhfgyz/2Ee8SqqNA0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbgHXJWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:22:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:36760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730395AbgHXIzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:55:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32AF2204FD;
        Mon, 24 Aug 2020 08:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598259309;
        bh=nstCH6mn71s6+t+b0/T4hwQQsqc+bqiv7+SPeqwEVLc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FbbM0E47TJ1z24JO9GWb5IJCWFXsdlDsp+DQcH7XqACugfJ1nXvAWHea14Rq/mqOr
         1Q0BdH+CuSCTEb0TGZB7apZ+TLClp9vK1A0qn2oH0tCNuOIYWTKF21xt2ENufBCarh
         rBV30cJD+cMUlY2+SIGtGSzVJB+PS6MnZRpk5f7U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.19 10/71] romfs: fix uninitialized memory leak in romfs_dev_read()
Date:   Mon, 24 Aug 2020 10:31:01 +0200
Message-Id: <20200824082356.398552400@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082355.848475917@linuxfoundation.org>
References: <20200824082355.848475917@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jann Horn <jannh@google.com>

commit bcf85fcedfdd17911982a3e3564fcfec7b01eebd upstream.

romfs has a superblock field that limits the size of the filesystem; data
beyond that limit is never accessed.

romfs_dev_read() fetches a caller-supplied number of bytes from the
backing device.  It returns 0 on success or an error code on failure;
therefore, its API can't represent short reads, it's all-or-nothing.

However, when romfs_dev_read() detects that the requested operation would
cross the filesystem size limit, it currently silently truncates the
requested number of bytes.  This e.g.  means that when the content of a
file with size 0x1000 starts one byte before the filesystem size limit,
->readpage() will only fill a single byte of the supplied page while
leaving the rest uninitialized, leaking that uninitialized memory to
userspace.

Fix it by returning an error code instead of truncating the read when the
requested read operation would go beyond the end of the filesystem.

Fixes: da4458bda237 ("NOMMU: Make it possible for RomFS to use MTD devices directly")
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: David Howells <dhowells@redhat.com>
Cc: <stable@vger.kernel.org>
Link: http://lkml.kernel.org/r/20200818013202.2246365-1-jannh@google.com
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/romfs/storage.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/fs/romfs/storage.c
+++ b/fs/romfs/storage.c
@@ -221,10 +221,8 @@ int romfs_dev_read(struct super_block *s
 	size_t limit;
 
 	limit = romfs_maxsize(sb);
-	if (pos >= limit)
+	if (pos >= limit || buflen > limit - pos)
 		return -EIO;
-	if (buflen > limit - pos)
-		buflen = limit - pos;
 
 #ifdef CONFIG_ROMFS_ON_MTD
 	if (sb->s_mtd)


