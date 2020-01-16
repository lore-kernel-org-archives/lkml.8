Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CE8C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B122077B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579204117;
	bh=eCRmzjTIyjfbPAe/mgLEe93bWWVURDrSsFcpf6uROXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kh0OuESMksU0aYd3sDGVm3p6BDY0NcWXhw1JO4e9jGxrS80xxn37Ty9lTcjCwYVDu
	 hbIcABwEbaB55yexADYEyw+Ste0rAYirDJBIKOX10MWophyTinIAYu2jIzLavh0vb3
	 XxZBDTXu2uPTXhCv0vQNQ0qu0IMFUCPlzZNdZMNA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730217AbgAPTsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 14:48:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:43418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730056AbgAPTsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 14:48:33 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4660520730;
        Thu, 16 Jan 2020 19:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579204112;
        bh=eCRmzjTIyjfbPAe/mgLEe93bWWVURDrSsFcpf6uROXM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NWyeid1GitOMqE3prMch6/hWlduNt9sJY2Qz8f5orJr7pXXcK5jrOwHt2yPJo5JAt
         qkSGn8BCTgaxWqLcPZqSdnGSmNEBlVaiDlOwiYiS2wBtUgjGvdBR+GLL7PxGIY8xKt
         QXCC908Z+SglQ58IDwsYgrc1X/SAahZRdscSSY20=
Date:   Thu, 16 Jan 2020 20:48:30 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Julian Stecklina <julian.stecklina@cyberus-technology.de>
Cc:     intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        zhiyuan.lv@intel.com, hang.yuan@intel.com,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Thomas Prescher <thomas.prescher@cyberus-technology.de>
Subject: Re: [RFC PATCH 4/4] drm/i915/gvt: move public gvt headers out into
 global include
Message-ID: <20200116194830.GA1072059@kroah.com>
References: <4079ce7c26a2d2a3c7e0828ed1ea6008d6e2c805.camel@cyberus-technology.de>
 <20200109171357.115936-1-julian.stecklina@cyberus-technology.de>
 <20200109171357.115936-5-julian.stecklina@cyberus-technology.de>
 <20200115152215.GA3830321@kroah.com>
 <9b32e225ee680e61716e300eb1ed8387599cc0dd.camel@cyberus-technology.de>
 <20200116142345.GA476889@kroah.com>
 <edb721906354e26c26883edf5bce09690ca07d6d.camel@cyberus-technology.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edb721906354e26c26883edf5bce09690ca07d6d.camel@cyberus-technology.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 04:05:22PM +0100, Julian Stecklina wrote:
> Hi Greg,
> 
> On Thu, 2020-01-16 at 15:23 +0100, Greg KH wrote:
> > On Thu, Jan 16, 2020 at 03:13:01PM +0100, Julian Stecklina wrote:
> > > Hi Greg, Christoph,
> > > 
> > > On Wed, 2020-01-15 at 16:22 +0100, Greg KH wrote:
> > > > On Thu, Jan 09, 2020 at 07:13:57PM +0200, Julian Stecklina wrote:
> > > > > Now that the GVT interface to hypervisors does not depend on i915/GVT
> > > > > internals anymore, we can move the headers to the global include/.
> > > > > 
> > > > > This makes out-of-tree modules for hypervisor integration possible.
> > > > 
> > > > What kind of out-of-tree modules do you need/want for this?
> > > 
> > > The mediated virtualization support in the i915 driver needs a backend to
> > > the
> > > hypervisor. There is currently one backend for KVM in the tree
> > > (drivers/gpu/drm/i915/gvt/kvmgt.c) and at least 3 other hypervisor backends
> > > out
> > > of tree in various states of development that I know of. We are currently
> > > developing one of these.
> > 
> > Great, then just submit this patch series as part of your patch series
> > when submitting yoru hypervisor code.  That's the normal way to export
> > new symbols, we can't do so without an in-kernel user.
> 
> Fair enough.
> 
> As I already said, the KVMGT code is the in-kernel user. But I guess I can
> extend the already existing function pointer way of decoupling KVMGT from i915
> and be on my way without exporting any symbols.
> 
> Somewhat independent of the current discussion, I also think that it's valuable
> to have a defined API (I'm not saying stable API) for the hypervisor backends to
> define what's okay and not okay for them to do.

The only way to get a "good" api is for at least 3 users of them get
into the kernel tree.  If all you have is one or two, then you go with
what you got, and evolve over time as more get added and find better
ways to use them.

In short, it's just basic evolution, not intelligent design :)

thanks,

greg k-h
