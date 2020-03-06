Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56788C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 07:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B4C52073D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 07:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgCFHvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 02:51:35 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38863 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbgCFHve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 02:51:34 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jA7lZ-0001YG-Vh; Fri, 06 Mar 2020 08:51:29 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jA7lZ-0004WQ-EO; Fri, 06 Mar 2020 08:51:29 +0100
Date:   Fri, 6 Mar 2020 08:51:29 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] regulator: pwm: Don't warn on probe deferral
Message-ID: <20200306075129.mzs22yjitkmgrthh@pengutronix.de>
References: <20200224144048.6587-1-jonathanh@nvidia.com>
 <20200224165859.GJ6215@sirena.org.uk>
 <20200226161757.idpzbs3jmayt7ya6@pengutronix.de>
 <20200226163905.GH4136@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200226163905.GH4136@sirena.org.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 04:39:05PM +0000, Mark Brown wrote:
> On Wed, Feb 26, 2020 at 05:17:57PM +0100, Uwe Kleine-König wrote:
> > On Mon, Feb 24, 2020 at 04:58:59PM +0000, Mark Brown wrote:
> 
> > > This then means that there's no way for users to determine why the
> > > driver has failed to instantiate which can be frustrating.  It'd be
> > > better to at least have some dev_dbg() output when deferring so that
> > > there's something for people to go on without having to instrument the
> > > code.
> 
> > Not printing an error message is quite usual however. I think a generic
> 
> Usual yet also frustraing.
> 
> > approach that for example makes the list of devices that should be
> > retried to probe on the next opportunity inspectable would be nice.
> 
> That's not really the issue, the bigger issue is trying to figure out
> why things are stuck - what exactly caused things to fail to
> instantiate.

I wonder if we should do something like:

	ret = some_call(some, args);
	if (ret) {
		if (emit_errmsg_for_err(ret))
			dev_err(dev, "some_call failed: %pE\n", ERR_PTR(ret));
		return ret;
	}

and have emit_errmsg_for_err return true if ret != -EPROBE_DEFER or some
kernel parameter is given.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
