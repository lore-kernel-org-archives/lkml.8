Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5057C2D0F8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 07:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB5EB206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 07:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732122AbgEMHNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 03:13:17 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:51825 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgEMHNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 03:13:17 -0400
Received: from [192.168.1.91] (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id AA8F5CED07;
        Wed, 13 May 2020 09:22:57 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 0/3] Bluetooth: Prevent scanning when device is not
 configured for wakeup
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200513021927.115700-1-abhishekpandit@chromium.org>
Date:   Wed, 13 May 2020 09:12:44 +0200
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <F6E282C4-8688-47A8-946D-70A5ABFB9257@holtmann.org>
References: <20200513021927.115700-1-abhishekpandit@chromium.org>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhishek,

> This patch series adds a hook to prevent Bluetooth from scanning during
> suspend if it is not configured to wake up. It's not always clear who
> the wakeup owner is from looking at hdev->dev so we need the driver to
> inform us whether to set up scanning.
> 
> By default, when no `prevent_wake` hook is implemented, we always
> configure scanning for wake-up.
> 
> Thanks
> Abhishek
> 
> 
> 
> Abhishek Pandit-Subedi (3):
>  Bluetooth: Rename BT_SUSPEND_COMPLETE
>  Bluetooth: Add hook for driver to prevent wake from suspend
>  Bluetooth: btusb: Implement hdev->prevent_wake
> 
> drivers/bluetooth/btusb.c        | 8 ++++++++
> include/net/bluetooth/hci_core.h | 3 ++-
> net/bluetooth/hci_core.c         | 8 +++++---
> net/bluetooth/hci_request.c      | 2 +-
> 4 files changed, 16 insertions(+), 5 deletions(-)

all 3 patches have been applied to bluetooth-next tree.

Regards

Marcel

