Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFB7C2D0EC
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 01:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B890B206A1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 01:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Tk8q2srF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="TEcpsJVb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgDKBAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 21:00:06 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:60986 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726648AbgDKBAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 21:00:05 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B42564049F;
        Sat, 11 Apr 2020 01:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1586566805; bh=sBz39E51gbnEbRWNxcNPLe16ntkqEknSnhTCz2v4OfA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Tk8q2srFqKN230kWkTf6vjh65uKvnYDw689I/TGdxomlZIN5iHxsgieNTiyibtXOV
         li+ecNns6TP/gfu/503tirZgmGjPDxAMxJZhCUZ+gcmnIB1hKXqupbcG8Io4e8Fld9
         pgyZx4cefNltSxyQBt/lbo+9doDbWhuEiCCZpuSMTUqHIFA93Jw6/7ZBaQSNIcIZF9
         61DJcnsXEbjWFOJ59bFMW46wOXYqF6Ehr6wOft1pwaDnXQhPt6ftJ1uWcASvaJSEhe
         H94ZjqzYKj9N3z27exsUwmTPMKlwNAmQp1CYl0XJ7XgWLVWkWu0HhMqSY1HPB9vsJr
         ZfhSH7ilsaqZA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 3C3F3A006B;
        Sat, 11 Apr 2020 01:00:03 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.200.27.51) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 10 Apr 2020 17:59:50 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.200.27.51) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 10 Apr 2020 17:59:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=amzQLUPJiXW8ftHd2vTfZfvwVvWwQppXIPte24L7K2/yE1eJMDHZPv75ibS2JijGJgTxQa6VXpvhCx5yYd0COwhzyCWFtWEcP1S+V9AWBmr+goqo6+fd9Q6/UizrfQqJ13K6egkUukmXeSVT2wycAceoFob157WaSqtHn0+n6y85EpFqi3GbskqJMgYAin3KQADLtUuAX5nFJ8J/sAzHhSlv0EKbtnv3tbFZeVWWAFb+Xdnl1Nq3oT3uJ4XK8IlGLlOxYnSeFSzyWFmoa2Tq0bwANu96Al2Y1pQJ/YA/a8VKO9T18j4zSBGTxk1e2TuRWihEwoA8bOfeBDAqOTIV0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBz39E51gbnEbRWNxcNPLe16ntkqEknSnhTCz2v4OfA=;
 b=SbaDxJJ84It0sj2TgVkDPHlCRy0oCOSTRJq0HsCWGEzrRRcBwVIcbzSZFAiRDaAcqm++vpsGUWej6/s7E+d+QJPgV5BOyBRnAK/LB6pHrIQFfwDKnPoJdVjTUhGLW+/dGTxYnBkYTpFv0oSymR12hQPybhMATMDb5dV5+Yf8buLcHDSFos/H1RzIJWggso2cMENQ9CZJfwFdlU28WJ5KL5F+8LNBInvmH0Qelww1fQapmMutzJqmDxSXWrxnxNL4dB739TcSz15aqUQQCkyNDxZqjZ2ozeM0zyOJ4H9y4gdVVgJYCx280c+g3T/g5YE8TljHCOa7mMnHVryLBLHsLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBz39E51gbnEbRWNxcNPLe16ntkqEknSnhTCz2v4OfA=;
 b=TEcpsJVbPpcBqzJIVBuuGHw7g5jBQgd02YXH3yvngm/uqJtBj9/PEtos3vbN6+zlW4ajDe3s+NcVjCtbAt68ryKJyWd9I6JZGuEn6NcC8tCOHyQiaMYpG9RADFeSAi/KXomL6B2XGAP3hvOjzXxRShtdUVajslX9+dqCz+SAvEA=
Received: from BYAPR12MB2710.namprd12.prod.outlook.com (2603:10b6:a03:68::11)
 by BYAPR12MB2727.namprd12.prod.outlook.com (2603:10b6:a03:71::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.21; Sat, 11 Apr
 2020 00:59:47 +0000
Received: from BYAPR12MB2710.namprd12.prod.outlook.com
 ([fe80::1d05:9263:557d:e8a6]) by BYAPR12MB2710.namprd12.prod.outlook.com
 ([fe80::1d05:9263:557d:e8a6%3]) with mapi id 15.20.2900.015; Sat, 11 Apr 2020
 00:59:47 +0000
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Michael Grzeschik <mgr@pengutronix.de>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Alan Stern <stern@rowland.harvard.edu>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH 2/2] usb: dwc3: gadget: restart the transfer if a isoc
 request is queued too late
