Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5EBC3B18B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22BBA20675
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581609205;
	bh=c+NAbmXVUCR2NCHZlhlJbWAl+qAOyeaTOTrvAYJSc7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PJxGLvP4yA2pxzsocNFFEFTNBDGL6LkNtxWVMWrDcDWqQNDm6PfTRFGVdBm433Kwp
	 +S5XtDbeDd8voet6/368YtDq2OyyrQw+Re/U4JCiMYmNuFMc9b83Y8p46C1tBz3HWA
	 oo/qTGPO9lLkaoFfaYvtQZ4b/baAo+MbAv9RuIUA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbgBMPxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:53:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:43374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728639AbgBMP0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:26:05 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82A8124690;
        Thu, 13 Feb 2020 15:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607564;
        bh=c+NAbmXVUCR2NCHZlhlJbWAl+qAOyeaTOTrvAYJSc7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C08jtjSBKoqwzYcD+O74ky90mjR8URc2wboGcy8LD3JHoc6Jlqx1QUkcFx0S0P06h
         BTUeLEf5jsyiS5s+lP9+W5g9EtuaiwO9kZ20+2v9JGZpgm2oSRj1VLNEKobgp5bB0i
         4r6vAWAPbdKjKbOVC1RTtbHZlTzCHa5NKF3AEn/Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 4.14 154/173] platform/x86: intel_mid_powerbtn: Take a copy of ddata
Date:   Thu, 13 Feb 2020 07:20:57 -0800
Message-Id: <20200213152010.229179137@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151931.677980430@linuxfoundation.org>
References: <20200213151931.677980430@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mika Westerberg <mika.westerberg@linux.intel.com>

commit 5e0c94d3aeeecc68c573033f08d9678fecf253bd upstream.

The driver gets driver_data from memory that is marked as const (which
is probably put to read-only memory) and it then modifies it. This
likely causes some sort of fault to happen.

Fix this by taking a copy of the structure.

Fixes: c94a8ff14de3 ("platform/x86: intel_mid_powerbtn: make mid_pb_ddata const")
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/platform/x86/intel_mid_powerbtn.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/platform/x86/intel_mid_powerbtn.c
+++ b/drivers/platform/x86/intel_mid_powerbtn.c
@@ -158,9 +158,10 @@ static int mid_pb_probe(struct platform_
 
 	input_set_capability(input, EV_KEY, KEY_POWER);
 
-	ddata = (struct mid_pb_ddata *)id->driver_data;
+	ddata = devm_kmemdup(&pdev->dev, (void *)id->driver_data,
+			     sizeof(*ddata), GFP_KERNEL);
 	if (!ddata)
-		return -ENODATA;
+		return -ENOMEM;
 
 	ddata->dev = &pdev->dev;
 	ddata->irq = irq;


