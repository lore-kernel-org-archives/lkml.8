Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9EEC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A392E20718
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579859792;
	bh=GT79FooQqGTj/KIsUOKgKa9dqw9ObSDXS8vyvK6kufQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mngEb4GDhg5yDI9O1SUcF2N8QN8i5K3gHVPv4GDBP/phj2J2MDn3ToUBQdk0dWHo9
	 Prm1nGR2KSd+MRD4+xkQJsXAaaacNml4GW4E2wEzOu6lDuN22BW+gJg3RFy/5PV5nx
	 HvAah2YxRPMb56zSw3YrtiANa5OYzyTOMvp73LJc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388317AbgAXJ4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:56:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:60208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731098AbgAXJ42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:56:28 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDF6620718;
        Fri, 24 Jan 2020 09:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579859787;
        bh=GT79FooQqGTj/KIsUOKgKa9dqw9ObSDXS8vyvK6kufQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eFl0b07mu7Y8f2ycp/M7hxGt9nbovQe1ilM/zR0XQ3BeyYpHd01flzM3ceWlHf/NS
         SvO81fxZnz8rP3g6KmbZu4DLQCzXzfy/KsEJjxoJ+jtRHTEPHSF5AIBr02fb7xlTSS
         wP/ZCTA7Of/yCsrDOPULcS6eIC2WlJajF7eI9Jpc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 195/343] afs: Fix the afs.cell and afs.volume xattr handlers
Date:   Fri, 24 Jan 2020 10:30:13 +0100
Message-Id: <20200124092945.633348648@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092919.490687572@linuxfoundation.org>
References: <20200124092919.490687572@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

[ Upstream commit c73aa4102f5b9f261a907c3b3df94cd2c478504d ]

Fix the ->get handlers for the afs.cell and afs.volume xattrs to pass the
source data size to memcpy() rather than target buffer size.

Overcopying the source data occasionally causes the kernel to oops.

Fixes: d3e3b7eac886 ("afs: Add metadata xattrs")
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/xattr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/afs/xattr.c b/fs/afs/xattr.c
index 2830e4f48d854..7c6b62a94e7e7 100644
--- a/fs/afs/xattr.c
+++ b/fs/afs/xattr.c
@@ -50,7 +50,7 @@ static int afs_xattr_get_cell(const struct xattr_handler *handler,
 		return namelen;
 	if (namelen > size)
 		return -ERANGE;
-	memcpy(buffer, cell->name, size);
+	memcpy(buffer, cell->name, namelen);
 	return namelen;
 }
 
@@ -104,7 +104,7 @@ static int afs_xattr_get_volume(const struct xattr_handler *handler,
 		return namelen;
 	if (namelen > size)
 		return -ERANGE;
-	memcpy(buffer, volname, size);
+	memcpy(buffer, volname, namelen);
 	return namelen;
 }
 
-- 
2.20.1



