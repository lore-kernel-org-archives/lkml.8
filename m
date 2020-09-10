Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB72C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 16:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73BF8206A1
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 16:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599754288;
	bh=U8UPf2zD1wD4F/oWQsINk4jgPZ05SckxVHhW9g+Hi8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dL6S2w599qny2d0a7uqfvhvhMETBBXPC+iOXDfC9iORTItAmIi7WPE+u4nq6Fi2Lc
	 R2iVLO1Wxz3814bqt7QrqVGIY2alvpi+hYCJp8c+GJz8Ak4Z8xPxIJceBiO4fqYPmG
	 sWcK/iMfzo7A4QHScMWPtCjXn9Lh9G2vkxNEhZpc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgIJQLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 12:11:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:57076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbgIJQIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 12:08:16 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EFFB20BED;
        Thu, 10 Sep 2020 16:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599754091;
        bh=U8UPf2zD1wD4F/oWQsINk4jgPZ05SckxVHhW9g+Hi8s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mZqBCLyVIULyL6HwvtYdbbM7Wrer1Z2zsTM5bo3K5ezyUUq2dwIoUdusDwc3NXDnI
         vtlz3tBLnZ4xBZzf6yhEfzA9+VjPaYzI4uPYta8fwCJOnV2eXdMdG2y66fC4XMme9M
         X/WorXSSs/SYtFNR/wdPBTO93xqquIVP8q7+wyoQ=
Date:   Thu, 10 Sep 2020 18:08:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        SW_Drivers <SW_Drivers@habana.ai>
Subject: Re: [PATCH 00/15] Adding GAUDI NIC code to habanalabs driver
Message-ID: <20200910160818.GA1158578@kroah.com>
References: <20200910150328.20545-1-oded.gabbay@gmail.com>
 <20200910155440.GC1151284@kroah.com>
 <CAFCwf132vzvEQ2Jrzme8SuK8OCSB8-QTXiwr5Rj96_hwi91TKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf132vzvEQ2Jrzme8SuK8OCSB8-QTXiwr5Rj96_hwi91TKQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 06:59:41PM +0300, Oded Gabbay wrote:
> On Thu, Sep 10, 2020 at 6:54 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Sep 10, 2020 at 06:03:13PM +0300, Oded Gabbay wrote:
> > > This patch-set adds support for initializing and using the GAUDI NIC ports,
> > > functioning as scale-out interconnect when doing distributed Deep Learning
> > > training. The training can be performed over tens of thousands of GAUDIs
> > > and it is done using the RDMA-over-converged-Ethernet (RoCE) v2 protocol.
> > >
> > > Each GAUDI exposes 10x100GbE ports that are designed to scale-out the
> > > inter-GAUDI communication by integrating a complete communication engine
> > > on-die. This native integration allows users to use the same scaling
> > > technology, both inside the server and rack (termed as scale-up), as well
> > > as for scaling across racks (scale-out). The racks can be connected
> > > directly between GAUDI processors, or through any number of standard
> > > Ethernet switches.
> > >
> > > The driver exposes the NIC ports to the user as standard Ethernet ports by
> > > registering each port to the networking subsystem. This allows the user to
> > > manage the ports with standard tools such as ifconfig, ethtool, etc. It
> > > also enables us to connect to the Linux networking stack and thus support
> > > standard networking protocols, such as IPv4, IPv6, TCP, etc. In addition,
> > > we can also leverage protocols such as DCB for dynamically configuring
> > > priorities to avoid congestion.
> > >
> > > For each NIC port there is a matching QMAN entity. For RoCE, the user
> > > submits workloads to the NIC through the QMAN, same as he does for the
> > > compute engines. For regular Ethernet, the user sends and receives packets
> > > through the standard Ethernet sockets. Those sockets are used only as a
> > > control path. The data path that is used for AI training goes through the
> > > RoCE interface.
> > >
> > > It is important to note that there are some limitations and uniqueness
> > > in GAUDI's NIC H/W, compared to other networking adapters that enforced us
> > > to use a less-than-common driver design:
> > >
> > > 1. The NIC functionality is NOT exposed as different PCI Physical
> > >    Functions. There is a single PF which is used for compute and
> > >    networking, as the main goal of the NIC ports is to be used as
> > >    intra-communication and not as standard network interfaces. This
> > >    implies we can't connect different drivers to handle the networking
> > >    ports because it is the same device, from the kernel POV, as the
> > >    compute. Therefore, we must integrate the networking code into the
> > >    main habanalabs driver.
> >
> > That's kind of common, see the long threads on the netdev and IB mailing
> > lists about this type of issue on other networking cards today.  The
> > whole "virtual bus" code should help solve this, if Intel ever gets
> > around to posting a new version of that patch series one day...
> >
> > But, because you are writing networking driver code here, you really
> > should run all of this by the netdev@vger.kernel.org maintainers and
> > developers, as they know how to review this interaction with the network
> > stack better than anyone else.
> >
> > Care to resend it and cc: them too?
> >
> > thanks,
> >
> > greg k-h
> 
> Sure, np.
> Do you have someone specific or should I just send it to that mailing list ?
> I don't know anyone there.

the MAINTAINERS file should help you:
	NETWORKING DRIVERS
	M:      "David S. Miller" <davem@davemloft.net>
	M:      Jakub Kicinski <kuba@kernel.org>
	L:      netdev@vger.kernel.org
	S:      Maintained
	W:      http://www.linuxfoundation.org/en/Net
	Q:      http://patchwork.ozlabs.org/project/netdev/list/
	T:      git git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
	T:      git git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
	F:      Documentation/devicetree/bindings/net/
	F:      drivers/net/
	F:      include/linux/etherdevice.h
	F:      include/linux/fcdevice.h
	F:      include/linux/fddidevice.h
	F:      include/linux/hippidevice.h
	F:      include/linux/if_*
	F:      include/linux/inetdevice.h
	F:      include/linux/netdevice.h
	F:      include/uapi/linux/if_*
	F:      include/uapi/linux/netdevice.h

:)
