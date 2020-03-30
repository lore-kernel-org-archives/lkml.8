Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B46C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 13:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCC6C20757
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 13:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pqgruber.com header.i=@pqgruber.com header.b="QCoR/o/d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgC3Nex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 09:34:53 -0400
Received: from mail.pqgruber.com ([52.59.78.55]:56328 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbgC3Nex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 09:34:53 -0400
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id A6693C63E20;
        Mon, 30 Mar 2020 15:34:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1585575291;
        bh=VG82nfwYd6WzyYlvHoW4q92Umm0iCjQRTg+niBTxir0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QCoR/o/dgwzlMUKs9HcFFf7ZvgMInZCN1pFqHer6AnO/z/eEj9ZktkqUsY9O4GHfJ
         rDLJCbCFZgiUtUUg/6zCny3QpG3bEQm5Mu0Zi1KAA+0p7jnm4hczo3V2Gdz4Pemymd
         PQkMmMd0Wn9/rPx0DOv3xOepGUWBAwG3zEnYTCRE=
Date:   Mon, 30 Mar 2020 15:34:50 +0200
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com
Subject: Re: [PATCH 2/4] pwm: pca9685: remove ALL_LED PWM channel
Message-ID: <20200330133450.GA1530@workstation.tuxnet>
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
 <20200226135229.24929-2-matthias.schiffer@ew.tq-group.com>
 <20200330130757.GC2431644@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330130757.GC2431644@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Mar 30, 2020 at 03:07:57PM +0200, Thierry Reding wrote:
> On Wed, Feb 26, 2020 at 02:52:27PM +0100, Matthias Schiffer wrote:
> > The interaction of the ALL_LED PWM channel with the other channels was
> > not well-defined. As the ALL_LED feature does not seem very useful and
> > it was making the code significantly more complex, simply remove it.
> > 
> > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> > ---
> >  drivers/pwm/pwm-pca9685.c | 115 ++++++--------------------------------
> >  1 file changed, 17 insertions(+), 98 deletions(-)
> 
> Applied, thanks.
> 
> Thierry

I was not reading the mailing list in the last weeks, so I only saw the
patch today.

We are using the ALL_LED channel in production to reduce the delay when
all 16 PWM outputs need to be set to the same duty cycle.

I am not sure it is a good idea to remove this feature.

Best regards,
Clemens
