Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425DDC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 10:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23B572078B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 10:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438398AbgDNKeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 06:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2438344AbgDNKb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 06:31:58 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A40C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 03:31:54 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jOIrA-00078x-0v; Tue, 14 Apr 2020 12:31:52 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jOIr9-0000Ib-9D; Tue, 14 Apr 2020 12:31:51 +0200
Date:   Tue, 14 Apr 2020 12:31:51 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] mailbox: imx-mailbox: fix scu msg header size check
Message-ID: <20200414103151.mm6w5gkgrdvt6z2b@pengutronix.de>
References: <1586851826-16596-1-git-send-email-peng.fan@nxp.com>
 <20200414082635.jo5yljonh5xgnujd@pengutronix.de>
 <AM0PR04MB4481562AFA8A4B9CDDD3E55F88DA0@AM0PR04MB4481.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM0PR04MB4481562AFA8A4B9CDDD3E55F88DA0@AM0PR04MB4481.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 08:40:19AM +0000, Peng Fan wrote:
> > Subject: Re: [PATCH] mailbox: imx-mailbox: fix scu msg header size check
> > 
> > On Tue, Apr 14, 2020 at 04:10:26PM +0800, peng.fan@nxp.com wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > The i.MX8 SCU message header size is the number of "u32" elements, not
> > > "u8", so fix the check.
> > >
> > > Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> > > Addresses-Coverity-ID: 1461658 ("Memory - corruptions")
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >
> > > V2:
> > >  I not include the fixes tag, since this patch still in next tree.
> > >
> > >  drivers/mailbox/imx-mailbox.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/mailbox/imx-mailbox.c
> > > b/drivers/mailbox/imx-mailbox.c index 7906624a731c..c2398cb63ea0
> > > 100644
> > > --- a/drivers/mailbox/imx-mailbox.c
> > > +++ b/drivers/mailbox/imx-mailbox.c
> > > @@ -154,12 +154,12 @@ static int imx_mu_scu_tx(struct imx_mu_priv
> > > *priv,
> > >
> > >  	switch (cp->type) {
> > >  	case IMX_MU_TYPE_TX:
> > > -		if (msg->hdr.size > sizeof(*msg)) {
> > > +		if (msg->hdr.size > (sizeof(*msg) / 4)) {
> > 
> > No need for the parenthesis. Maybe a comment would be helpful here,
> > something like:
> > 
> > 	/*
> > 	 * msg->hdr.size specifies the number of u32 words while sizeof
> > 	 * yields bytes.
> > 	 */
> 
> V2 will have the update.
> 
> > 
> > >  			/*
> > >  			 * The real message size can be different to
> > >  			 * struct imx_sc_rpc_msg_max size
> > >  			 */
> > > -			dev_err(priv->dev, "Exceed max msg size (%zu) on TX,
> > got: %i\n", sizeof(*msg), msg->hdr.size);
> > > +			dev_err(priv->dev, "Exceed max msg size (%zu) on TX,
> > got: %i\n",
> > > +sizeof(*msg) / 4, msg->hdr.size);
> > 
> > The unit here is also "number of u32 words", maybe bytes is more natural?
> 
> ok. Will change to msg->hdr.size << 2 keeping sizeof(*msg).
> 
> > And I suggesting specifying the unit in the error message.
> 
> Is this ok to you?
> dev_err(priv->dev, "Exceed max msg size (%zu) on TX, got: %i, 
> msg->hdr.size: %i\n", sizeof(*msg), msg->hdr.size << 2, msg->hdr.size);

I'd prefer:

	dev_err(priv->dev, "Maximal message size (%zu bytes) exceeded on TX; got: %i bytes\n"

. Duplicating the value doesn't add much value.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
