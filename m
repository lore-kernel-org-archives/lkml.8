Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC80DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 08:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA0B320658
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 08:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZBztK0BH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbgHKIaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 04:30:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21473 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728390AbgHKIaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 04:30:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597134606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kDxbTcL/Td6HbF1c9Y9dgTsZrWCIPjjlXYbn9U5Rp80=;
        b=ZBztK0BH61MCAIthbQWdE1tQ+4m+B/lSdH6gkPzhiMEg1+sqWPsL23jXu0S0H0VyWM3f+V
        CzgecgGi3K0LdKgiGzQQf/25a/3rSEgrAgOY3a1R1Oc+2CIkeLhixPLNelnkaQ/nECJ5ca
        4CvRC9mCuMpUP6B8rHiy8yd6ZR1g8HY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-Pfbpeqr4M5O8qJ6Rp76VHg-1; Tue, 11 Aug 2020 04:30:02 -0400
X-MC-Unique: Pfbpeqr4M5O8qJ6Rp76VHg-1
Received: by mail-wm1-f71.google.com with SMTP id p23so717503wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 01:30:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kDxbTcL/Td6HbF1c9Y9dgTsZrWCIPjjlXYbn9U5Rp80=;
        b=VAtEDB+9nuSqiohwhzjXFqzjUPG6ON8GA1k75pEBGGM8JGunj12gsVL1dQQkOIGm4H
         ydpO0BaFqRh0U2tGpQTwoe8avmYBzMfYXU1i0N3GcDhAZKfbGq8m9Wqq0qTRgV9g+eKN
         n1ei1lMAsOpwG8ZwakTie2IM1Zm0ARa3MbxZqEfzuFkVd1ilm4nEeFDfuUoI2ZUV26TN
         GiewIydarvaDtIk3YwrgR/Uga9DxBLowAwrzL0CT3tLeEoNg1TmuX1NOfF5/ExcWqcUS
         xhZFxEC020qjSsHFENZST/EdPcOYrapWUa19lUuHmW72/u/aJgk6mUj1YFEvEbRzKkVU
         k+Cw==
X-Gm-Message-State: AOAM533vsDaI87j9p+Z/InvCx1KhgFWZ2dK02fldNHTPrE7SI2c9aZbc
        0Ks73c1IrYt+v2hgvKEg3ZxtudEOEyUXHhNvWY2WPae1tFnRlZbMUefzl6GnnSQb6dbn3eeEMB3
        u9JREBg4rouuNWpWhntFZwB8B
X-Received: by 2002:adf:ed0c:: with SMTP id a12mr27814930wro.24.1597134600930;
        Tue, 11 Aug 2020 01:30:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyjtEM1zq0msQDxGpjz9K/i33tZLCi9C7abT7E7t+vxf8KBB5p0LMjNivEK3rGdoE02KY+6Hg==
X-Received: by 2002:adf:ed0c:: with SMTP id a12mr27814913wro.24.1597134600692;
        Tue, 11 Aug 2020 01:30:00 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
        by smtp.gmail.com with ESMTPSA id g14sm3815918wmk.37.2020.08.11.01.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 01:29:59 -0700 (PDT)
Date:   Tue, 11 Aug 2020 04:29:56 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Eli Cohen <eli@mellanox.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, rob.miller@broadcom.com,
        lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com,
        shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com,
        gdawar@xilinx.com, saugatm@xilinx.com, vmireyno@marvell.com,
        zhangweining@ruijie.com.cn
Subject: Re: [PATCH 1/4] vdpa: introduce config op to get valid iova range
Message-ID: <20200811042733-mutt-send-email-mst@kernel.org>
References: <20200617032947.6371-1-jasowang@redhat.com>
 <20200617032947.6371-2-jasowang@redhat.com>
 <20200805085035-mutt-send-email-mst@kernel.org>
 <20200806120354.GA171218@mtl-vdi-166.wap.labs.mlnx>
 <20200806082727-mutt-send-email-mst@kernel.org>
 <20200806124354.GA172661@mtl-vdi-166.wap.labs.mlnx>
 <20200810080410-mutt-send-email-mst@kernel.org>
 <2d1e6278-e57e-c340-399e-40ff102c74a3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2d1e6278-e57e-c340-399e-40ff102c74a3@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 10:53:09AM +0800, Jason Wang wrote:
> 
> On 2020/8/10 下午8:05, Michael S. Tsirkin wrote:
> > On Thu, Aug 06, 2020 at 03:43:54PM +0300, Eli Cohen wrote:
> > > On Thu, Aug 06, 2020 at 08:29:22AM -0400, Michael S. Tsirkin wrote:
> > > > On Thu, Aug 06, 2020 at 03:03:55PM +0300, Eli Cohen wrote:
> > > > > On Wed, Aug 05, 2020 at 08:51:56AM -0400, Michael S. Tsirkin wrote:
> > > > > > On Wed, Jun 17, 2020 at 11:29:44AM +0800, Jason Wang wrote:
> > > > > > > This patch introduce a config op to get valid iova range from the vDPA
> > > > > > > device.
> > > > > > > 
> > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > > ---
> > > > > > >   include/linux/vdpa.h | 14 ++++++++++++++
> > > > > > >   1 file changed, 14 insertions(+)
> > > > > > > 
> > > > > > > diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> > > > > > > index 239db794357c..b7633ed2500c 100644
> > > > > > > --- a/include/linux/vdpa.h
> > > > > > > +++ b/include/linux/vdpa.h
> > > > > > > @@ -41,6 +41,16 @@ struct vdpa_device {
> > > > > > >   	unsigned int index;
> > > > > > >   };
> > > > > > > +/**
> > > > > > > + * vDPA IOVA range - the IOVA range support by the device
> > > > > > > + * @start: start of the IOVA range
> > > > > > > + * @end: end of the IOVA range
> > > > > > > + */
> > > > > > > +struct vdpa_iova_range {
> > > > > > > +	u64 start;
> > > > > > > +	u64 end;
> > > > > > > +};
> > > > > > > +
> > > > > > 
> > > > > > This is ambiguous. Is end in the range or just behind it?
> > > > > > How about first/last?
> > > > > It is customary in the kernel to use start-end where end corresponds to
> > > > > the byte following the last in the range. See struct vm_area_struct
> > > > > vm_start and vm_end fields
> > > > Exactly my point:
> > > > 
> > > > include/linux/mm_types.h:       unsigned long vm_end;           /* The first byte after our end address
> > > > 
> > > > in this case Jason wants it to be the last byte, not one behind.
> > > > 
> > > > 
> > > Maybe start, size? Not ambiguous, and you don't need to do annoying
> > > calculations like size = last - start + 1
> > Size has a bunch of issues: can overlap, can not cover the entire 64 bit
> > range. The requisite checks are arguably easier to get wrong than
> > getting the size if you need it.
> 
> 
> Yes, so do you still prefer first/last or just begin/end which is consistent
> with iommu_domain_geometry?
> 
> Thanks

I prefer first/last I think, these are unambiguous.
E.g.

        dma_addr_t aperture_start; /* First address that can be mapped    */
        dma_addr_t aperture_end;   /* Last address that can be mapped     */

instead of addressing ambiguity with a comment, let's just name the field well.



> 
> > 

