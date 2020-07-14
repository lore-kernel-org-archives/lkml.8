Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB921C433EA
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B07D82240B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X5kDtG7t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731413AbgGNTJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 15:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731336AbgGNTJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:09:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A21C08C5DB;
        Tue, 14 Jul 2020 12:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=yJQCyMU4QC5CM8QEcB7EPBUPjYJdK3zPx0qGOqwbmg8=; b=X5kDtG7t0cVUXd3x+ntU2rSZaQ
        nRa8O3DwFc0O1+fz/SUO41onJfg43Fj19YkdOtYRdFPV1uaLLoSmJwQzemuooBpOMFNf7nJUpHg5Q
        GxVKJthb5kcEW/ScCD4aHS05dpTrkIPoqe4Qk4Z73VbgLD+V0il0Sa9R0h2Inx/0y0ETD4LyEkiqV
        MYDEm9yhHgA+Ons2x8A2D4jt2467P4MO5mf77u/0kbQ0EhMn8UOxtNTPKmqdiFlem4CcPpvklpjct
        AEQnGc24snjitsGVl1ERiAxKQ/4x/gwZhCxSZGun0bMw1Eu+5f507p7h1RH4emYoMcVHXfAkatwmU
        VqLgrocw==;
Received: from [2001:4bb8:188:5f50:f037:8cfe:627e:7028] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvQId-0005sM-Hf; Tue, 14 Jul 2020 19:09:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-kernel@vger.kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 13/23] initrd: mark init_linuxrc as __init
Date:   Tue, 14 Jul 2020 21:04:17 +0200
Message-Id: <20200714190427.4332-14-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714190427.4332-1-hch@lst.de>
References: <20200714190427.4332-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 init/do_mounts_initrd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index e4f88e9e1c0839..57ad5b2da8f5f5 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -56,7 +56,7 @@ static int __init early_initrd(char *p)
 }
 early_param("initrd", early_initrd);
 
-static int init_linuxrc(struct subprocess_info *info, struct cred *new)
+static int __init init_linuxrc(struct subprocess_info *info, struct cred *new)
 {
 	ksys_unshare(CLONE_FS | CLONE_FILES);
 	console_on_rootfs();
-- 
2.27.0

