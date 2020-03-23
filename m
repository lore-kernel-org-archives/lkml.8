Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF97C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29B8E206F9
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbgCWPsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 11:48:47 -0400
Received: from netrider.rowland.org ([192.131.102.5]:44009 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727176AbgCWPsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 11:48:46 -0400
Received: (qmail 27447 invoked by uid 500); 23 Mar 2020 11:48:45 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 23 Mar 2020 11:48:45 -0400
Date:   Mon, 23 Mar 2020 11:48:45 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Vinod Koul <vkoul@kernel.org>
cc:     kbuild test robot <lkp@intel.com>, <kbuild-all@lists.01.org>,
        <clang-built-linux@googlegroups.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-arm-msm@vger.kernel.org, Bjorn Andersson" 
        <bjorn.andersson@linaro.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Christian Lamparter <chunkeey@googlemail.com>,
        John Stultz <john.stultz@linaro.org>,
        Andreas =?iso-8859-1?Q?B=F6hler?= <dev@aboehler.at>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH v7 1/5] usb: hci: add hc_driver as argument for
 usb_hcd_pci_probe
In-Reply-To: <20200323153429.GR72691@vkoul-mobl>
Message-ID: <Pine.LNX.4.44L0.2003231147190.24254-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Mar 2020, Vinod Koul wrote:

> On 23-03-20, 22:49, kbuild test robot wrote:
> > Hi Vinod,
> > 
> > I love your patch! Yet something to improve:
> 
> Thanks for the report.
> 
> > [auto build test ERROR on v5.6-rc7]
> > [also build test ERROR on next-20200323]
> > [cannot apply to usb/usb-testing]
> > [if your patch is applied to the wrong git tree, please drop us a note to help
> > improve the system. BTW, we also suggest to use '--base' option to specify the
> > base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> > 
> > url:    https://github.com/0day-ci/linux/commits/Vinod-Koul/usb-xhci-Add-support-for-Renesas-USB-controllers/20200323-203447
> > base:    16fbf79b0f83bc752cee8589279f1ebfe57b3b6e
> > config: x86_64-defconfig (attached as .config)
> > compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project 006244152d6c7dd6a390ff89b236cc7801834b46)
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # save the attached .config to linux build tree
> >         COMPILER=clang make.cross ARCH=x86_64 
> > 
> > If you fix the issue, kindly add following tag
> > Reported-by: kbuild test robot <lkp@intel.com>
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    In file included from drivers/usb/host/uhci-hcd.c:847:
> > >> drivers/usb/host/uhci-pci.c:297:36: error: passing 'const struct hc_driver *' to parameter of type 'struct hc_driver *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
> >            return usb_hcd_pci_probe(dev, id, &uhci_driver);
> >                                              ^~~~~~~~~~~~
> >    include/linux/usb/hcd.h:483:27: note: passing argument to parameter 'driver' here
> >                                 struct hc_driver *driver);
> 
> I need to drop the const qualifiers for uhci_driver, I have checked that
> and will send v8 with this fix

No, don't remove the qualifier for uhci_driver.  Instead, change 
usb_hcd_pci_probe(): make driver a pointer to const.

Alan Stern

