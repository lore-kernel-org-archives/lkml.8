Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C6FC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1304024755
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579196678;
	bh=Cq8Wtn2reVxGdiGtTvpmp9TfpUrvmzek3sU2F8MwtBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lvu2+utRYuvUgZPKo+lPbNG7ZTQsbi5b5Oxfi5GEY/n37plJpRNwED/+aIvtF564t
	 BUblRCO3CPJt+ViLLvIYhRwtDcXMryiBSKzJ2zrEx4XDzlbbzJ1T5jDyPalBOLl0+2
	 zHCsvQBIOsjW+xt44ry+ARo6WcuNIYHDDh4puwxs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405906AbgAPRoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:44:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:35094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394115AbgAPRoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:44:16 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9068D24764;
        Thu, 16 Jan 2020 17:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196656;
        bh=Cq8Wtn2reVxGdiGtTvpmp9TfpUrvmzek3sU2F8MwtBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LKvDpKbfI5EpGgSHnidQMcQfbf8PQuks/Xl3kd8+lySyf1Jov7vpHUo8UKOZ/m/mP
         Wjw1KtIJR8qS9a/KuEpDtN1Ahs181SZmDQK3cmzmpyNlUx69OTHmtyoKJp5ZRum/U4
         aPoOtM0q4iEeJ1E5yiXpy5hi3U33vCk5kx8d+GE4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        Sasha Levin <sashal@kernel.org>,
        jfs-discussion@lists.sourceforge.net,
        clang-built-linux@googlegroups.com
Subject: [PATCH AUTOSEL 4.4 063/174] jfs: fix bogus variable self-initialization
Date:   Thu, 16 Jan 2020 12:41:00 -0500
Message-Id: <20200116174251.24326-63-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116174251.24326-1-sashal@kernel.org>
References: <20200116174251.24326-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit a5fdd713d256887b5f012608701149fa939e5645 ]

A statement was originally added in 2006 to shut up a gcc warning,
now but now clang warns about it:

fs/jfs/jfs_txnmgr.c:1932:15: error: variable 'pxd' is uninitialized when used within its own initialization
      [-Werror,-Wuninitialized]
                pxd_t pxd = pxd;        /* truncated extent of xad */
                      ~~~   ^~~

Modern versions of gcc are fine without the silly assignment, so just
drop it. Tested with gcc-4.6 (released 2011), 4.7, 4.8, and 4.9.

Fixes: c9e3ad6021e5 ("JFS: Get rid of "may be used uninitialized" warnings")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/jfs_txnmgr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c
index d595856453b2..de6351c1c8db 100644
--- a/fs/jfs/jfs_txnmgr.c
+++ b/fs/jfs/jfs_txnmgr.c
@@ -1928,8 +1928,7 @@ static void xtLog(struct jfs_log * log, struct tblock * tblk, struct lrd * lrd,
 	 * header ?
 	 */
 	if (tlck->type & tlckTRUNCATE) {
-		/* This odd declaration suppresses a bogus gcc warning */
-		pxd_t pxd = pxd;	/* truncated extent of xad */
+		pxd_t pxd;	/* truncated extent of xad */
 		int twm;
 
 		/*
-- 
2.20.1

