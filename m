Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0608BC2BB54
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 08:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C19C220692
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 08:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgDIIAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 04:00:09 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39571 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgDIIAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 04:00:09 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1jMS6T-0006EN-Mb; Thu, 09 Apr 2020 10:00:01 +0200
Received: from mgr by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1jMS6R-0003eZ-0g; Thu, 09 Apr 2020 09:59:59 +0200
Date:   Thu, 9 Apr 2020 09:59:58 +0200
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
Message-ID: <20200409075958.GA19563@pengutronix.de>
References: <Pine.LNX.4.44L0.1911131036340.1558-100000@iolanthe.rowland.org>
 <587b0adf-b71d-6fde-407b-46089ed5d695@synopsys.com>
 <20191114121422.qtvyom6nytzwoy2e@pengutronix.de>
 <6d4b87c8-5aca-18cb-81db-a8d2fd4bd86e@synopsys.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <6d4b87c8-5aca-18cb-81db-a8d2fd4bd86e@synopsys.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:31:45 up 49 days, 15:02, 84 users,  load average: 0.19, 0.23,
 0.17
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2019 at 08:11:56PM +0000, Thinh Nguyen wrote:
>Michael Olbrich wrote:
>> On Wed, Nov 13, 2019 at 07:14:59PM +0000, Thinh Nguyen wrote:
>>> Alan Stern wrote:
>>>> On Wed, 13 Nov 2019, Michael Olbrich wrote:
>>>>> On Wed, Nov 13, 2019 at 03:55:01AM +0000, Thinh Nguyen wrote:
>>>>>> Michael Olbrich wrote:
>>>>>>> Currently, most gadget drivers handle isoc transfers on a best effo=
rt
>>>>>>> bases: If the request queue runs empty, then there will simply be g=
aps in
>>>>>>> the isoc data stream.
>>>>>>>
>>>>>>> The UVC gadget depends on this behaviour. It simply provides new re=
quests
>>>>>>> when video frames are available and assumes that they are sent as s=
oon as
>>>>>>> possible.
>>>>>>>
>>>>>>> The dwc3 gadget currently works differently: It assumes that there =
is a
>>>>>>> contiguous stream of requests without any gaps. If a request is too=
 late,
>>>>>>> then it is dropped by the hardware.
>>>>>>> For the UVC gadget this means that a live stream stops after the fi=
rst
>>>>>>> frame because all following requests are late.
>>>>>> Can you explain little more how UVC gadget fails?
>>>>>> dwc3 controller expects a steady stream of data otherwise it will re=
sult
>>>>>> in missed_isoc status, and it should be fine as long as new requests=
 are
>>>>>> queued. The controller doesn't just drop the request unless there's =
some
>>>>>> other failure.
>>>>> UVC (with a live stream) does not fill the complete bandwidth of an
>>>>> isochronous endpoint. Let's assume for the example that one video fra=
me
>>>>> fills 3 requests. Because it is a live stream, there will be a gap be=
tween
>>>>> video frames. This is unavoidable, especially for compressed video. S=
o the
>>>>> UVC gadget will have requests for the frame numbers 1 2 3 5 6 7 9 10 =
11 13 14
>>>>> 15 and so on.
>>>>> The dwc3 hardware tries to send those with frame numbers 1 2 3 4 5 6 =
7 8 9
>>>>> 10 11 12. So except for the fist few requests, all are late and resul=
t in a
>>>>> missed_isoc. I tried to just ignore the missed_isoc but that did not =
work
>>>>> for me. I only received the first frame at the other end.
>>>>> Maybe I missing something here, i don't have access to the hardware
>>>>> documentation, so I can only guess from the existing driver.
>>> The reason I asked is because your patch doesn't seem to address the
>>> actual issue.
>>>
>>> For the 2 checks you do here
>>> 1. There are currently no requests queued in the hardware
>>> 2. The current frame number provided by DSTS does not match the frame
>>>   =A0=A0=A0 number returned by the last transfer.
>>>
>>> For #1, it's already done in the dwc3 driver. (check
>>> dwc3_gadget_endpoint_transfer_in_progress())
>> But that's only after a isoc_missed occurred. What exactly does that mea=
n?
>> Was the request transferred or not? My tests suggest that it was not
>> transferred, so I wanted to catch this before it happens.
>
>Missed_isoc status means that the controller did not move all the data
>in an interval.

