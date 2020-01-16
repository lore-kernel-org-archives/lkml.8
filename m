Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA1D0C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A69724694
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579196156;
	bh=t5URcK600Li5/kEvwIlodEPbK0NFjbo9iqcdWokoL/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ny95lQlLSHmNOYxpO+XQpRcdnDQUAS6I6qNfQ5Tl0mBCg+6Mg7Y5krjN538EH3Y0u
	 P/vUAuhBAxYYtOtkUh3TfnQNvtNwUJnWzKivaXf49mToZPLYODkQFjTjlNiFM0ZPLM
	 zBhI/lwwGormGFRL5vpiktNnop0GlgsonzZPHY50=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405161AbgAPRff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:35:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:49550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404922AbgAPRfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:35:17 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D2DF246A9;
        Thu, 16 Jan 2020 17:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196117;
        bh=t5URcK600Li5/kEvwIlodEPbK0NFjbo9iqcdWokoL/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0CzFKKoHrzGkY0g4515InR8V8ojNI6IaonuF66SlLIN5mHfant23ZPZXPVzn5Wj3Q
         nwwyIhAy/NSH9rYe0cRVMAMYCMUn+z3grHqNSwW5iVH85uGbMjf56xPS5fmX3s+68r
         ft5+unulR+Vha9RmHoZn/HvmqMeNYGTjxQI/npQU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yangtao Li <tiny.windzz@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 025/251] clk: qoriq: fix refcount leak in clockgen_init()
Date:   Thu, 16 Jan 2020 12:30:59 -0500
Message-Id: <20200116173445.21385-25-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116173445.21385-1-sashal@kernel.org>
References: <20200116173445.21385-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

[ Upstream commit 70af6c5b5270e8101f318c4b69cc98a726edfab9 ]

The of_find_compatible_node() returns a node pointer with refcount
incremented, but there is the lack of use of the of_node_put() when
done. Add the missing of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Fixes: 0dfc86b3173f ("clk: qoriq: Move chip-specific knowledge into driver")
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/clk-qoriq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
index cdce49f6476a..65876ff6df41 100644
--- a/drivers/clk/clk-qoriq.c
+++ b/drivers/clk/clk-qoriq.c
@@ -1245,6 +1245,7 @@ static void __init clockgen_init(struct device_node *np)
 				pr_err("%s: Couldn't map %s regs\n", __func__,
 				       guts->full_name);
 			}
+			of_node_put(guts);
 		}
 
 	}
-- 
2.20.1

