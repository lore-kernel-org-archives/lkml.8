Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCC8C433E4
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDD39204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M8rojZlM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgHFFy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 01:54:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39293 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726051AbgHFFyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 01:54:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596693264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mRThbniOH3H+nnbkiN1VpyYC3E+J3eqp2bqKy/0XWfw=;
        b=M8rojZlM7lqA8/xQfmmOUKN/buVBiM0ud8g4uGns9I6CY5F6gJZJFv/GINsZKwx87lCQZj
        mPFgIcFqLPyU3B5u+DbvDEpzQHfd7GN/mWyoWnxZFiwA1SPzz4tW/1JbZg8uta2z6ikI7J
        WS9dVOQsR+/sEUReVQ1J5B3bOjWhk6Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-7miEQa19OragyGqy-I5PEA-1; Thu, 06 Aug 2020 01:54:22 -0400
X-MC-Unique: 7miEQa19OragyGqy-I5PEA-1
Received: by mail-wr1-f70.google.com with SMTP id w7so11955170wre.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 22:54:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mRThbniOH3H+nnbkiN1VpyYC3E+J3eqp2bqKy/0XWfw=;
        b=LCCPbeL3Zp1iTifcoZ6LfSsNzI+FFR5BrA7W7w2cLAgXkBmFgR9mvT1xY8deSKpk9U
         VTmVJvtJOHNBCHs2CKhuHVWugbfkDKk3MsnBc25kjBGuKsJ1rqHUszoPvEoWm4PYDfrd
         lbLMQrkhYbaTHGWzBEcZHJ6xnBr+F0uyd3QLnj/Ns52z6u2+dnq7gI9FCfLtoyhzyxlR
         vI0eDqFaMjRmKMAySKAfYsM8XILssSjJ9OaXRojrjseGPJ9iOQploUSEmTtd9MUq5L/I
         GV/+oSHcpEsDodqD5iRwTmoBXCnFUmizf5pQVUZ/gfWd98rxRbTGeO19JcjOVx3ARrsQ
         7ArQ==
X-Gm-Message-State: AOAM533zg8QkE9GoLt4f22KZQQH9OmaEI8X+XvqiyGYT8Px6BxfcOcEl
        ZTUM5uVKg5iqrhK1PTQRj/H0VNUSBdbDcqJtkVZu/UFoevEvRtPTWYuG2cEvDE/Z2r/ACl/Y3AD
        MLu9hjSupp4L86RLLqIhZuuJ/
X-Received: by 2002:adf:8405:: with SMTP id 5mr5649916wrf.393.1596693261197;
        Wed, 05 Aug 2020 22:54:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMrWFVN7pqHpJZjnHy/aa/ngOxq7QmYPGN0WYucLhG9zbO1xWKLwEAt5Uz4zpDVEHC2CH3WA==
X-Received: by 2002:adf:8405:: with SMTP id 5mr5649901wrf.393.1596693261026;
        Wed, 05 Aug 2020 22:54:21 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net. [79.177.102.128])
        by smtp.gmail.com with ESMTPSA id z66sm5047641wme.16.2020.08.05.22.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 22:54:20 -0700 (PDT)
Date:   Thu, 6 Aug 2020 01:54:17 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, rob.miller@broadcom.com,
        lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com,
        shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com,
        gdawar@xilinx.com, saugatm@xilinx.com, vmireyno@marvell.com,
        zhangweining@ruijie.com.cn, eli@mellanox.com
Subject: Re: [PATCH 1/4] vdpa: introduce config op to get valid iova range
Message-ID: <20200806015336-mutt-send-email-mst@kernel.org>
References: <20200617032947.6371-1-jasowang@redhat.com>
 <20200617032947.6371-2-jasowang@redhat.com>
 <20200805085035-mutt-send-email-mst@kernel.org>
 <777d6e78-4271-10e9-4546-329f53962429@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <777d6e78-4271-10e9-4546-329f53962429@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 11:25:11AM +0800, Jason Wang wrote:
> 
> On 2020/8/5 下午8:51, Michael S. Tsirkin wrote:
> > On Wed, Jun 17, 2020 at 11:29:44AM +0800, Jason Wang wrote:
> > > This patch introduce a config op to get valid iova range from the vDPA
> > > device.
> > > 
> > > Signed-off-by: Jason Wang<jasowang@redhat.com>
> > > ---
> > >   include/linux/vdpa.h | 14 ++++++++++++++
> > >   1 file changed, 14 insertions(+)
> > > 
> > > diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> > > index 239db794357c..b7633ed2500c 100644
> > > --- a/include/linux/vdpa.h
> > > +++ b/include/linux/vdpa.h
> > > @@ -41,6 +41,16 @@ struct vdpa_device {
> > >   	unsigned int index;
> > >   };
> > > +/**
> > > + * vDPA IOVA range - the IOVA range support by the device
> > > + * @start: start of the IOVA range
> > > + * @end: end of the IOVA range
> > > + */
> > > +struct vdpa_iova_range {
> > > +	u64 start;
> > > +	u64 end;
> > > +};
> > > +
> > This is ambiguous. Is end in the range or just behind it?
> 
> 
> In the range.

OK I guess we can treat it as a bugfix and merge after rc1,
but pls add a bit more in the commit log about what's
currently broken.

> 
> > How about first/last?
> 
> 
> Sure.
> 
> Thanks
> 
> 
> > 
> > 
> > 

