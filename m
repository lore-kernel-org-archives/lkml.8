Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D87AC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 20:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CACC206C3
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 20:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TTKz/T7l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbgFFUIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 16:08:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26303 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728197AbgFFUIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 16:08:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591474117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I3vo96oJCGr914y5mhSidy9wAMihpQEenpV5SRACxSM=;
        b=TTKz/T7lBfUePoU5LZuRuJKWAlM4FAVL32Jgo4zPks5qrbjhx28jJHBI+101/buP9HR6x7
        yZDWk04LCfIWr7yMtnukWIHA3Q5Fc5/U+pnFXoXDM2BoXpwApRRyIhBKwt5TFjSutrNC2F
        OFBxIoQW087iBJw4maeHZ2zu+2qdttE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-O3qac5IBNF--c_92brJSTA-1; Sat, 06 Jun 2020 16:08:31 -0400
X-MC-Unique: O3qac5IBNF--c_92brJSTA-1
Received: by mail-wr1-f69.google.com with SMTP id s7so5358989wrm.16
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jun 2020 13:08:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=I3vo96oJCGr914y5mhSidy9wAMihpQEenpV5SRACxSM=;
        b=iPqwgf1EGXoY91RnUNvs8qkNOoM2QqCMORHgiu7y7G6/1BPqL6s6vX9IkjeD6thwYK
         /9kZlhL+8RUW+6LERpTbFSrmfsa+HtZX9cCzekkbTTpwwjNmSaSwCpovWhUNbQ9Oa/SP
         v2NLUZ+k4el/FNNIfT7d89aVQbkNx015RANDE0JVmgGsl1wr+iR+G9GHzClFeHPyjLNl
         x+HzZ7F3TxfvOcmtjqd+07bOqvS2/YEFfQ+pAkcLV50do0tG+KVwZEHP4PUUzUhHm0L5
         unhmEvAQRrBSTq8CWWZG1QcfIqjgY1qFRADZsPJoLrt22oEVA05Eg1YbH8wAqgXYHpEH
         c7OQ==
X-Gm-Message-State: AOAM532GpHk/KJlNZ4bBhtUmL+Ik67eCfBWouywNzZ848csg3SybSp5m
        EI4ygeCFppmxEr04GblETnmECw1ePYTOZrEf+RjCaTY9sFk3pv38gwN0GIG3n6ueS0T6CCFrRVP
        UwKt0GmF0AIxwyQfvoTLSdiKb
X-Received: by 2002:adf:ef50:: with SMTP id c16mr15276932wrp.161.1591474110521;
        Sat, 06 Jun 2020 13:08:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0SbwsNKKsOSlo/OYcuuvmM2xPp+M+9Ct36WZUV5Yngc7zJm9tOIPYCV68GGyxEnn/rpfZ/Q==
X-Received: by 2002:adf:ef50:: with SMTP id c16mr15276923wrp.161.1591474110326;
        Sat, 06 Jun 2020 13:08:30 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
        by smtp.gmail.com with ESMTPSA id z9sm16153180wmi.41.2020.06.06.13.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2020 13:08:29 -0700 (PDT)
Date:   Sat, 6 Jun 2020 16:08:27 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH RFC] uaccess: user_access_begin_after_access_ok()
Message-ID: <20200606160524-mutt-send-email-mst@kernel.org>
References: <20200603014815.GR23230@ZenIV.linux.org.uk>
 <3358ae96-abb6-6be9-346a-0e971cb84dcd@redhat.com>
 <20200603041849.GT23230@ZenIV.linux.org.uk>
 <3e723db8-0d55-fae6-288e-9d95905592db@redhat.com>
 <20200603013600-mutt-send-email-mst@kernel.org>
 <b7de29fa-33f2-bbc1-08dc-d73b28e3ded5@redhat.com>
 <20200603022935-mutt-send-email-mst@kernel.org>
 <f0573536-e6cc-3f68-5beb-a53c8e1d0620@redhat.com>
 <20200604124759-mutt-send-email-mst@kernel.org>
 <55b50859-a71b-c57e-e26b-5fc8659eac22@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55b50859-a71b-c57e-e26b-5fc8659eac22@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 05, 2020 at 06:03:38PM +0800, Jason Wang wrote:
> 
> On 2020/6/5 上午12:49, Michael S. Tsirkin wrote:
> > > > 2. Second argument to translate_desc is a GPA, isn't it?
> > > No, it's IOVA, this function will be called only when IOTLB is enabled.
> > > 
> > > Thanks
> > Right IOVA. Point stands how does it make sense to cast
> > a userspace pointer to an IOVA? I guess it's just
> > because it's talking to qemu actually, so it's abusing
> > the notation a bit ...
> > 
> 
> Yes, but the issues are:
> 
> 1) VHOST_SET_VRING_ADDR is used for iotlb and !iotlb
> 2) so did the memory accessors
> 
> Unless we differ separate IOTLB datapath out, there's probably not easy to
> have another notation.
> 
> Thanks

With the batching/format independence rework, it might be possible to
separate that down the road. We'll see.

-- 
MST

