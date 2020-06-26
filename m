Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5365C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B912204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593186966;
	bh=6IUg7SRx5RQHGMSi/Bki4tPWOaf3FpX8aR4DD0ku4s0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=GOBJUgCIjk54psKDgA2LgKHxKgB7MFZj3AUE94R1BLHUVLhUxyPgP1bWst7brggfZ
	 KlJTcto/ngZRioN7fXcynGaGFJ5xG5RatNo3E0LrBjcKFs3snFsvDucm93KDvVgos0
	 mzeMr3QCsqTDwBbUmQVgkLiNT3A5YD3ckbE/ehQg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbgFZP4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 11:56:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:45806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725833AbgFZP4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 11:56:04 -0400
Received: from coco.lan (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 544C1204EC;
        Fri, 26 Jun 2020 15:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593186964;
        bh=6IUg7SRx5RQHGMSi/Bki4tPWOaf3FpX8aR4DD0ku4s0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KjN8HAI7QAh00wP42xFh59WmNvd0glCw8A5ldDxHOHEthKS6FZUspz2XSH+2lMjG9
         kLLS8HGlbmbLg2vmjyMSIlS13b1UO/ZF5pBZG5oPgXkKDVLP5X6L3anx+L5p2RGBbT
         ltrG5qaj3niY62dCmMybcDTxMgWW0+aGHKbYmj7g=
Date:   Fri, 26 Jun 2020 17:56:00 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-media@vger.kernel.org
Subject: Re: [PATCH 0/7] Some atomisp fixes and improvements
Message-ID: <20200626175600.4b49e0f7@coco.lan>
In-Reply-To: <20200626175216.7955c374@coco.lan>
References: <cover.1593180146.git.mchehab+huawei@kernel.org>
        <20200626150021.GY3703480@smile.fi.intel.com>
        <20200626175216.7955c374@coco.lan>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 26 Jun 2020 17:52:16 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> Em Fri, 26 Jun 2020 18:00:21 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> escreveu:
> 
> > On Fri, Jun 26, 2020 at 04:04:52PM +0200, Mauro Carvalho Chehab wrote:
> > > Those patches are meant to improve device detection by the atomisp driver,
> > > relying on ACPI bios when possible.
> > > 
> > > It also adds a basis for using ACPI PM, but only if the DSDT tables have
> > > a description about how to turn on the resources needed by the cameras.
> > > 
> > > At least on the device I'm using for tests, this is not the case.  
> > 
> > Is this in your experimental tree? 
> 
> Yes. 
> 
> > I'll rebase mine on top and test.
> > After I will send the rest from my series and give a tag to this.
> 
> It would be helpful if you could test removing the DMI match table from
> your board. If your device has a DSDT table close to the one I have, the
> new code may be able to get everything from DSDT.

Err... I spoke too soon... looking on the logs from your 00/15, it 
seems that your device's DSDT is indeed different:

	[  116.401267] ACPI: \: failed to evaluate _DSM (0x1001)

If possible, could you please send me (could be in priv) a copy of your
DSDT?

Thanks,
Mauro
