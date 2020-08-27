Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCFFC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 12:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F75A2177B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 12:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="TQqPIETd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbgH0MtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 08:49:17 -0400
Received: from crapouillou.net ([89.234.176.41]:42534 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729097AbgH0Mnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 08:43:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1598532195; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=rDzVXd+3PKcewwf2mNEZ0MmfaCChGWVuexHP2Hb/JXw=;
        b=TQqPIETdQ8ngDu7lBLhSkUG4hp36/EevjKVFU9eBJxzVG4Tl4Ks/LMKk2Nm545NVxl8Tee
        rrh4CtOIcX2fZppAzQxoFwqx8SE+WDGYVCy2cqGF4oFpwMNKFYW4xmf8yoG7lb/jR5EKyG
        o/KUtMHc3kMvAb5ejKRMWzhu8tyU/Mc=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Felipe Balbi <balbi@kernel.org>,
        =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0?= <zhouyanjie@wanyeetech.com>,
        =?UTF-8?q?=E5=91=A8=E6=AD=A3?= <sernia.zhou@foxmail.com>,
        =?UTF-8?q?=E6=BC=86=E9=B9=8F=E6=8C=AF?= <aric.pzqi@ingenic.com>
Cc:     od@zcrc.me, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 0/1] USB: PHY: JZ4770: Next time, please test it
Date:   Thu, 27 Aug 2020 14:43:07 +0200
Message-Id: <20200827124308.71963-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a fix for the phy-jz4770 driver, which is broken in 5.9-rc2
starting from commit 2a6c0b82e651 ("USB: PHY: JZ4770: Add support for new Ingenic SoCs.").

I'm not amused by this, considering that this patch was obviously not
tested, yet it has a Tested-by tag. Next time, please test your patches
before sending them.

Thanks,
-Paul

Paul Cercueil (1):
  USB: PHY: JZ4770: Fix uninitialized value written to HW register

 drivers/usb/phy/phy-jz4770.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

-- 
2.28.0

