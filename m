Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4223AC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1803C20825
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598456019;
	bh=2F0FlTbURVaj1x4DrL2qLIeLQqGNDXWILGGXNk69h3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=E/4rbdRHl++oya++EaFvaPS4+/sbQa+irEr93nqs2ZYdN/KvW/pWTGz8SgUU2vKWI
	 fZFNLytb0b8QaSQBcUB3VjhMk/R4yWFdn2x0anTCKDDcMNEz1RutOglmhaamsU4hw3
	 ssNRu5vlq6Hy/xbeuQvV/emIq9EfgHG3626dSkJc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbgHZPdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 11:33:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:50596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727049AbgHZPdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 11:33:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51C9A2078D;
        Wed, 26 Aug 2020 15:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598456012;
        bh=2F0FlTbURVaj1x4DrL2qLIeLQqGNDXWILGGXNk69h3A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u28JoRRlaRp+ORrBZWuATbk3bssAY0RNJauoz7e/jSYK2dBkHdSvS+JdK8LU0d2mW
         O7JBScg+sp00QIkzgjNQesrxpVcVB0vuedg7WD/aqEBKIm8113RJ7j4MXrD44kWtcS
         5jQCokq4yLUpjNL7xnC06THocySmnhcycqOavoBw=
Date:   Wed, 26 Aug 2020 17:33:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Brooke Basile <brookebasile@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Ilja Van Sprundel <ivansprundel@ioactive.com>,
        Kees Cook <keescook@chromium.org>,
        Felipe Balbi <balbi@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [GIT PULL] USB fixes for 5.9-rc3
Message-ID: <20200826153347.GB4187816@kroah.com>
References: <20200826134315.GA3882506@kroah.com>
 <CGME20200826150239eucas1p24c59716cc31edfeb2eece84d97936b93@eucas1p2.samsung.com>
 <1425ab4f-ef7e-97d9-238f-0328ab51eb35@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1425ab4f-ef7e-97d9-238f-0328ab51eb35@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 05:02:38PM +0200, Marek Szyprowski wrote:
> Hi Greg,
> 
> On 26.08.2020 15:43, Greg KH wrote:
> > The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:
> >
> >    Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)
> >
> > are available in the Git repository at:
> >
> >    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.9-rc3
> >
> > for you to fetch changes up to 23e26d0577535f5ffe4ff8ed6d06e009553c0bca:
> >
> >    usb: typec: tcpm: Fix Fix source hard reset response for TDA 2.3.1.1 and TDA 2.3.1.2 failures (2020-08-25 16:02:35 +0200)
> >
> > ----------------------------------------------------------------
> > USB fixes for 5.9-rc3
> >
> > Here are a small set of USB fixes for 5.9-rc3.
> >
> > Like most set of USB bugfixes, they include the usual:
> > 	- usb gadget driver fixes
> > 	- xhci driver fixes
> > 	- typec fixes
> > 	- new qurks and ids
> > 	- fixes for USB patches merged in 5.9-rc1
> >
> > Nothing huge, all of these have been in linux-next with no reported
> > issues:
> >
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >
> > ----------------------------------------------------------------
> > Alan Stern (1):
> >        USB: yurex: Fix bad gfp argument
> >
> > Andy Shevchenko (1):
> >        usb: hcd: Fix use after free in usb_hcd_pci_remove()
> >
> > Badhri Jagan Sridharan (1):
> >        usb: typec: tcpm: Fix Fix source hard reset response for TDA 2.3.1.1 and TDA 2.3.1.2 failures
> >
> > Bastien Nocera (2):
> >        USB: Also match device drivers using the ->match vfunc
> >        USB: Fix device driver race
> >
> > Brooke Basile (2):
> >        USB: gadget: u_f: add overflow checks to VLA macros
> 
> Sorry, but the above patch breaks USB Ethernet Gadget operation. It also 
> didn't get the proper testing in linux-next (next-20200826 is the first 
> one with this patch).
> 
> This is how it explodes on Samsung Exynos (ARM 32bit) based board with 
> g_ether module loaded:
> 
> ------------[ cut here ]------------
> kernel BUG at mm/slub.c:4116!

