Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C878C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 18:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAAF220738
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 18:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406093AbgFXS3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 14:29:11 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:37734 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404995AbgFXS3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 14:29:10 -0400
Received: from marcel-macbook.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id 4A888CECDB;
        Wed, 24 Jun 2020 20:39:02 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] Bluetooth: btusb: BTUSB_WAKEUP_DISABLE prevents wake
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200624112428.1.Ib42ab202cfd82e7734571c302071da30a24ea27b@changeid>
Date:   Wed, 24 Jun 2020 20:29:08 +0200
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <51656AF4-EB93-44D1-8C1E-CD00A2BBA781@holtmann.org>
References: <20200624112428.1.Ib42ab202cfd82e7734571c302071da30a24ea27b@changeid>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhishek,

> When the BTUSB_WAKEUP_DISABLE flag is set, always return true for
> prevent wake. This tells the suspend notifier not to prepare the
> controller for reconnections during suspend.
> 
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
> Realtek chipsets currently lose their firmware when suspending (except
> in autosuspend where they assert remote_wakeup on the usb interface).
> There's no need to configure the Bluetooth stack for wake-up in this
> case so use the BTUSB_WAKEUP_DISABLE flag to also prevent wakeup from
> being configured.
> 
> This was tested on Chromebooks with Realtek chipsets running both 4.14
> and 5.4 kernel. It was tested with suspend functional tests and
> a suspend stress test for 50 iterations.
> 
> drivers/bluetooth/btusb.c | 3 +++
> 1 file changed, 3 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

