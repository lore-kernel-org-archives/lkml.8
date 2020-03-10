Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CBAC10F25
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 02:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 427D620637
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 02:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgCJCaW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 22:30:22 -0400
Received: from twhmllg4.macronix.com ([211.75.127.132]:14569 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbgCJCaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 22:30:21 -0400
Received: from twhfm1p2.macronix.com (twhfm1p2.macronix.com [172.17.20.92])
        by TWHMLLG4.macronix.com with ESMTP id 02A2U9g6072289;
        Tue, 10 Mar 2020 10:30:09 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.mxic.com.tw [172.17.14.55])
        by Forcepoint Email with ESMTP id 337CDB3A3A355115CDAE;
        Tue, 10 Mar 2020 10:30:09 +0800 (CST)
In-Reply-To: <20200309141403.241e773e@xps13>
References: <1583220084-10890-1-git-send-email-masonccyang@mxic.com.tw> <20200309141403.241e773e@xps13>
To:     "Miquel Raynal" <miquel.raynal@bootlin.com>
Cc:     allison@lohutok.net, bbrezillon@kernel.org,
        frieder.schrempf@kontron.de, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        rfontana@redhat.com, richard@nod.at, s.hauer@pengutronix.de,
        stefan@agner.ch, tglx@linutronix.de, vigneshr@ti.com,
        yuehaibing@huawei.com
Subject: Re: [PATCH v3 0/4] mtd: rawnand: Add support Macronix Block Portection & Deep
 Power Down mode
MIME-Version: 1.0
X-KeepSent: C31C83BB:5F8F8B14-48258527:000B6AF2;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OFC31C83BB.5F8F8B14-ON48258527.000B6AF2-48258527.000DBE12@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Tue, 10 Mar 2020 10:30:09 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2020/03/10 AM 10:30:09,
        Serialize complete at 2020/03/10 AM 10:30:09
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-MAIL: TWHMLLG4.macronix.com 02A2U9g6072289
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Miquel,

> 
> Mason Yang <masonccyang@mxic.com.tw> wrote on Tue,  3 Mar 2020 15:21:20
> +0800:
> 
> > Hi,
> > 
> > Changelog
> > 
> > v3:
> > patch nand_lock_area/nand_unlock_area.
> > fixed kbuidtest robot warnings and reviewer's comments.
> 
> I know it is painful for the contributor but I really need more details
> in the changelog. This is something I care about because I can speed-up

okay, more changelog as

1. Patched the Kdoc for both lock_area/unlock_area and _suspend/_resume
2. Created a helper to read default protected value (after device power 
on)
        for protection function detection.
3. patched the prefix for Macronix deep power down command, 0xB9
4. Patched the description of mxic_nand_resume() and add a small sleeping 
delay.
5. Created a helper for deep power down device part number detection.


> my reviews when I know what I already acked or not. "fixing reviewer's
> comments" is way too vague, I have absolutely no idea of what I told
> you last time :) So please, for the next iterations, be more verbose in
> these changelogs! (that's fine for this one, I'll check myself).
> 
> Cheers,
> Miquèl

thanks for your time and review.
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

