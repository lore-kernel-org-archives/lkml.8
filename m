Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B01FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 01:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 507A720748
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 01:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="CbPBKH1/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbgHKBHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 21:07:54 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:23492 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727979AbgHKBHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 21:07:43 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4BQZSZ0zymzLn;
        Tue, 11 Aug 2020 03:07:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1597108062; bh=gYTKXUJutik2+Fs5P1UBl/jeqdfUWT0Kq6EVMrvv6U0=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=CbPBKH1/HAGPGR2UqFXWoat9fIdTQCxfT38z++7jQytdFuepdoUUgDgECL4JxWVb5
         AtpeYKLvWigemKU8rorlVkL8EbYmRuz8idqJrAecH1KcmqgPOH3xGXDPul8uyYEei8
         XPoYK8tM0w+8cdVPTokmP+PBbC8wYLF31dIWmjSX2aW3f9L9+o9OFNqTv/YjB4pKq1
         b39g7xajRl0EeKfaUe/zQH6kkUGgflbKyysbKZg4VHkKHL2LOA5R08oNtczhRfuzCB
         4iHb3FMDj7gsZ2fCuTMYpeLOjMwdOrLHqLaYQJhK2s29HWs0QJSJ4k/vdMKzyZItfB
         j5XuyDwIGGn/A==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Tue, 11 Aug 2020 03:07:41 +0200
Message-Id: <169f98e7a2064a184167abc0f206f3a92513b8d8.1597107682.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1597107682.git.mirq-linux@rere.qmqm.pl>
References: <cover.1597107682.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 7/7] regulator: remove superfluous lock in
 regulator_resolve_coupling()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Dmitry Osipenko <digetx@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Vladimir Zapolskiy <vz@mleia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code modifies rdev, but locks c_rdev instead. The bug remains:
stored c_rdev could be freed just after unlock anyway. This doesn't blow
up because regulator_list_mutex taken outside holds it together.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index b85ec974944e..f8834559a2fb 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4942,13 +4942,9 @@ static void regulator_resolve_coupling(struct regulator_dev *rdev)
 			return;
 		}
 
-		regulator_lock(c_rdev);
-
 		c_desc->coupled_rdevs[i] = c_rdev;
 		c_desc->n_resolved++;
 
-		regulator_unlock(c_rdev);
-
 		regulator_resolve_coupling(c_rdev);
 	}
 }
-- 
2.20.1

