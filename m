Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDAAC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EDF1206EB
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593021591;
	bh=lqF4UvFTuSVPWPvYKcQ8+owOKSTEFacagpA6y42+2I4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=ZDQ78G8ccStrIyL9o1st/0I8+8RtZKxu/ChFxMt+J9nkz5POxuHRudrI682MrQLkF
	 Ij7dd7nPsgtdIoGCcm31wBg0i7G4yXz6/wPx8YlbdA6xUKP91ouv4IpzRd/oNBRd86
	 cL8UPZ+RbJ1+SfDUTzU0VH7latsu0G0coKlwIrs0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405956AbgFXR7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 13:59:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:59462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405808AbgFXR7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 13:59:49 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47F00207DD;
        Wed, 24 Jun 2020 17:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593021588;
        bh=lqF4UvFTuSVPWPvYKcQ8+owOKSTEFacagpA6y42+2I4=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=2OyEwIQ2W+yC8MeIiJn+zg6EpblYaMgeW1W2KIyhIYSiWBv27LoWjQc7whL/xeVKv
         y88icKjpG7HCb5h5QohX0bjtTPKL9DqECdzfBD8KC9GTdN07U3EonUUVOnBxKcXHUo
         yqYasuZpBgXc5lZj44gwka4tdlhLxCPXuN8CH3H4=
Date:   Wed, 24 Jun 2020 10:59:47 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     "Michael S. Tsirkin" <mst@redhat.com>
cc:     Peng Fan <peng.fan@nxp.com>, sstabellini@kernel.org,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        konrad.wilk@oracle.com, jasowang@redhat.com, x86@kernel.org,
        xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org, linux-imx@nxp.com
Subject: Re: [PATCH] xen: introduce xen_vring_use_dma
In-Reply-To: <20200624050355-mutt-send-email-mst@kernel.org>
Message-ID: <alpine.DEB.2.21.2006241047010.8121@sstabellini-ThinkPad-T480s>
References: <20200624091732.23944-1-peng.fan@nxp.com> <20200624050355-mutt-send-email-mst@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jun 2020, Michael S. Tsirkin wrote:
> On Wed, Jun 24, 2020 at 05:17:32PM +0800, Peng Fan wrote:
> > Export xen_swiotlb for all platforms using xen swiotlb
> > 
> > Use xen_swiotlb to determine when vring should use dma APIs to map the
> > ring: when xen_swiotlb is enabled the dma API is required. When it is
> > disabled, it is not required.
> > 
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> 
> Isn't there some way to use VIRTIO_F_IOMMU_PLATFORM for this?
> Xen was there first, but everyone else is using that now.

Unfortunately it is complicated and it is not related to
VIRTIO_F_IOMMU_PLATFORM :-(


The Xen subsystem in Linux uses dma_ops via swiotlb_xen to translate
foreign mappings (memory coming from other VMs) to physical addresses.
On x86, it also uses dma_ops to translate Linux's idea of a physical
address into a real physical address (this is unneeded on ARM.)


So regardless of VIRTIO_F_IOMMU_PLATFORM, dma_ops should be used on Xen/x86
always and on Xen/ARM if Linux is Dom0 (because it has foreign
mappings.) That is why we have the if (xen_domain) return true; in
vring_use_dma_api.

You might have noticed that I missed one possible case above: Xen/ARM
DomU :-)

Xen/ARM domUs don't need swiotlb_xen, it is not even initialized. So if
(xen_domain) return true; would give the wrong answer in that case.
Linux would end up calling the "normal" dma_ops, not swiotlb-xen, and
the "normal" dma_ops fail.


The solution I suggested was to make the check in vring_use_dma_api more
flexible by returning true if the swiotlb_xen is supposed to be used,
not in general for all Xen domains, because that is what the check was
really meant to do.


In this regards I have two more comments:

- the comment on top of the check in vring_use_dma_api is still valid
- the patch looks broken on x86: it should always return true, but it
  returns false instead

 
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index a2de775801af..768afd79f67a 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -252,7 +252,7 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
> >  	 * the DMA API if we're a Xen guest, which at least allows
> >  	 * all of the sensible Xen configurations to work correctly.
> >  	 */
> > -	if (xen_domain())
> > +	if (xen_vring_use_dma())
> >  		return true;
> >  
> >  	return false;
> 
> 
> The comment above this should probably be fixed.

> 
