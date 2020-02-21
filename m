Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D8FC11D00
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 02:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D8B6207FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 02:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbgBUCoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 21:44:17 -0500
Received: from twhmllg3.macronix.com ([211.75.127.131]:14394 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729259AbgBUCoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 21:44:17 -0500
Received: from twhfmlp1.macronix.com (twhfm1p1.macronix.com [172.17.20.91])
        by TWHMLLG3.macronix.com with ESMTP id 01L2iBgM043871;
        Fri, 21 Feb 2020 10:44:11 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.macronix.com [172.17.14.55])
        by Forcepoint Email with ESMTP id 891C3BD214BC865C0EDB;
        Fri, 21 Feb 2020 10:44:11 +0800 (CST)
In-Reply-To: <20200109180128.0f3e7b99@xps13>
References: <1572256527-5074-1-git-send-email-masonccyang@mxic.com.tw>  <1572256527-5074-5-git-send-email-masonccyang@mxic.com.tw> <20200109180128.0f3e7b99@xps13>
To:     "Miquel Raynal" <miquel.raynal@bootlin.com>
Cc:     bbrezillon@kernel.org, computersforpeace@gmail.com,
        dwmw2@infradead.org, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        marek.vasut@gmail.com, richard@nod.at, vigneshr@ti.com
Subject: Re: [PATCH v2 4/4] mtd: rawnand: Add support Macronix deep power down mode
MIME-Version: 1.0
X-KeepSent: D2853198:840A44DE-48258515:0008B888;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OFD2853198.840A44DE-ON48258515.0008B888-48258515.000F0829@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Fri, 21 Feb 2020 10:44:11 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2020/02/21 AM 10:44:11,
        Serialize complete at 2020/02/21 AM 10:44:11
Content-Type: text/plain; charset="US-ASCII"
X-MAIL: TWHMLLG3.macronix.com 01L2iBgM043871
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Miquel,

 
> > Macronix AD series support deep power down mode for a minimum
> > power consumption state.
> > 
> > Patch nand_suspend() & nand_resume() by Macronix specific
> > deep power down mode command and exit it.
> > 
> > Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> > ---
> >  drivers/mtd/nand/raw/nand_macronix.c | 72 
+++++++++++++++++++++++++++++++++++-
> >  1 file changed, 70 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/mtd/nand/raw/nand_macronix.c 
b/drivers/mtd/nand/raw/
> nand_macronix.c
> > index 13929bf..3098bc0 100644
> > --- a/drivers/mtd/nand/raw/nand_macronix.c
> > +++ b/drivers/mtd/nand/raw/nand_macronix.c
> > @@ -15,6 +15,8 @@
> >  #define MXIC_BLOCK_PROTECTION_ALL_LOCK 0x38
> >  #define MXIC_BLOCK_PROTECTION_ALL_UNLOCK 0x0
> > 
> > +#define NAND_CMD_POWER_DOWN 0xB9
> 
> I suppose this value is Macronix specific, and hence should have a
> MACRONIX_ or MXIC_ prefix instead of NAND_.

okay, will patch it to
#define MXIC_CMD_POWER_DOWN 0xB9

