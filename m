Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC736C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA44A208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597931298;
	bh=0cUhTu2kcvkdAMXDD1Ej4fAur3dt50eKRxc2djb/ufs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pHsV6uaQr86Hvnz7yZuLN9CbpJmw66pdVgQWp9OCd934gsXr1EKG0sfxkz/MZGy1k
	 CtltbpDw2VbyAm8I+F8snLOMdcXM8JKy/le6Qt0UVsR7cKaFw9Hzj5pCmVgtgBY4oG
	 H4uHF65jtr8Zwkzbb2aE/TjGTnBKGmVqjU9L0ERo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbgHTNsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:48:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:54954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728153AbgHTNsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 09:48:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D6CC208DB;
        Thu, 20 Aug 2020 13:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597931283;
        bh=0cUhTu2kcvkdAMXDD1Ej4fAur3dt50eKRxc2djb/ufs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YxOvmp69gqUfe9ze3lIxSTrJkUjCChxP5m09Az4de/WNFcztdDT0XC5y2O6c4OSfS
         E62SrOpobxYpa8gQiYCxcUZgRk/5E6PMYqNLmVbJMzbVm5jz6qju5J1UfXRavcg+58
         dZynIvxSXYIIDu0cYTa0VZt47sOgHnehFuOINxX0=
Date:   Thu, 20 Aug 2020 15:48:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Wei Hu <weh@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 5.8 164/232] PCI: hv: Fix a timing issue which causes
 kdump to fail occasionally
Message-ID: <20200820134823.GA1533625@kroah.com>
References: <20200820091612.692383444@linuxfoundation.org>
 <20200820091620.754492308@linuxfoundation.org>
 <MW2PR2101MB10522B1242B1309BF35EFFEED75A0@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <20200820132924.GA8670@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820132924.GA8670@sasha-vm>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 09:29:24AM -0400, Sasha Levin wrote:
> On Thu, Aug 20, 2020 at 01:00:51PM +0000, Michael Kelley wrote:
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org> Sent: Thursday, August 20, 2020 2:20 AM
> > > 
> > > From: Wei Hu <weh@microsoft.com>
> > > 
> > > [ Upstream commit d6af2ed29c7c1c311b96dac989dcb991e90ee195 ]
> > > 
> > > Kdump could fail sometime on Hyper-V guest because the retry in
> > > hv_pci_enter_d0() releases child device structures in hv_pci_bus_exit().
> > > 
> > > Although there is a second asynchronous device relations message sending
> > > from the host, if this message arrives to the guest after
> > > hv_send_resource_allocated() is called, the retry would fail.
> > > 
> > > Fix the problem by moving retry to hv_pci_probe() and start the retry
> > > from hv_pci_query_relations() call.  This will cause a device relations
> > > message to arrive to the guest synchronously; the guest would then be
> > > able to rebuild the child device structures before calling
> > > hv_send_resource_allocated().
> > > 
> > > Link:
> > > https://lore.kernel.org/linux-hyperv/20200727071731.18516-1-weh@microsoft.com/
> > > Fixes: c81992e7f4aa ("PCI: hv: Retry PCI bus D0 entry on invalid device state")
> > > Signed-off-by: Wei Hu <weh@microsoft.com>
> > > [lorenzo.pieralisi@arm.com: fixed a comment and commit log]
> > > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > ---
> > >  drivers/pci/controller/pci-hyperv.c | 71 +++++++++++++++--------------
> > >  1 file changed, 37 insertions(+), 34 deletions(-)
> > > 
> > 
> > This patch came through three days ago, and I indicated then that we don't want
> > it backported to 5.8 and earlier.
> 
> Uh, I re-added it by mistake, sorry.

Ok, let me go drop it...
