Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57670C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 10:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 256082467D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 10:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgCJKBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 06:01:47 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2540 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726211AbgCJKBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 06:01:46 -0400
Received: from lhreml703-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 7BC0699D27285E816645;
        Tue, 10 Mar 2020 10:01:44 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml703-cah.china.huawei.com (10.201.108.44) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 10 Mar 2020 10:01:44 +0000
Received: from localhost (10.202.226.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 10 Mar
 2020 10:01:44 +0000
Date:   Tue, 10 Mar 2020 10:01:42 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <sudeep.holla@arm.com>,
        <lukasz.luba@arm.com>, <james.quinlan@broadcom.com>
Subject: Re: [PATCH v4 07/13] firmware: arm_scmi: Add notification dispatch
 and delivery
Message-ID: <20200310100142.00005ca7@Huawei.com>
In-Reply-To: <b8456cc6-7aad-b5d1-dcd7-06692f340419@arm.com>
References: <20200304162558.48836-1-cristian.marussi@arm.com>
        <20200304162558.48836-8-cristian.marussi@arm.com>
        <20200309122614.00000651@Huawei.com>
        <b8456cc6-7aad-b5d1-dcd7-06692f340419@arm.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.57]
X-ClientProxiedBy: lhreml715-chm.china.huawei.com (10.201.108.66) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Mar 2020 16:37:53 +0000
Cristian Marussi <cristian.marussi@arm.com> wrote:

> Hi
> 
> On 09/03/2020 12:26, Jonathan Cameron wrote:
> > On Wed, 4 Mar 2020 16:25:52 +0000
> > Cristian Marussi <cristian.marussi@arm.com> wrote:
> >   
> >> Add core SCMI Notifications dispatch and delivery support logic which is
> >> able, at first, to dispatch well-known received events from the RX ISR to
> >> the dedicated deferred worker, and then, from there, to final deliver the
> >> events to the registered users' callbacks.
> >>
> >> Dispatch and delivery is just added here, still not enabled.
> >>
> >> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>  
> > 
> > Hmm.  Doing that magic in_flight stuff looks fine, but it feels like
> > the wrong way to approach a problem which is down to the lack of
> > atomicity of the kfifo_in pair.   Could we just make that atomic via
> > a bit of custom manipulation of the kfifo?
> > 
> > The snag is that stuff isn't exported from the innards of kfifo...  
> 
> My initial approach till v3 was to collate header and payload in a pre-allocated
> scratch buffer and then doing a single kfifo_in so as to avoid to worry about workqueue
> empting the kfifo and going to sleep right after a header has been read and a payload is
> in flight, but that, as pointed out indirectly by Jim Quinlan led to an unneeded memcpy...
> in fact I was copying in/out the fifo a total of 2*h + 3*p bytes, instead with this handling
> I can avoid such intermediate collation step and stick to the bare minimum needed 2*h + 2*p
> bytes memcopies.
> 
> On one side I was worried to make the code complex to avoid just a few bytes of memcpy, on the other
> side the redundant memcpy is on the ISR side and also I cannot assume that the unneded p bytes
> copied there are necessarily small ... being SMCI extensible you could possibly add a proprietary
> (or not) protocol with jumbo payloads of KBs so that the p-bytes redundant copy is no more so
> negligible.
> 
> At the end I did not find so horrible and complex the new in flight handling (tested introducing
> horrible mdelays in between the kfifo_inS inside the ISR...), so I went for that.
> 
> > 
> > Maybe what you have here is the best option.
> >   
> 
> I like the solution you propose down below, but the fact that it relies on the inner kfifo function
> is in fact a show stopper being based on the inernal api (and I have not found other viable ways to
> abuse the kfifo API :D ... as of now)...I wonder if it is not worth propose upstream (not in this series)
> a generic kfifo "light" scatter/gather in/out interface for this particular usecase; _kfifo_dma* seem to use
> the full fledged scatter/gather kernel structs, but that's certainly overkill for this scenario.

Seems sensible to me.  Whether via scatterlists is needed, I'm not sure.
Seems to me that most usecases will be header / payload like you have here.

The fiddly stuff in kfifo is always dealing with handling both variable and fixed
size versions.  Here we probably just want to reject the fixed size option at
compile time as it doesn't make sense.

Certainly worth exploring if the kfifo maintainers will allow this sort of interface.

Jonathan

