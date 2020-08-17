Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B78CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB09D20658
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597693668;
	bh=PtAUaUXWVdMKmJKMJdJwK0Vyk3IPL8CzcjLOySQH6vk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kNPXTGXUQzbY4dV2AztkbsizhMwgItJ+BcXqlLAkeRVOIvnpvQcaEWo/EE5FJiQdG
	 wi62boH0NWpOCzGX6X/blXdGeRj6G7M2n/su7EnKv0uZ7mjtGOKtAuT0nAw1600V5z
	 9Q2mMzP9XdnuUlM5zW09nL49uF8AolAqqxs0BV4U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732707AbgHQTro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:47:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:42396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729150AbgHQPUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:20:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05E5B20786;
        Mon, 17 Aug 2020 15:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597677632;
        bh=PtAUaUXWVdMKmJKMJdJwK0Vyk3IPL8CzcjLOySQH6vk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2s6EXPctuTmgQNY6nX4B78UjtBEkKaynZ9Q+j9qSeivlqio79L0XCjOoFCp3XB+IX
         KnXtMEuQuIl+OTo8XFat0bxn9LkqKo81bGysmg5g5bE1seoPkBY9e9O+1C7W36iAJ7
         w8hdLzGyHty4EQw0z8yHhfYaI4pkECSex2Dil9sg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 022/464] soc: qcom: rpmh-rsc: Dont use ktime for timeout in write_tcs_reg_sync()
Date:   Mon, 17 Aug 2020 17:09:35 +0200
Message-Id: <20200817143834.826643806@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit be24c6a71ecfbd9436ea1f496eb518a53e06368c ]

The write_tcs_reg_sync() may be called after timekeeping is suspended
so it's not OK to use ktime.  The readl_poll_timeout_atomic() macro
implicitly uses ktime.  This was causing a warning at suspend time.

Change to just loop 1000000 times with a delay of 1 us between loops.
This may give a timeout of more than 1 second but never less and is
safe even if timekeeping is suspended.

NOTE: I don't have any actual evidence that we need to loop here.
It's possibly that all we really need to do is just read the value
back to ensure that the pipes are cleaned and the looping/comparing is
totally not needed.  I never saw the loop being needed in my tests.
However, the loop shouldn't hurt.

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Reviewed-by: Maulik Shah <mkshah@codeaurora.org>
Fixes: 91160150aba0 ("soc: qcom: rpmh-rsc: Timeout after 1 second in write_tcs_reg_sync()")
Reported-by: Maulik Shah <mkshah@codeaurora.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Link: https://lore.kernel.org/r/20200528074530.1.Ib86e5b406fe7d16575ae1bb276d650faa144b63c@changeid
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/qcom/rpmh-rsc.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 076fd27f3081c..906778e2c1fae 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -175,13 +175,21 @@ static void write_tcs_reg(const struct rsc_drv *drv, int reg, int tcs_id,
 static void write_tcs_reg_sync(const struct rsc_drv *drv, int reg, int tcs_id,
 			       u32 data)
 {
-	u32 new_data;
+	int i;
 
 	writel(data, tcs_reg_addr(drv, reg, tcs_id));
-	if (readl_poll_timeout_atomic(tcs_reg_addr(drv, reg, tcs_id), new_data,
-				      new_data == data, 1, USEC_PER_SEC))
-		pr_err("%s: error writing %#x to %d:%#x\n", drv->name,
-		       data, tcs_id, reg);
+
+	/*
+	 * Wait until we read back the same value.  Use a counter rather than
+	 * ktime for timeout since this may be called after timekeeping stops.
+	 */
+	for (i = 0; i < USEC_PER_SEC; i++) {
+		if (readl(tcs_reg_addr(drv, reg, tcs_id)) == data)
+			return;
+		udelay(1);
+	}
+	pr_err("%s: error writing %#x to %d:%#x\n", drv->name,
+	       data, tcs_id, reg);
 }
 
 /**
-- 
2.25.1