Thread-Topic: [PATCH 2/2] usb: dwc3: gadget: restart the transfer if a isoc
 request is queued too late
Thread-Index: AQHVmKSAwOKFEHeaw0mottJUNN0pEqeIevUAgABCiACAAII+gIAAPESAgAEc0ACAAIVuAIDmOjMAgAEfnQCAAV5tAIAAMTkA
Date:   Sat, 11 Apr 2020 00:59:47 +0000
Message-ID: <295ff41f-f287-e2c8-7c33-1c225e9b76b5@synopsys.com>
References: <Pine.LNX.4.44L0.1911131036340.1558-100000@iolanthe.rowland.org>
 <587b0adf-b71d-6fde-407b-46089ed5d695@synopsys.com>
 <20191114121422.qtvyom6nytzwoy2e@pengutronix.de>
 <6d4b87c8-5aca-18cb-81db-a8d2fd4bd86e@synopsys.com>
 <20200409075958.GA19563@pengutronix.de>
 <431d2faa-b073-287c-62ec-557d7d021c48@synopsys.com>
 <20200410220336.GB19563@pengutronix.de>
In-Reply-To: <20200410220336.GB19563@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thinhn@synopsys.com; 
x-originating-ip: [149.117.7.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64abc784-ce5f-4447-e82e-08d7ddb3a16c
x-ms-traffictypediagnostic: BYAPR12MB2727:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB27278D142289E8DD4886F808AADF0@BYAPR12MB2727.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 03706074BC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2710.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(376002)(396003)(366004)(346002)(39860400002)(136003)(4326008)(8936002)(81156014)(6486002)(186003)(54906003)(316002)(31696002)(110136005)(6506007)(26005)(86362001)(2616005)(2906002)(71200400001)(31686004)(64756008)(30864003)(5660300002)(6512007)(66946007)(66476007)(8676002)(66446008)(36756003)(66556008)(76116006)(478600001);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1L5RsSpEQWLdAxZJOqK3WOHoB+cKbQXBiZ7y44Gqf0BYEbORoGA6RQtHJtuWm1r8KSOhCkihiPMug0hAcNs5DOyUByErezvzx/VqVg0zN4+QOpzUS+z87JJaf8h9P/O6hjo6yZ/4Pjf3Z5DYm97ut2v3Ps+0Ne0JXq2jofmEEyd4SksacM1w6OADQ7c8rHgLcPLygUSpdS4qOHEx1zWa7DMZcvoQf3l3x/q4CuLPgW4fra5QDLGISMpCI2YoYbaku1unCe7HdLz/Fm784rc9xj4v6spGvxxxl1ktNLjr1+MSXUntaM9Ugb0rVeYNocAgTGNbMDKuqzp0HPQpXyylwzSGMQiiVoUhI60pIx1sjbx1wnYJD6SD+BjXrMlzWYN3da0cYJ+oHZdBG9i9MNrYXBgXG30BS6O2V686ftnlkGL4+ycTYTNbbIBtI8qXWs5U
x-ms-exchange-antispam-messagedata: F8nVPOzs3UkeMBTgvhMqBFapjMEOnyidPJO3dccIki4GBIgzYdDLV9yQ2UCzSA+Jv8s/2wxQj2/+mu1raOF81mIx+MAv7khW2Hks5G/VQQojJi3NBMzZ9rcnkNyk0LMU6AAFuFOqglH24SitY5vTUg==
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <2FB54D9C2B37EA41B19298295B270C6C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 64abc784-ce5f-4447-e82e-08d7ddb3a16c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2020 00:59:47.1529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oB3QxfsxU22ZPBhBO49JuMY3NLySFEgt+3hk/omQPdH1hr9tigIBSY/GOJC0JGb8xMuuExPGEnCZxgDzB/ZAnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2727
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Michael Grzeschik wrote:
> On Fri, Apr 10, 2020 at 01:09:23AM +0000, Thinh Nguyen wrote:
>> Hi,
>>
>> Michael Grzeschik wrote:
>>> On Thu, Nov 14, 2019 at 08:11:56PM +0000, Thinh Nguyen wrote:
>>>> Michael Olbrich wrote:
>>>>> On Wed, Nov 13, 2019 at 07:14:59PM +0000, Thinh Nguyen wrote:
>>>>>> Alan Stern wrote:
>>>>>>> On Wed, 13 Nov 2019, Michael Olbrich wrote:
>>>>>>>> On Wed, Nov 13, 2019 at 03:55:01AM +0000, Thinh Nguyen wrote:
>>>>>>>>> Michael Olbrich wrote:
>>>>>>>>>> Currently, most gadget drivers handle isoc transfers on a best
>>>>>>>>>> effort
>>>>>>>>>> bases: If the request queue runs empty, then there will simply
>>>>>>>>>> be gaps in
>>>>>>>>>> the isoc data stream.
>>>>>>>>>>
>>>>>>>>>> The UVC gadget depends on this behaviour. It simply provides
>>>>>>>>>> new requests
>>>>>>>>>> when video frames are available and assumes that they are sent
>>>>>>>>>> as soon as
>>>>>>>>>> possible.
>>>>>>>>>>
>>>>>>>>>> The dwc3 gadget currently works differently: It assumes that
>>>>>>>>>> there is a
>>>>>>>>>> contiguous stream of requests without any gaps. If a request is
>>>>>>>>>> too late,
>>>>>>>>>> then it is dropped by the hardware.
>>>>>>>>>> For the UVC gadget this means that a live stream stops after
>>>>>>>>>> the first
>>>>>>>>>> frame because all following requests are late.
>>>>>>>>> Can you explain little more how UVC gadget fails?
>>>>>>>>> dwc3 controller expects a steady stream of data otherwise it
>>>>>>>>> will result
>>>>>>>>> in missed_isoc status, and it should be fine as long as new
>>>>>>>>> requests are
>>>>>>>>> queued. The controller doesn't just drop the request unless
>>>>>>>>> there's some
>>>>>>>>> other failure.
>>>>>>>> UVC (with a live stream) does not fill the complete bandwidth=20
>>>>>>>> of an
>>>>>>>> isochronous endpoint. Let's assume for the example that one video
>>>>>>>> frame
>>>>>>>> fills 3 requests. Because it is a live stream, there will be a
>>>>>>>> gap between
>>>>>>>> video frames. This is unavoidable, especially for compressed
>>>>>>>> video. So the
>>>>>>>> UVC gadget will have requests for the frame numbers 1 2 3 5 6 7 9
>>>>>>>> 10 11 13 14
>>>>>>>> 15 and so on.
>>>>>>>> The dwc3 hardware tries to send those with frame numbers 1 2 3 4
>>>>>>>> 5 6 7 8 9
>>>>>>>> 10 11 12. So except for the fist few requests, all are late and
>>>>>>>> result in a
>>>>>>>> missed_isoc. I tried to just ignore the missed_isoc but that did
>>>>>>>> not work
>>>>>>>> for me. I only received the first frame at the other end.
>>>>>>>> Maybe I missing something here, i don't have access to the=20
>>>>>>>> hardware
>>>>>>>> documentation, so I can only guess from the existing driver.
>>>>>> The reason I asked is because your patch doesn't seem to address the
>>>>>> actual issue.
>>>>>>
>>>>>> For the 2 checks you do here
>>>>>> 1. There are currently no requests queued in the hardware
>>>>>> 2. The current frame number provided by DSTS does not match the=20
>>>>>> frame
>>>>>> =A0 =A0=A0=A0 number returned by the last transfer.
>>>>>>
>>>>>> For #1, it's already done in the dwc3 driver. (check
>>>>>> dwc3_gadget_endpoint_transfer_in_progress())
>>>>> But that's only after a isoc_missed occurred. What exactly does that
>>>>> mean?
>>>>> Was the request transferred or not? My tests suggest that it was not
>>>>> transferred, so I wanted to catch this before it happens.
>>>>
>>>> Missed_isoc status means that the controller did not move all the data
>>>> in an interval.
>>>
>>> I read in some Processor documentation that in case the host tries to
>>> fetch data from the client and no active TRB (HWO=3D1) is available the
>>> XferInProgress Interrupt will be produced, with the missed status set.
>>> This is done because the hardware will produce zero length packets
>>> on its own, to keep the stream running.
>>
>> The controller only generates XferInProgress if it had processed a TRB
>> (with specific control bits). For IN direction, if the controller is
>> starved of TRB, it will send a ZLP if the host requests for data.
>
> Which control bits are those? ISOC-First, Chain and Last bits?
>
> I see the Scatter-Gather preparation is using these pattern.

