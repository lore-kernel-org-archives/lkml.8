Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A95C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA4462098B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592323674;
	bh=8LJvB/LGfhmrVz2EdFOe5aBaXRcWDqE+WFazPqlgZTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hpvPlPYuidvHr1wK8/d0LHcXJh1JVdpbnZheUGrMERJPUJ6aGnrfbBnn8V+2DJeel
	 N3Gle+TOWhp2W+cC0p8Vn6w4RblKTf+Jqq6J/ScqySwUZVCrcgSCJM/PImhaNMv3Mk
	 3cAxwpURnQfdxtmy5AITLxcRar7Ww095WDBM6qgs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732127AbgFPQHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 12:07:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:38984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729913AbgFPPqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:46:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEB5F2071A;
        Tue, 16 Jun 2020 15:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592322399;
        bh=8LJvB/LGfhmrVz2EdFOe5aBaXRcWDqE+WFazPqlgZTg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CBiAZS+32fW+PM8LwwQl08PK4HElbr/A5FfT+SJ5XWnCr749SZ+rcpAo5tiWWb4bS
         nIV3Ki8haC4uDDoKhNo//m786OprgcmZKt0fNM6Ijk1KnZwIvpWILXn1N/VPR0301O
         XYKwsF7R9LulSNrPIGGclUmLAB8SvD8dICFb9i1g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yuxuan Shui <yshuiv7@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 5.7 116/163] ovl: initialize error in ovl_copy_xattr
Date:   Tue, 16 Jun 2020 17:34:50 +0200
Message-Id: <20200616153112.359876631@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616153106.849127260@linuxfoundation.org>
References: <20200616153106.849127260@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuxuan Shui <yshuiv7@gmail.com>

commit 520da69d265a91c6536c63851cbb8a53946974f0 upstream.

In ovl_copy_xattr, if all the xattrs to be copied are overlayfs private
xattrs, the copy loop will terminate without assigning anything to the
error variable, thus returning an uninitialized value.

If ovl_copy_xattr is called from ovl_clear_empty, this uninitialized error
value is put into a pointer by ERR_PTR(), causing potential invalid memory
accesses down the line.

This commit initialize error with 0. This is the correct value because when
there's no xattr to copy, because all xattrs are private, ovl_copy_xattr
should succeed.

This bug is discovered with the help of INIT_STACK_ALL and clang.

Signed-off-by: Yuxuan Shui <yshuiv7@gmail.com>
Link: https://bugs.chromium.org/p/chromium/issues/detail?id=1050405
Fixes: 0956254a2d5b ("ovl: don't copy up opaqueness")
Cc: stable@vger.kernel.org # v4.8
Signed-off-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/overlayfs/copy_up.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -47,7 +47,7 @@ int ovl_copy_xattr(struct dentry *old, s
 {
 	ssize_t list_size, size, value_size = 0;
 	char *buf, *name, *value = NULL;
-	int uninitialized_var(error);
+	int error = 0;
 	size_t slen;
 
 	if (!(old->d_inode->i_opflags & IOP_XATTR) ||


