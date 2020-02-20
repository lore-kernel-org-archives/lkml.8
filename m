Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B414C34031
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 04:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FEFB208C4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 04:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ht7LhAiC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgBTEH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 23:07:58 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38774 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbgBTEH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 23:07:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=DsnBWKGRXR7v7coTpch/Jgp1pyAIAbHmN/qbKeL3Rbc=; b=ht7LhAiC4AlCXwZ5USJKlotrOk
        Zz4mLDzQbSRUL1p6q1pxOQcG25GDfuGvOpseX5AfPYpqd0+A2revWqc/JkMYpWgzgNSvMx3iM0QvP
        qJqLYoKc2deClfTN4oRWTPVT3NfmapvMmz1EwrDZ07ItfEMOWpmkGYHf4lCJQ0yZtxLKITzbpKpnh
        CRwjXjBS472Lc22wAzxOjrd8fEJGezTg7/bF+l6HMzvKjJ1lBtKl87P/Ra362aA9LWylPXy/Mr99P
        TbLIzvWib8FEflj8CVj8taei3+nAVTPYNP1KsSNNwgvCVJY8OjZESjx32rHhgEX06g8EpQaDGLq9E
        O7MR1XfA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4d7w-0001gm-5V; Thu, 20 Feb 2020 04:07:52 +0000
Subject: Re: [PATCH V3 4/5] virtio: introduce a vDPA based transport
To:     Jason Wang <jasowang@redhat.com>, mst@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Cc:     tiwei.bie@intel.com, jgg@mellanox.com, maxime.coquelin@redhat.com,
        cunming.liang@intel.com, zhihong.wang@intel.com,
        rob.miller@broadcom.com, xiao.w.wang@intel.com,
        haotian.wang@sifive.com, lingshan.zhu@intel.com,
        eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com,
        kevin.tian@intel.com, stefanha@redhat.com, hch@infradead.org,
        aadam@redhat.com, jiri@mellanox.com, shahafs@mellanox.com,
        hanand@xilinx.com, mhabets@solarflare.com
References: <20200220035650.7986-1-jasowang@redhat.com>
 <20200220035650.7986-5-jasowang@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2c5a3a84-be56-3003-8d71-d46645664bab@infradead.org>
Date:   Wed, 19 Feb 2020 20:07:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200220035650.7986-5-jasowang@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/19/20 7:56 PM, Jason Wang wrote:
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index 9c4fdb64d9ac..0df3676b0f4f 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -43,6 +43,19 @@ config VIRTIO_PCI_LEGACY
>  
>  	  If unsure, say Y.
>  
> +config VIRTIO_VDPA
> +	tristate "vDPA driver for virtio devices"
> +        select VDPA
> +        select VIRTIO
> +	help
> +	  This driver provides support for virtio based paravirtual
> +	  device driver over vDPA bus. For this to be useful, you need
> +	  an appropriate vDPA device implementation that operates on a
> +          physical device to allow the datapath of virtio to be
> +	  offloaded to hardware.
> +
> +	  If unsure, say M.
> +

Please use tabs consistently for indentation, not spaces,
except in the Kconfig help text, which should be 1 tab + 2 spaces.

>  config VIRTIO_PMEM
>  	tristate "Support for virtio pmem driver"
>  	depends on VIRTIO


-- 
~Randy

