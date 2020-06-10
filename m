Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F55BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 06:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED1B620734
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 06:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g9xaGjht"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgFJGQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 02:16:43 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37104 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725988AbgFJGQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 02:16:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591769800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dd9hSPJklMgRKnOtvAiPIti1OIPB2Shfs7YNJkiFzA4=;
        b=g9xaGjht/ceWgCHZ06Njx4//HgEk7rPdXJ3e64cy1JOqJAGkdXNfnPsoLOQFdsFLq4aoOZ
        /rm+kiHB8oT8iDPBDWu52oJgs0y3iosqBdiONbVyWSWUX10XQeJ+bV6VzucjQvFk91aVep
        K+WqtIfkWKkWEWLbMTmsJYcFOobRbws=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-WyxVb7iaOrqXm3GFQIDRNg-1; Wed, 10 Jun 2020 02:16:37 -0400
X-MC-Unique: WyxVb7iaOrqXm3GFQIDRNg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9AA56107ACCD;
        Wed, 10 Jun 2020 06:16:35 +0000 (UTC)
Received: from [10.72.13.194] (ovpn-13-194.pek2.redhat.com [10.72.13.194])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC6895D9D3;
        Wed, 10 Jun 2020 06:16:27 +0000 (UTC)
Subject: Re: [PATCH RESEND V2] vdpa: introduce virtio pci driver
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, rob.miller@broadcom.com,
        lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com,
        shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com,
        gdawar@xilinx.com, saugatm@xilinx.com, vmireyno@marvell.com,
        zhangweining@ruijie.com.cn, eli@mellanox.com
References: <20200610054951.16197-1-jasowang@redhat.com>
 <20200610020728-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <0964bd2d-8329-a091-41ed-a9b912ec4283@redhat.com>
Date:   Wed, 10 Jun 2020 14:16:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200610020728-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/6/10 下午2:07, Michael S. Tsirkin wrote:
> On Wed, Jun 10, 2020 at 01:49:51PM +0800, Jason Wang wrote:
>> This patch introduce a vDPA driver for virtio-pci device. It bridges
>> the virtio-pci control command to the vDPA bus. This will be used for
>> developing new features for both software vDPA framework and hardware
>> vDPA feature.
>>
>> Compared to vdpa_sim, it has several advantages:
>>
>> - it's a real device driver which allow us to play with real hardware
>>    features
>> - type independent instead of networking specific
>>
>> Note that since virtio specification does not support get/restore
>> virtqueue state. So we can not use this driver for VM. This can be
>> addressed by extending the virtio specification.
>>
>> Consider the driver is mainly for testing and development for vDPA
>> features, it can only be bound via dynamic ids to make sure it's not
>> conflict with the drivers like virtio-pci or IFCVF.
>>
>> Signed-off-by: Jason Wang<jasowang@redhat.com>
> error: sha1 information is lacking or useless (drivers/vdpa/Kconfig).
>
> which tree is this on top of?


Your vhost.git vhost branch, HEAD is bbea3bcfd1d6 vdpa: fix typos in the 
comments for __vdpa_alloc_device()

Do I need to use other branch?

Thanks


>

