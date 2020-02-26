Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F3AC4BA09
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 03:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B14B4222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 03:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CFOu0bY/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730245AbgBZDOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 22:14:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46516 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727880AbgBZDOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 22:14:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582686858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zPO9Q4VBlPr6ggd2qAuWkleMNlATunLXOSzyCdyykww=;
        b=CFOu0bY/IzaIL39WpkVkv9r8D1ez5cPo8qoRZ0W/GYxFPb2NY+plgNc14jES21D5rSvCde
        zX91IIH949TFVTCz6hkmcZpXMGW3f/mn6ufOnPxGDJ53WyXIVs0yMvpaMROioOR6JrLxUJ
        /tXFpsB8XtFdHX0onvffSKmNhu6bgfA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-DyPfyrCDO6K9EjXf8mESqA-1; Tue, 25 Feb 2020 22:14:14 -0500
X-MC-Unique: DyPfyrCDO6K9EjXf8mESqA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11C7E1034B20;
        Wed, 26 Feb 2020 03:14:13 +0000 (UTC)
Received: from [10.72.13.217] (ovpn-13-217.pek2.redhat.com [10.72.13.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AC1435C13D;
        Wed, 26 Feb 2020 03:14:00 +0000 (UTC)
Subject: Re: [PATCH] virtio_ring: Fix mem leak with vring_new_virtqueue()
To:     Suman Anna <s-anna@ti.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Tiwei Bie <tiwei.bie@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
References: <20200224212643.30672-1-s-anna@ti.com>
 <b622c831-9adb-b9af-dd4a-21605bc124a8@redhat.com>
 <0ace3a3b-cf2f-7977-5337-f74f530afbe1@ti.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <1ce2bee4-64ed-f630-2695-8e8b9b8e27c1@redhat.com>
Date:   Wed, 26 Feb 2020 11:13:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0ace3a3b-cf2f-7977-5337-f74f530afbe1@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/2/26 =E4=B8=8A=E5=8D=8812:51, Suman Anna wrote:
> Hi Jason,
>
> On 2/24/20 11:39 PM, Jason Wang wrote:
>> On 2020/2/25 =E4=B8=8A=E5=8D=885:26, Suman Anna wrote:
>>> The functions vring_new_virtqueue() and __vring_new_virtqueue() are u=
sed
>>> with split rings, and any allocations within these functions are mana=
ged
>>> outside of the .we_own_ring flag. The commit cbeedb72b97a ("virtio_ri=
ng:
>>> allocate desc state for split ring separately") allocates the desc st=
ate
>>> within the __vring_new_virtqueue() but frees it only when the
>>> .we_own_ring
>>> flag is set. This leads to a memory leak when freeing such allocated
>>> virtqueues with the vring_del_virtqueue() function.
>>>
>>> Fix this by moving the desc_state free code outside the flag and only
>>> for split rings. Issue was discovered during testing with remoteproc
>>> and virtio_rpmsg.
>>>
>>> Fixes: cbeedb72b97a ("virtio_ring: allocate desc state for split ring
>>> separately")
>>> Signed-off-by: Suman Anna<s-anna@ti.com>
>>> ---
>>>  =C2=A0 drivers/virtio/virtio_ring.c | 4 ++--
>>>  =C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_rin=
g.c
>>> index 867c7ebd3f10..58b96baa8d48 100644
>>> --- a/drivers/virtio/virtio_ring.c
>>> +++ b/drivers/virtio/virtio_ring.c
>>> @@ -2203,10 +2203,10 @@ void vring_del_virtqueue(struct virtqueue *_v=
q)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vq->split=
.queue_size_in_bytes,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vq->split=
.vring.desc,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vq->split=
.queue_dma_addr);
>>> -
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 k=
free(vq->split.desc_state);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 if (!vq->packed_ring)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree(vq->split.desc_stat=
e);
>> Nitpick, it looks to me it would be more clear if we just free
>> desc_state unconditionally here (and remove the kfree for packed above=
).
> OK, are you sure you want that to be folded into this patch? It looks t=
o
> me a separate cleanup/consolidation patch, and packed desc_state does
> not suffer this memleak, and need not be backported into stable kernels=
.
>
> regards
> Suman


Though it's just a small tweak, I'm fine for leaving it for future.

So

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

