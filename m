Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E80C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 06:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 109112072D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 06:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgDUGv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 02:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726511AbgDUGv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 02:51:27 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAD4C061A10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 23:51:27 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1jQmka-0004gu-LO; Tue, 21 Apr 2020 08:51:20 +0200
Received: from mgr by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1jQmkZ-00013P-1r; Tue, 21 Apr 2020 08:51:19 +0200
Date:   Tue, 21 Apr 2020 08:51:19 +0200
From:   Michael Grzeschik <mgr@pengutronix.de>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH 2/2] usb: dwc3: gadget: restart the transfer if a isoc
 request is queued too late
Message-ID: <20200421065118.GB2338@pengutronix.de>
References: <Pine.LNX.4.44L0.1911131036340.1558-100000@iolanthe.rowland.org>
 <587b0adf-b71d-6fde-407b-46089ed5d695@synopsys.com>
 <20191114121422.qtvyom6nytzwoy2e@pengutronix.de>
 <6d4b87c8-5aca-18cb-81db-a8d2fd4bd86e@synopsys.com>
 <20200409075958.GA19563@pengutronix.de>
 <431d2faa-b073-287c-62ec-557d7d021c48@synopsys.com>
 <20200410220336.GB19563@pengutronix.de>
 <295ff41f-f287-e2c8-7c33-1c225e9b76b5@synopsys.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZoaI/ZTpAVc4A5k6"
Content-Disposition: inline
In-Reply-To: <295ff41f-f287-e2c8-7c33-1c225e9b76b5@synopsys.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:30:47 up 61 days, 14:01, 87 users,  load average: 0.28, 0.20,
 0.16
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Apr 11, 2020 at 12:59:47AM +0000, Thinh Nguyen wrote:
>Hi,
>
>Michael Grzeschik wrote:
>> On Fri, Apr 10, 2020 at 01:09:23AM +0000, Thinh Nguyen wrote:
>>> Hi,
>>>
>>> Michael Grzeschik wrote:
>>>> On Thu, Nov 14, 2019 at 08:11:56PM +0000, Thinh Nguyen wrote:
>>>>> Michael Olbrich wrote:
>>>>>> On Wed, Nov 13, 2019 at 07:14:59PM +0000, Thinh Nguyen wrote:
>>>>>>> Alan Stern wrote:
>>>>>>>> On Wed, 13 Nov 2019, Michael Olbrich wrote:
>>>>>>>>> On Wed, Nov 13, 2019 at 03:55:01AM +0000, Thinh Nguyen wrote:
>>>>>>>>>> Michael Olbrich wrote:
>>>>>>>>>>> Currently, most gadget drivers handle isoc transfers on a best
>>>>>>>>>>> effort
>>>>>>>>>>> bases: If the request queue runs empty, then there will simply
>>>>>>>>>>> be gaps in
>>>>>>>>>>> the isoc data stream.
>>>>>>>>>>>
>>>>>>>>>>> The UVC gadget depends on this behaviour. It simply provides
>>>>>>>>>>> new requests
>>>>>>>>>>> when video frames are available and assumes that they are sent
>>>>>>>>>>> as soon as
>>>>>>>>>>> possible.
>>>>>>>>>>>
>>>>>>>>>>> The dwc3 gadget currently works differently: It assumes that
>>>>>>>>>>> there is a
>>>>>>>>>>> contiguous stream of requests without any gaps. If a request is
>>>>>>>>>>> too late,
>>>>>>>>>>> then it is dropped by the hardware.
>>>>>>>>>>> For the UVC gadget this means that a live stream stops after
>>>>>>>>>>> the first
>>>>>>>>>>> frame because all following requests are late.
>>>>>>>>>> Can you explain little more how UVC gadget fails?
>>>>>>>>>> dwc3 controller expects a steady stream of data otherwise it
>>>>>>>>>> will result
>>>>>>>>>> in missed_isoc status, and it should be fine as long as new
>>>>>>>>>> requests are
>>>>>>>>>> queued. The controller doesn't just drop the request unless
>>>>>>>>>> there's some
>>>>>>>>>> other failure.
>>>>>>>>> UVC (with a live stream) does not fill the complete bandwidth
>>>>>>>>> of an
>>>>>>>>> isochronous endpoint. Let's assume for the example that one video
>>>>>>>>> frame
>>>>>>>>> fills 3 requests. Because it is a live stream, there will be a
>>>>>>>>> gap between
>>>>>>>>> video frames. This is unavoidable, especially for compressed
>>>>>>>>> video. So the
>>>>>>>>> UVC gadget will have requests for the frame numbers 1 2 3 5 6 7 9
>>>>>>>>> 10 11 13 14
>>>>>>>>> 15 and so on.
>>>>>>>>> The dwc3 hardware tries to send those with frame numbers 1 2 3 4
>>>>>>>>> 5 6 7 8 9
>>>>>>>>> 10 11 12. So except for the fist few requests, all are late and
>>>>>>>>> result in a
>>>>>>>>> missed_isoc. I tried to just ignore the missed_isoc but that did
>>>>>>>>> not work
>>>>>>>>> for me. I only received the first frame at the other end.
>>>>>>>>> Maybe I missing something here, i don't have access to the
>>>>>>>>> hardware
>>>>>>>>> documentation, so I can only guess from the existing driver.
>>>>>>> The reason I asked is because your patch doesn't seem to address the
>>>>>>> actual issue.
>>>>>>>
>>>>>>> For the 2 checks you do here
>>>>>>> 1. There are currently no requests queued in the hardware
>>>>>>> 2. The current frame number provided by DSTS does not match the
>>>>>>> frame
>>>>>>> =A0 =A0=A0=A0 number returned by the last transfer.
>>>>>>>
>>>>>>> For #1, it's already done in the dwc3 driver. (check
>>>>>>> dwc3_gadget_endpoint_transfer_in_progress())
>>>>>> But that's only after a isoc_missed occurred. What exactly does that
>>>>>> mean?
>>>>>> Was the request transferred or not? My tests suggest that it was not
>>>>>> transferred, so I wanted to catch this before it happens.
>>>>>
>>>>> Missed_isoc status means that the controller did not move all the data
>>>>> in an interval.
>>>>
>>>> I read in some Processor documentation that in case the host tries to
>>>> fetch data from the client and no active TRB (HWO=3D1) is available the
>>>> XferInProgress Interrupt will be produced, with the missed status set.
>>>> This is done because the hardware will produce zero length packets
>>>> on its own, to keep the stream running.
>>>
>>> The controller only generates XferInProgress if it had processed a TRB
>>> (with specific control bits). For IN direction, if the controller is
>>> starved of TRB, it will send a ZLP if the host requests for data.
>>
>> Which control bits are those? ISOC-First, Chain and Last bits?
>>
>> I see the Scatter-Gather preparation is using these pattern.
>
>The IOC bit. You can check the programming guide for more detail on how
>to setup the TRBs, but what we have in dwc3 is fine.

