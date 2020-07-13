Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6482C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 06:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC85120674
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 06:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbgGMG3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 02:29:07 -0400
Received: from twhmllg3.macronix.com ([122.147.135.201]:18508 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729350AbgGMG3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 02:29:04 -0400
Received: from TWHMLLG3.macronix.com (localhost [127.0.0.2] (may be forged))
        by TWHMLLG3.macronix.com with ESMTP id 06D5upOs074331
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 13:56:51 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from twhfmlp1.macronix.com (twhfmlp1.macronix.com [172.17.20.91])
        by TWHMLLG3.macronix.com with ESMTP id 06D5umJN074304;
        Mon, 13 Jul 2020 13:56:48 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.macronix.com [172.17.14.55])
        by Forcepoint Email with ESMTP id 73E4BA0EA246962EF531;
        Mon, 13 Jul 2020 13:56:49 +0800 (CST)
In-Reply-To: <1590737775-4798-5-git-send-email-masonccyang@mxic.com.tw>
References: <1590737775-4798-1-git-send-email-masonccyang@mxic.com.tw> <1590737775-4798-5-git-send-email-masonccyang@mxic.com.tw>
To:     ycllin@mxic.com.tw
Cc:     boris.brezillon@collabora.com, broonie@kernel.org,
        juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        matthias.bgg@gmail.com, miquel.raynal@bootlin.com, p.yadav@ti.com,
        richard@nod.at, tudor.ambarus@microchip.com, vigneshr@ti.com
Subject: Re: [PATCH v4 4/7] mtd: spi-nor: core: add configuration register 2 read & write
 support
MIME-Version: 1.0
X-KeepSent: EB5FB2E6:05B846A9-482585A4:00209949;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OFEB5FB2E6.05B846A9-ON482585A4.00209949-482585A4.0020AAF4@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Mon, 13 Jul 2020 13:56:49 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2020/07/13 PM 01:56:49,
        Serialize complete at 2020/07/13 PM 01:56:49
Content-Type: text/plain; charset="US-ASCII"
X-MAIL: TWHMLLG3.macronix.com 06D5umJN074304
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


+ YC Lin in loop,

--
> 
> Subject
> 
> [PATCH v4 4/7] mtd: spi-nor: core: add configuration register 2 read & 
write support
> 
> Configuration register 2 is to set the device operation condition like
> STR or DTR mode at address offset 0 and DQS mode at address offset 
0x200.
> 
> Each device has various address offset for it's specific operatoin
> setting.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> ---


CONFIDENTIALITY NOTE:

This e-mail and any attachments may contain confidential information 
and/or personal data, which is protected by applicable laws. Please be 
reminded that duplication, disclosure, distribution, or use of this e-mail 
(and/or its attachments) or any part thereof is prohibited. If you receive 
this e-mail in error, please notify us immediately and delete this mail as 
well as its attachment(s) from your system. In addition, please be 
informed that collection, processing, and/or use of personal data is 
prohibited unless expressly permitted by personal data protection laws. 
Thank you for your attention and cooperation.

Macronix International Co., Ltd.

=====================================================================



============================================================================

CONFIDENTIALITY NOTE:

This e-mail and any attachments may contain confidential information and/or personal data, which is protected by applicable laws. Please be reminded that duplication, disclosure, distribution, or use of this e-mail (and/or its attachments) or any part thereof is prohibited. If you receive this e-mail in error, please notify us immediately and delete this mail as well as its attachment(s) from your system. In addition, please be informed that collection, processing, and/or use of personal data is prohibited unless expressly permitted by personal data protection laws. Thank you for your attention and cooperation.

Macronix International Co., Ltd.

=====================================================================

