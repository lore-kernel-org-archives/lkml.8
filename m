Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817F7C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 08:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67E2921527
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 08:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgFQI6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 04:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgFQI6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 04:58:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51207C061573
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 01:58:43 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=localhost)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1jlTtu-00071k-3n; Wed, 17 Jun 2020 10:58:30 +0200
Message-ID: <6ce028567aead7e5270c7d62b4f201bc686c0b3e.camel@pengutronix.de>
Subject: Re: [PATCH v5 0/2] mfd: Add ENE KB3930 Embedded Controller driver
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Geiner <christian.gmeiner@gmail.com>,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 17 Jun 2020 10:58:28 +0200
In-Reply-To: <20200616224404.994285-1-lkundrak@v3.sk>
References: <20200616224404.994285-1-lkundrak@v3.sk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lubomir,

Am Mittwoch, den 17.06.2020, 00:44 +0200 schrieb Lubomir Rintel:
> Hi,
> 
> please consider applying the patches chained to this message. It's the
> fifth version of the driver for the ENE KB3930 Embedded Controller.
> 
> This version is essentially a resend of v4. The only actual change is the
> addition of the Rob's Reviewed-by tag which I failed to do previously.
> Detailed change logs are in the individual patch descriptions.

I don't think you wanted this to go to the etnaviv list and
maintainers, right?

Regards,
Lucas

