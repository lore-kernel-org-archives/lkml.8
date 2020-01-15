Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E913C33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 22:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 341C22465A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 22:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="otoo6KHo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730415AbgAOWAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 17:00:20 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:43628 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgAOWAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 17:00:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1579125618; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=KhSz6MDjMwdC6Nwg7gqos3ZZHedUXssF2MewbU5C6XI=;
        b=otoo6KHoswaAEPcdmPJJmU6z0jgiYobmzCqoEcphC7NaPGYDKWIFpUDSSDYvCt2b29eOZH
        WBvev+9PM89kYtydp3+3UU1DHfeHwcRnsNhO8Pw7zrfCY6AEUHv2aPmiVmPg8JMXYnXylC
        tKdnva8lBON6pNwIg+U2oI7R1uWnfe8=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     od@zcrc.me, linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] usb: musb: jz4740-musb driver updates
Date:   Wed, 15 Jan 2020 19:00:03 -0300
Message-Id: <20200115220008.91445-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bin, Greg,

Just a small note to say that this patchset lies on top of the current
usb-testing branch, since it depends on commit edce61776c7e ("usb: musb:
Add noirq type of dma create interface").

Cheers,
-Paul


