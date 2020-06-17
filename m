Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50BAC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 03:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 816552082E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 03:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g6BI0oo0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgFQDTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 23:19:37 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50891 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726497AbgFQDTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 23:19:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592363975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mq/stawXjx0dcB0y1QUsFlRW19BEay/7Pm1Vse2Y1ZY=;
        b=g6BI0oo00Bt7qVf6Rbv5ZTwJdYCiQ46PyGzqOjAPQ+Fu9/t/PFWJ+eCk8OznU9piF+p/Ri
        ycXWTuwOcWPQAmP+FyMHFJNKMM/8FY23r1Vmox5wF+CHSriKnaag2dyZTdWGJMHuDRTk87
        ag2fa+dhgDqxCXdKWp4srBsM8pa791s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-xkJ2Kb9hMbC8iI2CXnx6hw-1; Tue, 16 Jun 2020 23:19:33 -0400
X-MC-Unique: xkJ2Kb9hMbC8iI2CXnx6hw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A81C910059A6;
        Wed, 17 Jun 2020 03:19:32 +0000 (UTC)
Received: from [10.72.13.217] (ovpn-13-217.pek2.redhat.com [10.72.13.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D49205D9D3;
        Wed, 17 Jun 2020 03:19:27 +0000 (UTC)
Subject: Re: [PATCH RFC v8 02/11] vhost: use batched get_vq_desc version
To:     "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, eperezma@redhat.com
References: <20200611113404.17810-1-mst@redhat.com>
 <20200611113404.17810-3-mst@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <0332b0cf-cf00-9216-042c-e870efa33626@redhat.com>
Date:   Wed, 17 Jun 2020 11:19:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200611113404.17810-3-mst@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/6/11 下午7:34, Michael S. Tsirkin wrote:
>   static void vhost_vq_free_iovecs(struct vhost_virtqueue *vq)
>   {
>   	kfree(vq->descs);
> @@ -394,6 +400,9 @@ static long vhost_dev_alloc_iovecs(struct vhost_dev *dev)
>   	for (i = 0; i < dev->nvqs; ++i) {
>   		vq = dev->vqs[i];
>   		vq->max_descs = dev->iov_limit;
> +		if (vhost_vq_num_batch_descs(vq) < 0) {
> +			return -EINVAL;
> +		}


This check breaks vdpa which set iov_limit to zero. Consider iov_limit 
is meaningless to vDPA, I wonder we can skip the test when device 
doesn't use worker.

Thanks

