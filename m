Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0B2C3B1BE
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 086D524670
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389130AbgBNSo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:44:59 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:44346 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729595AbgBNSo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 13:44:59 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 2F8A3FB03;
        Fri, 14 Feb 2020 19:44:56 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Exb_RJVpsLOz; Fri, 14 Feb 2020 19:44:55 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 1B2F840E06; Fri, 14 Feb 2020 19:44:54 +0100 (CET)
Date:   Fri, 14 Feb 2020 19:44:53 +0100
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     robh@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, Anson.Huang@nxp.com, devicetree@vger.kernel.org,
        kernel@puri.sm, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 00/12] arm64: dts: librem5-devkit: description updates
Message-ID: <20200214184453.GA38549@bogon.m.sigxcpu.org>
References: <20200205143003.28408-1-martin.kepplinger@puri.sm>
 <5f81b30a-d00f-9331-dc70-161376cfc008@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f81b30a-d00f-9331-dc70-161376cfc008@puri.sm>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Thu, Feb 13, 2020 at 03:08:57PM +0100, Martin Kepplinger wrote:
> On 05.02.20 15:29, Martin Kepplinger wrote:
> > These are additions to the imx8mq-librem5-devkit devicetree description
> > we are running for quite some time. All users should have them:
> > 
> > Angus Ainslie (Purism) (11):
> >   arm64: dts: librem5-devkit: add sai2 and sai6 pinctrl definitions
> >   arm64: dts: librem5-devkit: add the simcom 7100 modem and audio
> >   arm64: dts: librem5-devkit: allow modem to wake the system from
> >     suspend
> >   arm64: dts: librem5-devkit: enable sai2 audio interface
> >   arm64: dts: librem5-devkit: add the sgtl5000 i2c audio codec
> >   arm64: dts: librem5-devkit: add a vbus supply to usb0
> >   arm64: dts: librem5-devkit: add the regulators for DVFS
> >   arm64: dts: librem5-devkit: add a battery for the bq25896 to monitor
> >   arm64: dts: librem5-devkit: allow the redpine card to be removed
> >   arm64: dts: librem5-devkit: configure VSELECT
> >   arm64: dts: librem5-devkit: increase the VBUS current in the kernel
> > 
> > Martin Kepplinger (1):
> >   arm64: dts: librem5-devkit: add lsm9ds1 mount matrix
> > 
> >  .../dts/freescale/imx8mq-librem5-devkit.dts   | 173 +++++++++++++++++-
> >  1 file changed, 165 insertions(+), 8 deletions(-)
> > 
> 
> hi,
> 
> any objections or opinions on these additions?

I think

'arm64: dts: librem5-devkit: add a battery for the bq25896 to monitor'

should be dropped since the driver does not process any battery
information.

Cheers,
 -- Guido

> 
> thanks!
> 
>                                   martin
