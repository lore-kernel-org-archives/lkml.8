Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484D0C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13798246C0
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581607496;
	bh=95I4fJrY2I/63Omufoh19gK8kES5AAcYBHMGTpzeQKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QOasIhT27OTLT5ZPfpvasx2xzq6pzvYj9hJcBhMzkenuCUPzgHXx2NT/aTd3PCGLH
	 eLSZEzwFBXjsW8LbDEbuJPy86NsPKJzdBWNZVlsDijV+S3m0DHx/1+VttsFGJ+Mxh1
	 eH+GU/Jn8eZohcUV4DlnFR1jqdh41+0iMtRyav+8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbgBMPYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:24:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:34842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728406AbgBMPXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:23:31 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA8152469A;
        Thu, 13 Feb 2020 15:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607410;
        bh=95I4fJrY2I/63Omufoh19gK8kES5AAcYBHMGTpzeQKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iudQ/gwA9h0SfiEm+r0tAItG/FHABZwRPUHPdpNGrFVoCT9ezCMN96nAoryVc9NZg
         PAGeCevnzGq68qMb2cYLYUtvq3tnM2xuvl4ro7H0y0EjZ3lQZTKr2bT/ka2svxFvHq
         juWn15JSP27qcoEgHYkrLTS1jV+5vIjQJvCpw+TQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sven Van Asbroeck <TheSven73@gmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 4.9 032/116] power: supply: ltc2941-battery-gauge: fix use-after-free
Date:   Thu, 13 Feb 2020 07:19:36 -0800
Message-Id: <20200213151855.452948924@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151842.259660170@linuxfoundation.org>
References: <20200213151842.259660170@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Van Asbroeck <thesven73@gmail.com>

commit a60ec78d306c6548d4adbc7918b587a723c555cc upstream.

This driver's remove path calls cancel_delayed_work().
However, that function does not wait until the work function
finishes. This could mean that the work function is still
running after the driver's remove function has finished,
which would result in a use-after-free.

Fix by calling cancel_delayed_work_sync(), which ensures that
that the work is properly cancelled, no longer running, and
unable to re-schedule itself.

This issue was detected with the help of Coccinelle.

Cc: stable <stable@vger.kernel.org>
Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/power/supply/ltc2941-battery-gauge.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/power/supply/ltc2941-battery-gauge.c
+++ b/drivers/power/supply/ltc2941-battery-gauge.c
@@ -364,7 +364,7 @@ static int ltc294x_i2c_remove(struct i2c
 {
 	struct ltc294x_info *info = i2c_get_clientdata(client);
 
-	cancel_delayed_work(&info->work);
+	cancel_delayed_work_sync(&info->work);
 	power_supply_unregister(info->supply);
 	return 0;
 }


