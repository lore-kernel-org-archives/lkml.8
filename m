Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70924C433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 16:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B10F206F5
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 16:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730567AbgGMQmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 12:42:05 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:47865 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730298AbgGMQmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 12:42:02 -0400
Received: from marcel-macbook.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id 8F230CECC9;
        Mon, 13 Jul 2020 18:51:58 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [Linux-kernel-mentees] [PATCH 1/2] net/bluetooth: Prevent
 out-of-bounds read in hci_inquiry_result_evt()
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <3f69f09d6eb0bc1430cae2894c635252a1cb09e1.1594414498.git.yepeilin.cs@gmail.com>
Date:   Mon, 13 Jul 2020 18:42:00 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <72AE7F80-CE19-4051-85DB-60A3FD80D390@holtmann.org>
References: <3f69f09d6eb0bc1430cae2894c635252a1cb09e1.1594414498.git.yepeilin.cs@gmail.com>
To:     Peilin Ye <yepeilin.cs@gmail.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peilin,

> Check `num_rsp` before using it as for-loop counter.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
> ---
> net/bluetooth/hci_event.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