Why is slub.c erroring?  How is this related to freeing memory?

> Internal error: Oops - BUG: 0 [#1] SMP ARM
> Modules linked in: usb_f_ecm g_ether(+) usb_f_rndis u_ether libcomposite 
> panel_samsung_s6e8aa0 s5p_csis s5p_fimc exynos4_is_common v4l2_fwnode 
> max8997_regulator rtc_max8997 leds_max8997 max8
> emless mms114 governor_simpleondemand s5p_mfc lima gpu_sched s5p_jpeg 
> v4l2_mem2mem videobuf2_dma_contig videobuf2_memops videobuf2_v4l2 
> videobuf2_common phy_exynos_usb2 exynosdrm analogix_dp
>   s3c2410_wdt
> CPU: 0 PID: 616 Comm: modprobe Not tainted 5.9.0-rc1-00026-gb1cd1b65afba 
> #9023
> Hardware name: Samsung Exynos (Flattened Device Tree)
> PC is at kfree+0x234/0x268
> LR is at config_item_set_name+0x60/0xb0
> ...
> Process modprobe (pid: 616, stack limit = 0x(ptrval))
> ...
> [<c0494248>] (kfree) from [<c05347a0>] (config_item_set_name+0x60/0xb0)
> [<c05347a0>] (config_item_set_name) from [<c0534844>] 
> (config_group_init_type_name+0x1c/0x50)

Odd, for a "normal" descriptor, the logic should have remained the same
as without this patch.

What does the descriptor definition of your device look like that it
triggers this traceback?

> [<c0534844>] (config_group_init_type_name) from [<bf14bc18>] 
> (usb_os_desc_prepare_interf_dir+0x54/0x124 [libcomposite])
> [<bf14bc18>] (usb_os_desc_prepare_interf_dir [libcomposite]) from 
> [<bf15af9c>] (rndis_alloc_inst+0x100/0x150 [usb_f_rndis])
> [<bf15af9c>] (rndis_alloc_inst [usb_f_rndis]) from [<bf1499dc>] 
> (try_get_usb_function_instance+0x88/0xa4 [libcomposite])
> [<bf1499dc>] (try_get_usb_function_instance [libcomposite]) from 
> [<bf149ad8>] (usb_get_function_instance+0xc/0x44 [libcomposite])
> [<bf149ad8>] (usb_get_function_instance [libcomposite]) from 
> [<bf114164>] (eth_bind+0xdc/0x34c [g_ether])
> [<bf114164>] (eth_bind [g_ether]) from [<bf1497cc>] 
> (composite_bind+0x78/0x1a8 [libcomposite])
> [<bf1497cc>] (composite_bind [libcomposite]) from [<c0c62a0c>] 
> (udc_bind_to_driver+0x60/0x108)
> [<c0c62a0c>] (udc_bind_to_driver) from [<c0c62ed8>] 
> (usb_gadget_probe_driver+0x100/0x158)
> [<c0c62ed8>] (usb_gadget_probe_driver) from [<c0301fd0>] 
> (do_one_initcall+0x54/0x220)
> [<c0301fd0>] (do_one_initcall) from [<c03de390>] (do_init_module+0x60/0x210)
> [<c03de390>] (do_init_module) from [<c03dd0d4>] (load_module+0x2078/0x24c0)
> [<c03dd0d4>] (load_module) from [<c03dd758>] (sys_finit_module+0xc8/0xd8)
> [<c03dd758>] (sys_finit_module) from [<c03000c0>] 
> (ret_fast_syscall+0x0/0x54)
> Exception stack(0xedd1dfa8 to 0xedd1dff0)
> ...
> ---[ end trace 0dc21d79c1880545 ]---

Brooke, any ideas?

thanks,

greg k-h
