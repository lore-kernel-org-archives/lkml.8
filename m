Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98860C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F9B320720
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588941815;
	bh=MOsrPGqoB4XXFQyaQh5HcvYhvqTCmszs5uk/mNvrLW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JNAcZzmpIA/evbCStbvAfNBtK2HxBhz/f5eyMSGiNox/VQHKRzQNJ3wmCc5YLPtHc
	 IPI7IRsUiGql8NxEwyiqXk2T8QZR/TVlpnf6qDObb9Y9Rtq9Ofhy8Ii0ENNWnMRYDD
	 Z5Pm2ot/9IjRe3vwW2PlA7sJKzMYRKGzr5bTJGuU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgEHMne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:43:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:41168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729072AbgEHMn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:43:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F083724973;
        Fri,  8 May 2020 12:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941805;
        bh=MOsrPGqoB4XXFQyaQh5HcvYhvqTCmszs5uk/mNvrLW0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1aVw+IN7Wesx0lJwlMWHLnoTc011jbUImQwNmCnwWQA2V1e7jYGm3/RXB0g/iwgnM
         PIKFX5uk0Qt9tcIrGpFAewFvgBBgcRGI2iDf7c9aFqT+z409SbIFK39Wx3YkDIIgm0
         9d3JzdA2e2lzie0tsy2K2UPFMPQeuqDotVq+AUTw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 4.4 178/312] power: ipaq-micro-battery: freeing the wrong variable
Date:   Fri,  8 May 2020 14:32:49 +0200
Message-Id: <20200508123137.003825094@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
References: <20200508123124.574959822@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

commit b9223da41794030a5dfd5106c34ed1b98255e2ae upstream.

We accidentally free "micro_ac_power" which is an error pointer and it
leads to an oops.  We intended to free "micro_batt_power".

Fixes: a2c1d531854c ('power_supply: ipaq_micro_battery: Check return values in probe')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/power/ipaq_micro_battery.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/power/ipaq_micro_battery.c
+++ b/drivers/power/ipaq_micro_battery.c
@@ -261,7 +261,7 @@ static int micro_batt_probe(struct platf
 	return 0;
 
 ac_err:
-	power_supply_unregister(micro_ac_power);
+	power_supply_unregister(micro_batt_power);
 batt_err:
 	cancel_delayed_work_sync(&mb->update);
 	destroy_workqueue(mb->wq);


