Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14115C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB33F2070C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbgGFN5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 09:57:20 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:49034 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728940AbgGFN5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 09:57:20 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1jsRcT-003rgn-D2; Mon, 06 Jul 2020 15:57:17 +0200
Date:   Mon, 6 Jul 2020 15:57:17 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Diana Craciun <diana.craciun@nxp.com>
Cc:     linux-kernel@vger.kernel.org, laurentiu.tudor@nxp.com,
        gregkh@linuxfoundation.org, stuyoder@gmail.com, leoyang.li@nxp.com,
        bharatb.linux@gmail.com, Diana Craciun <diana.craciun@oss.nxp.com>,
        Bharat Bhushan <Bharat.Bhushan@nxp.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 03/13] bus/fsl-mc: add support for 'driver_override'
 in the mc-bus
Message-ID: <20200706135717.GB919533@lunn.ch>
References: <20200706124243.10697-1-diana.craciun@nxp.com>
 <20200706124243.10697-4-diana.craciun@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706124243.10697-4-diana.craciun@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Diana

On Mon, Jul 06, 2020 at 03:42:33PM +0300, Diana Craciun wrote:
> From: Bharat Bhushan <Bharat.Bhushan@nxp.com>
> 
> This patch is required for vfio-fsl-mc meta driver to successfully bind
> layerscape container devices for device passthrough. This patch adds
> a mechanism to allow a layerscape device to specify a driver rather than
> a layerscape driver provide a device match.
> 
> Example to allow a device (dprc.1) to specifically bind
> with driver (vfio-fsl-mc):-
>  - echo vfio-fsl-mc > /sys/bus/fsl-mc/devices/dprc.1/driver_override
>  - echo dprc.1 > /sys/bus/fsl-mc/drivers/fsl_mc_dprc/unbind
>  - echo dprc.1 > /sys/bus/fsl-mc/drivers/vfio-fsl-mc/bind

Something i asked before, why is this buried in a driver, when it
could be put in the driver core. This is not the only driver doing
this, so it does make sense to share the code and bugs.

      Andrew
