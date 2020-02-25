Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1821C35E04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 19:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B706E2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 19:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bl1xy3cQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730743AbgBYTvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 14:51:37 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41410 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728443AbgBYTvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 14:51:36 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01PGprxU059312;
        Tue, 25 Feb 2020 10:51:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582649513;
        bh=0h+nCmhnPTm+AmSxpQrAQWVhspSA8igiHXC6K5jdZ+0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=bl1xy3cQ+PDdt/XPMLXVfsyZTCfJxByP4KaL4YmYWsDj6i+sVPvRsxGjrGyIGo6jj
         ehQszO9pMmr7EchOe455Im5yIoWVdtb7BUGa52oJJKKtOp4k/z1UkcR4f81FlCSTGJ
         oE4lb1K0sQn1llZ2mz0dYWgyf7tWvsLg0MYtbJ4g=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01PGpr20102297;
        Tue, 25 Feb 2020 10:51:53 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 25
 Feb 2020 10:51:53 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 25 Feb 2020 10:51:53 -0600
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01PGpq6Q073429;
        Tue, 25 Feb 2020 10:51:53 -0600
Subject: Re: [PATCH] virtio_ring: Fix mem leak with vring_new_virtqueue()
To:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
CC:     Tiwei Bie <tiwei.bie@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>
References: <20200224212643.30672-1-s-anna@ti.com>
 <b622c831-9adb-b9af-dd4a-21605bc124a8@redhat.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <0ace3a3b-cf2f-7977-5337-f74f530afbe1@ti.com>
Date:   Tue, 25 Feb 2020 10:51:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <b622c831-9adb-b9af-dd4a-21605bc124a8@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On 2/24/20 11:39 PM, Jason Wang wrote:
> 
> On 2020/2/25 上午5:26, Suman Anna wrote:
>> The functions vring_new_virtqueue() and __vring_new_virtqueue() are used
>> with split rings, and any allocations within these functions are managed
>> outside of the .we_own_ring flag. The commit cbeedb72b97a ("virtio_ring:
>> allocate desc state for split ring separately") allocates the desc state
>> within the __vring_new_virtqueue() but frees it only when the
>> .we_own_ring
>> flag is set. This leads to a memory leak when freeing such allocated
>> virtqueues with the vring_del_virtqueue() function.
>>
>> Fix this by moving the desc_state free code outside the flag and only
>> for split rings. Issue was discovered during testing with remoteproc
>> and virtio_rpmsg.
>>
>> Fixes: cbeedb72b97a ("virtio_ring: allocate desc state for split ring
>> separately")
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> ---
>>   drivers/virtio/virtio_ring.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>> index 867c7ebd3f10..58b96baa8d48 100644
>> --- a/drivers/virtio/virtio_ring.c
>> +++ b/drivers/virtio/virtio_ring.c
>> @@ -2203,10 +2203,10 @@ void vring_del_virtqueue(struct virtqueue *_vq)
>>                        vq->split.queue_size_in_bytes,
>>                        vq->split.vring.desc,
>>                        vq->split.queue_dma_addr);
>> -
>> -            kfree(vq->split.desc_state);
>>           }
>>       }
>> +    if (!vq->packed_ring)
>> +        kfree(vq->split.desc_state);
> 
> 
> Nitpick, it looks to me it would be more clear if we just free
> desc_state unconditionally here (and remove the kfree for packed above).

OK, are you sure you want that to be folded into this patch? It looks to
me a separate cleanup/consolidation patch, and packed desc_state does
not suffer this memleak, and need not be backported into stable kernels.

regards
Suman

> Anyway desc_state will be allocated by use even if !we_own_ring.
> 
> Thanks
> 
> 
>>       list_del(&_vq->list);
>>       kfree(vq);
>>   }
> 

