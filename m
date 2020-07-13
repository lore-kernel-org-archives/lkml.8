Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D53C433F1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 16:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 294B120738
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 16:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730619AbgGMQmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 12:42:10 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:42089 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729751AbgGMQmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 12:42:04 -0400
Received: from marcel-macbook.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id 581A5CECCA;
        Mon, 13 Jul 2020 18:52:00 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [Linux-kernel-mentees] [PATCH 2/2] net/bluetooth: Prevent
 out-of-bounds read in hci_inquiry_result_with_rssi_evt()
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <82c4e719b7615f5333444bdc2b5cc243a693eeb1.1594414498.git.yepeilin.cs@gmail.com>
Date:   Mon, 13 Jul 2020 18:42:02 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Greg KH <gregkh@linuxfoundation.org>,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <1B0C88A5-05B1-49FB-9B8C-8D833BA51AD9@holtmann.org>
References: <3f69f09d6eb0bc1430cae2894c635252a1cb09e1.1594414498.git.yepeilin.cs@gmail.com>
 <82c4e719b7615f5333444bdc2b5cc243a693eeb1.1594414498.git.yepeilin.cs@gmail.com>
To:     Peilin Ye <yepeilin.cs@gmail.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peilin,

> Check `num_rsp` before using it as for-loop counter. Add `unlock` label.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
> ---
> net/bluetooth/hci_event.c | 7 +++++++
> 1 file changed, 7 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

