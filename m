Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD25C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 06:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B3AF206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 06:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgFAGGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 02:06:10 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:47655 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbgFAGGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 02:06:10 -0400
Received: from marcel-macbook.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id 08EB0CED01;
        Mon,  1 Jun 2020 08:15:56 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v1] Bluetooth: btmtkuart: Use serdev_device_write_buf()
 instead of serdev_device_write()
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1590767936-21907-1-git-send-email-zijuhu@codeaurora.org>
Date:   Mon, 1 Jun 2020 08:06:08 +0200
Cc:     Sean Wang <sean.wang@mediatek.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, mka@chromium.org
Content-Transfer-Encoding: 7bit
Message-Id: <E9312CE8-DEA4-4F63-97AE-B8A9FF338F61@holtmann.org>
References: <1590767936-21907-1-git-send-email-zijuhu@codeaurora.org>
To:     Zijun Hu <zijuhu@codeaurora.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zijun,

> serdev_device_write() is not appropriate at here because
> serdev_device_write_wakeup() is not used to release completion hold
> by the former at @write_wakeup member of struct serdev_device_ops.
> 
> Fix by using serdev_device_write_buf() instead of serdev_device_write().
> 
> Signed-off-by: Zijun Hu <zijuhu@codeaurora.org>
> ---
> drivers/bluetooth/btmtkuart.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

