Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4286C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 999A62225F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dm4DRQiQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgF2SiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:38:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20021 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727996AbgF2SiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:38:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593455891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Iiom3LNVi9ET0XgfPNiU1I3DflByt3ZNInrS8hmdp2U=;
        b=Dm4DRQiQ6fUDiw0ODYfzRHM0l5n+/OCax4tsmQVFEte4dJzOhv+iMeaX7PPDTf5oyU2Cvy
        0CJwQz6V7YaBivk2kU2ABaaWuXVz4uW6YjOtq4MYIn+3EyNMsgXd1uWHXxibfnQTObK24F
        8SkzU6q4SO8an7e201QLwzG41YBOs7A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-zq5FJK0EM5iWibiXsRdCPQ-1; Mon, 29 Jun 2020 02:33:44 -0400
X-MC-Unique: zq5FJK0EM5iWibiXsRdCPQ-1
Received: by mail-wm1-f72.google.com with SMTP id g138so9169162wme.7
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 23:33:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Iiom3LNVi9ET0XgfPNiU1I3DflByt3ZNInrS8hmdp2U=;
        b=bcJwot1rvvs31r6/bGkj69+UdKhSSU3V29QHO2CN/GXz2IBDw0gXkenJA5N8Fhy7pP
         yv6SjNdVYVEEVRlWaKnFo2or0J342R83z/tPKQ4Lu+9avZ1h4gk4KJYgOf2tHqquDaxv
         dKRcHykJPRBatK8yz/XMHye1JGzGO6WzGc6sLB70r9CYKpLVQXCy2bR545Ldhq8kzV0X
         D5yd0nT6kg01GFPFY99Pd6GrVCh4TVc6u6XvlP94eFK3nSkbkCZoOeL6w1dRROFpCrtp
         YSGj1o6IHwbwbP+aCQYAekMjaFjAV69JCyzGFY0hANWF6WxxyKy3HdVXawA+ztSCitb3
         MamQ==
X-Gm-Message-State: AOAM530kykZRCy2aHGfDYcu1cKbcr+mYv9MGX3cJp5TMQP037huGMZHQ
        1J5pGyazveM8pQupjHGQXa4NmqbqUiizQhjwevBkf+beDJiPsUI+FM719+Cn3xROx9v64wgxE2c
        pK53+Jv4h2oM6W7hincD04d3/
X-Received: by 2002:adf:8067:: with SMTP id 94mr14821901wrk.427.1593412423677;
        Sun, 28 Jun 2020 23:33:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfYJ1M6jIB+Bt9+iuqmCS+1/JuHYbah8AxWL9RwY6izIKRHTcVkotYUsuHjo+DZqHXAwCswQ==
X-Received: by 2002:adf:8067:: with SMTP id 94mr14821888wrk.427.1593412423531;
        Sun, 28 Jun 2020 23:33:43 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
        by smtp.gmail.com with ESMTPSA id s8sm41059111wru.38.2020.06.28.23.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 23:33:42 -0700 (PDT)
Date:   Mon, 29 Jun 2020 02:33:39 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
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
Subject: Re: [PATCH] xen: introduce xen_vring_use_dma
Message-ID: <20200629023225-mutt-send-email-mst@kernel.org>
References: <20200624050355-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2006241047010.8121@sstabellini-ThinkPad-T480s>
 <20200624163940-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2006241351430.8121@sstabellini-ThinkPad-T480s>
 <20200624181026-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2006251014230.8121@sstabellini-ThinkPad-T480s>
 <20200626110629-mutt-send-email-mst@kernel.org>
 <DB6PR0402MB27601CA74B85DA5A9F5E5DD6886E0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
 <20200629022124-mutt-send-email-mst@kernel.org>
 <DB6PR0402MB27602AB2A9A242D79343CE48886E0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB6PR0402MB27602AB2A9A242D79343CE48886E0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 06:25:41AM +0000, Peng Fan wrote:
> > > > > Anyway, re-reading the last messages of the original thread [1],
> > > > > it looks like Peng had a clear idea on how to fix the general issue.
> > > > > Peng, what happened with that?
> > >
> > > We shrinked the rpmsg reserved area to workaround the issue.
> > > So still use the dma apis in rpmsg.
> > >
> > > But here I am going to address domu android trusty issue using virtio.
> > 
> > My suggestion is to first of all fix DMA API so it works properly.
> 
> Could you please elaborate more details?
> 
> You mean the DMA API usage of rpmsg? Or xen domu dma_ops?
> 
> Thanks,
> Peng. 

Not 100% sure but I think xen dma ops.

-- 
MST

