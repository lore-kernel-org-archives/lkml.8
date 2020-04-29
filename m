Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05B4C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 11:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B64E2074A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 11:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="VN9jSEoO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgD2LmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 07:42:25 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:53637 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbgD2LmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 07:42:25 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49BxSt4pGzz9sPF;
        Wed, 29 Apr 2020 21:42:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1588160543;
        bh=1tlusSBwGr5U0w6ErMbJb/gNa+IXcP1MkkFVn6Y7ZS4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=VN9jSEoOBhTB0p7EzleihEGvDqn7BKfU3Cu5uchJytHan/oluvoCAsbvHah1ywvX6
         03PZ0H6jz1OeHzfonu9hVvZStkygHM4752zpFI5LAEZ+RNKl57gC0jM80kll0LzVY6
         ZnT4PiKsu2ii0Fd4sGYZxGSxVhCMcQMKjhIhqKgkIC/PKNDjzkiz+B7f3ypWbgum0x
         0gPTGfbVuuc6J11czz8r+wn2MJb9ZCCWdBmPwgR4NokJJ5rizd0HhGuvaxjpjhqnXb
         mT5GFrV9GWYM/Mbt8Ijx6t1L++y/J2NdDG/bfDS4iTbvAdJtBPSYIo7yp6FOBvki4G
         cUWQl8eQ7nvug==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linuxppc-dev@ozlabs.org, hch@lst.de, jk@ozlabs.org,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/spufs: Add rcu_read_lock() around fcheck()
In-Reply-To: <20200428135245.GA2827@lst.de>
References: <20200428114811.68436-1-mpe@ellerman.id.au> <20200428135245.GA2827@lst.de>
Date:   Wed, 29 Apr 2020 21:42:39 +1000
Message-ID: <875zdifrgw.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:
> On Tue, Apr 28, 2020 at 09:48:11PM +1000, Michael Ellerman wrote:
>> 
>> This comes from fcheck_files() via fcheck().
>> 
>> It's pretty clearly documented that fcheck() must be wrapped with
>> rcu_read_lock(), so fix it.
>
> But for this to actually be useful you'd need the rcu read lock until
> your are done with the file (or got a reference).

Hmm OK. My reasoning was that we were done with the struct file, because
we return the ctx that's hanging off the inode.

+	ctx = SPUFS_I(file_inode(file))->i_ctx;

But I guess the lifetime of the ctx is not guaranteed if the file goes
away.

It looks like the only long lived reference on the ctx is the one
taken in spufs_new_file() and dropped in spufs_evict_inode().

So if we take a reference to the ctx with the RCU lock held we should be
safe, I think. But I've definitely exhausted my spufs/vfs knowledge at
this point.

Something like below.

cheers


diff --git a/arch/powerpc/platforms/cell/spufs/coredump.c b/arch/powerpc/platforms/cell/spufs/coredump.c
index 8b3296b62f65..37c155254cd5 100644
--- a/arch/powerpc/platforms/cell/spufs/coredump.c
+++ b/arch/powerpc/platforms/cell/spufs/coredump.c
@@ -82,13 +82,20 @@ static int match_context(const void *v, struct file *file, unsigned fd)
  */
 static struct spu_context *coredump_next_context(int *fd)
 {
+       struct spu_context *ctx;
        struct file *file;
        int n = iterate_fd(current->files, *fd, match_context, NULL);
        if (!n)
                return NULL;
        *fd = n - 1;
+
+       rcu_read_lock();
        file = fcheck(*fd);
-       return SPUFS_I(file_inode(file))->i_ctx;
+       ctx = SPUFS_I(file_inode(file))->i_ctx;
+       get_spu_context(ctx);
+       rcu_read_unlock();
+
+       return ctx;
 }

 int spufs_coredump_extra_notes_size(void)
@@ -99,17 +106,23 @@ int spufs_coredump_extra_notes_size(void)
        fd = 0;
        while ((ctx = coredump_next_context(&fd)) != NULL) {
                rc = spu_acquire_saved(ctx);
-               if (rc)
+               if (rc) {
+                       put_spu_context(ctx);
                        break;
+               }
+
                rc = spufs_ctx_note_size(ctx, fd);
                spu_release_saved(ctx);
-               if (rc < 0)
+               if (rc < 0) {
+                       put_spu_context(ctx);
                        break;
+               }

                size += rc;

                /* start searching the next fd next time */
                fd++;
+               put_spu_context(ctx);
        }

        return size;

