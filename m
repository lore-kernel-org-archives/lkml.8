Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2058C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 23:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E4FC20780
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 23:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593474552;
	bh=YbTxDsPQ5DXse6zCMw0MuvKG3mwFGMtOfnE1ikxlpqo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=RStC7jknPsr4QyhsRhHxHylJX6mRUqCpakzPo5v8ybvRp9jshf4etJeQQ+LgMTYV9
	 oiLS88EvMwaDrbnf2tkuIckI5BPqL8YswZP6DSlax/md+xF6X6fpTIYhqo7kmRQG3h
	 oAvGL/Tr1qdfTsovP+/wX4avKNAVs6Y4KQ5nwqEQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbgF2XtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 19:49:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:50466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728226AbgF2XtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 19:49:08 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7889C20780;
        Mon, 29 Jun 2020 23:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593474548;
        bh=YbTxDsPQ5DXse6zCMw0MuvKG3mwFGMtOfnE1ikxlpqo=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=oupK0XZKr1tf9ZlB/vvhwl1g6l2FOT5EFgGIhASbYWQH4kL3mAqIIY0pFydyMp7AX
         ofoJ8l5Iy8Aj26eVYnf5X4wsVYL6+cyWfbFqp0keEtaF2uTu23UBwDyP6etUS+vytZ
         X2bXG5S9JLED91Z9FLDjXkzy6mkStrMTTdctv8GQ=
Date:   Mon, 29 Jun 2020 16:49:07 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Peng Fan <peng.fan@nxp.com>
cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "jgross@suse.com" <jgross@suse.com>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] xen: introduce xen_vring_use_dma
In-Reply-To: <DB6PR0402MB27601CA74B85DA5A9F5E5DD6886E0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
Message-ID: <alpine.DEB.2.21.2006291647450.8121@sstabellini-ThinkPad-T480s>
References: <20200624091732.23944-1-peng.fan@nxp.com> <20200624050355-mutt-send-email-mst@kernel.org> <alpine.DEB.2.21.2006241047010.8121@sstabellini-ThinkPad-T480s> <20200624163940-mutt-send-email-mst@kernel.org> <alpine.DEB.2.21.2006241351430.8121@sstabellini-ThinkPad-T480s>
 <20200624181026-mutt-send-email-mst@kernel.org> <alpine.DEB.2.21.2006251014230.8121@sstabellini-ThinkPad-T480s> <20200626110629-mutt-send-email-mst@kernel.org> <DB6PR0402MB27601CA74B85DA5A9F5E5DD6886E0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jun 2020, Peng Fan wrote:
> > > If that is the case, how is it possible that virtio breaks on ARM
> > > using the default dma_ops? The breakage is not Xen related (except
> > > that Xen turns dma_ops on). The original message from Peng was:
> > >
> > >   vring_map_one_sg -> vring_use_dma_api
> > >                    -> dma_map_page
> > >   		       -> __swiotlb_map_page
> > >   		                ->swiotlb_map_page
> > >   				->__dma_map_area(phys_to_virt(dma_to_phys(dev,
> > dev_addr)), size, dir);
> > >   However we are using per device dma area for rpmsg, phys_to_virt
> > >   could not return a correct virtual address for virtual address in
> > >   vmalloc area. Then kernel panic.
> > >
> > > I must be missing something. Maybe it is because it has to do with RPMesg?
> > 
> > I think it's an RPMesg bug, yes
> 
> rpmsg bug is another issue, it should not use dma_alloc_coherent for reserved area,
> and use vmalloc_to_page.
> 
> Anyway here using dma api will also trigger issue.

Is the stack trace above for the RPMesg issue or for the Trusty issue?
If it is the stack trace for RPMesg, can you also post the Trusty stack
trace? Or are they indentical?
