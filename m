Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3CEC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10664206F6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgGGPiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:38:50 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:58563 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728194AbgGGPis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:38:48 -0400
Received: from marcel-macbook.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id DF556CECED;
        Tue,  7 Jul 2020 17:48:42 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v1] Bluetooth: Fix kernel oops triggered by
 hci_adv_monitors_clear()
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200629201441.v1.1.I162e3c6c4f4d963250c37733c3428329110c5989@changeid>
Date:   Tue, 7 Jul 2020 17:38:46 +0200
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Alain Michaud <alainm@chromium.org>,
        Pavel Machek <pavel@ucw.cz>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <8174F3F7-52C5-4F15-8BF5-E005B44A55C0@holtmann.org>
References: <20200629201441.v1.1.I162e3c6c4f4d963250c37733c3428329110c5989@changeid>
To:     Miao-chen Chou <mcchou@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miao-chen,

> This fixes the kernel oops by removing unnecessary background scan
> update from hci_adv_monitors_clear() which shouldn't invoke any work
> queue.
> 
> The following test was performed.
> - Run "rmmod btusb" and verify that no kernel oops is triggered.
> 
> Signed-off-by: Miao-chen Chou <mcchou@chromium.org>
> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> Reviewed-by: Alain Michaud <alainm@chromium.org>
> ---
> 
> net/bluetooth/hci_core.c | 2 --
> 1 file changed, 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

