Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20279C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 12:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01A0720738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 12:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732564AbgFWMi2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 08:38:28 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:44271 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729574AbgFWMi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 08:38:28 -0400
Received: from marcel-macpro.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id 9B9B6CECC3;
        Tue, 23 Jun 2020 14:48:19 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v2 1/2] Bluetooth: btusb: fix up firmware download
 sequence
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1592850527-20931-1-git-send-email-sean.wang@mediatek.com>
Date:   Tue, 23 Jun 2020 14:38:26 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark-YW.Chen@mediatek.com
Content-Transfer-Encoding: 8BIT
Message-Id: <A854B681-BAFE-4FDD-9EE5-FBEF43385AA2@holtmann.org>
References: <5F6C2EB2-B0DF-4534-A123-4E6969A98410@holtmann.org>
 <1592850527-20931-1-git-send-email-sean.wang@mediatek.com>
To:     Sean Wang <sean.wang@mediatek.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

>>> Data RAM on the device have to be powered on before starting to
>>> download the firmware.
>>> 
>>> v1->v2:
>>> 	rebased to bluetooth-next
>>> 
>>> Fixes: a1c49c434e15 ("Bluetooth: btusb: Add protocol support for
>>> MediaTek MT7668U USB devices")
>>> Co-developed-by: Mark Chen <Mark-YW.Chen@mediatek.com>
>>> Signed-off-by: Mark Chen <Mark-YW.Chen@mediatek.com>
>>> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
>>> ---
>>> drivers/bluetooth/btusb.c | 16 +++++++++++++++-
>>> 1 file changed, 15 insertions(+), 1 deletion(-)
>> 
>> something is fishy here. git am still fails.
>> 
> 
> a little weird. I will try to git format-patch and send the patch again with another machine to you.

I think it is more important that you use git send-email to ensure that patch is delivered correctly. It looks like it got base64 encoded for no reason.

Regards

Marcel