OK.

>>>>>>> For #2, it's unlikely that DSTS current frame number will match
>>>>>>> with the
>>>>>>> XferNotReady's frame number. So this check doesn't mean much.
>>>>>> The frame number is also updated for each "Transfer In Progress"
>>>>>> interrupt.
>>>>>> If they match, then there a new request can still be queued
>>>>>> successfully.
>>>>>> Without this I got unnecessary stop/start transfers in the middle
>>>>>> of a
>>>>>> video frame. But maybe something else was wrong here. I'd need to
>>>>>> recheck.
>>>>>
>>>>> The reason they may not match is 1) the frame_number is only updated
>>>>> after the software handles the XferInProgress interrupt. Depends on
>>>>> system latency, that value may not be updated at the time that we
>>>>> check
>>>>> the frame_number.
>>>>> 2) This check doesn't work if the service interval is greater than 1
>>>>> uframe. That is, it doesn't have to match exactly the time to be
>>>>> consider not late. Though, the second reason can easily be fixed.
>>>>
>>>> In the empty trb case, after the Hardware has send enough zero packets
>>>> this
>>>> active transfer has to be stopped with endtransfer cmd. Because every
>>>> next
>>>> update transfer on that active transfer will likely lead to further
>>>> missed
>>>> transfers, as the newly updated trb will be handled to late anyway.
>>>
>>> The controller is expecting the function driver to feed TRBs to the
>>> controller for every interval. If it's late, then the controller will
>>> consider that data "missed_isoc".
>>>
>>> In your case, the UVC driver seems to queue requests to the controller
>>> driver as if it is bulk requests, and the UVC expects those data to go
>>> out at the time it queues. To achieve what UVC needs, then you may want
>>> to issue END_TRANSFER command before the next burst of data. This way,
>>> the controller can restart the isoc endpoint and not consider the next
>>> video frame data late. There are some corner cases that you need to
>>> watch out for. If you're going for this route, we can look further.
>>
>> Right, for now the drivers is doing:
>>
>> - Strart Transfer (with the right frame number) once.
>>
>> - Update Transfer On every ep_queue with the corresponding TRB
>> =A0setting CHN =3D 0, IOC =3D 1, First-ISOC =3D 1
>>
>> - End Transfer is somehow not handled right for this case.
>>
>> See my first comment. I think dwc3_prepare_one_trb_sg does the proper
>> chain
>> handling already.
>>
>>> Also, you'd need provide a way for the UVC to communicate to the dwc3 to
>>> let it know to expect the next burst of data.
>>
>> Can the UVC not just enqueue one big sg-request, which will represent
>> one burst
>> and not one TRB. Also that is=A0 what the SG code already seem to handle
>> right.
>
>Do you need SG? What size does video class driver setup its isoc URB? If
>it's superspeed, max is 48K, and depending on the type of platform
>you're running UVC on, you can setup a single 48K buffer per request if
>you want to do that. However, it's probably not a good idea since many
>host controllers can't even handle even close to 48K/uframe.

