Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E448C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 16:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28F8F206BE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 16:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FKCvN8bH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbgFVQA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 12:00:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22278 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729260AbgFVQAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 12:00:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592841654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KVVo1o4umZNzjH+FG7Lke6lFdsLIhTFS1KQNZFyeoJQ=;
        b=FKCvN8bHyyGHUcIk6+tsYHn3iMsyl/0lsRJdtghmB4QNvIvpiqk2XetE1zvKcrJAeJOHTZ
        T8HZfjqiujaus7GDMsmroyJmiLEnIAVKZqBb4I6rtEPy/DfoJ+IW/c7GmjjvO3EyzjyDxz
        9q8FNMn3KIe20l7l0AGGbqPVU5tQu1Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-qj1yjF_UOiu_eUuZo3KBOA-1; Mon, 22 Jun 2020 12:00:52 -0400
X-MC-Unique: qj1yjF_UOiu_eUuZo3KBOA-1
Received: by mail-wm1-f70.google.com with SMTP id q7so21337wmj.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 09:00:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=KVVo1o4umZNzjH+FG7Lke6lFdsLIhTFS1KQNZFyeoJQ=;
        b=mAkskHl6KuTqA0cwQ9cDQz/PGMR0FJCn2Hs8RMK5QNOou+wQ4H9onLSKPbuxFd4Gph
         jj0bxsqq5y1hhrn4J9jYRNew7+B67ncrFgyafTePrKbGvwJXbPNXxQm6Rx+VPfw7mvGO
         zqO9ckypIWGV5nd2xL5nczI1CJo3RbGTg5nBWZR/FwWG9JkR2zqLxKlG64AFpdtV38SN
         jy1aVn6Yskaa1nh4N4xugJZ4AfMAjwdhGD16JJu4zZo/IyAwnRuawO9zVWgw0ySIHW7q
         0JOd/fY+5D5CcAWrGja5xJinGNO41XxfhiE2qWZOegSZWWJ4K7lxmAXN4FMdTS57fDZF
         D9bQ==
X-Gm-Message-State: AOAM532xIxOaWvBPiHyjG3tycA31StfLv4tFDZGhVPmqWXDZtgzRRfN+
        XsmquLAnvlBMOKZLasqPVqetk5TgsEt3U99JMnt8IQvudaNNc4sn67JpLJwh29tBU+naNK3TxNC
        YNS/bZG2DT1KMv1FiaI/0kuYc
X-Received: by 2002:a7b:c385:: with SMTP id s5mr20342982wmj.121.1592841651776;
        Mon, 22 Jun 2020 09:00:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvgPO5JBany+h/NfYkGnwDtTNClIm0IeoiYnCbawxbhnKhPFgGcHzSS6vD+M99GoPOJKnLZg==
X-Received: by 2002:a7b:c385:: with SMTP id s5mr20342963wmj.121.1592841651583;
        Mon, 22 Jun 2020 09:00:51 -0700 (PDT)
Received: from redhat.com (bzq-79-178-18-124.red.bezeqint.net. [79.178.18.124])
        by smtp.gmail.com with ESMTPSA id 125sm2256wmc.23.2020.06.22.09.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 09:00:50 -0700 (PDT)
Date:   Mon, 22 Jun 2020 12:00:48 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        eperezma@redhat.com
Subject: Re: [PATCH RFC v8 02/11] vhost: use batched get_vq_desc version
Message-ID: <20200622115946-mutt-send-email-mst@kernel.org>
References: <20200611113404.17810-1-mst@redhat.com>
 <20200611113404.17810-3-mst@redhat.com>
 <0332b0cf-cf00-9216-042c-e870efa33626@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0332b0cf-cf00-9216-042c-e870efa33626@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 11:19:26AM +0800, Jason Wang wrote:
> 
> On 2020/6/11 下午7:34, Michael S. Tsirkin wrote:
> >   static void vhost_vq_free_iovecs(struct vhost_virtqueue *vq)
> >   {
> >   	kfree(vq->descs);
> > @@ -394,6 +400,9 @@ static long vhost_dev_alloc_iovecs(struct vhost_dev *dev)
> >   	for (i = 0; i < dev->nvqs; ++i) {
> >   		vq = dev->vqs[i];
> >   		vq->max_descs = dev->iov_limit;
> > +		if (vhost_vq_num_batch_descs(vq) < 0) {
> > +			return -EINVAL;
> > +		}
> 
> 
> This check breaks vdpa which set iov_limit to zero. Consider iov_limit is
> meaningless to vDPA, I wonder we can skip the test when device doesn't use
> worker.
> 
> Thanks

It doesn't need iovecs at all, right?

-- 
MST

