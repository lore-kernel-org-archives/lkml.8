Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBB9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 02:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26447206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 02:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H3h6yR1/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbgHKCzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 22:55:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32126 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728143AbgHKCzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 22:55:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597114513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GKhj1Ydo5cuP4e/A9fInsizZom2NntrocIU8lcoSOLg=;
        b=H3h6yR1/N0SVkdC3ut/OmN8hu/BJicAsQXM01YC3AUL/t0SVSuDMiZg9l6XPZQc2QqNPQb
        mYttuKhQUYOKBCQsg+GAruyT4+2qoVJ4OWTgIqahp5VVJxuHhrd7Wi32dJ1OjvDwjGVW0H
        ACPnCOu6C+1JqbyFTlzxKuR3+ch/LhM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-kzFg17BzO9CvIh7vxFZT_g-1; Mon, 10 Aug 2020 22:55:11 -0400
X-MC-Unique: kzFg17BzO9CvIh7vxFZT_g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 721A18005B0;
        Tue, 11 Aug 2020 02:55:10 +0000 (UTC)
Received: from [10.72.13.186] (ovpn-13-186.pek2.redhat.com [10.72.13.186])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3F6B26F130;
        Tue, 11 Aug 2020 02:55:04 +0000 (UTC)
Subject: Re: [PATCH] vdpa_sim: init iommu lock
To:     "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        virtualization@lists.linux-foundation.org, lkp@lists.01.org
References: <20200810124813.1555677-1-mst@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <e96ec466-0852-ffc8-0e26-118cc4118707@redhat.com>
Date:   Tue, 11 Aug 2020 10:55:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200810124813.1555677-1-mst@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/8/10 下午8:48, Michael S. Tsirkin wrote:
> The patch adding the iommu lock did not initialize it.
> The struct is zero-initialized so this is mostly a problem
> when using lockdep.
>
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Cc: Max Gurtovoy <maxg@mellanox.com>
> Fixes: 0ea9ee430e74 ("vdpasim: protect concurrent access to iommu iotlb")
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   drivers/vdpa/vdpa_sim/vdpa_sim.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index df3224b138ee..604d9d25ca47 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -358,6 +358,7 @@ static struct vdpasim *vdpasim_create(void)
>   
>   	INIT_WORK(&vdpasim->work, vdpasim_work);
>   	spin_lock_init(&vdpasim->lock);
> +	spin_lock_init(&vdpasim->iommu_lock);
>   
>   	dev = &vdpasim->vdpa.dev;
>   	dev->coherent_dma_mask = DMA_BIT_MASK(64);

