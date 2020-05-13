Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CCDC2D0FC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 12:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE0F22312A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 12:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589372779;
	bh=2nPOeFMik9ZQ6xUKx8jufYdpBAmDTPfySWDo5YjI/wo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PYOQ1AshGfLpzoEROun/rdbVZ7Q5m5+ll/dLHK1owu6mvgsWN9A3XDbSIwAiEebP0
	 IOZJuPTNOqIu+vAQcggbdDp004rYIcd5LDvvzmYYy7WCiBYXyXgdsARX58ZjsVFjhb
	 3Yjdv0G87lKGfZALgEGEbv5ZZWgChwmhd85hCWnE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731755AbgEMM0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 08:26:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:35094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbgEMM0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 08:26:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 845F623126;
        Wed, 13 May 2020 12:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589372776;
        bh=2nPOeFMik9ZQ6xUKx8jufYdpBAmDTPfySWDo5YjI/wo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cjGFtJREmNTq4FgZ+a7ie6IwGzteTC/KDPnz6U8iBRnMyIZgw8KSg+tkkQY2K/XN5
         SbFGEpjin9G6axFoke7d3ZIox+x7r8pKNnv4obxEEdO+/ok8me1Pgjq5D8AxYPwfYF
         Mjbp5BdabWGT9x5mF/k7xzDCFd3CIHIs2V1YXgCY=
Date:   Wed, 13 May 2020 14:26:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Al Cooper <alcooperx@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v10 1/5] usb: xhci: Change the XHCI link order in the
 Makefile
Message-ID: <20200513122613.GA1023594@kroah.com>
References: <20200512150019.25903-1-alcooperx@gmail.com>
 <20200512150019.25903-2-alcooperx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512150019.25903-2-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 11:00:15AM -0400, Al Cooper wrote:
> Some BRCMSTB USB chips have an XHCI, EHCI and OHCI controller
> on the same port where XHCI handles 3.0 devices, EHCI handles 2.0
> devices and OHCI handles <2.0 devices. Currently the Makefile
> has XHCI linking at the bottom which will result in the XHIC driver
> initalizing after the EHCI and OHCI drivers and any installed 3.0
> device will be seen as a 2.0 device. Moving the XHCI linking
> above the EHCI and OHCI linking fixes the issue.

What happens if all of these are modules and they are loaded in a
different order?  This makefile change will not help with that, you need
to have logic in the code in order to properly coordinate this type of
mess, sorry.

thanks,

greg k-h
