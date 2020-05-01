Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2584C47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 10:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 934432184D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 10:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588330525;
	bh=erC6W5Is3Nh/oL4QwwTvkse8Vyv5xbMSlz9NG80pnSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nudgrUb3CfjEkUSO53KeJpfnKYKhsfcfwHbELAOh6WcsMEeMhAt3wGR4FWY8mHWln
	 le0PjlVTLDQeDumms5KfqeGeatNMg1K5lg9enCqhLCFM2gZ25lvyOr2p6SPoHJUFCU
	 cOLRth/Asuy6t2DbbgnQIs2ScB8Mn3T4a2YOUnCA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbgEAKzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 06:55:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:51236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728352AbgEAKzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 06:55:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E06052166E;
        Fri,  1 May 2020 10:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588330522;
        bh=erC6W5Is3Nh/oL4QwwTvkse8Vyv5xbMSlz9NG80pnSs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uEKrn4o5840WtXxkC9WrJ17O5Jlu2T5837fDfIhIeL2APjwSqIXoIC8mLpye/1y/9
         13sLP6s7aik7eVuQOxVCXsjN5lnl3XoM4n3Zye2tx6gXqZmiZX0iAeWLo/MDIQpnJQ
         aytWAXjD/jPWwGbEdZVKarybkBxRoKVTfPxdNT4E=
Date:   Fri, 1 May 2020 12:55:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Jeremy Linton <jeremy.linton@arm.com>, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, git@thegavinli.com,
        jarkko.sakkinen@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] usb: usbfs: correct kernel->user page attribute mismatch
Message-ID: <20200501105520.GA1434711@kroah.com>
References: <20200430211922.929165-1-jeremy.linton@arm.com>
 <20200501070500.GA887524@kroah.com>
 <20200501103712.GA51954@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501103712.GA51954@C02TD0UTHF1T.local>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 11:37:12AM +0100, Mark Rutland wrote:
> On Fri, May 01, 2020 at 09:05:00AM +0200, Greg KH wrote:
> > On Thu, Apr 30, 2020 at 04:19:22PM -0500, Jeremy Linton wrote:
> > > On arm64, and possibly other architectures, requesting
> > > IO coherent memory may return Normal-NC if the underlying
> > > hardware isn't coherent. If these pages are then
> > > remapped into userspace as Normal, that defeats the
> > > purpose of getting Normal-NC, as well as resulting in
> > > mappings with differing cache attributes.
> > 
> > What is "Normal-NC"?
> 
> Arm terminology for "Normal Non-Cacheable"; it might be better to say
> something like:
> 
> On some architectures (e.g. arm64) an IO coherent mapping may use
> non-cachable attributes if the relevant device is cache coherent.
> If userspace mappings are cacheable, these may not be coherent with
> non-cacheable mappings. On arm64 this is the case for Normal-NC and
> Normal (cacheable) mappings.

That's better, but it doesn't answer any of my other questions on this
patch :)

thanks,

greg k-h
