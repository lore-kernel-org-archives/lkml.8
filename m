Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766ADC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 23:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B8B920575
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 23:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="aG1s/cll";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="qdzRHu7Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgDUXl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 19:41:29 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:56300 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725850AbgDUXl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 19:41:28 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 4A2B0C0353;
        Tue, 21 Apr 2020 23:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1587512487; bh=Jmd1BtdLL2vch2MTv8avnrSdFNn3tC+lo+/5phpOmkY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=aG1s/cllD2LZazmLrpfe/lzChL7ehM0d+h9SxJfimYYtA279z9M9PpmRi585qRB12
         6USQqrq7gKoqpmsqzSFYq8MFOlT7GSEeGq/jbAjDYZmoeLr+vofC+61GTxL8O3+IrG
         d+U7EB9tH11MWKK1Xw1BgJ37fgGIMFawkQu+4J0NDRr+xXZTYtZuKjwGg3s0QKGhNT
         VgsHsufEkOovB7eh4YLNEzDt0YJD0A7r0SsGdLckcXwDaV7IymALayFIVFEYSigXS7
         03LHhqHrjq3Tsq8OeA92QTMOGDBoVCF9pKWGK1jUoue2rrC1BkDH2y8x+zgjBxaw2X
         IA00QP5QS9Njg==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 4A9D1A0067;
        Tue, 21 Apr 2020 23:41:24 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.200.27.51) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 21 Apr 2020 16:41:07 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.200.27.51) with Microsoft SMTP Server (TLS) id
 14.3.487.0; Tue, 21 Apr 2020 16:41:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8JKpMKne4235pTIaG/+eK7rcmgKDm2LXIWPHYKOsfqIEh6oXbe36OEitLBFmthi64fRKPprkkCfgD5uCUSafqvuRxbGmaqmyjNboxy6K9cLrI5I49kozFGXIM+f5e7EQ61jmknQvTgRBzmZwYafqeVCKFooeW8/bPR9RI5ZQu1ChZob+13BHgn/ixbt6o7Ck5gKwwbdwDmvKxqoJJLvboJY9/QT3nmTfSh2qKQQiWLISQ6VxhLVCOcE0FgV1Z4YTspoef8/7E15iYGaIKl1h4HKDrjjMAlL+aikAODg41yW0gfAzMtCLq9+EfdClQV+RxWUvyFU5/Bfq+vbr1HWqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jmd1BtdLL2vch2MTv8avnrSdFNn3tC+lo+/5phpOmkY=;
 b=LphezCJh8ct3tKjpc8xTccJ8pfsxNjtMqQzYMDElXrR1Te4mxstj/81w6Psm1Cmvf3dG7pTIOhnBV5BNkxN1bQ8f+EyRVV3LzFPxIrtm+POybPssHzSUEvdt2DtbDw436+7hPOfgF1HN8dir8xk+oXMATNzS77V07A2xKqGuNytVbfp1H9fXI4n63lCnHu+8vQoYeGlaVwCvaO14w3BP7r5o58zOCnnnvDZIRB8IXHIUSwDsaevKxbZFaWwixeyUzeczY8twLw2VDGAg/+S2gvzIwkHMD7boqAqB1SzoV/0DLaBAO3UzjGEhMzezHjKF2091dO2jz/V6/hOAN7Pe9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jmd1BtdLL2vch2MTv8avnrSdFNn3tC+lo+/5phpOmkY=;
 b=qdzRHu7ZA3YjQ1BBzEz1QqL13KqzRLuA5FxGp1mzapVipissPIT66y/sRGxXkGjlvy5kPdumpjmaJAl1yWo/cHrCfPTRJsZIGI8CZIdpRWpQQdzK1TbDI3F5TvIK2aF/hYiO9/LGE0FftmcGvBJ9ySsRN8on0ZgjofAGSjb2Mls=