I read in some Processor documentation that in case the host tries to
fetch data from the client and no active TRB (HWO=3D1) is available the
XferInProgress Interrupt will be produced, with the missed status set.
This is done because the hardware will produce zero length packets
on its own, to keep the stream running.

>>> For #2, it's unlikely that DSTS current frame number will match with the
>>> XferNotReady's frame number. So this check doesn't mean much.
>> The frame number is also updated for each "Transfer In Progress" interru=
pt.
>> If they match, then there a new request can still be queued successfully.
>> Without this I got unnecessary stop/start transfers in the middle of a
>> video frame. But maybe something else was wrong here. I'd need to rechec=
k.
>
>The reason they may not match is 1) the frame_number is only updated
>after the software handles the XferInProgress interrupt. Depends on
>system latency, that value may not be updated at the time that we check
>the frame_number.
>2) This check doesn't work if the service interval is greater than 1
>uframe. That is, it doesn't have to match exactly the time to be
>consider not late. Though, the second reason can easily be fixed.

In the empty trb case, after the Hardware has send enough zero packets this
active transfer has to be stopped with endtransfer cmd. Because every next
update transfer on that active transfer will likely lead to further missed
transfers, as the newly updated trb will be handled to late anyway.

The odd thing here is, that I don't see the refered XferInProgress
Interrupts with the missed event, when the started_list is empty.

But this would be the only case to fall into this condition and handle it
properly. Like alredy assumed in the following code:

static void dwc3_gadget_endpoint_transfer_in_progress(struct dwc3_ep *dep,
              const struct dwc3_event_depevt *event)
{
=2E..

        if (event->status & DEPEVT_STATUS_MISSED_ISOC) {
                status =3D -EXDEV;

                if (list_empty(&dep->started_list))
                        stop =3D true;
        }

=2E..

        if (stop)
                dwc3_stop_active_transfer(dep, true, true);
=2E..
}

In fact I did sometimes see these XferInProgress Interrupts on empty trb qu=
eue
after I stoped the tansfer when the started_list was empty right after
ep_cleanup_completed_requests has moved all trbs out of the queue.

These Interrupts appeared right after the ENDTRANSFER cmd was send. (But I
could no verify this every time)

Anyways in that case these Interrupts are not useful anymore, as I already
implied the same stop, with ENDTRANSFER after we know that there are no oth=
er
trbs in the chain.

Regards,
Michael

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAl6O1fwACgkQC+njFXoe
LGTLTA//ahPg+KMjDckzq+GVLcakrCIvEgV9aUqdBgIBxqONOLRE2OkCWVxs/ZEt
y4NZWjz0ywSdoetbJEyMtXwU67OiEeQwFBqvhi0jhVeIQAy7y9K5NdGIrsCYzybK
SilCkAHUE/kfqH8J9RUNwpINBtSpzz7Y2gc2NbSWXWUzToJ0/RbsIgORUgI34fDO
MK84d63dD37dmZT8l7VWP3qzibCOBYJjJwdjC9h+NUfql2HTgpMYd/CEot48zS4V
33uOHHHjLaAjL1Ei38oold7Q01YXb93DGJ1QJvB6XvaGM7SKGSNiaYoESh55sy6z
4v2go0OOkJb93Se2pp0i0wUnKuthsd51oJmcaXXkgXL9F/LML0/EdmH+hT/5hVBd
teoRUuHJUYxXs55Z17AS2k5GlgBbOrcpZ9OdAWNKswWPZ3HQCsNUC2h6h1PouQk2
RDUP+/GX+gPxnsUoYq2mVyxYbqbvo+Y1mvZsszIKp/D3EZupOD2xs0MIOLJNB7Tk
g+BF+IlXcVvB2woTnsQWByhphOySsMVxv6ebtJWoqp2eFBc9me9ROwB82pP3zpIR
z0G7Zwq3w/DXi0JZfd/g7Xkl+y85SXCneSbx6NY/URlGoZ52O6ID+FmmEI5jDVon
piB2KMeOlYh92ARMqBmmEmw+zklPVFcf5+T1MpHJGCt4/j1dyVQ=
=b69V
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
