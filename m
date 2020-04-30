Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1ADC47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 15:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0437920661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 15:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=displaylink.com header.i=@displaylink.com header.b="FhOI4gJ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbgD3Pe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 11:34:59 -0400
Received: from eu-smtp-delivery-167.mimecast.com ([146.101.78.167]:22924 "EHLO
        eu-smtp-delivery-167.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726344AbgD3Pe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 11:34:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=displaylink.com;
        s=mimecast20151025; t=1588260894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y3BguGM6PLiAk86iz2Y+N5eMP7Ykk39zuxdLNRGAzX4=;
        b=FhOI4gJ7GWyAklLbgD3g6+BnovtPn1lvJ0CzT12oONry9S6YQoAdb01Y7pNfO1LQJjEgb5
        yBtvQhEziSEEQ//x/90Y+/tpAMJ8TfUA8VN8GuAGGGSW6cGTxdTfxdTaz4ATkHxPXUvYut
        PNZRCFJ78CXlyny3PMAPMGPsP5j8MlQ=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2058.outbound.protection.outlook.com [104.47.14.58]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-151-8PivuP0OOi-6bY-zvSmz-w-1; Thu, 30 Apr 2020 16:34:52 +0100
X-MC-Unique: 8PivuP0OOi-6bY-zvSmz-w-1
Received: from VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:64::13) by VI1PR1001MB1037.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:66::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Thu, 30 Apr
 2020 15:34:51 +0000
Received: from VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8cba:c335:a57e:9dfd]) by VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8cba:c335:a57e:9dfd%5]) with mapi id 15.20.2937.028; Thu, 30 Apr 2020
 15:34:50 +0000
Subject: Re: [External] Re: [PATCH v5 5/8] usb: mausb_host: Introduce PAL
 processing
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, mausb-host-devel@displaylink.com
References: <Pine.LNX.4.44L0.2004301112390.27217-100000@netrider.rowland.org>
From:   Vladimir Stankovic <vladimir.stankovic@displaylink.com>
Message-ID: <32cc80c0-c2ff-440c-7505-e848aba782d8@displaylink.com>
Date:   Thu, 30 Apr 2020 17:34:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <Pine.LNX.4.44L0.2004301112390.27217-100000@netrider.rowland.org>
Content-Language: en-US
X-ClientProxiedBy: LO2P265CA0456.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::36) To VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:64::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.101] (94.189.199.177) by LO2P265CA0456.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:e::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend Transport; Thu, 30 Apr 2020 15:34:50 +0000
X-Originating-IP: [94.189.199.177]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e78a8e3-ef94-4f22-7377-08d7ed1c05ad
X-MS-TrafficTypeDiagnostic: VI1PR1001MB1037:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR1001MB1037DCDE5D1CD4A360C9E79791AA0@VI1PR1001MB1037.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0389EDA07F
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(396003)(346002)(39840400004)(136003)(16526019)(186003)(52116002)(6486002)(107886003)(5660300002)(66476007)(66946007)(8676002)(66556008)(31696002)(86362001)(316002)(8936002)(478600001)(16576012)(6916009)(2906002)(956004)(44832011)(4326008)(36756003)(26005)(31686004)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aCqno4E7T0nF7ukfqxf4HB8bA1BRfoAE51uch9p7VFfseqqpQOnZCHAoKRPN4xxyl1MOdGJqjFDA2/JrSUS5G6JM+mPuP75Xypl9vMmKBL/GWfSz8ztXAih3SNYWf/r73bJMQLNm5aztqrozRI49jzxGw32wf0xGYzlBJy3i8Nc8XPGSuR1PHTznFnqzMrlf5bCiGwWoyMf560tWEWLibmHtAsNQXOorSLxBWzJiPOraDlybQykRDFlwpjn7qYH46criEWnOuITuNoZ9bMW1Y/TZfFPaxMlDDR5Z3ajIFseak0rEe2ErJdT35vPA3eqBoaEEFYtC5F9/f4r0VwzIQvf1lo641NOimelKNSaA+89RF8pbqkao/Vvxb5VmLtWr3xyezpqA2359z6ywOw6ckSCqjnT0Oq0H+aVJuJui/zZ4fcTurAO0q46aroou6Jas
X-MS-Exchange-AntiSpam-MessageData: B/fks0EhqvwBPXEkzyp5qhox49+nfVpLHiQXOF1P9YmuXUiYUs5nfYph1rUqYRblacEnSAa+J+3iA1mQOm0ZCNa6oOcn1qD6uvr1VuksVqoJU8kEt3WjMqQiTUai94KjtMHR9JcyCbQSo08BWIs3pMqEAKxpkV0LNdLHpcUJgdDIuTTEF7Z3PSKmelT9E3Gesje99B29TRFYMH/pwp+S+SDJ+ME0K7yzgpgPNF5NFv4+u2153w+wNckh37DWb9qHc+6beOz2QAW6YNCmrCnInN/XOLgsN6R9DaBTZc0gtCLr1dpjPnNpRdAnQctpGv+gmXQz+Yr0ivSXaO4oCDZJMmfbxJL0I5RJV3yjCtPY1YJfOPN8ZDBq/U+aRtoIi7z2e7xK1nD1vLkHAOYlyop4VXiyRM2ZJe12V1L5LD0Dwb/T6ETWvEYosEzsikSf5RQJ7yL4Mz80Phzad/UiUElaQ0EeOqs5jq4Ugg1wqZ+TOQhTLvhZk/pbGCoEk0dq5sAfIIpIGNUeQGDh5ILFkNnQvV17FcWFdIVaXWGH3NW/s7qcKhm+nQjRxESVLO7O3K5W6r4wxZ6q5k/eHIk8L0BvUuUpfhy0yTRj5hDAiM6tUqZXJN291vr9TvWYBhm8GV8jlE4ymYz6mfLv66+uXiK5hwlwQE5zsLSw0FcNRT7OyFdKw7cSRWAJrFOxMh+jO22T0KOtvvprbkl8wwwnA9gICSmsNsBEFhT/4iBUChzoQC2N7A0C1GC/c5KPm2gYySL4+dXMkN7xfU20tS+AgC0oRdMk3JEOaMsHR6/M+4OdUAg=
X-OriginatorOrg: displaylink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e78a8e3-ef94-4f22-7377-08d7ed1c05ad
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 15:34:50.8074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4bda75a-b444-4312-9c90-44a7c4b2c91a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JODNP2QVS300ellBOO54cIHVt9NTryNMR+4f5M78hG0H9alASCzqvG1u/8XqU/bC06+uR8qgw7r8oi6TCZIs9wC5wh02P8Ur8TS8QVghPmBAbswJ6K6dYAieQu9/RJuc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR1001MB1037
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: displaylink.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.4.20. 17:18, Alan Stern wrote:
> On Thu, 30 Apr 2020, Vladimir Stankovic wrote:
>=20
>> On 26.4.20. 22:56, Alan Stern wrote:
>>> On Sun, 26 Apr 2020, Vladimir Stankovic wrote:
>>>
>>>> On 26.4.20. 16:31, Alan Stern wrote:
>>>>> On Sun, 26 Apr 2020, Vladimir Stankovic wrote:
>>>>>
>>>>>> On 26.4.20. 02:32, Alan Stern wrote:
>>>>>>> On Sat, 25 Apr 2020 vladimir.stankovic@displaylink.com wrote:
>>>>>>>
>>>>>>>> Protocol adaptation layer (PAL) implementation has been added to
>>>>>>>> introduce MA-USB structures and logic.
>>>>>>>>
>>>>>>>> Signed-off-by: Vladimir Stankovic <vladimir.stankovic@displaylink.=
com>
>>>>>>>
>>>>>>> ...
>>>>>>>
>>>>>>>> +=09/*
>>>>>>>> +=09 * Masking URB_SHORT_NOT_OK flag as SCSI driver is adding it w=
here it
>>>>>>>> +=09 * should not, so it is breaking the USB drive on the linux
>>>>>>>> +=09 */
>>>>>>>> +=09urb->transfer_flags &=3D ~URB_SHORT_NOT_OK;
>=20
> ...
>=20
>>> Okay.  What SCSI driver does the comment refer to?  Is it something=20
>>> internal to DisplayLink or is it part of the regular Linux kernel?
>>>
>>> Alan Stern
>>>
>> Hi,
>>
>> Comment was related to the SCSI driver that's part of regular Linux kern=
el -
>> once the remote USB flash drive gets enumerated by host, it would appear=
 as
