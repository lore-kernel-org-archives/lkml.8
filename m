Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B419C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 10:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2F63207D3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 10:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B856tJDQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgFEKDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 06:03:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38269 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726262AbgFEKDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 06:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591351430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AmKVcXr9qrOmNSic1kKSnmuRnqw4zxqtb0ssms+7weA=;
        b=B856tJDQGBnRcElIXIMD6MIw1oVDgXzkYvePxj7pMqhrChCnYHzao2CZ72iR6NRC/aF2Cn
        tEuaesg2Sr17VPUyoBORTGf8ODVeKvblS3nThq15BKoplgd38YwNkSm0tG6VgTWZVFMgiS
        xEt2en1YLEAeiBuOtZMUGvc+MlxumTk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-pFUxXIkROne0bALtX15oJw-1; Fri, 05 Jun 2020 06:03:46 -0400
X-MC-Unique: pFUxXIkROne0bALtX15oJw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D26E800688;
        Fri,  5 Jun 2020 10:03:45 +0000 (UTC)
Received: from [10.72.12.233] (ovpn-12-233.pek2.redhat.com [10.72.12.233])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E3A4260BE2;
        Fri,  5 Jun 2020 10:03:40 +0000 (UTC)
Subject: Re: [PATCH RFC] uaccess: user_access_begin_after_access_ok()
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20200602084257.134555-1-mst@redhat.com>
 <20200603014815.GR23230@ZenIV.linux.org.uk>
 <3358ae96-abb6-6be9-346a-0e971cb84dcd@redhat.com>
 <20200603041849.GT23230@ZenIV.linux.org.uk>
 <3e723db8-0d55-fae6-288e-9d95905592db@redhat.com>
 <20200603013600-mutt-send-email-mst@kernel.org>
 <b7de29fa-33f2-bbc1-08dc-d73b28e3ded5@redhat.com>
 <20200603022935-mutt-send-email-mst@kernel.org>
 <f0573536-e6cc-3f68-5beb-a53c8e1d0620@redhat.com>
 <20200604124759-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <55b50859-a71b-c57e-e26b-5fc8659eac22@redhat.com>
Date:   Fri, 5 Jun 2020 18:03:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200604124759-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/6/5 上午12:49, Michael S. Tsirkin wrote:
>>> 2. Second argument to translate_desc is a GPA, isn't it?
>> No, it's IOVA, this function will be called only when IOTLB is enabled.
>>
>> Thanks
> Right IOVA. Point stands how does it make sense to cast
> a userspace pointer to an IOVA? I guess it's just
> because it's talking to qemu actually, so it's abusing
> the notation a bit ...
>

Yes, but the issues are:

1) VHOST_SET_VRING_ADDR is used for iotlb and !iotlb
2) so did the memory accessors

Unless we differ separate IOTLB datapath out, there's probably not easy 
to have another notation.

Thanks

