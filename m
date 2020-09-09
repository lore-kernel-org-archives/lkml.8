Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF01C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 00:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F919218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 00:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R6gDusR4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729767AbgIIA50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 20:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgIIA5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 20:57:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C72C061755;
        Tue,  8 Sep 2020 17:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=edHMnCORJHCF3GGZi4la1uovDGKt4ZGTnbqEXZK5eEY=; b=R6gDusR4C0ITTwuInVdq7YY0RO
        fY7Dy3uBdw9OMnFtGW3eJfnKsqbQW5WD2e7iFGw7SAAUPb2GCQGmX6PvaW8/sdkjf9H0lZpW/IDBn
        +oonYdH8HVpdOQrwwhPE6UDVSN9TgAb7nEOQa/g4sSCBnzXyxqVSw3kRHOeZJLhJN2GjvZMfTjH4g
        sxabOm8I2Mf9yCSiXZ75kZRrrnRgywJc2k7Ud3ZQksqm5Sfu3oZK7+RXuHSL+ZwTI0174u4iRHAXa
        qwnoznCT33dVRoeGNuQzNmmn3TFoTcURuC4BpDFv3zOY1okOYHtF1jPiHQBArktVPdnY+1U80vDsF
        VI22d9Ew==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFoQL-000630-UP; Wed, 09 Sep 2020 00:57:22 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Jiri Kosina <trivial@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH trivial] usb: phy: phy-ab8500-usb: fix spello of "function"
Message-ID: <1be7e71f-6b79-290a-f38e-b51ccaf85e8e@infradead.org>
Date:   Tue, 8 Sep 2020 17:57:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix typo/spello of "function".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: linux-usb@vger.kernel.org
Cc: Jiri Kosina <trivial@kernel.org>
---
 drivers/usb/phy/phy-ab8500-usb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200908.orig/drivers/usb/phy/phy-ab8500-usb.c
+++ linux-next-20200908/drivers/usb/phy/phy-ab8500-usb.c
@@ -518,7 +518,7 @@ static int ab8500_usb_link_status_update
  *   3. Enable AB regulators
  *   4. Enable USB phy
  *   5. Reset the musb controller
- *   6. Switch the ULPI GPIO pins to fucntion mode
+ *   6. Switch the ULPI GPIO pins to function mode
  *   7. Enable the musb Peripheral5 clock
  *   8. Restore MUSB context
  */

