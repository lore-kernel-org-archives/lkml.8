Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E098BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 08:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3DC52063A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 08:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgE1IiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 04:38:19 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:53112 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbgE1IiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 04:38:19 -0400
Received: from marcel-macpro.fritz.box (p4fefc5a7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 11449CECB0;
        Thu, 28 May 2020 10:48:04 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] Bluetooth: btbcm: Added 003.006.007, changed 001.003.015
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200524174129.29372-1-azamat.hackimov@gmail.com>
Date:   Thu, 28 May 2020 10:38:17 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <E02C79DB-527F-4CAB-80AB-BE58BA14C87A@holtmann.org>
References: <20200524174129.29372-1-azamat.hackimov@gmail.com>
To:     "Azamat H. Hackimov" <azamat.hackimov@gmail.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Azamat,

> Added new Broadcom device BCM4350C5, changed BCM4354A2 to BCM4356A2.
> 
> Based on Broadcom Windows drivers 001.003.015 should be BCM4356A2. I
> have user report that firmware name is misplaced
> (https://github.com/winterheart/broadcom-bt-firmware/issues/3).
> 
> Signed-off-by: Azamat H. Hackimov <azamat.hackimov@gmail.com>
> ---
> drivers/bluetooth/btbcm.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

