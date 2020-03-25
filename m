Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01400C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 01:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4EF92073C
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 01:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbgCYBJr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 21:09:47 -0400
Received: from twhmllg4.macronix.com ([211.75.127.132]:10779 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbgCYBJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 21:09:47 -0400
Received: from twhfm1p2.macronix.com (twhfmlp2.macronix.com [172.17.20.92])
        by TWHMLLG4.macronix.com with ESMTP id 02P19dJM056234;
        Wed, 25 Mar 2020 09:09:39 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.mxic.com.tw [172.17.14.55])
        by Forcepoint Email with ESMTP id 8F40FA52ED8DA1FC9596;
        Wed, 25 Mar 2020 09:09:39 +0800 (CST)
In-Reply-To: <20200324225739.11538d08@xps13>
References: <1584517348-14486-1-git-send-email-masonccyang@mxic.com.tw> <1584517348-14486-3-git-send-email-masonccyang@mxic.com.tw> <20200324225739.11538d08@xps13>
To:     "Miquel Raynal" <miquel.raynal@bootlin.com>
Cc:     allison@lohutok.net, bbrezillon@kernel.org,
        frieder.schrempf@kontron.de, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        richard@nod.at, s.hauer@pengutronix.de, stefan@agner.ch,
        tglx@linutronix.de, vigneshr@ti.com, yuehaibing@huawei.com
Subject: Re: [PATCH v4 2/2] mtd: rawnand: macronix: Add support for deep power down
 mode
MIME-Version: 1.0
X-KeepSent: 7F063DBA:65AA16F3-48258536:0006374F;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OF7F063DBA.65AA16F3-ON48258536.0006374F-48258536.00065F7D@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Wed, 25 Mar 2020 09:09:39 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2020/03/25 AM 09:09:39,
        Serialize complete at 2020/03/25 AM 09:09:39
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-MAIL: TWHMLLG4.macronix.com 02P19dJM056234
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Miquel,

> Mason Yang <masonccyang@mxic.com.tw> wrote on Wed, 18 Mar 2020 15:42:28
> +0800:
> 
> > Macronix AD series support deep power down mode for a minimum
> > power consumption state.
> > 
> > Overload nand_suspend() & nand_resume() in Macronix specific code to
> > support deep power down mode.
> > 
> > Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> 
> This was not based on nand/next so as I applied changes in this files
> (patches 1 and 2 of the original series) this patch did not apply. I
> manually merged it.

Got it and thanks a lot for your help.

> 
> 
> Thanks,
> Miquèl

best regards,
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

