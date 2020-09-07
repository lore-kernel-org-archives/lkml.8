Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD9BC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D46D2080A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599497367;
	bh=syf/mrawTOysmHCUC8/4Wh8OWhj5SiPsMX3nynqs+WI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jauyGvnjHzX2rW6kULqGBesOipgbVOPVaoGb9RVV79f1a7mhgJGLdFjzQtdbBrhhf
	 HtI3Ou1UmiQW32KYrX4ZB1bYM83JfDDZbsbvb1dx/sFUgD1eMb5SY2USzJLMNKrw12
	 zIWKcAOeqWnWOX1lJdo+DtNEyu1SeCBUHg8gL7Rg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731028AbgIGQtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:49:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:49012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730813AbgIGQfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:35:08 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13A83221E9;
        Mon,  7 Sep 2020 16:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599496507;
        bh=syf/mrawTOysmHCUC8/4Wh8OWhj5SiPsMX3nynqs+WI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m3PHEhaLMMp+2hJF+CKrBwRRz10/U02B5dd0lcQGUhyIUIVbIJdFPmSmEhnOhrpaD
         3zS/Vl6z/mOjqumqYVH+PP4eH03yxwWMTdkqmmJuCZReAloYIwfK2IvhFK1KMbQldu
         eJygVJDN7EXIZswEI8QW8aJ5DPHVxlr0z9LylrRs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dinghao Liu <dinghao.liu@zju.edu.cn>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>,
        linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 05/17] firestream: Fix memleak in fs_open
Date:   Mon,  7 Sep 2020 12:34:48 -0400
Message-Id: <20200907163500.1281543-5-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907163500.1281543-1-sashal@kernel.org>
References: <20200907163500.1281543-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dinghao Liu <dinghao.liu@zju.edu.cn>

[ Upstream commit 15ac5cdafb9202424206dc5bd376437a358963f9 ]

When make_rate() fails, vcc should be freed just
like other error paths in fs_open().

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/atm/firestream.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/atm/firestream.c b/drivers/atm/firestream.c
index 0e449ee11ac7f..e7cffd0cc3616 100644
--- a/drivers/atm/firestream.c
+++ b/drivers/atm/firestream.c
@@ -1013,6 +1013,7 @@ static int fs_open(struct atm_vcc *atm_vcc)
 				error = make_rate (pcr, r, &tmc0, NULL);
 				if (error) {
 					kfree(tc);
+					kfree(vcc);
 					return error;
 				}
 			}
-- 
2.25.1

