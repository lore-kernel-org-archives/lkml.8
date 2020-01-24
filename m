Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81695C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 563E42087E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579859165;
	bh=P1g8GQH4MJHT71mFOPxg6RYOdZntluXA94OiB9NRuE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TQLRxPonxipRGDAmriaNlxh4iIaumxQxfvfeadejddScV/3YAPhKelENEKSJ+xZhr
	 UNItJ2C5Go5v+h0Cnnlj2wNyWq9wD5K9Af8wxDQ60VnHULr2exQFctAvQPtesNzuAA
	 eB0M10u8zroeC0+jPbJkGxIfcUUKI/ux1yBUHWqM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387540AbgAXJqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:46:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:45212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730953AbgAXJqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:46:02 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51E122087E;
        Fri, 24 Jan 2020 09:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579859161;
        bh=P1g8GQH4MJHT71mFOPxg6RYOdZntluXA94OiB9NRuE0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vsftTnR+DoFYUp955fdXcoj0H4y1S4s1gZ2pRumsgVBpjHpt5NW2ccA6ApviNlgps
         EsTf2foops2TJr3+CQ/kCjhDTK+O8Md9pyEeRzGIvo2AN/gdGS2KRMhkTe/e46tIkN
         S6XI0Vvii8wXpMpQ1F3HibsOZGTGab5fQnBDTp2U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 044/343] clk: qoriq: fix refcount leak in clockgen_init()
Date:   Fri, 24 Jan 2020 10:27:42 +0100
Message-Id: <20200124092925.565815594@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092919.490687572@linuxfoundation.org>
References: <20200124092919.490687572@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 1a292519d84f2..999a90a166092 100644
--- a/drivers/clk/clk-qoriq.c
+++ b/drivers/clk/clk-qoriq.c
@@ -1382,6 +1382,7 @@ static void __init clockgen_init(struct device_node *np)
 				pr_err("%s: Couldn't map %pOF regs\n", __func__,
 				       guts);
 			}
+			of_node_put(guts);
 		}
 
 	}
-- 
2.20.1



