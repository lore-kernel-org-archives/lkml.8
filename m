Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80248C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 477AA2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579863769;
	bh=8Lb8wIeoJAIgYDUfg3jZ2qrbwv/B3IqBNcJDx88DvQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u1H3EYK2kQ7inMl9Ri3blSS11Uon3tiHOV9xCroi5bCf53S5PS70ja7JNhN8Rs8ct
	 tx/jO75JlO3BEYqDvjleCenJ/6sFp6sjpLGqXFZlHlJGy8NNkM/FMOMqGJPUO4jwoF
	 5XL0SOa74yEuRrcb9/0H66il9dPGhVuSatVIyCi4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388176AbgAXLCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:02:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:36318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731019AbgAXLCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:02:45 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E1EF2071A;
        Fri, 24 Jan 2020 11:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579863765;
        bh=8Lb8wIeoJAIgYDUfg3jZ2qrbwv/B3IqBNcJDx88DvQo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lARn0xaK0INrh+poET8d/YhJLkGFVqwVE3Y0pP1EtwK+XaDdjjyrBO6mqfB9p6YXO
         KPJklbiv9WpiFHPLzvJYCGVJDI92xsnWlcIdPw7ERwsKMdDfmZ4DxAcGVprIB3CJAH
         KKU3soTQEZNPLUvVjocWM8dYzZLOYLMbOXHHpfJw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 069/639] exportfs: fix passing zero to ERR_PTR() warning
Date:   Fri, 24 Jan 2020 10:23:59 +0100
Message-Id: <20200124093056.056227306@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 909e22e05353a783c526829427e9a8de122fba9c ]

Fix a static code checker warning:
  fs/exportfs/expfs.c:171 reconnect_one() warn: passing zero to 'ERR_PTR'

The error path for lookup_one_len_unlocked failure
should set err to PTR_ERR.

Fixes: bbf7a8a3562f ("exportfs: move most of reconnect_path to helper function")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/exportfs/expfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
index 808cae6d5f50f..ae3248326c449 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -147,6 +147,7 @@ static struct dentry *reconnect_one(struct vfsmount *mnt,
 	tmp = lookup_one_len_unlocked(nbuf, parent, strlen(nbuf));
 	if (IS_ERR(tmp)) {
 		dprintk("%s: lookup failed: %d\n", __func__, PTR_ERR(tmp));
+		err = PTR_ERR(tmp);
 		goto out_err;
 	}
 	if (tmp != dentry) {
-- 
2.20.1



