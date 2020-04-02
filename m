Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D78C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 09:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7C72206D3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 09:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ozs9wvGW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387574AbgDBJY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 05:24:28 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53811 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgDBJY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 05:24:28 -0400
Received: by mail-wm1-f67.google.com with SMTP id d77so2604307wmd.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 02:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QBLTad+iICgypznQbxOsc5K7y6BcjDBR3loOYsj8SjI=;
        b=Ozs9wvGWhInw+jHbV+TIbhn0mHoMFHCEFO25FeTvEMCTPyY7OHacXfEcXTiNoiBAeQ
         1VC8fPDraFaL2tn2VMqFbzjR1t79IdHS47FEvt89UccYOkek8UikchvvcScI+YAjAs3/
         TE8T3z8N4aqHw3WD5KZR9MWiTu/hQbk1lodhGs9xJG5gBFJa61Vrvi0K7VDctd344t/N
         /jNl1HvBSa9zNSpEP8Trto2aUS9cIST5YLl/mwd5+LO0lomPjvAW9JdePTMIqtmHn82N
         lN9l20L2TlPcVG4dnFhtolx0+Ct2YljEiGF98iw/XLHqCdoCP7NhtERc1Kweco00bYgX
         /fiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QBLTad+iICgypznQbxOsc5K7y6BcjDBR3loOYsj8SjI=;
        b=mwMHAS7Ki9ALRn8DqiR1Y3+hAznHGp+zP9KeDB3nZggNVWSCA1+saJM3tEZ0ydvcXR
         rtdeDoO0LGuwKMX9TFtWew4IK3iBUlxaXxlS+rDXC+9PIQHnOwyBu2Eo+UjJyx3fSWu6
         GgtshsmSfiE03ywV9+BtfxWWehTnwAqIL4UTp6AdkKMnoZX0Y5qumKJ+r3YindBNLa7P
         RRp9/Ph1Asz7VP6NDo2jR5VCZNT95MqMKw2eb7Tz/X/nTeBrNA6Maht1uQ2keckhQPlN
         lVFNNf0qILVAelIAaWxOQd0WVICMWJq4F01xEzuOzBw2rGOh4DHEN7GH0GZX9z2z92nA
         OMSQ==
X-Gm-Message-State: AGi0PuZa7OfRxdC7d1IskGZx0jC5kDxgx4yXeI7m3dwi5PjiNMVS98bj
        ye2aEQMm18tczi3n7iyezYQK0w==
X-Google-Smtp-Source: APiQypI7yks1BQgHkRfqDIDPyzmNDQl3OkV9mh18UeW9nruJ9Kr3U7S557vz+0veoQwZ4Jzint1MtA==
X-Received: by 2002:a7b:cde8:: with SMTP id p8mr2493598wmj.87.1585819466713;
        Thu, 02 Apr 2020 02:24:26 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:6097:1406:6470:33b5])
        by smtp.gmail.com with ESMTPSA id f13sm6396383wrx.56.2020.04.02.02.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 02:24:26 -0700 (PDT)
Date:   Thu, 2 Apr 2020 11:24:17 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Bharat Bhushan <bbhushan2@marvell.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>
Subject: Re: [EXT] Re: [RFC PATCH v2] iommu/virtio: Use page size bitmap
 supported by endpoint
Message-ID: <20200402092417.GA1176452@myrica>
References: <20200401113804.21616-1-bbhushan2@marvell.com>
 <b75beb74-89ce-fd6a-6207-3c0d7f479215@arm.com>
 <20200401154932.GA1124215@myrica>
 <MWHPR1801MB19667BA1D59590BC3DFD87C7E3C60@MWHPR1801MB1966.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR1801MB19667BA1D59590BC3DFD87C7E3C60@MWHPR1801MB1966.namprd18.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 03:53:40AM +0000, Bharat Bhushan wrote:
> > > > +struct virtio_iommu_probe_pgsize_mask {
> > > > +	struct virtio_iommu_probe_property	head;
> > > > +	__u8					reserved[4];
> > > > +	__u64					pgsize_bitmap;
> > 
> > Should be __le64
> 
> Based on" iommu/virtio: Fix sparse warning" patch https://www.spinics.net/lists/linux-virtualization/msg41944.html changed to __u64 (not __le64)

Yes that one was only for the virtio config struct, to play nice with
other devices. We should still use __le for the other structures,
including probe properties.

Thanks,
Jean

> 
> Will keep __le64.
> 
> Thanks
> -Bharat
> 
> > 
> > Thanks,
> > Jean
> > 
> > > > +};
> > > > +
> > > >   #define VIRTIO_IOMMU_RESV_MEM_T_RESERVED	0
> > > >   #define VIRTIO_IOMMU_RESV_MEM_T_MSI		1
> > > >
