Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_DBL_ABUSE_MALW,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EF7C35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 17:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C1A2082E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 17:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbgBDRYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 12:24:08 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54891 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727310AbgBDRYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 12:24:08 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iz1vg-00062P-A3; Tue, 04 Feb 2020 18:24:04 +0100
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1iz1vf-0003o0-C0; Tue, 04 Feb 2020 18:24:03 +0100
Date:   Tue, 4 Feb 2020 18:24:03 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     mark.rutland@arm.com, robh@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: librem5-devkit: add lsm9ds1 mount matrix
Message-ID: <20200204172403.jlb6zeqv2jdblkqb@pengutronix.de>
References: <20200120100722.30359-1-martin.kepplinger@puri.sm>
 <20200203110545.GB24291@pengutronix.de>
 <7298838b-b5ce-4e90-331a-4b62a6f91b95@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7298838b-b5ce-4e90-331a-4b62a6f91b95@puri.sm>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 18:23:30 up 81 days,  8:42, 82 users,  load average: 0.01, 0.09,
 0.04
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-02-03 12:31, Martin Kepplinger wrote:
> 
> 
> On 03.02.20 12:05, Marco Felsch wrote:
> > Hi Martin,
> > 
> > On 20-01-20 11:07, Martin Kepplinger wrote:
> >> The IMU chip on the librem5-devkit is not mounted at the "natural" place
> >> that would match normal phone orientation (see the documentation for the
> >> details about what that is).
> >>
> >> Since the lsm9ds1 driver supports providing a mount matrix, we can describe
> >> the orientation on the board in the dts:
> > 
> > I didn't found the patch which adds the iio_read_mount_matrix()
> > support. Appart of that your patch looks good so feel free to add my:
> > 
> > Reviewed-by: Marco Felsch <m.felsch@pengutronix.de> 
> > 
> > Regards,
> >   Marco
> > 
> 
> hi Marco, thanks for having a look. there it is:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=04e6fedb18f6899453e59a748fb95be56ef73836

I see =)

> thanks again, for now as long as I don't resend I leave adding the
> reviewed-by to maintainers,
> 
>                                martin
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
