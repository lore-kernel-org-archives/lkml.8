Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3347C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 925CD218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588943865;
	bh=RevHL6/ppsU+ZB24KHRGsVR2GQXsknbXP3xp1aWcpXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CMK/2kO33vimHKULVuzmE26eKQBHoJ129EPIsAtX1DiHEdulrXG2v4N2kWNkRgN1X
	 /x3V8IOkLW8fkVR7PWmNu2P5YqAHJInsGpKnRWwbLD16r+FhE6mU/8W+3BtxOyS5XS
	 iFqAXk2GzfmlWytqpOH/c93bh2/Emi4PO0PEtE8A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730488AbgEHNRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:17:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:41746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729106AbgEHMnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:43:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEEEB206B8;
        Fri,  8 May 2020 12:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941825;
        bh=RevHL6/ppsU+ZB24KHRGsVR2GQXsknbXP3xp1aWcpXQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BDzjNUDj+tO/hHOxJMM4mZRUNkMRuXNTkkNg+CmzBwvPH1ncfWob5i/cte5WCNIKr
         AlzW8xMLfTEhXz4NqyWA8xhzoTH9M2ZKkhQ3Rc2aLGMXLf/HtweBf7ybdyDk02aH2d
         yflFghPCs9yrZLNXoDx5x78r6bSOOvzUUPXtINhw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>,
        Eric Anholt <eric@anholt.net>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.4 185/312] pinctrl: bcm2835: Fix memory leak in error path
Date:   Fri,  8 May 2020 14:32:56 +0200
Message-Id: <20200508123137.489910835@linuxfoundation.org>
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

From: Stefan Wahren <stefan.wahren@i2se.com>

commit 53653c6b91750debba6dc4503003c851257fd340 upstream.

In case of an invalid pin value bcm2835_pctl_dt_node_to_map()
would leak the pull configs of already assigned pins.
So avoid this by calling the free map function in error case.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Fixes: e1b2dc70cd5b ("pinctrl: add bcm2835 driver")
Reviewed-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pinctrl/bcm/pinctrl-bcm2835.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/pinctrl/bcm/pinctrl-bcm2835.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
@@ -795,7 +795,7 @@ static int bcm2835_pctl_dt_node_to_map(s
 	return 0;
 
 out:
-	kfree(maps);
+	bcm2835_pctl_dt_free_map(pctldev, maps, num_pins * maps_per_pin);
 	return err;
 }
 


