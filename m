Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB36C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 06:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A32B320760
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 06:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C+De58hf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgFJG3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 02:29:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42030 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726078AbgFJG3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 02:29:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591770554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z2x7M7QCGAsae1BplgLRSy2XsJ6miBlImwYneWZ/p2I=;
        b=C+De58hfUOAyaoO65HZ5rw+BJGH6lBRpSNQcPu/RmNuu3xy4rSN91dHbF6LcGtWjJ6k2lN
        kBygG2J2QZFYekcKc51T+waXO+VmBMWiiDQ6nWJtlbbVBJT2+AR5G6EFNQZO6db4haAvOq
        1IXiVYFC+t3bup802gTeWEjzuR/JgaQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-YVENjHhqNzm2zgOrDGL04w-1; Wed, 10 Jun 2020 02:29:12 -0400
X-MC-Unique: YVENjHhqNzm2zgOrDGL04w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE9051883600;
        Wed, 10 Jun 2020 06:29:10 +0000 (UTC)
Received: from [10.72.13.194] (ovpn-13-194.pek2.redhat.com [10.72.13.194])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1912C7BFE2;
        Wed, 10 Jun 2020 06:29:02 +0000 (UTC)
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
 <0964bd2d-8329-a091-41ed-a9b912ec4283@redhat.com>
 <20200610022030-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <be938f8f-8f98-b55e-34b8-b0faf560ef30@redhat.com>
Date:   Wed, 10 Jun 2020 14:29:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200610022030-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/6/10 下午2:21, Michael S. Tsirkin wrote:
> On Wed, Jun 10, 2020 at 02:16:26PM +0800, Jason Wang wrote:
>> On 2020/6/10 下午2:07, Michael S. Tsirkin wrote:
>>> On Wed, Jun 10, 2020 at 01:49:51PM +0800, Jason Wang wrote:
>>>> This patch introduce a vDPA driver for virtio-pci device. It bridges
>>>> the virtio-pci control command to the vDPA bus. This will be used for
>>>> developing new features for both software vDPA framework and hardware
>>>> vDPA feature.
>>>>
>>>> Compared to vdpa_sim, it has several advantages:
>>>>
>>>> - it's a real device driver which allow us to play with real hardware
>>>>     features
>>>> - type independent instead of networking specific
>>>>
>>>> Note that since virtio specification does not support get/restore
>>>> virtqueue state. So we can not use this driver for VM. This can be
>>>> addressed by extending the virtio specification.
>>>>
>>>> Consider the driver is mainly for testing and development for vDPA
>>>> features, it can only be bound via dynamic ids to make sure it's not
>>>> conflict with the drivers like virtio-pci or IFCVF.
>>>>
>>>> Signed-off-by: Jason Wang<jasowang@redhat.com>
>>> error: sha1 information is lacking or useless (drivers/vdpa/Kconfig).
>>>
>>> which tree is this on top of?
>>
>> Your vhost.git vhost branch, HEAD is bbea3bcfd1d6 vdpa: fix typos in the
>> comments for __vdpa_alloc_device()
>>
>> Do I need to use other branch?
>>
>> Thanks
> No it's ok, I am just wondering why doesn't it apply then.


I found the reason, I generate the patch on another branch whose base 
does not existed in the vhost branch. Will repost.

Sorry.


>

