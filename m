Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67493C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35BEB246D5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579195629;
	bh=mHu7FcEcH7ZTqsu4AfsnGL48Fe7PrHeLWBDhrp1hE4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qzdfiL039IHZ9sXjtpJuM9P0kkuLEmi7xiGj08PqRv3VDTFg61SzVVRuhgMkLaUCu
	 0o2oQMJogSFM1lZeac6ziHfjtkz1X82lIA8PuD3cJChWDJIZln4oAwNngt+LX7cnPm
	 9HYNcKBDday9nKcPGbkhOMI7yEyLukUgixAkazNg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392412AbgAPR1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:27:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:36224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390515AbgAPR05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:26:57 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 244FA246C8;
        Thu, 16 Jan 2020 17:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195616;
        bh=mHu7FcEcH7ZTqsu4AfsnGL48Fe7PrHeLWBDhrp1hE4s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c9ve+a8GcQcMxsTJ9NUJASM9OE4EUwX5ipK0z2tS64mcrHxuPACc1CKBGp4uBJKOs
         wui7F0JZQ2Yb6k+Sak18AE/t9lPYCckS1N3tr4Y+t1WZIwrQsu9VeK56lDO35B2+L2
         SMFgi6pN/+K/DmQ7yUiWyhJrduxjVhVKjuB2JNmo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>, linux-afs@lists.infradead.org
Subject: [PATCH AUTOSEL 4.14 189/371] afs: Fix the afs.cell and afs.volume xattr handlers
Date:   Thu, 16 Jan 2020 12:21:01 -0500
Message-Id: <20200116172403.18149-132-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116172403.18149-1-sashal@kernel.org>
References: <20200116172403.18149-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 2830e4f48d85..7c6b62a94e7e 100644
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

