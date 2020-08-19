Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD1CC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFB0C205CB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597843440;
	bh=GUAK/3Erqnn4v6wmDx98GtQrAlIyBXmM7AhYh906syU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BsBOy9U0LJdViY6cCh/mV6/AQ0I6a1V2zXQl+srq1mM7pAtHWrghHW/UutZ3PNIYx
	 fuUQrr3EWubm9pNGWT5/1MfbS+NyiTs0h7xf/6VAtBqaDXtWJYNLEwbbVKORD4KXwh
	 X2P37FkQmx47nPW3j3EQC9L0mtomnDvTpVBJqKx0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgHSNX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 09:23:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:36500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726752AbgHSNXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 09:23:34 -0400
Received: from dragon (unknown [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 170D9205CB;
        Wed, 19 Aug 2020 13:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597843413;
        bh=GUAK/3Erqnn4v6wmDx98GtQrAlIyBXmM7AhYh906syU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EuDaDJ4FYqnTEo41N6XrhzVujSM53sGEQYAhMSZjrC/NTp+E+XRXFxddwKP1wZ2Po
         UtW1kppzqKMmPWgTaTLRlKxTtvvsB2S9RknaW/qOE+t00MZ7UBbolUu+R+/VsJkOkL
         HZH9u8xjRg1IMeqtbAT+d+rr291T41+/20blr6BM=
Date:   Wed, 19 Aug 2020 21:23:19 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Franck LENORMAND (OSS)" <franck.lenormand@oss.nxp.com>
Cc:     s.hauer@pengutronix.de, festevam@gmail.com, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, aisheng.dong@nxp.com, abel.vesa@nxp.com,
        Anson.Huang@nxp.com, linux@rempel-privat.de,
        leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        qiangqing.zhang@nxp.com, peng.fan@nxp.com
Subject: Re: [PATCH v2 0/5] Add support of SECVIO from SNVS on iMX8q/x
Message-ID: <20200819132317.GA7114@dragon>
References: <1595344835-67746-1-git-send-email-franck.lenormand@oss.nxp.com>
 <1597737122.73802.3.camel@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1597737122.73802.3.camel@oss.nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 09:52:02AM +0200, Franck LENORMAND (OSS) wrote:
> Hello,
> 
> Peng was able to do a firt pass of review on my patchset which led to this
> second version. I hope a maintainer will be able to take a look at this
> patchset once rested after all the work they did for 5.9.

@Peng, are you okay with this version?

@Aisheng, have a review on this?

Shawn

> 
> On mar., 2020-07-21 at 17:20 +0200, franck.lenormand@oss.nxp.com wrote:
> > From: Franck LENORMAND <franck.lenormand@oss.nxp.com>
> > 
> > This patchset aims to add support for the SECurity VIOlation (SECVIO) of the
> > SNVS. A secvio is a signal emitted by the SNVS when a hardware attack
> > is detected. On imx8x and imx8q SoC, the SNVS is controlled by the
> > SECO and it is possible to interact with it using the SCU using the SC APIs.
> > 
> > For the driver to communicate with the SNVS via the SCU and the SECO, I had to:
> >  - Add support for exchange of big message with the SCU (needed for
> > imx_scu_irq_get_status)
> >  - Add API to check linux can control the SECVIO (imx_sc_rm_is_resource_owned)
> >  - Add APIs for the driver to read the state of the SECVIO registers of the
> > SNVS and DGO (imx_sc_seco_secvio_enable and imx_sc_seco_secvio_enable).
> > 
> > To check the state of the SECVIO IRQ in the SCU, I added the
> > imx_scu_irq_get_status API.
> > 
> > The secvio driver is designed to receive the IRQ produced by the
> > SNVS in case of hardware attack and notify the status to the
> > audit framework which can be used by the user.
> > 
> > The goal of the driver is to be self suficient but can be extended by the
> > user to perform custom operations on values read (imx_sc_seco_secvio_enable)
> > 
> > v2:
> >  - Removed (firmware: imx: scu-rm: Add Resource Management APIs)
> > 	-> Code required is already present
> >  - Removed (firmware: imx: scu: Support reception of messages of any size)
> > 	-> The imx-scu is already working in fast-ipc mode
> >  - (soc: imx8: Add the SC SECVIO driver):
> > 	- Fixed the warnings reported by kernel test robot
> > 
> > Franck LENORMAND (5):
> >   firmware: imx: scu-seco: Add SEcure Controller APIS
> >   firmware: imx: scu-irq: Add API to retrieve status of IRQ
> >   dt-bindings: firmware: imx-scu: Add SECVIO resource
> >   dt-bindings: arm: imx: Documentation of the SC secvio driver
> >   soc: imx8: Add the SC SECVIO driver
> > 
> >  .../bindings/arm/freescale/fsl,imx-sc-secvio.yaml  |  34 +
> >  drivers/firmware/imx/Makefile                      |   2 +-
> >  drivers/firmware/imx/imx-scu-irq.c                 |  37 +-
> >  drivers/firmware/imx/imx-scu.c                     |   3 +
> >  drivers/firmware/imx/seco.c                        | 275 +++++++
> >  drivers/soc/imx/Kconfig                            |  10 +
> >  drivers/soc/imx/Makefile                           |   1 +
> >  drivers/soc/imx/secvio/Kconfig                     |  10 +
> >  drivers/soc/imx/secvio/Makefile                    |   3 +
> >  drivers/soc/imx/secvio/imx-secvio-audit.c          |  39 +
> >  drivers/soc/imx/secvio/imx-secvio-debugfs.c        | 379 +++++++++
> >  drivers/soc/imx/secvio/imx-secvio-sc-int.h         |  84 ++
> >  drivers/soc/imx/secvio/imx-secvio-sc.c             | 858 +++++++++++++++++++++
> >  include/dt-bindings/firmware/imx/rsrc.h            |   3 +-
> >  include/linux/firmware/imx/ipc.h                   |   1 +
> >  include/linux/firmware/imx/sci.h                   |   5 +
> >  include/linux/firmware/imx/svc/seco.h              |  73 ++
> >  include/soc/imx/imx-secvio-sc.h                    | 177 +++++
> >  18 files changed, 1991 insertions(+), 3 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,imx-sc-
> > secvio.yaml
> >  create mode 100644 drivers/firmware/imx/seco.c
> >  create mode 100644 drivers/soc/imx/secvio/Kconfig
> >  create mode 100644 drivers/soc/imx/secvio/Makefile
> >  create mode 100644 drivers/soc/imx/secvio/imx-secvio-audit.c
> >  create mode 100644 drivers/soc/imx/secvio/imx-secvio-debugfs.c
> >  create mode 100644 drivers/soc/imx/secvio/imx-secvio-sc-int.h
> >  create mode 100644 drivers/soc/imx/secvio/imx-secvio-sc.c
> >  create mode 100644 include/linux/firmware/imx/svc/seco.h
> >  create mode 100644 include/soc/imx/imx-secvio-sc.h
> > 
> 