We wan't to transfer uncached 4K Video frames via UVC. So Scatter-Gather
is a must anyway.

>What I was saying is if UVC knows when to wait for the next video data,
>it can tell dwc3 to stop the isoc endpoint before queuing the next video
>data in a set of requests. If UVC doesn't know that, then it needs to
>tell dwc3 to change its handling of isoc requests.

In function/gadget/uvc_video.c we take a buffer and pump it into many
available requests as we find. On the way the driver can drain that
video frame queue, in that case we could stop the transfer. I have
prepared a patch where we have only one source, queueing new requests,
so this could work.

For now to limit the interrupt load on the dwc3 driver we already set
the request no_interrupt on every nth request, and make sure the
interrupt is on the very last one of the frame. But with that we still
sometimes run into missed transfers as the queued trb list somehow ends
up with a TRB not having the IOC bit set.

>>>> The odd thing here is, that I don't see the refered XferInProgress
>>>> Interrupts with the missed event, when the started_list is empty.
>>>
>>> See my first comment.
>>>
>>>>
>>>> But this would be the only case to fall into this condition and
>>>> handle it
>>>> properly. Like alredy assumed in the following code:
>>>>
>>>> static void dwc3_gadget_endpoint_transfer_in_progress(struct dwc3_ep
>>>> *dep,
>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 const struct dwc3_event_depevt *e=
vent)
>>>> {
>>>> ...
>>>>
>>>> =A0=A0=A0=A0=A0=A0 if (event->status & DEPEVT_STATUS_MISSED_ISOC) {
>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 status =3D -EXDEV;
>>>>
>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (list_empty(&dep->starte=
d_list))
>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sto=
p =3D true;
>>>> =A0=A0=A0=A0=A0=A0 }
>>>>
>>>> ...
>>>>
>>>> =A0=A0=A0=A0=A0=A0 if (stop)
>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dwc3_stop_active_transfer(d=
ep, true, true);
>>>> ...
>>>> }
>>>>
>>>> In fact I did sometimes see these XferInProgress Interrupts on empty
>>>> trb queue
>>>> after I stoped the tansfer when the started_list was empty right after
>>>> ep_cleanup_completed_requests has moved all trbs out of the queue.
>>>>
>>>> These Interrupts appeared right after the ENDTRANSFER cmd was send.
>>>> (But I
>>>> could no verify this every time)
>>>
>>> If END_TRANSFER command completes, then you should not see
>>> XferInProgress event. The next event should ber XferNotReady.
>>
>> Right. This also stops, after the Command Complete Interrupt arrives.
>>
>>>> Anyways in that case these Interrupts are not useful anymore, as I
>>>> already
>>>> implied the same stop, with ENDTRANSFER after we know that there are
>>>> no other
>>>> trbs in the chain.
>>>>
>>>
>>> Just curious, do you know if there's a reason for UVC to behave this
>>> way? Seems like what it's trying to do is more for bulk. Maybe it wants
>>> bandwidth priority perhaps?
>>
>> I don't know, probably it was more likely for USB 2.0 controllers to
>> be handled
>> this way.
>>
>> As mentioned the current uvc code is also working when we add this
>> changes.
>>
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index ec357f64f319..a5dc44f2e9d8 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -2629,6 +2629,9 @@ static void
>> dwc3_gadget_endpoint_transfer_in_progress(struct dwc3_ep *dep,
>>
>> =A0=A0=A0=A0=A0=A0 dwc3_gadget_ep_cleanup_completed_requests(dep, event,=
 status);
>>
>> +=A0=A0=A0=A0=A0=A0 if (list_empty(&dep->started_list))
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 stop =3D true;
>> +
>
>You should check the pending list too and either drop them or prepare
>those requests (maybe too late). This happens when there's no available
>TRB but UVC queues more requests.
>Also, make sure this change only applies for isoc.

I will send the patches for that so we can discuss the right handling
for that in a separate thread.

>This may work. Just keep in mind that the timing parameter of the
>XferNotReady will be expired by the time the UVC queues the next isoc
>request. (Maybe that's why you tried to check for the current frame
>number via DSTS instead in your first patch?).
>With the new changes in Felipe testing/next branch, this may be ok.
>
>
>> =A0=A0=A0=A0=A0=A0 if (stop)
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dwc3_stop_active_transfer(dep=
, true, true);
>> =A0=A0=A0=A0=A0=A0 else if (dwc3_gadget_ep_should_continue(dep))
>>
>> diff --git a/drivers/usb/gadget/function/uvc_video.c
>> b/drivers/usb/gadget/function/uvc_video.c
>> index da6ba8ba4bca..a3dac5d91aae 100644
>> --- a/drivers/usb/gadget/function/uvc_video.c
>> +++ b/drivers/usb/gadget/function/uvc_video.c
>> @@ -183,6 +183,7 @@ uvc_video_complete(struct usb_ep *ep, struct
>> usb_request *req)
>>
>> =A0=A0=A0=A0=A0=A0 switch (req->status) {
>> =A0=A0=A0=A0=A0=A0 case 0:
>> +=A0=A0=A0=A0=A0=A0 case -EXDEV: /* we ignore missed transfers */
>
>Any time you see missed_isoc, you have data dropped. May want to check
>to see what's going on.

See my comment above.

>> break;
>>
>> =A0=A0=A0=A0=A0=A0 case -ESHUTDOWN:=A0=A0=A0=A0=A0=A0=A0 /* disconnect f=
rom host. */
>>
>>
>
>BR,
>Thinh
>

Regards,
Michael

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--ZoaI/ZTpAVc4A5k6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAl6el+QACgkQC+njFXoe
LGRAVBAApl78v2MM4MgQLf5/z4TttiRTj08slPceiKsUAnqZD/xWJJzGoyDGFs9a
ErpfbBUYDf2821jW2IVmo18gAC7ZAv3si/+qI3AVvzEh6Rnepzg8+hhy6SEvWhZl
udRfykS+l6Dw5TPI3OYRJ7mB1Dw3FzWNyDcanOTzch5Rl2UH3Z+AyqsPjIh+IzCF
yAL1pAhO8iA3WIMuQqi+veEeR1mfP1tJtxJA0t5fGD1kmbJfcnjgMjidg0kBDHJb
7VAtgn66By5xG/M6GOmggPRidousHjG3SdF8ayWIINiRhmApzcYmNMZXuk49Po1w
cJkOdZ57jhT+cYHy6E3jXVIY9VS629lB/4j9x0TgaHuqWUXHMIJBGHugzWtzx0iw
J59/yW/cmfyVXaM7aLghWUnjCtv8IRHk3Xy9i4oR8ty9JEeSk9AVtRPfKjwkivHn
nEUNCLe9fqb+Nu5i/nryiTz0rawPWCuWa8nvYhqVsal8HNKAC5OmImjT44qKZupa
GjClV5rc+i1LQzgZ7NaYRbZ6yv7ON6lmM6s2JR7yC4cJAhHIiHzpPVCUNEMNg2yS
BK3O0t4rBimCuq314KFHEhzwB23/zOorEDf7YnzenctsggCRihAQk7G42/u9Epv9
eIYsOIPsrsX1qkCODnjLe/tpewW6w4BtGE8qqi/QrMsXodhT7Xg=
=CVuG
-----END PGP SIGNATURE-----

--ZoaI/ZTpAVc4A5k6--
