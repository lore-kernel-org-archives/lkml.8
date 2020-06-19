Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67EEC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9BEE204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592585289;
	bh=an4Pmc8XjI0h6GPlpDzwEw973xGTuUCS6+ncmNpufzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X1c3dBEzgoSo+LbBtjECbS1bs9kU0bmVaLLXZcfT4ooS6Tpra9aLSvgXojFezk2Zm
	 lAeeMjRh5Yh8QyZ3v/yVvCB+RjmUbpvrJajavVk45PowURIivbxe/kW61XDFDLSBD0
	 4LKa6mthTCfrZ4hOrFBtoek4BizgghaSf4Ex91iU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405739AbgFSQsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:48:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:59070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388182AbgFSOkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:40:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED6082070A;
        Fri, 19 Jun 2020 14:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592577653;
        bh=an4Pmc8XjI0h6GPlpDzwEw973xGTuUCS6+ncmNpufzk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y0q+ePDeZ7Vh7wAN5dfHjR4ieo+kTn6V3xKGzzxTED+ignRxOVkqx78R2kKWMYal8
         use+BkqX3FnegCdVUdPyzFajqXFFYjvHuMzYowfNvYLCPDI5zDdffF4TJaw6UAqjSV
         32h97YaBjWDn/lRCv07y9w0mmerBUxZLzF3C1yyU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yuxuan Shui <yshuiv7@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.9 035/128] ovl: initialize error in ovl_copy_xattr
Date:   Fri, 19 Jun 2020 16:32:09 +0200
Message-Id: <20200619141622.053348936@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141620.148019466@linuxfoundation.org>
References: <20200619141620.148019466@linuxfoundation.org>
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
@@ -56,7 +56,7 @@ int ovl_copy_xattr(struct dentry *old, s
 {
 	ssize_t list_size, size, value_size = 0;
 	char *buf, *name, *value = NULL;
-	int uninitialized_var(error);
+	int error = 0;
 	size_t slen;
 
 	if (!(old->d_inode->i_opflags & IOP_XATTR) ||


