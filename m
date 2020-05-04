Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5418BC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 08:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 345D420746
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 08:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbgEDIHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 04:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727100AbgEDIHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 04:07:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29C9C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 01:07:35 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=localhost)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1jVW8B-0007yE-Il; Mon, 04 May 2020 10:07:15 +0200
Message-ID: <bf758b2ce26ba8f1b94f1f8fbd1c506d84759a5f.camel@pengutronix.de>
Subject: Re: [RFC PATCH 4/4] arm64: dts: imx8mm: Add GPU nodes for 2D and 3D
 core using Etnaviv
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Adam Ford <aford173@gmail.com>,
        Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     Anson Huang <Anson.Huang@nxp.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Li Jun <jun.li@nxp.com>, NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "etnaviv@lists.freedesktop.org" <etnaviv@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Mon, 04 May 2020 10:07:14 +0200
In-Reply-To: <CAHCN7xJ=srZxygtG6hW_+us=qH1heY-k=EosavYH9tDk-KG0Bw@mail.gmail.com>
References: <20200430124602.14463-1-frieder.schrempf@kontron.de>
         <20200430124602.14463-5-frieder.schrempf@kontron.de>
         <CAHCN7xJ=srZxygtG6hW_+us=qH1heY-k=EosavYH9tDk-KG0Bw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1 (3.36.1-1.fc32) 
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

Am Sonntag, den 03.05.2020, 09:49 -0500 schrieb Adam Ford:
> On Thu, Apr 30, 2020 at 7:46 AM Schrempf Frieder
> <frieder.schrempf@kontron.de> wrote:
> > From: Frieder Schrempf <frieder.schrempf@kontron.de>
> > 
> > According to the documents, the i.MX8M-Mini features a GC320 and a
> > GCNanoUltra GPU core. Etnaviv detects them as:
> > 
> >         etnaviv-gpu 38000000.gpu: model: GC600, revision: 4653
> >         etnaviv-gpu 38008000.gpu: model: GC520, revision: 5341
> > 
> > This seems to work fine more or less without any changes to the HWDB,
> > which still might be needed in the future to correct some features,
> > etc.
> > 
> > Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> > ---
> Since not everyone uses the 3D or 2D, would it make sense to mark them
> as disabled by default and let people who need the 3D and 2D enable
> them at their respective board files?

No, devices on the SoC with no external dependencies should be always
enabled.

The board has much less influence over whether the GPU is being used
than the specific use-case. While the board designer may not even think
about using the GPUs (because no display connector present or something
like that) people using the board may still find uses for the GPU, like
doing video pipeline color space conversions or something lie that.

Regards,
Lucas