>> directly attached to host and then handled by the kernel.
>>
>> With current implementation, following messages are being logged:
>>
>> scsi 3:0:0:0: Direct-Access     Kingston DataTraveler 3.0 PMAP PQ: 0 ANS=
I: 6
>> sd 3:0:0:0: Attached scsi generic sg2 type 0
>>
>> after which the flash drive is usable/accessible from host side.
>=20
> More context please.  Without the log messages preceding this one we=20
> can't tell whether the device is using the usb-storage driver or the=20
> uas driver.
>=20
> Also, what makes you think the driver is setting the SHORT_NOT_OK flag
> at the wrong time?  In fact, how can there be a wrong time? =20
> SHORT_NOT_OK is a valid flag to use with any control or bulk URB.
>=20
> Alan Stern
>=20
The comment is clearly wrong - as mentioned earlier, this fix was added in =
early
development phase and I guess that implementer was not clear on how the par=
ticular
flag was added. Investigation is ongoing around proper fix for this.

Anyhow, it is a usb-storage driver related to this - here is usb-related lo=
g snippet:

usb 3-1.1.2: new high-speed USB device number 5 using mausb_host_hcd_dev
usb 3-1.1.2: New USB device found, idVendor=3D0951, idProduct=3D1666
usb 3-1.1.2: New USB device strings: Mfr=3D1, Product=3D2, SerialNumber=3D3
usb 3-1.1.2: Product: DataTraveler 3.0
usb 3-1.1.2: Manufacturer: Kingston
usb 3-1.1.2: SerialNumber: 0C9D9210E304E311095E087A
usb-storage 3-1.1.2:1.0: USB Mass Storage device detected
scsi host3: usb-storage 3-1.1.2:1.0
scsi 3:0:0:0: Direct-Access     Kingston DataTraveler 3.0 PMAP PQ: 0 ANSI: =
6
Attached scsi generic sg2 type 0
[sdb] 30277632 512-byte logical blocks: (15.5 GB/14.4 GiB)

As can be seen, USB flash attached to remote device is properly enumerated =
via
MA USB. Without the fix, usb driver is not able to read USB descriptors, en=
ding
up in USB storage not being accessible.

--=20
Regards,
Vladimir.

