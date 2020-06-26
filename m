Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 581E0C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 03:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3276320767
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 03:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kq4aAleZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgFZDwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 23:52:39 -0400
Received: from m12-14.163.com ([220.181.12.14]:36374 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728476AbgFZDwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 23:52:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=8IHp+vsynR+DWzpyYD
        z0bkNc3Q75NjA9ypC5lFUl5qs=; b=kq4aAleZ2X7JgmLXfljvbgx0UaasLbPA23
        3YcwEiVZOvNTbrhbstkh7/VXBFqiJbf5Y4SECbuHFgCFyQxxfL0SD+PTM70Ewx77
        D2f0v58yarnnjAb+33W3fzyGF7ozwcnZOFNBJdNc/Dok+tcLBkIwiRogu5ZkdzdL
        rJrwF/nbw=
Received: from bolli-Vostro-5390.lan (unknown [110.188.94.210])
        by smtp10 (Coremail) with SMTP id DsCowAC36t7wcPVe40GsIQ--.31954S2;
        Fri, 26 Jun 2020 11:52:16 +0800 (CST)
From:   libolingjl@163.com
To:     davem@davemloft.net, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, liboling <libolingjl@163.com>
Subject: [PATCH] samples cn_test: fix cn leakage
Date:   Fri, 26 Jun 2020 11:52:14 +0800
Message-Id: <20200626035214.22709-1-libolingjl@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: DsCowAC36t7wcPVe40GsIQ--.31954S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF4rZryrGr43WF43WrW8Crg_yoWxZrX_XF
        1fGF1kArW3JF1Fqw17Awn5GFsaq348tF4UGrWYkry8AFW0vw1Dur4DJan0gr4UWrZxua47
        tr1UuF1jkr1IyjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUj8pnJUUUUU==
X-Originating-IP: [110.188.94.210]
X-CM-SenderInfo: pole0zhlqjyzi6rwjhhfrp/xtbBSRZPZlaD7PZ33wABsQ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: liboling <libolingjl@163.com>

Error return when add the second cn_test_id,
we need del the first cn_test_id.

Signed-off-by: liboling <libolingjl@163.com>
---
 samples/connector/cn_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/samples/connector/cn_test.c b/samples/connector/cn_test.c
index 0958a171d0..275e3f9082 100644
--- a/samples/connector/cn_test.c
+++ b/samples/connector/cn_test.c
@@ -151,6 +151,7 @@ static int cn_test_init(void)
 	cn_test_id.val++;
 	err = cn_add_callback(&cn_test_id, cn_test_name, cn_test_callback);
 	if (err) {
+		cn_test_id.val--;
 		cn_del_callback(&cn_test_id);
 		goto err_out;
 	}
-- 
2.17.1


