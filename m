Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C96EC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C62924748
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579196614;
	bh=2Gp2Tp8VnXh2eaulPPIZdAlNW2teEQGzKNx7aT491rg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zsEoszLGb92u5Vscj8+BuamS0/WNx1yxnOuOysIYmJrzq3DEiKDBm1iLCvT4AEdZg
	 M9XmYwdW1b6JELlZP7ldGSKgTne6xgZ3NtmR14HtsGRS3hUqQzdYjWrrOifR1PWfGo
	 2SbA+YZE2aXxOU3Dnu8QBnwmVvcaAfAbIRy7CM7U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393941AbgAPRnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:43:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:33332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393912AbgAPRnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:43:18 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 408DF24736;
        Thu, 16 Jan 2020 17:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196598;
        bh=2Gp2Tp8VnXh2eaulPPIZdAlNW2teEQGzKNx7aT491rg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BrYKsEbGcsVf96M8FfuJ2yqSdV+Sa4DAgSmJRrAhYWCnaUAc0xU5SxK/QC5CemdkV
         4pX+v+2R3stiFpB68aDWtwX3W+PQ4mFjK8UjNhBePHxEXMQbEZfkTbFpQ9GDhvL1Wa
         +UPfRdw4n08ZH/YcXoTypFNkQECcoUT7mRcHfxqU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yangtao Li <tiny.windzz@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 020/174] clk: qoriq: fix refcount leak in clockgen_init()
Date:   Thu, 16 Jan 2020 12:40:17 -0500
Message-Id: <20200116174251.24326-20-sashal@kernel.org>
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
index 7244a621c61b..efc9e1973295 100644
--- a/drivers/clk/clk-qoriq.c
+++ b/drivers/clk/clk-qoriq.c
@@ -1244,6 +1244,7 @@ static void __init clockgen_init(struct device_node *np)
 				pr_err("%s: Couldn't map %s regs\n", __func__,
 				       guts->full_name);
 			}
+			of_node_put(guts);
 		}
 
 	}
-- 
2.20.1

