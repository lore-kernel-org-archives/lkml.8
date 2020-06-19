Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8BDC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 07:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F27D20739
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 07:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730725AbgFSHgB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 03:36:01 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:45799 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729740AbgFSHgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 03:36:01 -0400
Received: from marcel-macbook.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id 5D6D7CECF1;
        Fri, 19 Jun 2020 09:45:51 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 2/2] Bluetooth: btmtksdio: fix up firmware download
 sequence
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <51dda3f7e6e3a01b20145c5e879e837cec78b7da.1592463595.git.sean.wang@mediatek.com>
Date:   Fri, 19 Jun 2020 09:35:58 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Chen <Mark-YW.Chen@mediatek.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <2A034CCA-9FF9-4C78-B1D3-91B54CA271DC@holtmann.org>
References: <c9bf7346a060d8913b670bbed7ed9e60b592e16f.1592463595.git.sean.wang@mediatek.com>
 <51dda3f7e6e3a01b20145c5e879e837cec78b7da.1592463595.git.sean.wang@mediatek.com>
To:     Sean Wang <sean.wang@mediatek.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

> Data RAM on the device have to be powered on before starting to download
> the firmware.
> 
> Fixes: 9aebfd4a2200 ("Bluetooth: mediatek: add support for MediaTek MT7663S and MT7668S SDIO devices")
> Co-developed-by: Mark Chen <Mark-YW.Chen@mediatek.com>
> Signed-off-by: Mark Chen <Mark-YW.Chen@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
> drivers/bluetooth/btmtksdio.c | 16 +++++++++++++++-
> 1 file changed, 15 insertions(+), 1 deletion(-)

the patch doesn’t apply to bluetooth-next tree.

Regards

Marcel

