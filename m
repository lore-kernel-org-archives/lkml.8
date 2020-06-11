Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01197C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 09:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA2BB20760
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 09:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CDXgEr+E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgFKJGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 05:06:48 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59102 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726802AbgFKJGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 05:06:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591866405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EMC0E2B827Ia2DQRzxKsWY/OK5Bg//cvAlofONDhk2Q=;
        b=CDXgEr+EKvV5ntUXOSA2QcNFsr/CHHfGNpy2UioYOT4kYXXA7Fb/YRwlB5NtGGRbZ0am2X
        rOItVzsG2E2ekTGJylt8N+J/4iO6U+HiMOlaZIZ0V7qHKKh4+CR0QpS+WyiZXv14CQu8Gt
        jlyIYphj03AwPrCiwGVkeCPUuGWjYjI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-Dtiwu3n_PQiSG9EjgspCpg-1; Thu, 11 Jun 2020 05:06:43 -0400
X-MC-Unique: Dtiwu3n_PQiSG9EjgspCpg-1
Received: by mail-wm1-f71.google.com with SMTP id q7so883420wmj.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 02:06:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=EMC0E2B827Ia2DQRzxKsWY/OK5Bg//cvAlofONDhk2Q=;
        b=ahCYiakongUFY6MvhsM90ULBUV8P2hOtz6KvaUVYH4+wx+b3Ywg9Dg20V+yGIZ5Iq4
         C5s2yrQR6zueW5W0U0x00oK9EG2KPXJCrue1oDSFPG9owGhw4OIRJeaE+ELeKuM+7Ds5
         wizJGk1ZdC4a7J2TCzre0+BT93VBDDqChxEp0p/hK2BqplrGC+K42XHMr5T6fH63Sn0b
         9xOhbvNqG2n8nzlpoN/aNNMbSW9q7HSHjUTkCqwCWnJMFwIAoT/dLSW4Sbf3VebcNa8p
         Ce8EodCE3PuxMel4boNZ7MJQUVmLrAkjVn4Xs+aD5f4urPeH2ft6sme+2vyV+f8rV3mQ
         8hXQ==
X-Gm-Message-State: AOAM533BB39ajZ2bRC3QjeYbQRvH8UdBzDDSKU62ISJtVLjLrcmXq113
        dF+EiRk/88QL5hjZxdXBgC8eKb0pJN60iWAv2CiivAc9xSeTlHCqOv1qWxfR4uwAQz+5N2b14Zg
        3iOlYPTN+fEQ6piAwmOAs+oO5
X-Received: by 2002:adf:dccc:: with SMTP id x12mr8242094wrm.72.1591866401977;
        Thu, 11 Jun 2020 02:06:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwjS282NzyfgjaTUCOeu+TiuTHkZ19eiBXmK6U3BwQgdXs1XxcOHzbjcay7nTvobbz5n62KJQ==
X-Received: by 2002:adf:dccc:: with SMTP id x12mr8242068wrm.72.1591866401733;
        Thu, 11 Jun 2020 02:06:41 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
        by smtp.gmail.com with ESMTPSA id y80sm3152548wmc.34.2020.06.11.02.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 02:06:40 -0700 (PDT)
Date:   Thu, 11 Jun 2020 05:06:38 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        eperezma@redhat.com
Subject: Re: [PATCH RFC v6 02/11] vhost: use batched get_vq_desc version
Message-ID: <20200611050416-mutt-send-email-mst@kernel.org>
References: <20200608125238.728563-1-mst@redhat.com>
 <20200608125238.728563-3-mst@redhat.com>
 <81904cc5-b662-028d-3b4a-bdfdbd2deb8c@redhat.com>
 <20200610070259-mutt-send-email-mst@kernel.org>
 <76b14132-407a-48bf-c4d5-9d0b2c700bb0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76b14132-407a-48bf-c4d5-9d0b2c700bb0@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 11:02:57AM +0800, Jason Wang wrote:
> 
> On 2020/6/10 下午7:05, Michael S. Tsirkin wrote:
> > > > +EXPORT_SYMBOL_GPL(vhost_get_vq_desc);
> > > >    /* Reverse the effect of vhost_get_vq_desc. Useful for error handling. */
> > > >    void vhost_discard_vq_desc(struct vhost_virtqueue *vq, int n)
> > > >    {
> > > > +	unfetch_descs(vq);
> > > >    	vq->last_avail_idx -= n;
> > > So unfetch_descs() has decreased last_avail_idx.
> > > Can we fix this by letting unfetch_descs() return the number and then we can
> > > do:
> > > 
> > > int d = unfetch_descs(vq);
> > > vq->last_avail_idx -= (n > d) ? n - d: 0;
> > > 
> > > Thanks
> > That's intentional I think - we need both.
> 
> 
> Yes, but:
> 
> 
> > 
> > Unfetch_descs drops the descriptors in the cache that were
> > *not returned to caller*  through get_vq_desc.
> > 
> > vhost_discard_vq_desc drops the ones that were returned through get_vq_desc.
> > 
> > Did I miss anything?
> 
> We could count some descriptors twice, consider the case e.g we only cache
> on descriptor:
> 
> fetch_descs()
>     fetch_buf()
>         last_avail_idx++;
> 
> Then we want do discard it:
> vhost_discard_avail_buf(1)
>     unfetch_descs()
>         last_avail_idx--;
>     last_avail_idx -= 1;
> 
> Thanks


I don't think that happens. vhost_discard_avail_buf(1) is only called
after get vhost_get_avail_buf. vhost_get_avail_buf increments
first_desc.  unfetch_descs only counts from first_desc to ndescs.

If I'm wrong, could you show values of first_desc and ndescs in this
scenario?

-- 
MST

