Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569BDC54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 10:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3144C20776
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 10:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587725722;
	bh=K9+b1rTapg006SIB5atM7S2iJK8RNGUMIZkn+n29O1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ez+56uUDuaPW9wExWOpFBm5LTsPmvr/KsjvPZEcmKQh/JC/ShVmycPMczSB80wGhM
	 ubv+rmmff1V75tBiwdq/4FSeFRrEoBLadYOcFkdZnABhQrggTWp3EqKlYIRStqWvEC
	 kQeB3K7WvbMj6GV+Hc909B5zYYUv5NKpWBTe8C0w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbgDXKzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 06:55:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:52376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbgDXKzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 06:55:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 652F220776;
        Fri, 24 Apr 2020 10:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587725718;
        bh=K9+b1rTapg006SIB5atM7S2iJK8RNGUMIZkn+n29O1s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LJdel0eRJof2lo1GMlC9+yZ5jSeuKES0JLS+2ISF2npXrRzEHsgz+pKvEzFcqy7f6
         pQoEFMZ7k/LrjecJxiBrXNH9qmW1UkVmOse8grbU6SWp+rqv/aGxzZd8iulU1EbnU0
         x24p9hKPmLkpz95YIFjoFcAFbW8NhI48hQg9ZLCw=
Date:   Fri, 24 Apr 2020 12:55:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christian.Gromm@microchip.com
Cc:     devel@driverdev.osuosl.org, lkp@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: b276527539 ("staging: most: move core files out of the staging
 .."): [   12.247349] BUG: kernel NULL pointer dereference, address: 00000000
Message-ID: <20200424105516.GA395057@kroah.com>
References: <20200329133917.GE11705@shao2-debian>
 <1e725f60c598cd8a5f167fd63ade6ee173960f01.camel@microchip.com>
 <20200424101634.GB390100@kroah.com>
 <210f5dac5fe26fba008068a932e51a9cde142c89.camel@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <210f5dac5fe26fba008068a932e51a9cde142c89.camel@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 10:21:05AM +0000, Christian.Gromm@microchip.com wrote:
> On Fri, 2020-04-24 at 12:16 +0200, Greg KH wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > know the content is safe
> > 
> > On Fri, Apr 24, 2020 at 09:41:36AM +0000, 
> > Christian.Gromm@microchip.com wrote:
> > > On Sun, 2020-03-29 at 21:39 +0800, kernel test robot wrote:
> > > > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > > > know the content is safe
> > > > 
> > > > Greetings,
> > > > 
> > > > 0day kernel testing robot got the below dmesg and the first bad
> > > > commit is
> > > > 
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
> > > > staging-next
> > > > 
> > > > commit b276527539188f1f61c082ebef27803db93e536d
> > > > Author:     Christian Gromm <christian.gromm@microchip.com>
> > > > AuthorDate: Tue Mar 10 14:02:40 2020 +0100
> > > > Commit:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > CommitDate: Tue Mar 24 13:42:44 2020 +0100
> > > > 
> > > >     staging: most: move core files out of the staging area
> > > > 
> > > >     This patch moves the core module to the /drivers/most
> > > > directory
> > > >     and makes all necessary changes in order to not break the
> > > > build.
> > > > 
> > > >     Signed-off-by: Christian Gromm <christian.gromm@microchip.com
> > > > >
> > > >     Link:
> > > > https://lore.kernel.org/r/1583845362-26707-2-git-send-email-christian.gromm@microchip.com
> > > >     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org
> > > > >
> > > > 
> > > > 22dd4acc80  Staging: speakup: Add identifier name to function
> > > > declaration arguments.
> > > > b276527539  staging: most: move core files out of the staging
> > > > area
> > > > e681bb287f  staging: vt6656: Use DIV_ROUND_UP macro instead of
> > > > specific code
> > > > +-------------------------------------------------------+------
> > > > ----
> > > > --+------------+------------+
> > > > >                                                       |
> > > > > 22dd4acc80
> > > > > > b276527539 | e681bb287f |
> > > > +-------------------------------------------------------+------
> > > > ----
> > > > --+------------+------------+
> > > > > boot_successes                                        |
> > > > > 26         | 0          | 0          |
> > > > > boot_failures                                         |
> > > > > 8          | 11         | 11         |
> > > > > WARNING:possible_circular_locking_dependency_detected |
> > > > > 8          |            |            |
> > > > > BUG:kernel_NULL_pointer_dereference,address           |
> > > > > 0          | 11         | 11         |
> > > > > Oops:#[##]                                            |
> > > > > 0          | 11         | 11         |
> > > > > EIP:__list_add_valid                                  |
> > > > > 0          | 11         | 11         |
> > > > > Kernel_panic-not_syncing:Fatal_exception              |
> > > > > 0          | 11         | 11         |
> > > > +-------------------------------------------------------+------
> > > > ----
> > > > --+------------+------------+
> > > > 
> > > > If you fix the issue, kindly add following tag
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > 
> > > > [   12.242090] no options.
> > > > [   12.245364] FPGA DOWNLOAD --->
> > > > [   12.245723] FPGA image file name: xlinx_fpga_firmware.bit
> > > > [   12.246548] GPIO INIT FAIL!!
> > > > [   12.246995] most_sound: init()
> > > > [   12.247349] BUG: kernel NULL pointer dereference, address:
> > > 
> > > The init order of the modules is wrong in case the driver is
> > > being built in-tree.
> > > 
> > > The init function of module most_sound is called before the
> > > core itself is being initialized.
> > > 
> > > [    5.179189] most_sound: init()
> > > [    5.180205] mostcore: __init()
> > > 
> > > Hence the list used in the core to store and track the
> > > registered components has not been initialized with
> > > INIT_LIST_HEAD(&comp_list) by the time the sound module
> > > tries to register itself with the core.
> > > 
> > > The Kconfig of most_sound, however, has a dependency to
> > > MOST. How can the build system be forced to initialize the
> > > core module first?
> > 
> > Linker order is the thing here.
> > 
> > You can mess with the init levels here, and use subsys_initcall() for
> > mostcore, will that fix it?
> 
> I already gave it a try and it works. But is it ok to use the
> subsys_initcall() function when the driver is being built as a
> module?

Yes, that works the same, see it's use elsewhere in the kernel tree, and
for what it "degrades to" if the file is being built as a module.

thanks,

greg k-h