The IOC bit. You can check the programming guide for more detail on how=20
to setup the TRBs, but what we have in dwc3 is fine.


>
>>>>>> For #2, it's unlikely that DSTS current frame number will match
>>>>>> with the
>>>>>> XferNotReady's frame number. So this check doesn't mean much.
>>>>> The frame number is also updated for each "Transfer In Progress"
>>>>> interrupt.
>>>>> If they match, then there a new request can still be queued
>>>>> successfully.
>>>>> Without this I got unnecessary stop/start transfers in the middle=20
>>>>> of a
>>>>> video frame. But maybe something else was wrong here. I'd need to
>>>>> recheck.
>>>>
>>>> The reason they may not match is 1) the frame_number is only updated
>>>> after the software handles the XferInProgress interrupt. Depends on
>>>> system latency, that value may not be updated at the time that we=20
>>>> check
>>>> the frame_number.
>>>> 2) This check doesn't work if the service interval is greater than 1
>>>> uframe. That is, it doesn't have to match exactly the time to be
>>>> consider not late. Though, the second reason can easily be fixed.
>>>
>>> In the empty trb case, after the Hardware has send enough zero packets
>>> this
>>> active transfer has to be stopped with endtransfer cmd. Because every
>>> next
>>> update transfer on that active transfer will likely lead to further
>>> missed
>>> transfers, as the newly updated trb will be handled to late anyway.
>>
>> The controller is expecting the function driver to feed TRBs to the
>> controller for every interval. If it's late, then the controller will
>> consider that data "missed_isoc".
>>
>> In your case, the UVC driver seems to queue requests to the controller
>> driver as if it is bulk requests, and the UVC expects those data to go
>> out at the time it queues. To achieve what UVC needs, then you may want
>> to issue END_TRANSFER command before the next burst of data. This way,
>> the controller can restart the isoc endpoint and not consider the next
>> video frame data late. There are some corner cases that you need to
>> watch out for. If you're going for this route, we can look further.
>
> Right, for now the drivers is doing:
>
> - Strart Transfer (with the right frame number) once.
>
> - Update Transfer On every ep_queue with the corresponding TRB
> =A0setting CHN =3D 0, IOC =3D 1, First-ISOC =3D 1
>
> - End Transfer is somehow not handled right for this case.
>
> See my first comment. I think dwc3_prepare_one_trb_sg does the proper=20
> chain
> handling already.
>
>> Also, you'd need provide a way for the UVC to communicate to the dwc3 to
>> let it know to expect the next burst of data.
>
> Can the UVC not just enqueue one big sg-request, which will represent=20
> one burst
> and not one TRB. Also that is=A0 what the SG code already seem to handle=
=20
> right.