> 
> > +
> >  struct nand_onfi_vendor_macronix {
> >     u8 reserved;
> >     u8 reliability_func;
> > @@ -137,13 +139,66 @@ static int mxic_nand_unlock(struct nand_chip 
*chip, 
> loff_t ofs, uint64_t len)
> >     return ret;
> >  }
> > 
> > +int nand_power_down_op(struct nand_chip *chip)
> > +{
> > +   int ret;
> > +
> > +   if (nand_has_exec_op(chip)) {
> > +      struct nand_op_instr instrs[] = {
> > +         NAND_OP_CMD(NAND_CMD_POWER_DOWN, 0),
> > +      };
> > +
> > +      struct nand_operation op = NAND_OPERATION(chip->cur_cs, 
instrs);
> > +
> > +      ret = nand_exec_op(chip, &op);
> > +      if (ret)
> > +         return ret;
> > +
> > +   } else {
> > +      chip->legacy.cmdfunc(chip, NAND_CMD_POWER_DOWN, -1, -1);
> > +   }
> > +
> > +   return 0;
> > +}
> > +
> > +static int mxic_nand_suspend(struct nand_chip *chip)
> > +{
> > +   int ret;
> > +
> > +   nand_select_target(chip, 0);
> > +   ret = nand_power_down_op(chip);
> > +   if (ret < 0)
> > +      pr_err("%s called for chip into suspend failed\n", __func__);
> 
> What about something more specific?
> 
>        "Suspending MXIC NAND chip failed (%)\n", ret

okay, patch it with this sentence, thanks.

> 
> > +   nand_deselect_target(chip);
> > +
> > +   return ret;
> > +}
> > +
> > +static void mxic_nand_resume(struct nand_chip *chip)
> > +{
> > +   /*
> > +    * Toggle #CS pin to resume NAND device and don't care
> > +    * of the others CLE, #WE, #RE pins status.
> > +    * Here sending power down command to toggle #CS line.
> 
> The first sentence seems right, the second could be upgraded:
> 
>            The purpose of doing a power down operation is just to
>            ensure some bytes will be sent over the NAND bus so that #CS
>            gets toggled because this is why the chip is woken up.
>       The content of the bytes sent on the NAND bus are not
>       relevant at this time. Sending bytes on the bus is mandatory
>       for a lot of NAND controllers otherwise they are not able to
>       just assert/de-assert #CS.

okay, will patch the second sentence based on your comments.
i.e,.

 /*
  * Toggle #CS pin to resume NAND device and don't care
  * of the others CLE, #WE, #RE pins status.
  * A NAND controller ensure it is able to assert/de-assert #CS
  * by sending any byte over the NAND bus.
  * i.e.,
  * NAND power down command or reset command.
  */ 

> 
> > +    */
> > +   nand_select_target(chip, 0);
> > +   nand_power_down_op(chip);
> 
> Are you sure sending a power_down_op will not be interpreted by the
> chip?

yes, sure !

> 
> I would expect a sleeping delay here, even small.

okay, will patch it.

> 
> > +   nand_deselect_target(chip);
> > +}
> > +
> >  /*
> > - * Macronix NAND AC series support Block Protection by SET_FEATURES
> > + * Macronix NAND AC & AD series support Block Protection by 
SET_FEATURES
> >   * to lock/unlock blocks.
> >   */
> >  static int macronix_nand_init(struct nand_chip *chip)
> >  {
> > -   bool blockprotected = false;
> > +   unsigned int i;
> > +   bool blockprotected = false, powerdown = false;
> > +   static const char * const power_down_dev[] = {
> > +      "MX30LF1G28AD",
> > +      "MX30LF2G28AD",
> > +      "MX30LF4G28AD",
> > +   };
> > 
> >     if (nand_is_slc(chip))
> >        chip->options |= NAND_BBM_FIRSTPAGE | NAND_BBM_SECONDPAGE;
> > @@ -153,6 +208,14 @@ static int macronix_nand_init(struct nand_chip 
*chip)
> > 
> >     macronix_nand_onfi_init(chip);
> > 
> > +   for (i = 0; i < ARRAY_SIZE(power_down_dev); i++) {
> > +      if (!strcmp(power_down_dev[i], chip->parameters.model)) {
> > +         blockprotected = true;
> > +         powerdown = true;
> > +         break;
> > +      }
> > +   }
> > +
> >     if (blockprotected) {
> >        bitmap_set(chip->parameters.set_feature_list,
> >              ONFI_FEATURE_ADDR_MXIC_PROTECTION, 1);
> > @@ -163,6 +226,11 @@ static int macronix_nand_init(struct nand_chip 
*chip)
> >        chip->_unlock = mxic_nand_unlock;
> >     }
> > 
> > +   if (powerdown) {
> > +      chip->_suspend = mxic_nand_suspend;
> > +      chip->_resume = mxic_nand_resume;
> > +   }
> 
> See my comment on patch 2.

ok, got it.

thanks for your time & comments.
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

