Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3687C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 04:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B053320756
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 04:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="NVcjX8N7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbgHJEdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 00:33:35 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:31500 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbgHJEde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 00:33:34 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4BQ34X5ZrNzMK;
        Mon, 10 Aug 2020 06:33:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1597034012; bh=43qYXqlZERoG1ZlAOtzLN/PtSZReli4+3GOGERgoZAY=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=NVcjX8N73xitkRL3dbkNmGmJZddV0bw/7la7mZ5g0GaMjLiV5ViF6JAXps6fG1/BO
         3yfo86jnNYGZYYUX/hX5H8BRVC8+9hpoEHnF4b1wT1RWtbISdW6MSDBcBbrmeQtwzw
         GZXvmdZ832hLceSQznfCUH0X5crR1dLgGk4Uv2tkrcVsWt8Q04YPFIHRxYCbuybb5c
         y2jYJMabar+MC5LpvQf8hpTo5BDo87+8dIohCNG0b8fgQwWQL7ah2TjrAILawCvxOC
         wO+JnOLSBhDp/DpU7Igw1cEUxpbLHfPoRLwm06cTAna2gBta00td5MyUWSljSvfmN/
         xKYoIjWFg6p6g==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Mon, 10 Aug 2020 06:33:32 +0200
Message-Id: <5a0da9017c69a4dbc3f9b50f44476fce80a73387.1597032945.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1597032945.git.mirq-linux@rere.qmqm.pl>
References: <cover.1597032945.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 1/3] regulator: don't require mutex for
 regulator_notifier_call_chain()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Dmitry Osipenko <digetx@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
Cc:     linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 3801b86aa482 ("regulator: Refactor supply implementation
to work as regular consumers") we no longer cascade notifications
and so notifier head's built-in rwsem is enough to protect the
notifier chain. Remove the requirement to fix one case where
rdev->mutex might be forced to be taken recursively.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index b0662927487c..f4035167e7ba 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4658,14 +4658,11 @@ EXPORT_SYMBOL_GPL(regulator_bulk_free);
  * @data: callback-specific data.
  *
  * Called by regulator drivers to notify clients a regulator event has
- * occurred. We also notify regulator clients downstream.
- * Note lock must be held by caller.
+ * occurred.
  */
 int regulator_notifier_call_chain(struct regulator_dev *rdev,
 				  unsigned long event, void *data)
 {
-	lockdep_assert_held_once(&rdev->mutex.base);
-
 	_notifier_call_chain(rdev, event, data);
 	return NOTIFY_DONE;
 
-- 
2.20.1

