Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD63C2D0F8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 07:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A67EF206D6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 07:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730479AbgEMH2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 03:28:10 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:45716 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728490AbgEMH2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 03:28:09 -0400
Received: from [192.168.1.91] (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id EA86BCED09;
        Wed, 13 May 2020 09:37:50 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] Bluetooth: serdev: Constify serdev_device_ops
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200509131719.5681-1-rikard.falkeborn@gmail.com>
Date:   Wed, 13 May 2020 09:28:08 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <4B316DC7-D034-483A-A461-2BF2CC4C2565@holtmann.org>
References: <20200509131719.5681-1-rikard.falkeborn@gmail.com>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rikard,

> serdev_device_ops is not modified and can be const. Also, remove the
> unneeded declaration of it.
> 
> Output from the file command before and after:
> 
> Before:
>   text    data     bss     dec     hex filename
>   7192    2408     192    9792    2640 drivers/bluetooth/hci_serdev.o
> 
> After:
>   text    data     bss     dec     hex filename
>   7256    2344     192    9792    2640 drivers/bluetooth/hci_serdev.o
> 
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> ---
> drivers/bluetooth/hci_serdev.c | 4 +---
> 1 file changed, 1 insertion(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