> 
> Thanks
> 
> Cristian
> 
> > Jonathan
> >   
> >> ---
> >> V3 --> V4
> >> - dispatcher now handles dequeuing of events in chunks (header+payload):
> >>   handling of these in_flight events let us remove one unneeded memcpy
> >>   on RX interrupt path (scmi_notify)
> >> - deferred dispatcher now access their own per-protocol handlers' table
> >>   reducing locking contention on the RX path
> >> V2 --> V3
> >> - exposing wq in sysfs via WQ_SYSFS
> >> V1 --> V2
> >> - splitted out of V1 patch 04
> >> - moved from IDR maps to real HashTables to store event_handlers
> >> - simplified delivery logic
> >> ---
> >>  drivers/firmware/arm_scmi/notify.c | 334 ++++++++++++++++++++++++++++-
> >>  drivers/firmware/arm_scmi/notify.h |   9 +
> >>  2 files changed, 342 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
> >> index d6c08cce3c63..0854d48d5886 100644
> >> --- a/drivers/firmware/arm_scmi/notify.c
> >> +++ b/drivers/firmware/arm_scmi/notify.c
> >> @@ -44,6 +44,27 @@
> >>   * as described in the SCMI Protocol specification, while src_id represents an
> >>   * optional, protocol dependent, source identifier (like domain_id, perf_id
> >>   * or sensor_id and so forth).
> >> + *
> >> + * Upon reception of a notification message from the platform the SCMI RX ISR  
> [snip]
> 
> >> +	if (unlikely(len > r_evt->evt->max_payld_sz)) {
> >> +		pr_err("SCMI Notifications: discard badly sized message\n");
> >> +		return -EINVAL;
> >> +	}
> >> +	if (unlikely(kfifo_avail(&r_evt->proto->equeue.kfifo) <
> >> +		     sizeof(eh) + len)) {
> >> +		pr_warn("SCMI Notifications: queue full dropping proto_id:%d  evt_id:%d  ts:%lld\n",
> >> +			proto_id, evt_id, ts);
> >> +		return -ENOMEM;
> >> +	}
> >> +
> >> +	eh.timestamp = ts;
> >> +	eh.evt_id = evt_id;
> >> +	eh.payld_sz = len;
> >> +	kfifo_in(&r_evt->proto->equeue.kfifo, &eh, sizeof(eh));  
> > 
> > I'd add a comment that this potential race here is the reason (I think) for all
> > the inflight handling above.
> > 
> > Either that or create a kfifo_in_pair_unsafe that just makes these atomic by only
> > updating the kfifo->in point after adding both parts.
> > 
> > It will be as simple as (I think, kfifo magic always give me a headache).
> > {
> > 	struct __kfifo *__kfifo = &kfifo->kfifo;
> > 	kfifo_copy_in(fifo, &eh, sizeof(eh), fifo->in);
> > 	kfifo_copy_in(fifo, &buf, len, fifo->in + sizeof(eh));
> > 	fifo->in += len + sizeof(eh);
> > }
> > 
> > It's unsafe because crazy things will happen if there isn't enough room, but you
> > can't get there in this code because of the check above and we are making
> > horrendous assumptions about the kfifo type.
> >   
> 
> As said above.
> >> +	kfifo_in(&r_evt->proto->equeue.kfifo, buf, len);
> >> +	queue_work(r_evt->proto->equeue.wq,
> >> +		   &r_evt->proto->equeue.notify_work);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >>  /**
> >>   * scmi_initialize_events_queue  - Allocate/Initialize a kfifo buffer
> >>   *
> >> @@ -332,12 +604,21 @@ static void scmi_put_handler_unlocked(struct scmi_notify_instance *ni,
> >>  static int scmi_initialize_events_queue(struct scmi_notify_instance *ni,
> >>  					struct events_queue *equeue, size_t sz)
> >>  {
> >> +	int ret = 0;  
> > 
> > ret looks to be always initialized below.
> >   
> 
> Right.
> >> +
> >>  	equeue->qbuf = devm_kzalloc(ni->handle->dev, sz, GFP_KERNEL);
> >>  	if (!equeue->qbuf)
> >>  		return -ENOMEM;
> >>  	equeue->sz = sz;
> >>  
> >> -	return kfifo_init(&equeue->kfifo, equeue->qbuf, equeue->sz);
> >> +	ret = kfifo_init(&equeue->kfifo, equeue->qbuf, equeue->sz);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	INIT_WORK(&equeue->notify_work, scmi_events_dispatcher);
> >> +	equeue->wq = ni->notify_wq;
> >> +
> >> +	return ret;
> >>  }
> >>  
> >>  /**
> >> @@ -740,6 +1021,38 @@ scmi_get_or_create_handler(struct scmi_notify_instance *ni, u32 evt_key)
> >>  	return __scmi_event_handler_get_ops(ni, evt_key, true);
> >>  }
> >>  
> >> +/**
> >> + * scmi_get_active_handler  - Helper to get active handlers only
> >> + *
> >> + * Search for the desired handler matching the key only in the per-protocol
> >> + * table of registered handlers: this is called only from the dispatching path
> >> + * so want to be as quick as possible and do not care about pending.
> >> + *
> >> + * @ni: A reference to the notification instance to use
> >> + * @evt_key: The event key to use
> >> + *
> >> + * Return: A properly refcounted active handler
> >> + */
> >> +static struct scmi_event_handler *
> >> +scmi_get_active_handler(struct scmi_notify_instance *ni, u32 evt_key)
> >> +{
> >> +	struct scmi_registered_event *r_evt;
> >> +	struct scmi_event_handler *hndl = NULL;
> >> +
> >> +	r_evt = SCMI_GET_REVT(ni, KEY_XTRACT_PROTO_ID(evt_key),
> >> +			      KEY_XTRACT_EVT_ID(evt_key));
> >> +	if (likely(r_evt)) {
> >> +		mutex_lock(&r_evt->proto->registered_mtx);
> >> +		hndl = KEY_FIND(r_evt->proto->registered_events_handlers,
> >> +				hndl, evt_key);
> >> +		if (likely(hndl))
> >> +			refcount_inc(&hndl->users);
> >> +		mutex_unlock(&r_evt->proto->registered_mtx);
> >> +	}
> >> +
> >> +	return hndl;
> >> +}
> >> +
> >>  /**
> >>   * __scmi_enable_evt  - Enable/disable events generation
> >>   *
> >> @@ -861,6 +1174,16 @@ static void scmi_put_handler(struct scmi_notify_instance *ni,
> >>  	mutex_unlock(&ni->pending_mtx);
> >>  }
> >>  
> >> +static void scmi_put_active_handler(struct scmi_notify_instance *ni,
> >> +					  struct scmi_event_handler *hndl)
> >> +{
> >> +	struct scmi_registered_event *r_evt = hndl->r_evt;
> >> +
> >> +	mutex_lock(&r_evt->proto->registered_mtx);
> >> +	scmi_put_handler_unlocked(ni, hndl);
> >> +	mutex_unlock(&r_evt->proto->registered_mtx);
> >> +}
> >> +
> >>  /**
> >>   * scmi_event_handler_enable_events  - Enable events associated to an handler
> >>   *
> >> @@ -1087,6 +1410,12 @@ int scmi_notification_init(struct scmi_handle *handle)
> >>  	ni->gid = gid;
> >>  	ni->handle = handle;
> >>  
> >> +	ni->notify_wq = alloc_workqueue("scmi_notify",
> >> +					WQ_UNBOUND | WQ_FREEZABLE | WQ_SYSFS,
> >> +					0);
> >> +	if (!ni->notify_wq)
> >> +		goto err;
> >> +
> >>  	ni->registered_protocols = devm_kcalloc(handle->dev, SCMI_MAX_PROTO,
> >>  						sizeof(char *), GFP_KERNEL);
> >>  	if (!ni->registered_protocols)
> >> @@ -1133,6 +1462,9 @@ void scmi_notification_exit(struct scmi_handle *handle)
> >>  	/* Ensure atomic values are updated */
> >>  	smp_mb__after_atomic();
> >>  
> >> +	/* Destroy while letting pending work complete */
> >> +	destroy_workqueue(ni->notify_wq);
> >> +
> >>  	devres_release_group(ni->handle->dev, ni->gid);
> >>  
> >>  	pr_info("SCMI Notifications Core Shutdown.\n");
> >> diff --git a/drivers/firmware/arm_scmi/notify.h b/drivers/firmware/arm_scmi/notify.h
> >> index f765acda2311..6cd386649d5a 100644
> >> --- a/drivers/firmware/arm_scmi/notify.h
> >> +++ b/drivers/firmware/arm_scmi/notify.h
> >> @@ -51,10 +51,17 @@ struct scmi_event {
> >>   *			using the proper custom protocol commands.
> >>   *			Return true if at least one the required src_id
> >>   *			has been successfully enabled/disabled
> >> + * @fill_custom_report: fills a custom event report from the provided
> >> + *			event message payld identifying the event
> >> + *			specific src_id.
> >> + *			Return NULL on failure otherwise @report now fully
> >> + *			populated
> >>   */
> >>  struct scmi_protocol_event_ops {
> >>  	bool (*set_notify_enabled)(const struct scmi_handle *handle,
> >>  				   u8 evt_id, u32 src_id, bool enabled);
> >> +	void *(*fill_custom_report)(u8 evt_id, u64 timestamp, const void *payld,
> >> +				    size_t payld_sz, void *report, u32 *src_id);
> >>  };
> >>  
> >>  int scmi_notification_init(struct scmi_handle *handle);
> >> @@ -65,5 +72,7 @@ int scmi_register_protocol_events(const struct scmi_handle *handle,
> >>  				  const struct scmi_protocol_event_ops *ops,
> >>  				  const struct scmi_event *evt, int num_events,
> >>  				  int num_sources);
> >> +int scmi_notify(const struct scmi_handle *handle, u8 proto_id, u8 evt_id,
> >> +		const void *buf, size_t len, u64 ts);
> >>  
> >>  #endif /* _SCMI_NOTIFY_H */  
> > 
> >   
> 


