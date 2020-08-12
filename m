Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC34C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADE37207F7
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597247839;
	bh=rtpZd4CzicwKfG2N+/esSbmfEn6gndlbOTXOwshb8U0=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=T+sERKLfLdes+AgbyJaIxSS0x+5KFhZJn9PsEs7tyv8tN1aCxFQbYzKqFLoSFPPTi
	 8UHrGB7dbs1kafi/pUaVx7uiESdzQh8Qk2LscdOJWy8NrQko1vx7r1HTyCQr5hgCik
	 S/+66gp6pFWG+RtR/IH0RVkmjL5LrGcFOHmma/AI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgHLP5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 11:57:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:46166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbgHLP5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 11:57:04 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 111DE22EBE;
        Wed, 12 Aug 2020 15:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597247821;
        bh=rtpZd4CzicwKfG2N+/esSbmfEn6gndlbOTXOwshb8U0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sVM9gvEs1xUk/gWr8ZU+EZicfli5KRFi9jh+y2EbvkxYhICrEmehuebgx2e4LHbB2
         9CgJKJlzaqvUtBzXwwv7P3uFKsG70WJzCWRlBCIll2nC51tq27LfLZI7L9z7bPoMCe
         DXlZxVPC61AE8XEmrjzI7mu4v14u50OmiMhUTjF8=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k5t7b-005t7G-6y; Wed, 12 Aug 2020 17:56:59 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH 36/44] staging: regulator: hi6421v600-regulator: initialize ramp_delay
Date:   Wed, 12 Aug 2020 17:56:46 +0200
Message-Id: <2fa9118fc676dc1e8aa46725da0b7de7b8eb0794.1597247164.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597247164.git.mchehab+huawei@kernel.org>
References: <cover.1597247164.git.mchehab+huawei@kernel.org>
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
 drivers/staging/hikey9xx/hi6421v600-regulator.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/hikey9xx/hi6421v600-regulator.c b/drivers/staging/hikey9xx/hi6421v600-regulator.c
index 5ddaf7f8cacc..21467fce9980 100644
--- a/drivers/staging/hikey9xx/hi6421v600-regulator.c
+++ b/drivers/staging/hikey9xx/hi6421v600-regulator.c
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

