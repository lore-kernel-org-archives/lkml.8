Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7201C35249
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 06:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D6C620659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 06:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YgkvhRC6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgBEGan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 01:30:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32228 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725468AbgBEGam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 01:30:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580884241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SK/6EZm6JjjZrHYe/o5W90LoH1mAJQFt67RmR4CQh0M=;
        b=YgkvhRC6oEL83OP1ymGPPJJYiDFnwqsRhnOqo6LV6h3nEX9VZU9anBYQ21hs7Z5J20uNUo
        SZkb5eDb9rwubWni2fiPnCTX/RV+OcncXVRiQM2oD1RClkX3Lh0WSI/9zxSuVou9yIT6+R
        71AwJ2Jy8XqBF7f3VnpPDgJV6RPSpvI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-Bv_k2MFZPtCOm_k4WpS0wA-1; Wed, 05 Feb 2020 01:30:40 -0500
X-MC-Unique: Bv_k2MFZPtCOm_k4WpS0wA-1
Received: by mail-qt1-f199.google.com with SMTP id n4so707974qtv.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 22:30:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=SK/6EZm6JjjZrHYe/o5W90LoH1mAJQFt67RmR4CQh0M=;
        b=nS71eW45cgzi2Xa5cQ4pjRNFBYD0zNK/ClKEcRB7egbYlZUu9/NLEjkttR28csh/2T
         cT6IeIMwyjjEU6lfsxf3Dr9JyjVNcnfOxFYewW7rDXGzVbmwM3Clbki+o3UMpRyh6EIC
         QeLeovlplVAbpxwneoDLVCTaIL1mSHgvNiflp8vbUDa2Ef8XtgqeQkeCzONrV6qo8HXi
         SJsnhD8i2jH3Vkr354Nsyv8YdN7Y/CxwG47w/1a6bwCMG9FqJMtfM/TIFJtRyiMOL1/Z
         jEfSL+ag3QVqXIvL4/ISFh2fGFTCJ6uCsKDf1ZCeF1EosBP4vX4Kw7RlExu0l+UC+NFv
         C7/w==
X-Gm-Message-State: APjAAAVSrYINawDKq6c2PmYO2NiKRktkdDQYYOA6fKAEe/+Sg+g6uspy
        6+RInB85bceiUVvsfFDUKYZM8D5tePMZuZ/Yo/Jha5hoRSpeZAj79VI+UbuYg/oHG7f08VdLFuF
        rvZ/60BvH4tmLPp/Nur54q6rM
X-Received: by 2002:a05:6214:11a8:: with SMTP id u8mr30684186qvv.16.1580884239902;
        Tue, 04 Feb 2020 22:30:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqwkD0A2RyJgsZhuekPIPi4xkOg0VrIIr3OXInSUl8ooLyFt/kzVDntwDVhZLhJKb38ZnUEwpg==
X-Received: by 2002:a05:6214:11a8:: with SMTP id u8mr30684150qvv.16.1580884239611;
        Tue, 04 Feb 2020 22:30:39 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
        by smtp.gmail.com with ESMTPSA id a36sm13471539qtk.29.2020.02.04.22.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 22:30:38 -0800 (PST)
Date:   Wed, 5 Feb 2020 01:30:32 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Tiwei Bie <tiwei.bie@intel.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, shahafs@mellanox.com, jgg@mellanox.com,
        rob.miller@broadcom.com, haotian.wang@sifive.com,
        eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com,
        rdunlap@infradead.org, hch@infradead.org, jiri@mellanox.com,
        hanand@xilinx.com, mhabets@solarflare.com,
        maxime.coquelin@redhat.com, lingshan.zhu@intel.com,
        dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
Subject: Re: [PATCH] vhost: introduce vDPA based backend
Message-ID: <20200205011935-mutt-send-email-mst@kernel.org>
References: <20200131033651.103534-1-tiwei.bie@intel.com>
 <7aab2892-bb19-a06a-a6d3-9c28bc4c3400@redhat.com>
 <20200204005306-mutt-send-email-mst@kernel.org>
 <cf485e7f-46e3-20d3-8452-e3058b885d0a@redhat.com>
 <20200205020555.GA369236@___>
 <798e5644-ca28-ee46-c953-688af9bccd3b@redhat.com>
 <20200205003048-mutt-send-email-mst@kernel.org>
 <eb53d1c2-92ae-febf-f502-2d3e107ee608@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb53d1c2-92ae-febf-f502-2d3e107ee608@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 01:50:28PM +0800, Jason Wang wrote:
> 
> On 2020/2/5 下午1:31, Michael S. Tsirkin wrote:
> > On Wed, Feb 05, 2020 at 11:12:21AM +0800, Jason Wang wrote:
> > > On 2020/2/5 上午10:05, Tiwei Bie wrote:
> > > > On Tue, Feb 04, 2020 at 02:46:16PM +0800, Jason Wang wrote:
> > > > > On 2020/2/4 下午2:01, Michael S. Tsirkin wrote:
> > > > > > On Tue, Feb 04, 2020 at 11:30:11AM +0800, Jason Wang wrote:
> > > > > > > 5) generate diffs of memory table and using IOMMU API to setup the dma
> > > > > > > mapping in this method
> > > > > > Frankly I think that's a bunch of work. Why not a MAP/UNMAP interface?
> > > > > > 
> > > > > Sure, so that basically VHOST_IOTLB_UPDATE/INVALIDATE I think?
> > > > Do you mean we let userspace to only use VHOST_IOTLB_UPDATE/INVALIDATE
> > > > to do the DMA mapping in vhost-vdpa case? When vIOMMU isn't available,
> > > > userspace will set msg->iova to GPA, otherwise userspace will set
> > > > msg->iova to GIOVA, and vhost-vdpa module will get HPA from msg->uaddr?
> > > > 
> > > > Thanks,
> > > > Tiwei
> > > I think so. Michael, do you think this makes sense?
> > > 
> > > Thanks
> > to make sure, could you post the suggested argument format for
> > these ioctls?
> > 
> 
> It's the existed uapi:
> 
> /* no alignment requirement */
> struct vhost_iotlb_msg {
>     __u64 iova;
>     __u64 size;
>     __u64 uaddr;
> #define VHOST_ACCESS_RO      0x1
> #define VHOST_ACCESS_WO      0x2
> #define VHOST_ACCESS_RW      0x3
>     __u8 perm;
> #define VHOST_IOTLB_MISS           1
> #define VHOST_IOTLB_UPDATE         2
> #define VHOST_IOTLB_INVALIDATE     3
> #define VHOST_IOTLB_ACCESS_FAIL    4
>     __u8 type;
> };
> 
> #define VHOST_IOTLB_MSG 0x1
> #define VHOST_IOTLB_MSG_V2 0x2
> 
> struct vhost_msg {
>     int type;
>     union {
>         struct vhost_iotlb_msg iotlb;
>         __u8 padding[64];
>     };
> };
> 
> struct vhost_msg_v2 {
>     __u32 type;
>     __u32 reserved;
>     union {
>         struct vhost_iotlb_msg iotlb;
>         __u8 padding[64];
>     };
> };

Oh ok.  So with a real device, I suspect we do not want to wait for each
change to be processed by device completely, so we might want an asynchronous variant
and then some kind of flush that tells device "you better apply these now".

-- 
MST

