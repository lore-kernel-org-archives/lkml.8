Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E250C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7342F2075A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595859595;
	bh=iUh9dnBwToXwhWtzVBeJCBPtLhp603IQ6o4UTkg+7LU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xQFBlN2GZS0bwJp+JTy7+MEBfv0sFJjfGnlCmq5l8CexJdTCdrYrp6WUUFFIpDmq1
	 KbOfa8ti8ThCQGs6xe8ecR5kk4+H6JPjglluegWMBAq7/ebRXqrIE0VlGikBdG0agi
	 DSsm/uMLZh2o3s2k5/iuHI47yLHGQ6Su9W+Xr23Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730880AbgG0OTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:19:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:47844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731406AbgG0OTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:19:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F8F020FC3;
        Mon, 27 Jul 2020 14:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859587;
        bh=iUh9dnBwToXwhWtzVBeJCBPtLhp603IQ6o4UTkg+7LU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j8H4A4CHjrZbL7xjtZwXELLsozo3S5vXe2P/PcG7E1MuA7TizuRRV+8eYFhjtJHYJ
         q9QCnpyHJShu29UCr01roK2LAW8SouFAHYkRzY4BQWWfSFkIdgnY4hgAtd38I00+16
         aC46uZbWTccDN5F/4hQMykndixBlXTB97iLD2x5Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hyeongseok Kim <hyeongseok@gmail.com>,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH 5.7 029/179] exfat: fix wrong size update of stream entry by typo
Date:   Mon, 27 Jul 2020 16:03:24 +0200
Message-Id: <20200727134934.084625370@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134932.659499757@linuxfoundation.org>
References: <20200727134932.659499757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hyeongseok Kim <hyeongseok@gmail.com>

commit 41e3928f8c58184fcf0bb22e822af39a436370c7 upstream.

The stream.size field is updated to the value of create timestamp
of the file entry. Fix this to use correct stream entry pointer.

Fixes: 29bbb14bfc80 ("exfat: fix incorrect update of stream entry in __exfat_truncate()")
Signed-off-by: Hyeongseok Kim <hyeongseok@gmail.com>
Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/exfat/file.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -175,7 +175,7 @@ int __exfat_truncate(struct inode *inode
 			ep2->dentry.stream.size = 0;
 		} else {
 			ep2->dentry.stream.valid_size = cpu_to_le64(new_size);
-			ep2->dentry.stream.size = ep->dentry.stream.valid_size;
+			ep2->dentry.stream.size = ep2->dentry.stream.valid_size;
 		}
 
 		if (new_size == 0) {


