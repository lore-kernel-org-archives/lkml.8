Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0BDC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0CDE2076C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597160579;
	bh=vP6PyJ4SYYvqDtVUdtbgakiPQ2FEJTaB5GgBFirvOcI=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=gaJfrMwyQHaXXGBhcyBlQ9Y0wnld+Rm5oIOl/h3FRBkBl2d78M5evt3Y+a4FIoPra
	 Z3fOT4qOaTJL727ZdFSgo/7K3poHmamPHEjFkTYn9zFFHYEv6cml/Mt55G+zNN2nyL
	 AVAc6koYQqqrecA/oDvYeycDSPrMyYpLoq3Mt9JY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbgHKPmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 11:42:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:47558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729026AbgHKPmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 11:42:08 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F72F22D75;
        Tue, 11 Aug 2020 15:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597160524;
        bh=vP6PyJ4SYYvqDtVUdtbgakiPQ2FEJTaB5GgBFirvOcI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A8zov5JLB3fUj6eWzZ4e3WRpBzcWy4NV0MncYb6CTFwGYrrYP3VkklbLQONzC1h02
         tO/457azkkT5Qd1SJN66WD+Kj1pkwcHfRnVeU/eYs8m1JRe8M6KVPcUIS6fSad2cO1
         tMn3EY0aoRr3VhT+w4fc36eqg4hv/OJ26RiPi/MY=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k5WPa-004bnZ-9I; Tue, 11 Aug 2020 17:42:02 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 28/33] regulator: hi6421v600-regulator: initialize ramp_delay
Date:   Tue, 11 Aug 2020 17:41:54 +0200
Message-Id: <b5580abc1f54e71cb5016cade30d052d21faa97e.1597160086.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597160086.git.mchehab+huawei@kernel.org>
References: <cover.1597160086.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without that, the regulator's core complains with:

       ldo17: ramp_delay not set

For now, use the enable time, as we don't have any datasheets from
this device.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/regulator/hi6421v600-regulator.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/regulator/hi6421v600-regulator.c b/drivers/regulator/hi6421v600-regulator.c
index 5ddaf7f8cacc..21467fce9980 100644
--- a/drivers/regulator/hi6421v600-regulator.c
+++ b/drivers/regulator/hi6421v600-regulator.c
@@ -267,6 +267,9 @@ static int hi6421_spmi_dt_parse(struct platform_device *pdev,
 		return ret;
 	}
 
+	/* FIXME: are there a better value for this? */
+	rdesc->ramp_delay = rdesc->enable_time;
+
 	/* parse .eco_uA */
 	ret = of_property_read_u32(np, "eco-microamp",
 				   &sreg->eco_uA);
-- 
2.26.2

