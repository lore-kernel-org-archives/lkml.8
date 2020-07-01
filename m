Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28ACFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 21:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05CDA20853
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 21:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="crw6jiU7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgGAVXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 17:23:42 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31610 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726144AbgGAVXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 17:23:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593638620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m2r4biBmgD4usQWexXh9vBu72j/PA8sqQ6Ual1zjZVg=;
        b=crw6jiU7NhllWsejLks+KSy/+5heCSBlI+u1DNJL2cT6+NItN82GvS+jfs17iRKCIBbGAp
        WyPqN76wPTH65j/okO6O+/uOTgo3EYLtA56qxDTEbJJunIMBrN5a9rpcm5bdgnxjHWgovX
        NdXLwRk8svEcRy+4XpXZbIx0kcEUf48=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-4k_3co6SOTSedzKSiL7HHg-1; Wed, 01 Jul 2020 17:23:39 -0400
X-MC-Unique: 4k_3co6SOTSedzKSiL7HHg-1
Received: by mail-wr1-f72.google.com with SMTP id j16so17151262wrw.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 14:23:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m2r4biBmgD4usQWexXh9vBu72j/PA8sqQ6Ual1zjZVg=;
        b=jEzOYrgxJFjv8xZFfLHLVhMCnYsKWLQFyph9Q/BmKuTxKJQMHbiDRHdd0ic64gSj8w
         SCwKixUBot5g8LRK1TgAbst2ZPeSaWrk8H2AfacqjBpCkObc0WEKdtRnD6WH35YvvOEc
         6sERuzNZf7Ryva6OCi7zOrg7QLvb60x+fTnphXE4XSI4PVMJGRv0H8rxXcwQRsCrRGh9
         h7oCtEhSM1aQPE/LG3ZkTiyOg/2TCgz5YTwXZxf6quZIjhi6Rn2ry6Jcm/5MI6cn/l9z
         O7iMFONqSurvT/C0yoO75al/Gp65WYPJmaBn1rJvgsn6IAVjJXtJOBV3ovapk5Rh5jfZ
         nP4w==
X-Gm-Message-State: AOAM533pGMnLX5N8rGU9plSRsdwr8xYM0ZpxZmOIhYMrVTW6Mj8mcc/E
        iSiLAUDTqwS8POsR3Vu4YDCn/UnSc35TpuoCuSXvbNmJSY7TrvkotUd02VkB0l9wrQAcsnD8zai
        2gtsJptP4OSqfTYFAXNvTYkZQ
X-Received: by 2002:a5d:6b8c:: with SMTP id n12mr28640726wrx.352.1593638617972;
        Wed, 01 Jul 2020 14:23:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQ5EOdK3/I7t3hzH2nXxlZ8gKRo3bNG63qK7yosafmw6Hvgwi6pb2IZMrXml3ZBqz0x5VNnw==
X-Received: by 2002:a5d:6b8c:: with SMTP id n12mr28640715wrx.352.1593638617762;
        Wed, 01 Jul 2020 14:23:37 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
        by smtp.gmail.com with ESMTPSA id d63sm8905146wmc.22.2020.07.01.14.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 14:23:35 -0700 (PDT)
Date:   Wed, 1 Jul 2020 17:23:32 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, jgross@suse.com,
        Peng Fan <peng.fan@nxp.com>, x86@kernel.org,
        konrad.wilk@oracle.com, jasowang@redhat.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, linux-imx@nxp.com,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] xen: introduce xen_vring_use_dma
Message-ID: <20200701172219-mutt-send-email-mst@kernel.org>
References: <20200624050355-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2006241047010.8121@sstabellini-ThinkPad-T480s>
 <20200624163940-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2006241351430.8121@sstabellini-ThinkPad-T480s>
 <20200624181026-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2006251014230.8121@sstabellini-ThinkPad-T480s>
 <20200626110629-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2006291621300.8121@sstabellini-ThinkPad-T480s>
 <20200701133456.GA23888@infradead.org>
 <alpine.DEB.2.21.2007011020320.8121@sstabellini-ThinkPad-T480s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2007011020320.8121@sstabellini-ThinkPad-T480s>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 01, 2020 at 10:34:53AM -0700, Stefano Stabellini wrote:
> Would you be in favor of a more flexible check along the lines of the
> one proposed in the patch that started this thread:
> 
>     if (xen_vring_use_dma())
>             return true;
> 
> 
> xen_vring_use_dma would be implemented so that it returns true when
> xen_swiotlb is required and false otherwise.

Just to stress - with a patch like this virtio can *still* use DMA API
if PLATFORM_ACCESS is set. So if DMA API is broken on some platforms
as you seem to be saying, you guys should fix it before doing something
like this..

-- 
MST

