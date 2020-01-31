Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA72C35240
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 15:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 705BF2173E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 15:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbgAaPr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 10:47:28 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:56026 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728992AbgAaPr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 10:47:28 -0500
Received: (qmail 3508 invoked by uid 2102); 31 Jan 2020 10:47:27 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 31 Jan 2020 10:47:27 -0500
Date:   Fri, 31 Jan 2020 10:47:27 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
cc:     Vinod Koul <vkoul@kernel.org>,
        Christian Lamparter <chunkeey@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        USB list <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v6 0/5] usb: xhci: Add support for Renesas USB controllers
In-Reply-To: <64340358-6682-4ae0-9c06-d72d5a4ff259@linux.intel.com>
Message-ID: <Pine.LNX.4.44L0.2001311045470.1577-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jan 2020, Mathias Nyman wrote:

> I realize this can't be easily changed because usb_hcd_pci_probe() takes the
> pci_device_id pointer as an argument, and expects id.driver_data to be a
> HC driver pointer.
> 
> So this turns out to be a question for Greg and Alan:
> 
> Would it make sense to change usb_hcd_pci_probe() to take a HC driver pointer
> as an argument instead of a pointer to pci_device_id?
> pci_device_id pointer is only used to extract the HC driver handle.
> This way the driver_data could be used for, well, driver data.

That seems like a good idea to me.  There aren't very many drivers that 
use usb_hcd_pci_probe(); changing them all should be fairly easy.

Alan Stern

