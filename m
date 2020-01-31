Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1F7C33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 05:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1548720663
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 05:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbgAaFyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 00:54:17 -0500
Received: from mga12.intel.com ([192.55.52.136]:45660 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726399AbgAaFyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 00:54:16 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2020 21:54:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,384,1574150400"; 
   d="scan'208";a="377255838"
Received: from dpdk-virtio-tbie-2.sh.intel.com (HELO ___) ([10.67.104.74])
  by orsmga004.jf.intel.com with ESMTP; 30 Jan 2020 21:54:12 -0800
Date:   Fri, 31 Jan 2020 13:54:04 +0800
From:   Tiwei Bie <tiwei.bie@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     mst@redhat.com, jasowang@redhat.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, shahafs@mellanox.com, jgg@mellanox.com,
        rob.miller@broadcom.com, haotian.wang@sifive.com,
        eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com,
        hch@infradead.org, jiri@mellanox.com, hanand@xilinx.com,
        mhabets@solarflare.com, maxime.coquelin@redhat.com,
        lingshan.zhu@intel.com, dan.daly@intel.com,
        cunming.liang@intel.com, zhihong.wang@intel.com
Subject: Re: [PATCH] vhost: introduce vDPA based backend
Message-ID: <20200131055403.GB111365@___>
References: <20200131033651.103534-1-tiwei.bie@intel.com>
 <43aeecb4-4c08-df3d-1c1d-699ec4c494bd@infradead.org>
 <05e21ed9-d5af-b57c-36cd-50b34915e82d@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <05e21ed9-d5af-b57c-36cd-50b34915e82d@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 09:12:57PM -0800, Randy Dunlap wrote:
> On 1/30/20 7:56 PM, Randy Dunlap wrote:
> > Hi,
> > 
> > On 1/30/20 7:36 PM, Tiwei Bie wrote:
> >> diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> >> index f21c45aa5e07..13e6a94d0243 100644
> >> --- a/drivers/vhost/Kconfig
> >> +++ b/drivers/vhost/Kconfig
> >> @@ -34,6 +34,18 @@ config VHOST_VSOCK
> >>  	To compile this driver as a module, choose M here: the module will be called
> >>  	vhost_vsock.
> >>  
> >> +config VHOST_VDPA
> >> +	tristate "Vhost driver for vDPA based backend"
> 
> oops, missed this one:
> 	                           vDPA-based

Will fix. Thanks!

> 
> >> +	depends on EVENTFD && VDPA
> >> +	select VHOST
> >> +	default n
> >> +	---help---
> >> +	This kernel module can be loaded in host kernel to accelerate
> >> +	guest virtio devices with the vDPA based backends.
> > 
> > 	                              vDPA-based
> > 
> >> +
> >> +	To compile this driver as a module, choose M here: the module
> >> +	will be called vhost_vdpa.
> >> +
> > 
> > The preferred Kconfig style nowadays is
> > (a) use "help" instead of "---help---"
> > (b) indent the help text with one tab + 2 spaces
> > 
> > and don't use "default n" since that is already the default.
> > 
> >>  config VHOST
> >>  	tristate
> >>          depends on VHOST_IOTLB
> > 
> > thanks.
> > 
> 
> 
> -- 
> ~Randy
> 
