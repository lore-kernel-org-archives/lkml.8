Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC52C3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 00:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 753EA20801
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 00:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="h00UqDtC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbgCFA2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 19:28:06 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:50484 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbgCFA2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 19:28:04 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0260RrJm080385;
        Thu, 5 Mar 2020 18:27:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583454473;
        bh=YJf4KHSPGL0RTl9hoO/JnG8itCOApAjq2pNa0gAdb7I=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=h00UqDtCzS/dSUz21lLLqqBWrH68K8stUvTCpi6q6BEMS1wMt366AXWj+CtpMe5RJ
         Tete8JZXLXAArYsIjDlXpOzOznWKxKLKtZxdEMJbLvpBxvQm9Mrigllig+6Z/zfGJG
         vhHm6x9kRkMNeZLvg7cPWab/rVy3Knkg+JJrtXgo=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0260RrrZ050253
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Mar 2020 18:27:53 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 5 Mar
 2020 18:27:53 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 5 Mar 2020 18:27:53 -0600
Received: from [128.247.81.254] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0260Rr4m081998;
        Thu, 5 Mar 2020 18:27:53 -0600
Subject: Re: [PATCH] virtio_ring: Fix mem leak with vring_new_virtqueue()
To:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
CC:     Tiwei Bie <tiwei.bie@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>
References: <20200224212643.30672-1-s-anna@ti.com>
 <b622c831-9adb-b9af-dd4a-21605bc124a8@redhat.com>
 <0ace3a3b-cf2f-7977-5337-f74f530afbe1@ti.com>
 <1ce2bee4-64ed-f630-2695-8e8b9b8e27c1@redhat.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <a4335428-e29e-d567-b18b-3c144020a726@ti.com>
Date:   Thu, 5 Mar 2020 18:27:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1ce2bee4-64ed-f630-2695-8e8b9b8e27c1@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/20 9:13 PM, Jason Wang wrote:
> 
> On 2020/2/26 上午12:51, Suman Anna wrote:
>> Hi Jason,
>>
>> On 2/24/20 11:39 PM, Jason Wang wrote:
>>> On 2020/2/25 上午5:26, Suman Anna wrote:
>>>> The functions vring_new_virtqueue() and __vring_new_virtqueue() are
>>>> used
>>>> with split rings, and any allocations within these functions are
>>>> managed
>>>> outside of the .we_own_ring flag. The commit cbeedb72b97a
>>>> ("virtio_ring:
>>>> allocate desc state for split ring separately") allocates the desc
>>>> state
>>>> within the __vring_new_virtqueue() but frees it only when the
>>>> .we_own_ring
>>>> flag is set. This leads to a memory leak when freeing such allocated
>>>> virtqueues with the vring_del_virtqueue() function.
>>>>
>>>> Fix this by moving the desc_state free code outside the flag and only
>>>> for split rings. Issue was discovered during testing with remoteproc
>>>> and virtio_rpmsg.
>>>>
>>>> Fixes: cbeedb72b97a ("virtio_ring: allocate desc state for split ring
>>>> separately")
>>>> Signed-off-by: Suman Anna<s-anna@ti.com>
>>>> ---
>>>>    drivers/virtio/virtio_ring.c | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/virtio/virtio_ring.c
>>>> b/drivers/virtio/virtio_ring.c
>>>> index 867c7ebd3f10..58b96baa8d48 100644
>>>> --- a/drivers/virtio/virtio_ring.c
>>>> +++ b/drivers/virtio/virtio_ring.c
>>>> @@ -2203,10 +2203,10 @@ void vring_del_virtqueue(struct virtqueue *_vq)
>>>>                         vq->split.queue_size_in_bytes,
>>>>                         vq->split.vring.desc,
>>>>                         vq->split.queue_dma_addr);
>>>> -
>>>> -            kfree(vq->split.desc_state);
>>>>            }
>>>>        }
>>>> +    if (!vq->packed_ring)
>>>> +        kfree(vq->split.desc_state);
>>> Nitpick, it looks to me it would be more clear if we just free
>>> desc_state unconditionally here (and remove the kfree for packed above).
>> OK, are you sure you want that to be folded into this patch? It looks to
>> me a separate cleanup/consolidation patch, and packed desc_state does
>> not suffer this memleak, and need not be backported into stable kernels.
>>
>> regards
>> Suman
> 
> 
> Though it's just a small tweak, I'm fine for leaving it for future.
> 
> So
> 
> Acked-by: Jason Wang <jasowang@redhat.com>
> 

Mike,
Ping on this. I don't see the patch in -next yet. Can we get this into
the current -rc please?

regards
Suman
