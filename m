Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8F1C33CB6
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 05:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5F9424125
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 05:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hpSMJeHp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbgAUFra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 00:47:30 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53497 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727829AbgAUFr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 00:47:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579585648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mRIHR//6+tMI2y6i3aA+ZdSwTH32dw9nU4PtvoJMAts=;
        b=hpSMJeHpJplNoQRwgJF9wxj1ZInOwkWrf8Dyv0pFeM96h5QIJNtRblrUCPHlObwxoivQ1L
        opqaUJ2FtidtyNnzs4GtFqhgR93bku3ZH5AgXOoPqa6dnoeamyZ6JxPBGVSbBpdV2435F4
        5iCFFm7AdhHLThoeEpcS2LvMSkxqR2I=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-c8_gJOG6OyG9tAhk-LwQww-1; Tue, 21 Jan 2020 00:47:26 -0500
X-MC-Unique: c8_gJOG6OyG9tAhk-LwQww-1
Received: by mail-qv1-f70.google.com with SMTP id g15so916719qvq.20
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 21:47:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mRIHR//6+tMI2y6i3aA+ZdSwTH32dw9nU4PtvoJMAts=;
        b=bJZIXzZVc8EJeoCG4J0/K7jo/nVNa5ChLLOxsHgGDJ4ie3jprc2BcoC2yugmNL41Mq
         eNrdmo3r2mJudM6Ap0JT/ZLJDSfQuxWGlJujpA1zHID6MvsMRB+9JHKIonlfMGqbQ1oH
         ArXzHoCv60NvLUpmnwgx5hbHIhyy3R6xgiTtWxLAeWO+Txi/nnARNW6TUf8aa3dvpurK
         Rv3m7rrae9STvlx0yGCiKF8z4HoGCsLvKzcprdoCFHlxjwYMpCKIA1AZQlx7MVy9HkXa
         2pvXzGz3A3riwTmLPKxzLJDJCYYIfx68ZaB19cIsThUX7X3B8MS/5PXqcy3eEaUgNmmP
         0pww==
X-Gm-Message-State: APjAAAVIDJP24xAZYCi4P7LNPU2ZL+IABaiX5RPuYzyGPhKgSxzLK9Cs
        zguJ7R+24PXAgJb1g9k2g1Cl3s2+C4Dv5yXhUFGzv2WjFAaOQC2ZUJM4z10SNFYJeiSiSUvRNJG
        LBXE4eiQMqAobrwUJIn86zR2x
X-Received: by 2002:a37:a3c7:: with SMTP id m190mr3086746qke.212.1579585646172;
        Mon, 20 Jan 2020 21:47:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqwfdKT9tkT26VsOESb0T418l/eNKuGfLtPJgnWBbUAbKn1jVX+EvvcLfJEE9PfxETYES/rukQ==
X-Received: by 2002:a37:a3c7:: with SMTP id m190mr3086726qke.212.1579585645935;
        Mon, 20 Jan 2020 21:47:25 -0800 (PST)
Received: from redhat.com (bzq-79-179-85-180.red.bezeqint.net. [79.179.85.180])
        by smtp.gmail.com with ESMTPSA id x3sm18835929qts.35.2020.01.20.21.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 21:47:24 -0800 (PST)
Date:   Tue, 21 Jan 2020 00:47:15 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Shahaf Shuler <shahafs@mellanox.com>,
        Rob Miller <rob.miller@broadcom.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Netdev <netdev@vger.kernel.org>,
        "Bie, Tiwei" <tiwei.bie@intel.com>,
        "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>,
        "Liang, Cunming" <cunming.liang@intel.com>,
        "Wang, Zhihong" <zhihong.wang@intel.com>,
        "Wang, Xiao W" <xiao.w.wang@intel.com>,
        "haotian.wang@sifive.com" <haotian.wang@sifive.com>,
        "Zhu, Lingshan" <lingshan.zhu@intel.com>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        Parav Pandit <parav@mellanox.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "stefanha@redhat.com" <stefanha@redhat.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "hch@infradead.org" <hch@infradead.org>,
        Ariel Adam <aadam@redhat.com>,
        "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>,
        Jiri Pirko <jiri@mellanox.com>,
        "hanand@xilinx.com" <hanand@xilinx.com>,
        "mhabets@solarflare.com" <mhabets@solarflare.com>
Subject: Re: [PATCH 3/5] vDPA: introduce vDPA bus
Message-ID: <20200121004047-mutt-send-email-mst@kernel.org>
References: <20200116124231.20253-1-jasowang@redhat.com>
 <20200116124231.20253-4-jasowang@redhat.com>
 <20200117070324-mutt-send-email-mst@kernel.org>
 <239b042c-2d9e-0eec-a1ef-b03b7e2c5419@redhat.com>
 <CAJPjb1+fG9L3=iKbV4Vn13VwaeDZZdcfBPvarogF_Nzhk+FnKg@mail.gmail.com>
 <AM0PR0502MB379553984D0D55FDE25426F6C3330@AM0PR0502MB3795.eurprd05.prod.outlook.com>
 <d69918ca-8af4-44b2-9652-633530d4c113@redhat.com>
 <20200120174933.GB3891@mellanox.com>
 <2a324cec-2863-58f4-c58a-2414ee32c930@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a324cec-2863-58f4-c58a-2414ee32c930@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 12:00:57PM +0800, Jason Wang wrote:
> 
> On 2020/1/21 上午1:49, Jason Gunthorpe wrote:
> > On Mon, Jan 20, 2020 at 04:43:53PM +0800, Jason Wang wrote:
> > > This is similar to the design of platform IOMMU part of vhost-vdpa. We
> > > decide to send diffs to platform IOMMU there. If it's ok to do that in
> > > driver, we can replace set_map with incremental API like map()/unmap().
> > > 
> > > Then driver need to maintain rbtree itself.
> > I think we really need to see two modes, one where there is a fixed
> > translation without dynamic vIOMMU driven changes and one that
> > supports vIOMMU.
> 
> 
> I think in this case, you meant the method proposed by Shahaf that sends
> diffs of "fixed translation" to device?
> 
> It would be kind of tricky to deal with the following case for example:
> 
> old map [4G, 16G) new map [4G, 8G)
> 
> If we do
> 
> 1) flush [4G, 16G)
> 2) add [4G, 8G)
> 
> There could be a window between 1) and 2).
> 
> It requires the IOMMU that can do
> 
> 1) remove [8G, 16G)
> 2) flush [8G, 16G)
> 3) change [4G, 8G)
> 
> ....

Basically what I had in mind is something like qemu memory api

0. begin
1. remove [8G, 16G)
2. add [4G, 8G)
3. commit

Anyway, I'm fine with a one-shot API for now, we can
improve it later.

> > 
> > There are different optimization goals in the drivers for these two
> > configurations.
> > 
> > > > If the first one, then I think memory hotplug is a heavy flow
> > > > regardless. Do you think the extra cycles for the tree traverse
> > > > will be visible in any way?
> > > I think if the driver can pause the DMA during the time for setting up new
> > > mapping, it should be fine.
> > This is very tricky for any driver if the mapping change hits the
> > virtio rings. :(
> > 
> > Even a IOMMU using driver is going to have problems with that..
> > 
> > Jason
> 
> 
> Or I wonder whether ATS/PRI can help here. E.g during I/O page fault,
> driver/device can wait for the new mapping to be set and then replay the
> DMA.
> 
> Thanks
> 


-- 
MST

