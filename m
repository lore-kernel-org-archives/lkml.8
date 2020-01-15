Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAF0C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 13:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86BA8222C3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 13:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kalray.eu header.i=@kalray.eu header.b="k7pT4RPq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbgAON53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 08:57:29 -0500
Received: from zimbra2.kalray.eu ([92.103.151.219]:58188 "EHLO
        zimbra2.kalray.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730070AbgAON4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 08:56:43 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 4721727E02D1;
        Wed, 15 Jan 2020 14:56:41 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id bGMhighg2Kt6; Wed, 15 Jan 2020 14:56:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id CAD4327E0DA9;
        Wed, 15 Jan 2020 14:56:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu CAD4327E0DA9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1579096600;
        bh=Mkb49ll5lGBHay5dsOaWUInFYwrlRg3Wju6sxzltjj8=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=k7pT4RPqP6XTa3N+R776DYMNrg/Fug9Y/Nb9pBwHQZXDKloWwzI8VIxakgGLH3uCh
         AGbfkyhlnC/Hna5ndxsd6imjSCJuzhexN6V8wPR4PbLtAi0LF9n0Q8favxZKRRDY+t
         vA1BKyx/dsskazJLLAIoHdalzxXsS81sniAWS3xw=
X-Virus-Scanned: amavisd-new at zimbra2.kalray.eu
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3BR-Mp-NM8_W; Wed, 15 Jan 2020 14:56:40 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id B628627E02D1;
        Wed, 15 Jan 2020 14:56:40 +0100 (CET)
Date:   Wed, 15 Jan 2020 14:56:40 +0100 (CET)
From:   =?utf-8?Q?Cl=C3=A9ment?= Leger <cleger@kalray.eu>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1473755958.12366773.1579096600598.JavaMail.zimbra@kalray.eu>
In-Reply-To: <20200115084601-mutt-send-email-mst@kernel.org>
References: <20200115120535.17454-1-cleger@kalray.eu> <20200115084601-mutt-send-email-mst@kernel.org>
Subject: Re: [PATCH] virtio_ring: Use workqueue to execute virtqueue
 callback
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.40.202]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - GC75 (Linux)/8.8.12_GA_3794)
Thread-Topic: virtio_ring: Use workqueue to execute virtqueue callback
Thread-Index: S1fYa/cATg3viLmb/fEor9kiAMTFkQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



----- On 15 Jan, 2020, at 14:49, Michael S. Tsirkin mst@redhat.com wrote:

> On Wed, Jan 15, 2020 at 01:05:35PM +0100, Clement Leger wrote:
>> Currently, in vring_interrupt, the vq callbacks are called directly.
>> However, these callbacks are not meant to be executed in IRQ context.
>> They do not return any irq_return_t value and some of them can do
>> locking (rpmsg_recv_done -> rpmsg_recv_single -> mutex_lock).
> 
> That's a bug in rpmsg. Pls fix there.

Ok.

> 
>> When compiled with DEBUG_ATOMIC_SLEEP, the kernel will spit out warnings
>> when such case shappen.
>> 
>> In order to allow calling these callbacks safely (without sleeping in
>> IRQ context), execute them in a workqueue if needed.
>> 
>> Signed-off-by: Clement Leger <cleger@kalray.eu>
> 
> If applied this would slow data path handling of VQ events
> significantly. Teaching callbacks to return irqreturn_t
> might be a good idea, though it's not an insignificant
> amount of work.

Yes, I was expecting that it would slow down VQ event handling.
I was not completely sure of the criticality of that.

Thanks for your answer.

> 
> 
>> ---
>>  drivers/virtio/virtio_ring.c | 20 ++++++++++++++++++--
>>  1 file changed, 18 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>> index 867c7ebd3f10..0e4d0e5ca227 100644
>> --- a/drivers/virtio/virtio_ring.c
>> +++ b/drivers/virtio/virtio_ring.c
>> @@ -183,6 +183,9 @@ struct vring_virtqueue {
>>  	/* DMA, allocation, and size information */
>>  	bool we_own_ring;
>>  
>> +	/* Work struct for vq callback handling */
>> +	struct work_struct work;
>> +
>>  #ifdef DEBUG
>>  	/* They're supposed to lock for us. */
>>  	unsigned int in_use;
>> @@ -2029,6 +2032,16 @@ static inline bool more_used(const struct vring_virtqueue
>> *vq)
>>  	return vq->packed_ring ? more_used_packed(vq) : more_used_split(vq);
>>  }
>>  
>> +static void vring_work_handler(struct work_struct *work_struct)
>> +{
>> +	struct vring_virtqueue *vq = container_of(work_struct,
>> +						  struct vring_virtqueue,
>> +						  work);
>> +	pr_debug("virtqueue callback for %p (%p)\n", vq, vq->vq.callback);
>> +
>> +	vq->vq.callback(&vq->vq);
>> +}
>> +
>>  irqreturn_t vring_interrupt(int irq, void *_vq)
>>  {
>>  	struct vring_virtqueue *vq = to_vvq(_vq);
>> @@ -2041,9 +2054,8 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
>>  	if (unlikely(vq->broken))
>>  		return IRQ_HANDLED;
>>  
>> -	pr_debug("virtqueue callback for %p (%p)\n", vq, vq->vq.callback);
>>  	if (vq->vq.callback)
>> -		vq->vq.callback(&vq->vq);
>> +		schedule_work(&vq->work);
>>  
>>  	return IRQ_HANDLED;
>>  }
>> @@ -2110,6 +2122,8 @@ struct virtqueue *__vring_new_virtqueue(unsigned int
>> index,
>>  					vq->split.avail_flags_shadow);
>>  	}
>>  
>> +	INIT_WORK(&vq->work, vring_work_handler);
>> +
>>  	vq->split.desc_state = kmalloc_array(vring.num,
>>  			sizeof(struct vring_desc_state_split), GFP_KERNEL);
>>  	if (!vq->split.desc_state) {
>> @@ -2179,6 +2193,8 @@ void vring_del_virtqueue(struct virtqueue *_vq)
>>  {
>>  	struct vring_virtqueue *vq = to_vvq(_vq);
>>  
>> +	cancel_work_sync(&vq->work);
>> +
>>  	if (vq->we_own_ring) {
>>  		if (vq->packed_ring) {
>>  			vring_free_queue(vq->vq.vdev,
>> --
> > 2.15.0.276.g89ea799
