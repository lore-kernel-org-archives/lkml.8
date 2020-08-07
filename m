Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A9AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 20:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A87372074D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 20:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgHGUFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 16:05:38 -0400
Received: from mga14.intel.com ([192.55.52.115]:16010 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbgHGUFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 16:05:38 -0400
IronPort-SDR: iaVY8ZioFqIRfmMdYAlGAAF4NJih1v8u1knjiI/dbOP3EpeJAs5IEDiPF6hWzZ+TmQg79sjBnT
 lFLet/7m9Rbw==
X-IronPort-AV: E=McAfee;i="6000,8403,9706"; a="152397697"
X-IronPort-AV: E=Sophos;i="5.75,446,1589266800"; 
   d="scan'208";a="152397697"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2020 13:05:38 -0700
IronPort-SDR: iN9afJV0a8iKNGDrKwlY/zfIRTfZOsKW1t/FEpub7fHuyHY/ALiRqNmEgG/cOqSeiy78Jgvoay
 show9POj62vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,446,1589266800"; 
   d="scan'208";a="275462904"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga007.fm.intel.com with ESMTP; 07 Aug 2020 13:05:38 -0700
Date:   Fri, 7 Aug 2020 13:05:38 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-nvdimm@lists.01.org
Subject: Re: [PATCH v3 33/38] virtio_pmem: convert to LE accessors
Message-ID: <20200807200537.GD2467625@iweiny-DESK2.sc.intel.com>
References: <20200805134226.1106164-1-mst@redhat.com>
 <20200805134226.1106164-34-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805134226.1106164-34-mst@redhat.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 09:44:45AM -0400, Michael S. Tsirkin wrote:
> Virtio pmem is modern-only. Use LE accessors for config space.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/nvdimm/virtio_pmem.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
> index 5e3d07b47e0c..726c7354d465 100644
> --- a/drivers/nvdimm/virtio_pmem.c
> +++ b/drivers/nvdimm/virtio_pmem.c
> @@ -58,9 +58,9 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
>  		goto out_err;
>  	}
>  
> -	virtio_cread(vpmem->vdev, struct virtio_pmem_config,
> +	virtio_cread_le(vpmem->vdev, struct virtio_pmem_config,
>  			start, &vpmem->start);
> -	virtio_cread(vpmem->vdev, struct virtio_pmem_config,
> +	virtio_cread_le(vpmem->vdev, struct virtio_pmem_config,
>  			size, &vpmem->size);

FWIW I think squashing patch 15/38 and this patch would have made more sense.

Acked-by: Ira Weiny <ira.weiny@intel.com>

>  
>  	res.start = vpmem->start;
> -- 
> MST
> 
