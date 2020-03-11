Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E69C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 02:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF82D20637
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 02:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgCKCkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 22:40:18 -0400
Received: from twhmllg3.macronix.com ([211.75.127.131]:52222 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbgCKCkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 22:40:18 -0400
Received: from twhfmlp1.macronix.com (twhfm1p1.macronix.com [172.17.20.91])
        by TWHMLLG3.macronix.com with ESMTP id 02B2e4K9076230;
        Wed, 11 Mar 2020 10:40:04 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.macronix.com [172.17.14.55])
        by Forcepoint Email with ESMTP id C5868B39AA6AF42ADD58;
        Wed, 11 Mar 2020 10:40:04 +0800 (CST)
In-Reply-To: <20200310202723.16b48f4b@collabora.com>
References: <1583220084-10890-1-git-send-email-masonccyang@mxic.com.tw> <1583220084-10890-2-git-send-email-masonccyang@mxic.com.tw> <20200310202723.16b48f4b@collabora.com>
To:     "Boris Brezillon" <boris.brezillon@collabora.com>
Cc:     allison@lohutok.net, bbrezillon@kernel.org,
        frieder.schrempf@kontron.de, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        miquel.raynal@bootlin.com, rfontana@redhat.com, richard@nod.at,
        s.hauer@pengutronix.de, stefan@agner.ch, tglx@linutronix.de,
        vigneshr@ti.com, yuehaibing@huawei.com
Subject: Re: [PATCH v3 1/4] mtd: rawnand: Add support manufacturer specific lock/unlock
 operation
MIME-Version: 1.0
X-KeepSent: CDE22522:001A7410-48258528:000E260F;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OFCDE22522.001A7410-ON48258528.000E260F-48258528.000EA7E7@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Wed, 11 Mar 2020 10:40:04 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2020/03/11 AM 10:40:04,
        Serialize complete at 2020/03/11 AM 10:40:04
Content-Type: text/plain; charset="US-ASCII"
X-MAIL: TWHMLLG3.macronix.com 02B2e4K9076230
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Boris,

> > Add nand_lock() & nand_unlock() for manufacturer specific lock & 
unlock
> > operation while the device supports Block Portection function.
> > 
> > Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> > Reported-by: kbuild test robot <lkp@intel.com>
> 
> Reported-by on something that's not a fix doesn't make sense. I know
> the 0day bot asked you to add this tag, but that should only be done if
> you submit a separate patch, ideally with a Fixes tag. If the offending
> patch has not been merged yet, you should just fix the commit and ignore
> the Reported-by tag (you can mention who reported the problem in the
> changelog though).
> 

okay, understand it.
Thanks a lot for your explanation.

Mason

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

