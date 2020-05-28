Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78491C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 18:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D3A22078C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 18:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="m+xP5gEr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405914AbgE1SgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 14:36:03 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:10705 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405863AbgE1Sfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 14:35:55 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49XxGT4LZGz63;
        Thu, 28 May 2020 20:35:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1590690953; bh=JDXQmGIW53NRlTH7B094Eeot8dV9wNZ5qBuxOCKPMUY=;
        h=Date:From:Subject:To:Cc:From;
        b=m+xP5gErbXWNOqVWw+QSCUTA256Y3YYdiXr/xLyb3IUQ11U6aFUXkBL/65iQQ2/GC
         qWo9/51NWY9Ul5gqdLLIi7kg7Gz1qH6a1lQqygHcAwj2ykNr1x9X0mIxQxTm1NPMlN
         IyalaCwTS+GUaak0fSlxzFMqfKTMYpXjI+1xpaQ8V+nDpqQ8N8Tgfv0GBy2WNuVJas
         SY9EVlk3PKZFiPpTIhBFOiOvnXo1RSiOZMLRnv7yaGbm2JcHIAd/1Kg9vecGqDaH8T
         93BgjBYaRaR2e62MJhWQ0qbv2hz5C/f/25/U3lBnh0s3Wz2im1wYduvxwR2Ec9zB9N
         BgtVKsrysOogg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Thu, 28 May 2020 20:35:45 +0200
Message-Id: <cover.1590690650.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 0/3] usb: gadget: udc: atmel: assorted fixes
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Cristian Birsan <cristian.birsan@microchip.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Songjun Wu <songjun.wu@atmel.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two trivial fixes and .pullup implementation for Atmel UDC driver to
make composite gadget happy when handling reconfiguration.

Michał Mirosław (3):
  usb: gadget: udc: atmel: remove outdated comment in usba_ep_disable()
  usb: gadget: udc: atmel: fix uninitialized read in debug printk
  usb: gadget: udc: atmel: implement .pullup callback

 drivers/usb/gadget/udc/atmel_usba_udc.c | 30 ++++++++++++++++++-------
 1 file changed, 22 insertions(+), 8 deletions(-)

-- 
2.20.1

