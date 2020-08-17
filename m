Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEBE5C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9831C204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597690755;
	bh=C8HJY6mzlMYJgOJb/37DmfGgi7e8IQV70Tp3hB3M2jk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CBg6Ddl2kWziprTTWxTfkYQC/j1SUP0I9668MVwVwYxlAvXEhaxsmCCWJFrcMO3T7
	 U9iWROZKYNinObES1mdOTMFkpdbgUadIaNj+zKLusygMeAHfN/3Vpj2cqsWAv16HOj
	 XmpN83VZHUjhFrYkdWTNBrwfwQWkWoliS5NNy1WQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391846AbgHQS7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:59:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:60972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387414AbgHQPsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:48:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55D872067C;
        Mon, 17 Aug 2020 15:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679325;
        bh=C8HJY6mzlMYJgOJb/37DmfGgi7e8IQV70Tp3hB3M2jk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rc+qfE14BVCsrJkLy/5PVlqzfXBwP6Sodfj9akvfScHMndvm3VJTZOAwOdJEXUxqK
         5dvayqCqqh7LCrHEuSfXK8975AqxoWjclXC9BoqM15zvv1BnYqoyTZuJi5hyCESKWs
         HmFW3PEHY4j6K3Q4WO1gcQjIMJycmP056W93k+Uc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 155/393] staging: most: avoid null pointer dereference when iface is null
Date:   Mon, 17 Aug 2020 17:13:25 +0200
Message-Id: <20200817143827.135155225@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit e4463e49e29f43eecec86e2e2b2e2ab4feb7d867 ]

In the case where the pointer iface is null then the reporting of this
error will dereference iface when printing an error message causing which
is not ideal.  Since the majority of callers to most_register_interface
report an error when -EINVAL is returned a simple fix is to just remove
the error message, I doubt it will be missed.

Addresses-Coverity: ("Dereference after null check")
Fixes: 57562a72414c ("Staging: most: add MOST driver's core module")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Link: https://lore.kernel.org/r/20200624163957.11676-1-colin.king@canonical.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/most/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/most/core.c b/drivers/most/core.c
index f781c46cd4af9..353ab277cbc6b 100644
--- a/drivers/most/core.c
+++ b/drivers/most/core.c
@@ -1283,10 +1283,8 @@ int most_register_interface(struct most_interface *iface)
 	struct most_channel *c;
 
 	if (!iface || !iface->enqueue || !iface->configure ||
-	    !iface->poison_channel || (iface->num_channels > MAX_CHANNELS)) {
-		dev_err(iface->dev, "Bad interface or channel overflow\n");
+	    !iface->poison_channel || (iface->num_channels > MAX_CHANNELS))
 		return -EINVAL;
-	}
 
 	id = ida_simple_get(&mdev_id, 0, 0, GFP_KERNEL);
 	if (id < 0) {
-- 
2.25.1