Received: from BYAPR12MB2917.namprd12.prod.outlook.com (2603:10b6:a03:130::14)
 by BYAPR12MB3271.namprd12.prod.outlook.com (2603:10b6:a03:138::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Tue, 21 Apr
 2020 23:41:05 +0000
Received: from BYAPR12MB2917.namprd12.prod.outlook.com
 ([fe80::3860:a61:5aeb:a248]) by BYAPR12MB2917.namprd12.prod.outlook.com
 ([fe80::3860:a61:5aeb:a248%7]) with mapi id 15.20.2921.030; Tue, 21 Apr 2020
 23:41:05 +0000
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
Thread-Index: AQHVmKSAwOKFEHeaw0mottJUNN0pEqeIevUAgABCiACAAII+gIAAPESAgAEc0ACAAIVuAIDmOjMAgAEfnQCAAV5tAIAAMTkAgBAZiYCAARofAA==
Date:   Tue, 21 Apr 2020 23:41:05 +0000
Message-ID: <d87513ec-c429-7ec2-aac7-d54e83a596ab@synopsys.com>
References: <Pine.LNX.4.44L0.1911131036340.1558-100000@iolanthe.rowland.org>
 <587b0adf-b71d-6fde-407b-46089ed5d695@synopsys.com>
 <20191114121422.qtvyom6nytzwoy2e@pengutronix.de>
 <6d4b87c8-5aca-18cb-81db-a8d2fd4bd86e@synopsys.com>
 <20200409075958.GA19563@pengutronix.de>
 <431d2faa-b073-287c-62ec-557d7d021c48@synopsys.com>
 <20200410220336.GB19563@pengutronix.de>
 <295ff41f-f287-e2c8-7c33-1c225e9b76b5@synopsys.com>
 <20200421065118.GB2338@pengutronix.de>
In-Reply-To: <20200421065118.GB2338@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thinhn@synopsys.com; 
x-originating-ip: [149.117.7.23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e966679e-31b4-424b-c28c-08d7e64d757d
x-ms-traffictypediagnostic: BYAPR12MB3271:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB32712B170C003DAFDB0F01DAAAD50@BYAPR12MB3271.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 038002787A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2917.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(39860400002)(136003)(366004)(346002)(396003)(376002)(30864003)(4326008)(66476007)(186003)(31686004)(71200400001)(2616005)(31696002)(76116006)(6512007)(66556008)(64756008)(66446008)(66946007)(6506007)(8936002)(478600001)(54906003)(316002)(36756003)(26005)(8676002)(86362001)(110136005)(5660300002)(81156014)(6486002)(2906002);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZDNP6AQhgldiFMhAWW57GzpF9fOYkF5STHwki00Xp0zcxe/GnM1o6ZWB5FHo5jIxVR9B4LgXMuN5qsXWs/9zc/Kr5KrS4XztrCnvZeOzyjbKvectI4PoQemMhnlLlVPU113APNO5Jx7DX/9DPoCCKxTNDKAANra9BmH97QNl3z9taoRMV7QPzqirwPdM4W3hJW1SvQ7viu/NKH94qJNBHJwO2CUmhUFIB+M65/9gnDrlJ//WVUwBLg4/XiPMFyiqM360DTY5yeQyBnvN7+tiZ8T3VXZMwq5Pcj0a4azevOdDfCPrHlZzjr2UPNfsgmpRC6kA8k3PbUZg7AYJ5e8fMQw+J2G0lapfeRMHa5fqKdr1H9yZfckbFLn0wyHg4W8kbD+jNukUiJ/lWYqf2XvsTV7eyWPuaMqaUlilxs9X0a31fRDYOReQkXGLz9xf0fKG
x-ms-exchange-antispam-messagedata: rosOHx95WHnwe48q3GQzBIkbq1XQL2poSSUeh+sQujH2VTmbcORaCscIeVrCG4sMbJzFKFrvcYkFz2HaCaDACM2vCblThZlNlmn0UqUpfgYgwQ7mIfgGv3fX9mDqLdWQkB9KPpz1WFnI8/XlPIagfQ==
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <79DAD694EFEC9441B492CEB0DB048629@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e966679e-31b4-424b-c28c-08d7e64d757d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2020 23:41:05.2961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XEzZxhC2r9uMzAvYSF/DZ9FHb/+gcZiqL7XsjAOJp2uNX2wcoiEKGfODD1C92EDaTyn4laZoT59npd/LkARI0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3271
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Michael Grzeschik wrote:
> Hi,
>
> On Sat, Apr 11, 2020 at 12:59:47AM +0000, Thinh Nguyen wrote:
>> Hi,
>>
>> Michael Grzeschik wrote:
>>> On Fri, Apr 10, 2020 at 01:09:23AM +0000, Thinh Nguyen wrote:
>>>> Hi,
>>>>
>>>> Michael Grzeschik wrote:
>>>>> On Thu, Nov 14, 2019 at 08:11:56PM +0000, Thinh Nguyen wrote:
>>>>>> Michael Olbrich wrote:
>>>>>>> On Wed, Nov 13, 2019 at 07:14:59PM +0000, Thinh Nguyen wrote:
>>>>>>>> Alan Stern wrote:
>>>>>>>>> On Wed, 13 Nov 2019, Michael Olbrich wrote:
>>>>>>>>>> On Wed, Nov 13, 2019 at 03:55:01AM +0000, Thinh Nguyen wrote:
>>>>>>>>>>> Michael Olbrich wrote:
>>>>>>>>>>>> Currently, most gadget drivers handle isoc transfers on a best
>>>>>>>>>>>> effort
>>>>>>>>>>>> bases: If the request queue runs empty, then there will simply
>>>>>>>>>>>> be gaps in
>>>>>>>>>>>> the isoc data stream.
>>>>>>>>>>>>
>>>>>>>>>>>> The UVC gadget depends on this behaviour. It simply provides
>>>>>>>>>>>> new requests
>>>>>>>>>>>> when video frames are available and assumes that they are sent
>>>>>>>>>>>> as soon as
>>>>>>>>>>>> possible.
>>>>>>>>>>>>
>>>>>>>>>>>> The dwc3 gadget currently works differently: It assumes that
>>>>>>>>>>>> there is a
>>>>>>>>>>>> contiguous stream of requests without any gaps. If a=20
>>>>>>>>>>>> request is
>>>>>>>>>>>> too late,
>>>>>>>>>>>> then it is dropped by the hardware.
>>>>>>>>>>>> For the UVC gadget this means that a live stream stops after
>>>>>>>>>>>> the first
>>>>>>>>>>>> frame because all following requests are late.
>>>>>>>>>>> Can you explain little more how UVC gadget fails?
>>>>>>>>>>> dwc3 controller expects a steady stream of data otherwise it
>>>>>>>>>>> will result
>>>>>>>>>>> in missed_isoc status, and it should be fine as long as new
>>>>>>>>>>> requests are
>>>>>>>>>>> queued. The controller doesn't just drop the request unless
>>>>>>>>>>> there's some
>>>>>>>>>>> other failure.
>>>>>>>>>> UVC (with a live stream) does not fill the complete bandwidth
>>>>>>>>>> of an
>>>>>>>>>> isochronous endpoint. Let's assume for the example that one=20
>>>>>>>>>> video
>>>>>>>>>> frame
>>>>>>>>>> fills 3 requests. Because it is a live stream, there will be a
>>>>>>>>>> gap between
>>>>>>>>>> video frames. This is unavoidable, especially for compressed
>>>>>>>>>> video. So the
>>>>>>>>>> UVC gadget will have requests for the frame numbers 1 2 3 5 6=20
>>>>>>>>>> 7 9
>>>>>>>>>> 10 11 13 14
>>>>>>>>>> 15 and so on.
>>>>>>>>>> The dwc3 hardware tries to send those with frame numbers 1 2 3 4
>>>>>>>>>> 5 6 7 8 9
>>>>>>>>>> 10 11 12. So except for the fist few requests, all are late and
>>>>>>>>>> result in a
>>>>>>>>>> missed_isoc. I tried to just ignore the missed_isoc but that did
>>>>>>>>>> not work
>>>>>>>>>> for me. I only received the first frame at the other end.
>>>>>>>>>> Maybe I missing something here, i don't have access to the
>>>>>>>>>> hardware
>>>>>>>>>> documentation, so I can only guess from the existing driver.
>>>>>>>> The reason I asked is because your patch doesn't seem to=20
>>>>>>>> address the
>>>>>>>> actual issue.
>>>>>>>>
>>>>>>>> For the 2 checks you do here
>>>>>>>> 1. There are currently no requests queued in the hardware
>>>>>>>> 2. The current frame number provided by DSTS does not match the
>>>>>>>> frame
>>>>>>>> =A0 =A0=A0=A0 number returned by the last transfer.
>>>>>>>>
>>>>>>>> For #1, it's already done in the dwc3 driver. (check
>>>>>>>> dwc3_gadget_endpoint_transfer_in_progress())
>>>>>>> But that's only after a isoc_missed occurred. What exactly does=20
>>>>>>> that
>>>>>>> mean?
>>>>>>> Was the request transferred or not? My tests suggest that it was=20
>>>>>>> not
>>>>>>> transferred, so I wanted to catch this before it happens.
>>>>>>
>>>>>> Missed_isoc status means that the controller did not move all the=20
>>>>>> data
>>>>>> in an interval.
>>>>>
>>>>> I read in some Processor documentation that in case the host tries to
>>>>> fetch data from the client and no active TRB (HWO=3D1) is available t=
he
>>>>> XferInProgress Interrupt will be produced, with the missed status=20
>>>>> set.
>>>>> This is done because the hardware will produce zero length packets
>>>>> on its own, to keep the stream running.
>>>>
>>>> The controller only generates XferInProgress if it had processed a TRB
>>>> (with specific control bits). For IN direction, if the controller is
>>>> starved of TRB, it will send a ZLP if the host requests for data.
>>>
>>> Which control bits are those? ISOC-First, Chain and Last bits?
>>>
>>> I see the Scatter-Gather preparation is using these pattern.
>>
>> The IOC bit. You can check the programming guide for more detail on how
>> to setup the TRBs, but what we have in dwc3 is fine.
>
> OK.
>
>>>>>>>> For #2, it's unlikely that DSTS current frame number will match
>>>>>>>> with the
>>>>>>>> XferNotReady's frame number. So this check doesn't mean much.
>>>>>>> The frame number is also updated for each "Transfer In Progress"
>>>>>>> interrupt.
>>>>>>> If they match, then there a new request can still be queued
>>>>>>> successfully.
>>>>>>> Without this I got unnecessary stop/start transfers in the middle
>>>>>>> of a
>>>>>>> video frame. But maybe something else was wrong here. I'd need to
>>>>>>> recheck.
>>>>>>
>>>>>> The reason they may not match is 1) the frame_number is only updated
>>>>>> after the software handles the XferInProgress interrupt. Depends on
>>>>>> system latency, that value may not be updated at the time that we
>>>>>> check
>>>>>> the frame_number.
>>>>>> 2) This check doesn't work if the service interval is greater than 1
>>>>>> uframe. That is, it doesn't have to match exactly the time to be
>>>>>> consider not late. Though, the second reason can easily be fixed.
>>>>>
>>>>> In the empty trb case, after the Hardware has send enough zero=20
>>>>> packets
>>>>> this
>>>>> active transfer has to be stopped with endtransfer cmd. Because every
>>>>> next
>>>>> update transfer on that active transfer will likely lead to further
>>>>> missed
>>>>> transfers, as the newly updated trb will be handled to late anyway.
>>>>
>>>> The controller is expecting the function driver to feed TRBs to the
>>>> controller for every interval. If it's late, then the controller will
>>>> consider that data "missed_isoc".
>>>>
>>>> In your case, the UVC driver seems to queue requests to the controller
>>>> driver as if it is bulk requests, and the UVC expects those data to go
>>>> out at the time it queues. To achieve what UVC needs, then you may=20
>>>> want
>>>> to issue END_TRANSFER command before the next burst of data. This way,
>>>> the controller can restart the isoc endpoint and not consider the next
>>>> video frame data late. There are some corner cases that you need to
>>>> watch out for. If you're going for this route, we can look further.
>>>
>>> Right, for now the drivers is doing:
>>>
>>> - Strart Transfer (with the right frame number) once.
>>>
>>> - Update Transfer On every ep_queue with the corresponding TRB
>>> =A0setting CHN =3D 0, IOC =3D 1, First-ISOC =3D 1
>>>
>>> - End Transfer is somehow not handled right for this case.
>>>
>>> See my first comment. I think dwc3_prepare_one_trb_sg does the proper
>>> chain
>>> handling already.
>>>
>>>> Also, you'd need provide a way for the UVC to communicate to the=20
>>>> dwc3 to
>>>> let it know to expect the next burst of data.
>>>
>>> Can the UVC not just enqueue one big sg-request, which will represent
>>> one burst
>>> and not one TRB. Also that is=A0 what the SG code already seem to handl=
e
>>> right.
>>
>> Do you need SG? What size does video class driver setup its isoc URB? If
>> it's superspeed, max is 48K, and depending on the type of platform
>> you're running UVC on, you can setup a single 48K buffer per request if
>> you want to do that. However, it's probably not a good idea since many
>> host controllers can't even handle even close to 48K/uframe.
>
> We wan't to transfer uncached 4K Video frames via UVC. So Scatter-Gather
> is a must anyway.
>
>> What I was saying is if UVC knows when to wait for the next video data,
>> it can tell dwc3 to stop the isoc endpoint before queuing the next video
>> data in a set of requests. If UVC doesn't know that, then it needs to
>> tell dwc3 to change its handling of isoc requests.
>
> In function/gadget/uvc_video.c we take a buffer and pump it into many
> available requests as we find. On the way the driver can drain that
> video frame queue, in that case we could stop the transfer. I have
> prepared a patch where we have only one source, queueing new requests,
> so this could work.
>
> For now to limit the interrupt load on the dwc3 driver we already set
> the request no_interrupt on every nth request, and make sure the
> interrupt is on the very last one of the frame. But with that we still
> sometimes run into missed transfers as the queued trb list somehow ends
> up with a TRB not having the IOC bit set.
>
>>>>> The odd thing here is, that I don't see the refered XferInProgress
>>>>> Interrupts with the missed event, when the started_list is empty.
>>>>
>>>> See my first comment.
>>>>
>>>>>
>>>>> But this would be the only case to fall into this condition and
>>>>> handle it
>>>>> properly. Like alredy assumed in the following code:
>>>>>
>>>>> static void dwc3_gadget_endpoint_transfer_in_progress(struct dwc3_ep
>>>>> *dep,
>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 const struct dwc3_event_depevt *=
event)
>>>>> {
>>>>> ...
>>>>>
>>>>> =A0=A0=A0=A0=A0=A0 if (event->status & DEPEVT_STATUS_MISSED_ISOC) {
>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 status =3D -EXDEV;
>>>>>
>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (list_empty(&dep->start=
ed_list))
>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st=
op =3D true;
>>>>> =A0=A0=A0=A0=A0=A0 }
>>>>>
>>>>> ...
>>>>>
>>>>> =A0=A0=A0=A0=A0=A0 if (stop)
>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dwc3_stop_active_transfer(=
dep, true, true);
>>>>> ...
>>>>> }
>>>>>
>>>>> In fact I did sometimes see these XferInProgress Interrupts on empty
>>>>> trb queue
>>>>> after I stoped the tansfer when the started_list was empty right=20
>>>>> after
>>>>> ep_cleanup_completed_requests has moved all trbs out of the queue.
>>>>>
>>>>> These Interrupts appeared right after the ENDTRANSFER cmd was send.
>>>>> (But I
>>>>> could no verify this every time)
>>>>
>>>> If END_TRANSFER command completes, then you should not see
>>>> XferInProgress event. The next event should ber XferNotReady.
>>>
>>> Right. This also stops, after the Command Complete Interrupt arrives.
>>>
>>>>> Anyways in that case these Interrupts are not useful anymore, as I
>>>>> already
>>>>> implied the same stop, with ENDTRANSFER after we know that there are
>>>>> no other
>>>>> trbs in the chain.
>>>>>
>>>>
>>>> Just curious, do you know if there's a reason for UVC to behave this
>>>> way? Seems like what it's trying to do is more for bulk. Maybe it=20
>>>> wants
>>>> bandwidth priority perhaps?
>>>
>>> I don't know, probably it was more likely for USB 2.0 controllers to
>>> be handled
>>> this way.
>>>
>>> As mentioned the current uvc code is also working when we add this
>>> changes.
>>>
>>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>>> index ec357f64f319..a5dc44f2e9d8 100644
>>> --- a/drivers/usb/dwc3/gadget.c
>>> +++ b/drivers/usb/dwc3/gadget.c
>>> @@ -2629,6 +2629,9 @@ static void
>>> dwc3_gadget_endpoint_transfer_in_progress(struct dwc3_ep *dep,
>>>
>>> =A0=A0=A0=A0=A0=A0 dwc3_gadget_ep_cleanup_completed_requests(dep, event=
, status);
>>>
>>> +=A0=A0=A0=A0=A0=A0 if (list_empty(&dep->started_list))
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 stop =3D true;
>>> +
>>
>> You should check the pending list too and either drop them or prepare
>> those requests (maybe too late). This happens when there's no available
>> TRB but UVC queues more requests.
>> Also, make sure this change only applies for isoc.
>
> I will send the patches for that so we can discuss the right handling
> for that in a separate thread.

Sure, we can review further then.

BR,
Thinh