Do you need SG? What size does video class driver setup its isoc URB? If=20
it's superspeed, max is 48K, and depending on the type of platform=20
you're running UVC on, you can setup a single 48K buffer per request if=20
you want to do that. However, it's probably not a good idea since many=20
host controllers can't even handle even close to 48K/uframe.

What I was saying is if UVC knows when to wait for the next video data,=20
it can tell dwc3 to stop the isoc endpoint before queuing the next video=20
data in a set of requests. If UVC doesn't know that, then it needs to=20
tell dwc3 to change its handling of isoc requests.

>
>>> The odd thing here is, that I don't see the refered XferInProgress
>>> Interrupts with the missed event, when the started_list is empty.
>>
>> See my first comment.
>>
>>>
>>> But this would be the only case to fall into this condition and=20
>>> handle it
>>> properly. Like alredy assumed in the following code:
>>>
>>> static void dwc3_gadget_endpoint_transfer_in_progress(struct dwc3_ep
>>> *dep,
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 const struct dwc3_event_depevt *ev=
ent)
>>> {
>>> ...
>>>
>>> =A0=A0=A0=A0=A0=A0 if (event->status & DEPEVT_STATUS_MISSED_ISOC) {
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 status =3D -EXDEV;
>>>
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (list_empty(&dep->started=
_list))
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 stop=
 =3D true;
>>> =A0=A0=A0=A0=A0=A0 }
>>>
>>> ...
>>>
>>> =A0=A0=A0=A0=A0=A0 if (stop)
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dwc3_stop_active_transfer(de=
p, true, true);
>>> ...
>>> }
>>>
>>> In fact I did sometimes see these XferInProgress Interrupts on empty
>>> trb queue
>>> after I stoped the tansfer when the started_list was empty right after
>>> ep_cleanup_completed_requests has moved all trbs out of the queue.
>>>
>>> These Interrupts appeared right after the ENDTRANSFER cmd was send.
>>> (But I
>>> could no verify this every time)
>>
>> If END_TRANSFER command completes, then you should not see
>> XferInProgress event. The next event should ber XferNotReady.
>
> Right. This also stops, after the Command Complete Interrupt arrives.
>
>>> Anyways in that case these Interrupts are not useful anymore, as I
>>> already
>>> implied the same stop, with ENDTRANSFER after we know that there are
>>> no other
>>> trbs in the chain.
>>>
>>
>> Just curious, do you know if there's a reason for UVC to behave this
>> way? Seems like what it's trying to do is more for bulk. Maybe it wants
>> bandwidth priority perhaps?
>
> I don't know, probably it was more likely for USB 2.0 controllers to=20
> be handled
> this way.
>
> As mentioned the current uvc code is also working when we add this=20
> changes.
>
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index ec357f64f319..a5dc44f2e9d8 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -2629,6 +2629,9 @@ static void=20
> dwc3_gadget_endpoint_transfer_in_progress(struct dwc3_ep *dep,
>
> =A0=A0=A0=A0=A0=A0 dwc3_gadget_ep_cleanup_completed_requests(dep, event, =
status);
>
> +=A0=A0=A0=A0=A0=A0 if (list_empty(&dep->started_list))
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 stop =3D true;
> +

You should check the pending list too and either drop them or prepare=20
those requests (maybe too late). This happens when there's no available=20
TRB but UVC queues more requests.
Also, make sure this change only applies for isoc.

This may work. Just keep in mind that the timing parameter of the=20
XferNotReady will be expired by the time the UVC queues the next isoc=20
request. (Maybe that's why you tried to check for the current frame=20
number via DSTS instead in your first patch?).
With the new changes in Felipe testing/next branch, this may be ok.


> =A0=A0=A0=A0=A0=A0 if (stop)
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dwc3_stop_active_transfer(dep,=
 true, true);
> =A0=A0=A0=A0=A0=A0 else if (dwc3_gadget_ep_should_continue(dep))
>
> diff --git a/drivers/usb/gadget/function/uvc_video.c=20
> b/drivers/usb/gadget/function/uvc_video.c
> index da6ba8ba4bca..a3dac5d91aae 100644
> --- a/drivers/usb/gadget/function/uvc_video.c
> +++ b/drivers/usb/gadget/function/uvc_video.c
> @@ -183,6 +183,7 @@ uvc_video_complete(struct usb_ep *ep, struct=20
> usb_request *req)
>
> =A0=A0=A0=A0=A0=A0 switch (req->status) {
> =A0=A0=A0=A0=A0=A0 case 0:
> +=A0=A0=A0=A0=A0=A0 case -EXDEV: /* we ignore missed transfers */

Any time you see missed_isoc, you have data dropped. May want to check=20
to see what's going on.

> break;
>
> =A0=A0=A0=A0=A0=A0 case -ESHUTDOWN:=A0=A0=A0=A0=A0=A0=A0 /* disconnect fr=
om host. */
>
>

BR,
Thinh
