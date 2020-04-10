Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B612C2BB85
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 01:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2012720A8B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 01:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="kss0gaZR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="MPVxx43t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgDJBJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 21:09:37 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:47078 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726327AbgDJBJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 21:09:37 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 81EDFC007F;
        Fri, 10 Apr 2020 01:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1586480976; bh=ijBQ5Ds45kciRGGUWqSgvlmWQv8A29YDBYBtWJqlERw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=kss0gaZRjDMA5fVPXSCyybADNiIWdsj6LWRfGRBb8lWOLM2j8nSpgy12+UcfSQE9u
         qS9Z5UHDds+WqQqARKPPMAz8M/+TaBrtqTEZGFyh7kHxzMn819B6vSAZPU5AvBtWIe
         4vUqtkWxZoZwAX6HPWG2h/Ug3lUF91rSZQBnDrhKVkM9dZl6j2ysjZ3UnceD9k7Nqm
         toJTphep1b3ItCfYMfMMuxu02pmtejU0MN/GZH/IbpJVAIALiBGXv0Qw/s5PY/lYaV
         AemvzmVTk7KITA4THwFNlsI0nJDGnD1IP9GM1ssRyzNUfP9WkSw35IQ/gT1US7efTL
         UTbONvMVnn5oA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id B6793A0067;
        Fri, 10 Apr 2020 01:09:33 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.200.27.51) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 9 Apr 2020 18:09:25 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.200.27.51) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 9 Apr 2020 18:09:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=POauGGNObvhooolEOLQWygzjWg4HXDcy7l+rcKEtiqHdNjkQo9kmBCvHicQjEQQ0vhYvWoBL6rmNIge+veeK36qAT6N1uWD5nuTpkxfWR0uMK0XHEjhOukXi8AlP35k6AV24MQ5fhPFAGp3pdtRf+32rKKB+SkSCn1KiR7Z4GMrXXYZyFAgifv60/AtMKn+yeeHlox3RA1vF5ff56VN/WBdagCMpSvn6+40/0BDid+uag6mNLnFFXQQQIHhElDnQIcTUR7VrgClJj7XsDDfDjwhbNtYSMXVCC7lCS2N9ZPm6vViKxbbDitTBrzcOryabbQuzMFgsb0o7lvfqSqfOOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijBQ5Ds45kciRGGUWqSgvlmWQv8A29YDBYBtWJqlERw=;
 b=FyCjEtU5pLcMA2xnC4ZZlkeIR941GyvjppyzTsMM866T3EiIO1lJ7YlAD+6WG1fd9WbgAHD2gqfSqfwIhpivgbGogBWdQU668Mqc4aDlajQ7S89L1mTEND0NnTaMxahm0dbZlo2C2DzQdfmcpqsAYNZYYGxJ1P/p2/Y7G8iDKEVSKHCExrA+NayE5eudHGwmIkrfYUCRwJ/EzguATR5aIXABeWxGVvhxw0K97DLelYh6P6jrqL1WtyyvpiHYQFSQmkukn02VOjNZL841M9u9f/oHQq7JDI5fwSmGR6U7H1gECax8uuON5Ftb+QfL1Ldon3KLjLZWThXVSARUH9LQwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijBQ5Ds45kciRGGUWqSgvlmWQv8A29YDBYBtWJqlERw=;
 b=MPVxx43t6ltO6Mx1QMAXkbKNTzCE9QS9bNI+4RQUkQbUt2VzLn1SRQlkErRigkU+w7zN+5xOF4T60XiC2LArjl9DBpNhS2A/wa5Eu+sQMFNq24noT9G3//yzlsw6znReDKafMg4UwDQZKmJG+qoIuSSFhoIRSlAiyD1aLs6kfdQ=
