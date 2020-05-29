Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96458C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 11:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F960207D4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 11:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgE2LjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 07:39:07 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:43837 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgE2LjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 07:39:07 -0400
Received: from marcel-macbook.fritz.box (p4fefc5a7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 678C0CECD3;
        Fri, 29 May 2020 13:48:51 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v2] bluetooth: hci_qca: Fix suspend/resume functionality
 failure
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1590697867-7618-1-git-send-email-zijuhu@codeaurora.org>
Date:   Fri, 29 May 2020 13:39:03 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Harish Bandi <c-hbandi@codeaurora.org>,
        Hemantg <hemantg@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rocky Liao <rjliao@codeaurora.org>, stable@kernel.org,
        tientzu@chromium.org
Content-Transfer-Encoding: 7bit
Message-Id: <EF31B890-1520-460B-B337-46D99DAB999A@holtmann.org>
References: <1590697867-7618-1-git-send-email-zijuhu@codeaurora.org>
To:     Zijun Hu <zijuhu@codeaurora.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zijun,

> @dev parameter of qca_suspend()/qca_resume() represents
> serdev_device, but it is mistook for hci_dev and causes
> succedent unexpected memory access.
> 
> Fix by taking @dev as serdev_device.
> 
> Fixes: 41d5b25fed0 ("Bluetooth: hci_qca: add PM support")
> Signed-off-by: Zijun Hu <zijuhu@codeaurora.org>
> ---
> Changes in v2:
> - remove unused variable @hdev
> 
> drivers/bluetooth/hci_qca.c | 10 ++++++----
> 1 file changed, 6 insertions(+), 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

