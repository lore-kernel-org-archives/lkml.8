Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A9BC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 10:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6C8F2070A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 10:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbgCFKU7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 05:20:59 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33555 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgCFKU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 05:20:59 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1jAA68-00018D-KZ; Fri, 06 Mar 2020 11:20:52 +0100
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1jAA67-0007hp-HB; Fri, 06 Mar 2020 11:20:51 +0100
Message-ID: <69903c69a95902c0ddc8fb9e7a6762abf28aa034.camel@pengutronix.de>
Subject: Re: [PATCH v3 2/4] drm/imx: Add initial support for DCSS on iMX8MQ
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>
Cc:     Laurentiu Palcu <laurentiu.palcu@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, agx@sigxcpu.org,
        lukas@mntmn.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Date:   Fri, 06 Mar 2020 11:20:51 +0100
In-Reply-To: <20200306095830.sa5eig67phngr3fa@fsr-ub1864-141>
References: <1575625964-27102-1-git-send-email-laurentiu.palcu@nxp.com>
         <1575625964-27102-3-git-send-email-laurentiu.palcu@nxp.com>
         <03b551925d079fcc151239afa735562332cfd557.camel@pengutronix.de>
         <20200306095830.sa5eig67phngr3fa@fsr-ub1864-141>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurentiu,

On Fri, 2020-03-06 at 11:58 +0200, Laurentiu Palcu wrote:
> On Wed, Feb 26, 2020 at 02:19:11PM +0100, Lucas Stach wrote:
[...]
> > > +/* This function will be called from interrupt context. */
> > > +void dcss_scaler_write_sclctrl(struct dcss_scaler *scl)
> > > +{
> > > +	int chnum;
> > > +
> > > +	for (chnum = 0; chnum < 3; chnum++) {
> > > +		struct dcss_scaler_ch *ch = &scl->ch[chnum];
> > > +
> > > +		if (ch->scaler_ctrl_chgd) {
> > > +			dcss_ctxld_write_irqsafe(scl->ctxld, scl->ctx_id,
> > > +						 ch->scaler_ctrl,
> > > +						 ch->base_ofs +
> > > +						 DCSS_SCALER_CTRL);
> > 
> > Why is this using the _irqsafe variant without any locking? Won't this
> > lead to potential internal state corruption? dcss_ctxld_write is using
> > the _irqsave locking variants, so it fine with being called from IRQ
> > context.
> 
> This is only called from __dcss_ctxld_enable() which is already protected
> by lock/unlock in dcss_ctxld_kick().

You could add a lockdep_assert_held() line to the top of this function
to make it clear this depends on the lock being held.

regards
Philipp