Received: from BYAPR12MB2710.namprd12.prod.outlook.com (2603:10b6:a03:68::11)
 by BYAPR12MB3526.namprd12.prod.outlook.com (2603:10b6:a03:13d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.17; Fri, 10 Apr
 2020 01:09:23 +0000
Received: from BYAPR12MB2710.namprd12.prod.outlook.com
 ([fe80::1d05:9263:557d:e8a6]) by BYAPR12MB2710.namprd12.prod.outlook.com
 ([fe80::1d05:9263:557d:e8a6%3]) with mapi id 15.20.2900.015; Fri, 10 Apr 2020
 01:09:23 +0000
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
Thread-Index: AQHVmKSAwOKFEHeaw0mottJUNN0pEqeIevUAgABCiACAAII+gIAAPESAgAEc0ACAAIVuAIDmOjMAgAEfnQA=
Date:   Fri, 10 Apr 2020 01:09:23 +0000
Message-ID: <431d2faa-b073-287c-62ec-557d7d021c48@synopsys.com>
References: <Pine.LNX.4.44L0.1911131036340.1558-100000@iolanthe.rowland.org>
 <587b0adf-b71d-6fde-407b-46089ed5d695@synopsys.com>
 <20191114121422.qtvyom6nytzwoy2e@pengutronix.de>
 <6d4b87c8-5aca-18cb-81db-a8d2fd4bd86e@synopsys.com>
 <20200409075958.GA19563@pengutronix.de>
In-Reply-To: <20200409075958.GA19563@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thinhn@synopsys.com; 
x-originating-ip: [149.117.7.23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 50ce774a-bedf-42e5-1ff3-08d7dcebce50
x-ms-traffictypediagnostic: BYAPR12MB3526:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3526DCD804C4F9F36560D2FEAADE0@BYAPR12MB3526.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0369E8196C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2710.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(376002)(39860400002)(366004)(396003)(136003)(346002)(8936002)(31686004)(81166007)(54906003)(86362001)(4326008)(478600001)(6506007)(36756003)(71200400001)(8676002)(6512007)(66556008)(81156014)(66446008)(2616005)(6486002)(31696002)(5660300002)(66946007)(66476007)(186003)(110136005)(64756008)(2906002)(76116006)(26005)(316002);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YQKRJQiBmpunlUJ0hVacopGfiIq7ISnwYCh52e+N4tkWSOiQoEn4h9aom+n+Eq8kvA0o1/L7NZLyBcTlLHNpH4kKQquhQYekAtZsNQLUG4DNcG1NnO7141eEZ9jj9Fr9Yg9+tNzovrR/wEnLa2gcs/DI2v7BANolEI5eke9nHjWRq9D3yGFDZpdGh8aJ+w7V1wh2en0ArpjXNiwrLKL12ImKykij6zgdH+uZkKueKaKteovper/tMRTh5GxT+pGk/KPucwU/1hmjfeCL9lBHv4uCYaDER4tOk+csk+IQDTCw2+84KcyHut+KXxZdscKj7HQ4PFwuvoyqDUJOq/lSjM2tbErNjqqc188lpQKVBnf1D8T6vc98dOsnsGmFXnXNPU7m3Tw7gDSjyw9KxKgpGc7wHeUEC38mI29yFrn3BqbcjWTCqJIfo6LbTm0wQhHW
x-ms-exchange-antispam-messagedata: qFuZXR4GC2WtmTRDUFlE0IQM957PRBEQiiovj3arjUOYKF/C7i8dsNUH16Ru8oGfPlXPAeaU6DlGg0MiJU+XAitEW+mF/N+VqXdxdMv6pvC4+TbVhaafLRNZR9m/3/OmLMfYGKIKSeoqL/2MLiYQFg==
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <84B48088BF64E44CAFB3371691F74C8A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 50ce774a-bedf-42e5-1ff3-08d7dcebce50
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2020 01:09:23.1038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ewz2Hc4huWacBwyH1Qoz3dA69wzNH23tUyNAtX9Sn7TKV9vRuqxWbs74WvkZ8sT2gFDlzpdFd0inCpaluZF6IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3526
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Michael Grzeschik wrote:
> On Thu, Nov 14, 2019 at 08:11:56PM +0000, Thinh Nguyen wrote:
>> Michael Olbrich wrote:
>>> On Wed, Nov 13, 2019 at 07:14:59PM +0000, Thinh Nguyen wrote:
>>>> Alan Stern wrote:
>>>>> On Wed, 13 Nov 2019, Michael Olbrich wrote:
>>>>>> On Wed, Nov 13, 2019 at 03:55:01AM +0000, Thinh Nguyen wrote:
>>>>>>> Michael Olbrich wrote:
>>>>>>>> Currently, most gadget drivers handle isoc transfers on a best=20
>>>>>>>> effort
>>>>>>>> bases: If the request queue runs empty, then there will simply=20
>>>>>>>> be gaps in
>>>>>>>> the isoc data stream.
>>>>>>>>
>>>>>>>> The UVC gadget depends on this behaviour. It simply provides=20
>>>>>>>> new requests
>>>>>>>> when video frames are available and assumes that they are sent=20
>>>>>>>> as soon as
>>>>>>>> possible.
>>>>>>>>
>>>>>>>> The dwc3 gadget currently works differently: It assumes that=20
>>>>>>>> there is a
>>>>>>>> contiguous stream of requests without any gaps. If a request is=20
>>>>>>>> too late,
>>>>>>>> then it is dropped by the hardware.
>>>>>>>> For the UVC gadget this means that a live stream stops after=20
>>>>>>>> the first
>>>>>>>> frame because all following requests are late.
>>>>>>> Can you explain little more how UVC gadget fails?
>>>>>>> dwc3 controller expects a steady stream of data otherwise it=20
>>>>>>> will result
>>>>>>> in missed_isoc status, and it should be fine as long as new=20
>>>>>>> requests are
>>>>>>> queued. The controller doesn't just drop the request unless=20
>>>>>>> there's some
>>>>>>> other failure.
>>>>>> UVC (with a live stream) does not fill the complete bandwidth of an
>>>>>> isochronous endpoint. Let's assume for the example that one video=20
>>>>>> frame
>>>>>> fills 3 requests. Because it is a live stream, there will be a=20
>>>>>> gap between
>>>>>> video frames. This is unavoidable, especially for compressed=20
>>>>>> video. So the
>>>>>> UVC gadget will have requests for the frame numbers 1 2 3 5 6 7 9=20
>>>>>> 10 11 13 14
>>>>>> 15 and so on.
>>>>>> The dwc3 hardware tries to send those with frame numbers 1 2 3 4=20
>>>>>> 5 6 7 8 9
>>>>>> 10 11 12. So except for the fist few requests, all are late and=20
>>>>>> result in a
>>>>>> missed_isoc. I tried to just ignore the missed_isoc but that did=20
>>>>>> not work
>>>>>> for me. I only received the first frame at the other end.
>>>>>> Maybe I missing something here, i don't have access to the hardware
>>>>>> documentation, so I can only guess from the existing driver.
>>>> The reason I asked is because your patch doesn't seem to address the
>>>> actual issue.
>>>>
>>>> For the 2 checks you do here
>>>> 1. There are currently no requests queued in the hardware
>>>> 2. The current frame number provided by DSTS does not match the frame
>>>> =A0 =A0=A0=A0 number returned by the last transfer.
>>>>
>>>> For #1, it's already done in the dwc3 driver. (check
>>>> dwc3_gadget_endpoint_transfer_in_progress())
>>> But that's only after a isoc_missed occurred. What exactly does that=20
>>> mean?
>>> Was the request transferred or not? My tests suggest that it was not
>>> transferred, so I wanted to catch this before it happens.
>>
>> Missed_isoc status means that the controller did not move all the data
>> in an interval.
>
> I read in some Processor documentation that in case the host tries to
> fetch data from the client and no active TRB (HWO=3D1) is available the
> XferInProgress Interrupt will be produced, with the missed status set.
> This is done because the hardware will produce zero length packets
> on its own, to keep the stream running.

The controller only generates XferInProgress if it had processed a TRB=20
(with specific control bits). For IN direction, if the controller is=20
starved of TRB, it will send a ZLP if the host requests for data.


>
>>>> For #2, it's unlikely that DSTS current frame number will match=20
>>>> with the
>>>> XferNotReady's frame number. So this check doesn't mean much.
>>> The frame number is also updated for each "Transfer In Progress"=20
>>> interrupt.
>>> If they match, then there a new request can still be queued=20
>>> successfully.
>>> Without this I got unnecessary stop/start transfers in the middle of a
>>> video frame. But maybe something else was wrong here. I'd need to=20
>>> recheck.
>>
>> The reason they may not match is 1) the frame_number is only updated
>> after the software handles the XferInProgress interrupt. Depends on
>> system latency, that value may not be updated at the time that we check
>> the frame_number.
>> 2) This check doesn't work if the service interval is greater than 1
>> uframe. That is, it doesn't have to match exactly the time to be
>> consider not late. Though, the second reason can easily be fixed.
>
> In the empty trb case, after the Hardware has send enough zero packets=20
> this
> active transfer has to be stopped with endtransfer cmd. Because every=20
> next
> update transfer on that active transfer will likely lead to further=20
> missed
> transfers, as the newly updated trb will be handled to late anyway.

