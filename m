Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BBEC2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4777D20772
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585646118;
	bh=CY/wbAodfT00hdTU5A7Rz1+tsKBLLbSu1NJDFYyHIy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rAtlzMi2SnFC91rP/0Lpvy4VUtbvZEhDwgWnB5GOiQoJOPbYACd4kakXrHyb7tSws
	 gs+fi0MdW/QmWUJYHI7//j/e4HWNYmBr3yWO4gl2Srfq5BFwTVEcbUObEKCzFLgB8M
	 wI6158d04HZTuem/43hGlSKSIf4tgxMGUKixiOoI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731894AbgCaJPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:15:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:35298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730926AbgCaJPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:15:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76D7120772;
        Tue, 31 Mar 2020 09:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585646110;
        bh=CY/wbAodfT00hdTU5A7Rz1+tsKBLLbSu1NJDFYyHIy4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JQ3fdUgwqJVAHg/RpJbO9PsXEbEDAB7iAbnxYR6F+Opfwj2IF3eSpOQ42nWu2reu8
         Bk/YGaKsEvQR7+s75V0pLR5v0NUvCz8oyoS1ePClF5lcuKLElO7kNrvDcPFRuy/dnI
         ktZg0vrFEAlAxuvkO5/tYtxSIGD+fDKQxz0fIcmw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Luis Henriques <lhenriques@suse.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 5.4 087/155] ceph: fix memory leak in ceph_cleanup_snapid_map()
Date:   Tue, 31 Mar 2020 10:58:47 +0200
Message-Id: <20200331085428.002744980@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085418.274292403@linuxfoundation.org>
References: <20200331085418.274292403@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luis Henriques <lhenriques@suse.com>

commit c8d6ee01449cd0d2f30410681cccb616a88f50b1 upstream.

kmemleak reports the following memory leak:

unreferenced object 0xffff88821feac8a0 (size 96):
  comm "kworker/1:0", pid 17, jiffies 4294896362 (age 20.512s)
  hex dump (first 32 bytes):
    a0 c8 ea 1f 82 88 ff ff 00 c9 ea 1f 82 88 ff ff  ................
    00 00 00 00 00 00 00 00 00 01 00 00 00 00 ad de  ................
  backtrace:
    [<00000000b3ea77fb>] ceph_get_snapid_map+0x75/0x2a0
    [<00000000d4060942>] fill_inode+0xb26/0x1010
    [<0000000049da6206>] ceph_readdir_prepopulate+0x389/0xc40
    [<00000000e2fe2549>] dispatch+0x11ab/0x1521
    [<000000007700b894>] ceph_con_workfn+0xf3d/0x3240
    [<0000000039138a41>] process_one_work+0x24d/0x590
    [<00000000eb751f34>] worker_thread+0x4a/0x3d0
    [<000000007e8f0d42>] kthread+0xfb/0x130
    [<00000000d49bd1fa>] ret_from_fork+0x3a/0x50

A kfree is missing while looping the 'to_free' list of ceph_snapid_map
objects.

Cc: stable@vger.kernel.org
Fixes: 75c9627efb72 ("ceph: map snapid to anonymous bdev ID")
Signed-off-by: Luis Henriques <lhenriques@suse.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ceph/snap.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -1155,5 +1155,6 @@ void ceph_cleanup_snapid_map(struct ceph
 			pr_err("snapid map %llx -> %x still in use\n",
 			       sm->snap, sm->dev);
 		}
+		kfree(sm);
 	}
 }


