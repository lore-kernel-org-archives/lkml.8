Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6E7C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 07:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AB37204EF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 07:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591599930;
	bh=Cwb5EvcljlGuWZibUThhRbS8xMa0vQTQolaLMZ/c5as=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Z2aUYsrBkPMnoK+lGpT8ZVBv9L47bqjfPNO6jD+rxQr0DYL/p+y46smv7kWac1SB/
	 TCHUOtiXgJOXnPX5RyptIn6hU30Vmf4CChteqdR/MwYZNgep0J33NZpz3qPyiGRYMz
	 eRf4FNGFkEMkWUuRJJuYarrXOtNYm2g4t+AsBEV4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbgFHHF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 03:05:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:59292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728053AbgFHHF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 03:05:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82AAC204EF;
        Mon,  8 Jun 2020 07:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591599927;
        bh=Cwb5EvcljlGuWZibUThhRbS8xMa0vQTQolaLMZ/c5as=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O7C2gTuGrrDXWc++jYwOGas+TIDhSEWNm3KD/ejRL6r6ydrkpOQTJGVr/sjRYQCvO
         0GBbVJ7ubizOlA6x2IGxvJDOyRw2XUdVaMvnUF/mdGxAf0ea8yutP1E1enV2XIS+0C
         Emmez8U3uopmEehE/09yMvgmv4CrqM+kMJY3zXbE=
Date:   Mon, 8 Jun 2020 09:05:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     mathias.nyman@intel.com,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] xhci: Poll for U0 after disabling USB2 LPM
Message-ID: <20200608070524.GB247853@kroah.com>
References: <20200520101811.2623-1-kai.heng.feng@canonical.com>
 <20200520101811.2623-2-kai.heng.feng@canonical.com>
 <EF6B47D0-973E-46B7-9194-C58389FFAB35@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EF6B47D0-973E-46B7-9194-C58389FFAB35@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 11:58:40AM +0800, Kai-Heng Feng wrote:
> 
> 
> > On May 20, 2020, at 18:18, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> > 
> > USB2 devices with LPM enabled may interrupt the system suspend:
> > [  932.510475] usb 1-7: usb suspend, wakeup 0
> > [  932.510549] hub 1-0:1.0: hub_suspend
> > [  932.510581] usb usb1: bus suspend, wakeup 0
> > [  932.510590] xhci_hcd 0000:00:14.0: port 9 not suspended
> > [  932.510593] xhci_hcd 0000:00:14.0: port 8 not suspended
> > ..
> > [  932.520323] xhci_hcd 0000:00:14.0: Port change event, 1-7, id 7, portsc: 0x400e03
> > ..
> > [  932.591405] PM: pci_pm_suspend(): hcd_pci_suspend+0x0/0x30 returns -16
> > [  932.591414] PM: dpm_run_callback(): pci_pm_suspend+0x0/0x160 returns -16
> > [  932.591418] PM: Device 0000:00:14.0 failed to suspend async: error -16
> > 
> > During system suspend, USB core will let HC suspends the device if it
> > doesn't have remote wakeup enabled and doesn't have any children.
> > However, from the log above we can see that the usb 1-7 doesn't get bus
> > suspended due to not in U0. After a while the port finished U2 -> U0
> > transition, interrupts the suspend process.
> > 
> > The observation is that after disabling LPM, port doesn't transit to U0
> > immediately and can linger in U2. xHCI spec 4.23.5.2 states that the
> > maximum exit latency for USB2 LPM should be BESL + 10us. The BESL for
> > the affected device is advertised as 400us, which is still not enough
> > based on my testing result.
> > 
> > So let's use the maximum permitted latency, 10000, to poll for U0
> > status to solve the issue.
> > 
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> 
> A gentle ping...

It is the middle of the merge window, we can't do anything with any new
patch until after -rc1 is out.

You know this...

greg k-h