The controller is expecting the function driver to feed TRBs to the=20
controller for every interval. If it's late, then the controller will=20
consider that data "missed_isoc".

In your case, the UVC driver seems to queue requests to the controller=20
driver as if it is bulk requests, and the UVC expects those data to go=20
out at the time it queues. To achieve what UVC needs, then you may want=20
to issue END_TRANSFER command before the next burst of data. This way,=20
the controller can restart the isoc endpoint and not consider the next=20
video frame data late. There are some corner cases that you need to=20
watch out for. If you're going for this route, we can look further.

Also, you'd need provide a way for the UVC to communicate to the dwc3 to=20
let it know to expect the next burst of data.

>
>
> The odd thing here is, that I don't see the refered XferInProgress
> Interrupts with the missed event, when the started_list is empty.

See my first comment.

>
> But this would be the only case to fall into this condition and handle it
> properly. Like alredy assumed in the following code:
>
> static void dwc3_gadget_endpoint_transfer_in_progress(struct dwc3_ep=20
> *dep,
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 const struct dwc3_event_depevt *even=
t)
> {
> ...
>
> =A0=A0=A0=A0=A0=A0 if (event->status & DEPEVT_STATUS_MISSED_ISOC) {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 status =3D -EXDEV;
>
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (list_empty(&dep->started_l=
ist))
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 stop =
=3D true;
> =A0=A0=A0=A0=A0=A0 }
>
> ...
>
> =A0=A0=A0=A0=A0=A0 if (stop)
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dwc3_stop_active_transfer(dep,=
 true, true);
> ...
> }
>
> In fact I did sometimes see these XferInProgress Interrupts on empty=20
> trb queue
> after I stoped the tansfer when the started_list was empty right after
> ep_cleanup_completed_requests has moved all trbs out of the queue.
>
> These Interrupts appeared right after the ENDTRANSFER cmd was send.=20
> (But I
> could no verify this every time)

If END_TRANSFER command completes, then you should not see=20
XferInProgress event. The next event should ber XferNotReady.

>
> Anyways in that case these Interrupts are not useful anymore, as I=20
> already
> implied the same stop, with ENDTRANSFER after we know that there are=20
> no other
> trbs in the chain.
>

Just curious, do you know if there's a reason for UVC to behave this=20
way? Seems like what it's trying to do is more for bulk. Maybe it wants=20
bandwidth priority perhaps?

BR,
Thinh
