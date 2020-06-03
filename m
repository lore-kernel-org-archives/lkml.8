Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A81C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF70C2068D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgFCRwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 13:52:38 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:59020 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgFCRwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 13:52:37 -0400
Received: from marcel-macbook.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id 99CF5CED2F;
        Wed,  3 Jun 2020 20:02:23 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] Bluetooth: Check scan state before disabling during
 suspend
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200601184223.1.I281c81384150e8fefbebf32fa79cb091d0311208@changeid>
Date:   Wed, 3 Jun 2020 19:52:35 +0200
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <2FBCE848-7DDE-446A-A159-0B1A53AE7893@holtmann.org>
References: <20200601184223.1.I281c81384150e8fefbebf32fa79cb091d0311208@changeid>
To:     Manish Mandlik <mmandlik@google.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manish,

> Check current scan state by checking HCI_LE_SCAN flag and send scan
> disable command only if scan is already enabled.
> 
> Signed-off-by: Manish Mandlik <mmandlik@google.com>
> ---
> 
> net/bluetooth/hci_request.c | 10 ++++++----
> 1 file changed, 6 insertions(+), 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

