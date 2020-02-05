Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F2BC352A2
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 13:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA8B217BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 13:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CzvJwhwX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgBENO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 08:14:57 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28603 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727861AbgBENO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 08:14:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580908495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QuNXmwS8sysRc0ThXGMCmTTQlX8tFR45lSd0PUTiOGs=;
        b=CzvJwhwXrycMJnKvpCWji+0amMkonKqF/bG//ByPBF59iq3kYYjy0F5ebHXAZlYr9RG7eV
        U690ZpS/GYaOohPjq5mweRKtcUieVkAObnf7tfLLtFPX8+WuzzxwiJXnDcJI+VfOKD/8W1
        1zaCRT901L2/EwMsv8hm36qP5XUPMcA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-aLulppEHPVSN6rsb3IMFqg-1; Wed, 05 Feb 2020 08:14:54 -0500
X-MC-Unique: aLulppEHPVSN6rsb3IMFqg-1
Received: by mail-qk1-f197.google.com with SMTP id 12so1217964qkf.20
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 05:14:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QuNXmwS8sysRc0ThXGMCmTTQlX8tFR45lSd0PUTiOGs=;
        b=c7vk4iLDDaAkP0MqOaPAEIoMpfpLrUbK/xENTmyaKVnQXzWBAmibMGWZ/NMrCtDa0I
         LXiEHQXCTMtLOXtNvLuj3K1q5O/37XNXFkN+3SXrR+AOTtmjbrpMmxKoj3MXRfADMb3D
         oQvvyKXP4wczN24grUTodk3+knQKlYCsu+ADqcT50qYinGOj32lCkYAQs8neFQNQpDZ6
         i3hnqjpkLp7UJY2MBPS28dExP+lBcXdOL5EnAPf/6MEMS7HGhynsi1dWDtHoYo7mSAR0
         iFegIBd1CIi8RmdhtQuRvHt//X4ZaFUFPVWpruNWkkS5n6/1J5Pk4tgw7qGSW2GhaAwz
         jMmQ==
X-Gm-Message-State: APjAAAXCchWNdg2FWGERHAZMJoqpYTBoH85s944civAc5iHpyhDqiORN
        Oeu5K5zJsiXF7tFmEiPNSwGA72RgXj2s3X4BCshrVr6dgj6+wWp8QkpM9V1yRPLsBKvTahTx+eA
        uVcOjJnZcPrh0LUWJgDt9Fb3u
X-Received: by 2002:a37:6551:: with SMTP id z78mr34386876qkb.144.1580908493731;
        Wed, 05 Feb 2020 05:14:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqyPJbBNbk5endfccq+ku5moWMnpzgaXCLDqjaEgV35BhSBP12RgV6EFcH2z1a9H9HuZasXKOQ==
X-Received: by 2002:a37:6551:: with SMTP id z78mr34386840qkb.144.1580908493533;
        Wed, 05 Feb 2020 05:14:53 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
        by smtp.gmail.com with ESMTPSA id c45sm14187780qtd.43.2020.02.05.05.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 05:14:52 -0800 (PST)
Date:   Wed, 5 Feb 2020 08:14:46 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Shahaf Shuler <shahafs@mellanox.com>,
        Tiwei Bie <tiwei.bie@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "rob.miller@broadcom.com" <rob.miller@broadcom.com>,
        "haotian.wang@sifive.com" <haotian.wang@sifive.com>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        Parav Pandit <parav@mellanox.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "hch@infradead.org" <hch@infradead.org>,
        Jiri Pirko <jiri@mellanox.com>,
        "hanand@xilinx.com" <hanand@xilinx.com>,
        "mhabets@solarflare.com" <mhabets@solarflare.com>,
        "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>,
        "lingshan.zhu@intel.com" <lingshan.zhu@intel.com>,
        "dan.daly@intel.com" <dan.daly@intel.com>,
        "cunming.liang@intel.com" <cunming.liang@intel.com>,
        "zhihong.wang@intel.com" <zhihong.wang@intel.com>
Subject: Re: [PATCH] vhost: introduce vDPA based backend
Message-ID: <20200205081210-mutt-send-email-mst@kernel.org>
References: <20200131033651.103534-1-tiwei.bie@intel.com>
 <7aab2892-bb19-a06a-a6d3-9c28bc4c3400@redhat.com>
 <20200205020247.GA368700@___>
 <AM0PR0502MB37952015716C1D5E07E390B6C3020@AM0PR0502MB3795.eurprd05.prod.outlook.com>
 <112858a4-1a01-f4d7-e41a-1afaaa1cad45@redhat.com>
 <20200205125648.GV23346@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205125648.GV23346@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 08:56:48AM -0400, Jason Gunthorpe wrote:
> On Wed, Feb 05, 2020 at 03:50:14PM +0800, Jason Wang wrote:
> > > Would it be better for the map/umnap logic to happen inside each device ?
> > > Devices that needs the IOMMU will call iommu APIs from inside the driver callback.
> > 
> > Technically, this can work. But if it can be done by vhost-vpda it will make
> > the vDPA driver more compact and easier to be implemented.
> 
> Generally speaking, in the kernel, it is normal to not hoist code of
> out drivers into subsystems until 2-3 drivers are duplicating that
> code. It helps ensure the right design is used
> 
> Jason

That's up to the sybsystem maintainer really, as there's also some
intuition involved in guessing a specific API is widely useful.
In-kernel APIs are flexible, if we find something isn't needed we just
drop it.

-- 
MST

