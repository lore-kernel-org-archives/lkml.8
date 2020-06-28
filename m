Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3447FC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 14:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10B5320781
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 14:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593353632;
	bh=OTTxMpZn8TmaQ8zXr5LHkWm2vtIRAznfc6VzcZ+x1mQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XMv1L6ylUJgsCfBQGJawoJtnmT9j3eQaKwXnvDxhmojXKET94DX3DRCOv73HwRPuP
	 zsNSkeTjQanTb1sV7EjEyaNCoS1DZDJmRW3do7o7KHnYVxo7euQhOeBgXpnvuuIkr6
	 DjZ1GWpTcZbIrwZ37RTWt5cJce/9KoqBBiEgRIXQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgF1ONu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 10:13:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:39334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbgF1ONu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 10:13:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CA7C20738;
        Sun, 28 Jun 2020 14:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593353629;
        bh=OTTxMpZn8TmaQ8zXr5LHkWm2vtIRAznfc6VzcZ+x1mQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kj5Hnv6sJj8ZSCJoCrR6BdWZvmhfGavB0Eaiwuky4hp0lri57atYbE9abOnN2xMBD
         OCr1gVmwvnffHxWerERzGr7lrKmC9jvt/pzUGGkpk/4E0lL4J0zG2eMmrPrLI554+C
         sqBIfeAegL2MKzz4K2nHAFy3q34XKE8O6P8ly/qo=
Date:   Sun, 28 Jun 2020 16:13:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Zhang Qiang <qiang.zhang@windriver.com>, linux-usb@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: Re: [PATCH] usb: gadget: function: printer: The device interface is
 reset and should return error code
Message-ID: <20200628141339.GA3131191@kroah.com>
References: <37bf94a0-92a0-ca4e-a4e4-5dd44aef2b88@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37bf94a0-92a0-ca4e-a4e4-5dd44aef2b88@web.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 28, 2020 at 03:43:10PM +0200, Markus Elfring wrote:
> I suggest to choose a more succinct patch subject.
> 
> 
> > After the device is disconnected from the host side, the interface of
> > the device is reset. If the userspace operates the device again,
> > an error code should be returned.
> 
> Please use an imperative wording for the commit message.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=719fdd32921fb7e3208db8832d32ae1c2d68900f#n151
> 
> 
> > Signed-off-by: Zqiang <qiang.zhang@windriver.com>
> 
> Did you really specify your real name here?
> 
> Regards,
> Markus

Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot
