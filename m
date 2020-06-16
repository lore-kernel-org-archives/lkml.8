Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE95C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8792520B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbgFPM5K convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgFPM5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:57:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0861C0613ED
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 05:57:08 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1jlB96-0007Oj-Of; Tue, 16 Jun 2020 14:56:56 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1jlB95-0004yK-DX; Tue, 16 Jun 2020 14:56:55 +0200
Message-ID: <706f56a20d318b841792ca19a6fe7135cb6c61e3.camel@pengutronix.de>
Subject: Re: [PATCH v4 3/3] ARM: dts: bcm2711: Add HDMI DVP
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Maxime Ripard <maxime@cerno.tech>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>, linux-clk@vger.kernel.org
Date:   Tue, 16 Jun 2020 14:56:55 +0200
In-Reply-To: <20200616121641.jpoz237p43sbndg2@gilmour.lan>
References: <cover.4c4625a8e076f3163b800b3d8986b282ee98d908.1591867332.git-series.maxime@cerno.tech>
         <e22222ca7f41b960e9bb1a31e0dd2de95b8c0cd1.1591867332.git-series.maxime@cerno.tech>
         <810816166d8ef554e1bb1f4a2b39ea0b8a1a3d5b.camel@suse.de>
         <20200616121641.jpoz237p43sbndg2@gilmour.lan>
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

Hi Maxime,

On Tue, 2020-06-16 at 14:16 +0200, Maxime Ripard wrote:
> Hi Nicolas,
> 
> On Mon, Jun 15, 2020 at 06:26:19PM +0200, Nicolas Saenz Julienne wrote:
> > On Thu, 2020-06-11 at 11:23 +0200, Maxime Ripard wrote:
> > > Now that we have a driver for the DVP, let's add its DT node.
> > > 
> > > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> > > ---
> > 
> > I can take this patch, but I guess the rest should go trough the clock tree.
> > Is it OK with you?
> 
> We have a build dependency on the reset framework for that driver, so it
> should rather go through the reset tree (or Philipp should make an
> immutable branch that the clk maintainers can merge).

I've prepared an immutable branch that these patches could be based on
and that could be merged into the clk tree:

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  git://git.pengutronix.de/git/pza/linux reset/simple

for you to fetch changes up to a9701376ed0fb61a5be4bb438daf26bd9cfa24b5:

  reset: simple: Add reset callback (2020-06-16 14:19:57 +0200)

----------------------------------------------------------------
Maxime Ripard (2):
      reset: Move reset-simple header out of drivers/reset
      reset: simple: Add reset callback

 drivers/reset/reset-simple.c                    | 23 +++++++++++++++++++++--
 drivers/reset/reset-socfpga.c                   |  3 +--
 drivers/reset/reset-sunxi.c                     |  3 +--
 drivers/reset/reset-uniphier-glue.c             |  3 +--
 {drivers => include/linux}/reset/reset-simple.h |  7 +++++++
 5 files changed, 31 insertions(+), 8 deletions(-)
 rename {drivers => include/linux}/reset/reset-simple.h (74%)

regards
Philipp
