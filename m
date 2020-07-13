Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2994C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 03:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 889F220725
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 03:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594609360;
	bh=A6MPJdy59dkFtPa9jX+vGeKW7O3CRBwsu/PGmPjn/m8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=t1PJ3ZPkNmSulRHqQSMxKaCVVrFKvzaPZA8J8CYsFIZ/1vOd4PSeAzT8RR7VMSslE
	 nP6YVIkFIfHJwMW2zqKR3ce51MK5cirUjBhHwOFjlD4GwgnrV2g6y+XTR2F+OaezOy
	 6Ho2uarnc29vEgFsL5fA5KWa84ROvTQElEmwqQ9I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbgGMDCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 23:02:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:60728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgGMDCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 23:02:39 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9469B206B6;
        Mon, 13 Jul 2020 03:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594609358;
        bh=A6MPJdy59dkFtPa9jX+vGeKW7O3CRBwsu/PGmPjn/m8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sx3PcbYwo+zXw2RRuF8lp9DRqlIbxefoNHvUhg3JrzbmOc7KUM66c//BUPPIjKXpD
         aaD8pLeI6enKfN/RguUjg6kOwmv9IXQzolScyTx+RbpP4kLIHcHgmpMmWRNVklT5dB
         S/QmUy+IarrpW8gny58ZmeiHR6XaZ4EuSC3qt5aM=
Date:   Mon, 13 Jul 2020 11:02:33 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] imx: Provide correct number of resources when
 registering gpio devices
Message-ID: <20200713030232.GA21277@dragon>
References: <20200701032651.12420-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701032651.12420-1-linux@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 08:26:51PM -0700, Guenter Roeck wrote:
> Since commit a85a6c86c25be ("driver core: platform: Clarify that IRQ 0 is
> invalid"), the kernel is a bit touchy when it encounters interrupt 0.
> As a result, there are lots of warnings such as the following when booting
> systems such as 'kzm'.
> 
> WARNING: CPU: 0 PID: 1 at drivers/base/platform.c:224 platform_get_irq_optional+0x118/0x128
> 0 is an invalid IRQ number
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.8.0-rc3 #1
> Hardware name: Kyoto Microcomputer Co., Ltd. KZM-ARM11-01
> [<c01127d4>] (unwind_backtrace) from [<c010c620>] (show_stack+0x10/0x14)
> [<c010c620>] (show_stack) from [<c06f5f54>] (dump_stack+0xe8/0x120)
> [<c06f5f54>] (dump_stack) from [<c0128878>] (__warn+0xe4/0x108)
> [<c0128878>] (__warn) from [<c0128910>] (warn_slowpath_fmt+0x74/0xbc)
> [<c0128910>] (warn_slowpath_fmt) from [<c08b8e84>] (platform_get_irq_optional+0x118/0x128)
> [<c08b8e84>] (platform_get_irq_optional) from [<c08b8eb4>] (platform_irq_count+0x20/0x3c)
> [<c08b8eb4>] (platform_irq_count) from [<c0728660>] (mxc_gpio_probe+0x8c/0x494)
> [<c0728660>] (mxc_gpio_probe) from [<c08b93cc>] (platform_drv_probe+0x48/0x98)
> [<c08b93cc>] (platform_drv_probe) from [<c08b703c>] (really_probe+0x214/0x344)
> [<c08b703c>] (really_probe) from [<c08b7274>] (driver_probe_device+0x58/0xb4)
> [<c08b7274>] (driver_probe_device) from [<c08b7478>] (device_driver_attach+0x58/0x60)
> [<c08b7478>] (device_driver_attach) from [<c08b7504>] (__driver_attach+0x84/0xc0)
> [<c08b7504>] (__driver_attach) from [<c08b50f8>] (bus_for_each_dev+0x78/0xb8)
> [<c08b50f8>] (bus_for_each_dev) from [<c08b62cc>] (bus_add_driver+0x154/0x1e0)
> [<c08b62cc>] (bus_add_driver) from [<c08b82b8>] (driver_register+0x74/0x108)
> [<c08b82b8>] (driver_register) from [<c0102320>] (do_one_initcall+0x80/0x3b4)
> [<c0102320>] (do_one_initcall) from [<c1501008>] (kernel_init_freeable+0x170/0x208)
> [<c1501008>] (kernel_init_freeable) from [<c0e178d4>] (kernel_init+0x8/0x11c)
> [<c0e178d4>] (kernel_init) from [<c0100134>] (ret_from_fork+0x14/0x20)
> 
> As it turns out, mxc_register_gpio() is a bit lax when setting the
> number of resources: it registers a resource with interrupt 0 when in
> reality there is no such interrupt. Fix the problem by not declaring
> the second interrupt resource if there is no second interrupt.
> 
> Fixes: a85a6c86c25be ("driver core: platform: Clarify that IRQ 0 is invalid")
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

I changed the subject prefix to 'ARM: imx: ...' and applied the patch.

Shawn
