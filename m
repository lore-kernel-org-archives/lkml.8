Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC31C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 08:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B5B120656
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 08:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbgFHIO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 04:14:57 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:48005 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729060AbgFHIO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 04:14:56 -0400
Received: from marcel-macpro.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id CC6E3CEC82;
        Mon,  8 Jun 2020 10:24:43 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 3/3] Bluetooth: hci_qca: Refactor error handling in
 qca_suspend()
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200605114552.3.Ib9b5e6e81ea31cdc964cd0562ef4985a6c6c5154@changeid>
Date:   Mon, 8 Jun 2020 10:14:54 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        Rocky Liao <rjliao@codeaurora.org>,
        Zijun Hu <zijuhu@codeaurora.org>, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Claire Chang <tientzu@chromium.org>
Content-Transfer-Encoding: 7bit
Message-Id: <7C70D49B-16CE-4299-8E35-78FA0668FF65@holtmann.org>
References: <20200605184611.252218-1-mka@chromium.org>
 <20200605114552.3.Ib9b5e6e81ea31cdc964cd0562ef4985a6c6c5154@changeid>
To:     Matthias Kaehlcke <mka@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

> If waiting for IBS sleep times out jump to the error handler, this is
> easier to read than multiple 'if' branches and a fall through to the
> error handler.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> 
> drivers/bluetooth/hci_qca.c | 12 +++++-------
> 1 file changed, 5 insertions(+), 7 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

