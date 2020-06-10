Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A850C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 18:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE69C207C3
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 18:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgFJSBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 14:01:22 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:59985 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgFJSBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 14:01:22 -0400
X-Originating-IP: 86.202.110.81
Received: from localhost (lfbn-lyo-1-15-81.w86-202.abo.wanadoo.fr [86.202.110.81])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 07B8EC0005;
        Wed, 10 Jun 2020 18:01:18 +0000 (UTC)
Date:   Wed, 10 Jun 2020 20:01:18 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>, Johan Hovold <johan@kernel.org>,
        Mark Greer <mgreer@animalcreek.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Enable Greybus Audio codec driver
Message-ID: <20200610180118.GZ3720@piout.net>
References: <cover.1591802243.git.vaibhav.sr@gmail.com>
 <20200610173711.GK5005@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610173711.GK5005@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/2020 18:37:11+0100, Mark Brown wrote:
> On Wed, Jun 10, 2020 at 10:58:24PM +0530, Vaibhav Agarwal wrote:
> > The existing GB Audio codec driver is dependent on MSM8994 Audio driver.
> > During the development stage, this dependency was configured due to
> > various changes involved in MSM Audio driver to enable addtional codec
> > card and some of the changes proposed in mainline ASoC framework.
> 
> I'm not sure why you're copying me on a staging driver?  I don't recall
> the base driver having been submitted properly yet.

That was my suggestion, the whole history is that I submitted a patch
removing this driver as it was not getting compiled and so didn't go
through the componentization. See
https://lore.kernel.org/lkml/20200507212912.599433-1-alexandre.belloni@bootlin.com/

My point was that if we were to keep that driver, the goal would be to
have it out of staging instead of simply making it compile.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
