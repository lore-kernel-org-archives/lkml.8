Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87749C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A42B2158C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592578569;
	bh=waDnIzkFy2yPMYa8d+xDQU4UEevm4QyBOITEaJdX0T8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Fd2UHkvvVPQNjRwzuHqYEHQkGyzWHMjPIXxs1T+RGrU3aT7pfMTZXeqyU2+1SkH5W
	 qywx+Dgz8FyekNiiLgNG0gvtykHYCQVFEB+DcHpEsI56d3iRXsO5KsHDOJghWJD9Zt
	 O5tAAbBIp01z6myjiDo5Wo8cSHV0naNB8hFxIB84=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390030AbgFSO4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:56:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:50880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388945AbgFSOz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:55:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A65A2217D8;
        Fri, 19 Jun 2020 14:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592578557;
        bh=waDnIzkFy2yPMYa8d+xDQU4UEevm4QyBOITEaJdX0T8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S3Zw2torBlN1ZNy4Yy17hS5GNdWylaNqAAdhrpiHYvmNyx6RrrhQNjXGgwkQH/ZUO
         RcJLSrN0if4dv2hmmzly8m8R3WEmKOckVGhYKw9aeYUXjI1Jy/kR6l2q/isjkonjJa
         h5OwTkczooDO3iW2dbg3H/ywpipt356lvfztmbxw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yuxuan Shui <yshuiv7@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.19 068/267] ovl: initialize error in ovl_copy_xattr
Date:   Fri, 19 Jun 2020 16:30:53 +0200
Message-Id: <20200619141652.149764885@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141648.840376470@linuxfoundation.org>
References: <20200619141648.840376470@linuxfoundation.org>
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
@@ -43,7 +43,7 @@ int ovl_copy_xattr(struct dentry *old, s
 {
 	ssize_t list_size, size, value_size = 0;
 	char *buf, *name, *value = NULL;
-	int uninitialized_var(error);
+	int error = 0;
 	size_t slen;
 
 	if (!(old->d_inode->i_opflags & IOP_XATTR) ||


