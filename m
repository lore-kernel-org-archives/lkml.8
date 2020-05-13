Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D44DC2D0F8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 06:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E17A20708
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 06:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729963AbgEMGwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 02:52:17 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:41606 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729355AbgEMGwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 02:52:17 -0400
Received: from [192.168.1.91] (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 35DC6CED06;
        Wed, 13 May 2020 09:01:58 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 0/2] Bluetooth: Update LE scanning parameters for suspend
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200513020933.102443-1-abhishekpandit@chromium.org>
Date:   Wed, 13 May 2020 08:51:45 +0200
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <037EB7A4-BC2B-4776-B911-423A72F763A3@holtmann.org>
References: <20200513020933.102443-1-abhishekpandit@chromium.org>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhishek,

> This series updates the values used for window and interval when the
> system suspends. It also fixes a u8 vs u16 bug when setting up passive
> scanning.
> 
> The values chosen for window and interval are 11.25ms and 640ms. I have
> tested these on several Chromebooks with different LE peers (mouse,
> keyboard, Raspberry Pi running bluez) and all of them are able to wake
> the system with those parameters.
> 
> Thanks
> Abhishek
> 
> 
> 
> Abhishek Pandit-Subedi (2):
>  Bluetooth: Fix incorrect type for window and interval
>  Bluetooth: Modify LE window and interval for suspend
> 
> net/bluetooth/hci_request.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

both patches have been applied to bluetooth-next tree.

Regards

Marcel

