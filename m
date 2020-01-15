Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DF9C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 21:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9079F2081E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 21:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbgAOVcr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 16:32:47 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:48441 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728998AbgAOVcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 16:32:46 -0500
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id D197DCECF2;
        Wed, 15 Jan 2020 22:42:02 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH v7 0/2] add support of interrupt for host wakeup from
 devicetree in BCM HCI driver
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200115101243.17094-1-glaroque@baylibre.com>
Date:   Wed, 15 Jan 2020 22:32:44 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        johan@kernel.org, nsaenzjulienne@suse.de,
        linux-kernel@vger.kernel.org, khilman@baylibre.com
Content-Transfer-Encoding: 8BIT
Message-Id: <8F9FC361-4CF3-48EE-A88B-D6429714C8BE@holtmann.org>
References: <20200115101243.17094-1-glaroque@baylibre.com>
To:     Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guillaume,

> add interrupts and interrupt-names properties to set host wakeup IRQ.
> actually driver find this IRQ from host-wakeup-gpios propety
> but some platforms are not supported gpiod_to_irq function.
> so to have possibility to use interrupt mode we need to add interrupts
> field in devicetree and support it in driver.
> 
> change sinve v6:
> - depracate host-wakeup-gpios 
> 
> change sinve v5:
> - add tags
> 
> change sinve v4 [1]:
> - add patch to update Documentation
> - use of_irq_get_byname to be more clear and move call in bcm_of_probe
> - update commit message
> 
> change since v3:
> - move on of_irq instead of platform_get_irq
> 
> change since v2:
> - fix commit message
> 
> change since v1:
> - rebase patch
> 
> [1] https://lore.kernel.org/linux-bluetooth/20191213105521.4290-1-glaroque@baylibre.com/
> 
> Guillaume La Roque (2):
>  dt-bindings: net: bluetooth: add interrupts properties
>  bluetooth: hci_bcm: enable IRQ capability from devicetree
> 
> .../devicetree/bindings/net/broadcom-bluetooth.txt         | 7 +++++--
> drivers/bluetooth/hci_bcm.c                                | 3 +++
> 2 files changed, 8 insertions(+), 2 deletions(-)

both patches have been applied to bluetooth-next tree.

Regards

Marcel

