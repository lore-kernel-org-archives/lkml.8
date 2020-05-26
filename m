Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FCFC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA43B20776
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590521587;
	bh=NeOqInKTzxN7ojom7Vp7pT2oQY1bMAcK0kOuJJCDwnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gFqDzGSjfsDOlWdBa/kd2UjrbM9btimRr6e2t5JIOI15FwKfdaQkq/r1yWsy3Tmpq
	 gadzyJ7EvV1cTZ1SrQki6BjfgNQGTx2jdmUbZay5dAckMVgnxVsIlZRHt1TQVd5flv
	 hN/Gseb5OV25Cm4Y7Efvz54Ihmv+kf97TSUcJRx8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389853AbgEZS4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 14:56:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:49220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389823AbgEZS4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 14:56:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17D5920870;
        Tue, 26 May 2020 18:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590519385;
        bh=NeOqInKTzxN7ojom7Vp7pT2oQY1bMAcK0kOuJJCDwnE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uPIMLpUa4c3atZsLKb0SDf9VEHxhm9G64Zg/JA1k61/lwYLBjKpgwlBgN9EaMNVWS
         2zNwBiP2TJ0NQOhcTJ/iZ/gFElXA6PT54uKHn8Er48wrxX8Rojd/uw31+fsGclNHya
         M26ksDFtvVfeyFvSKRadTLryBGIg9T0tcwaPnJ6c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Thiago Macieira <thiago.macieira@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <sashal@kernel.org>, stable@kernel.org
Subject: [PATCH 4.4 07/65] fix multiplication overflow in copy_fdtable()
Date:   Tue, 26 May 2020 20:52:26 +0200
Message-Id: <20200526183908.706497453@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183905.988782958@linuxfoundation.org>
References: <20200526183905.988782958@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 4e89b7210403fa4a8acafe7c602b6212b7af6c3b ]

cpy and set really should be size_t; we won't get an overflow on that,
since sysctl_nr_open can't be set above ~(size_t)0 / sizeof(void *),
so nr that would've managed to overflow size_t on that multiplication
won't get anywhere near copy_fdtable() - we'll fail with EMFILE
before that.

Cc: stable@kernel.org # v2.6.25+
Fixes: 9cfe015aa424 (get rid of NR_OPEN and introduce a sysctl_nr_open)
Reported-by: Thiago Macieira <thiago.macieira@intel.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/file.c b/fs/file.c
index 7e9eb65a2912..090015401c55 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -88,7 +88,7 @@ static void copy_fd_bitmaps(struct fdtable *nfdt, struct fdtable *ofdt,
  */
 static void copy_fdtable(struct fdtable *nfdt, struct fdtable *ofdt)
 {
-	unsigned int cpy, set;
+	size_t cpy, set;
 
 	BUG_ON(nfdt->max_fds < ofdt->max_fds);
 
-- 
2.25.1



