Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371DCC83000
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08AC22072A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=displaylink.com header.i=@displaylink.com header.b="NIuq+nyS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgD3OiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:38:14 -0400
Received: from eu-smtp-delivery-167.mimecast.com ([207.82.80.167]:26231 "EHLO
        eu-smtp-delivery-167.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727899AbgD3OiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 10:38:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=displaylink.com;
        s=mimecast20151025; t=1588257489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uiWplXwyOM2yIhLrES/y3Z8BHueLokSSTvaPXvsZjbM=;
        b=NIuq+nyShFqi1M20zNV4aNwGimt/eurItZoutPAKB8lgCkjvvm1njUokGuLq7fkUuYm28s
        J6giXT+6Zbiq6Ptkr9OnrUMLCc5MumDmUqrLy1cb3L+lNoD2PHAUEy6r6pv8Oo3UHKRjHG
        lsiKO9DdiV4N9vrDzoYo9pkPoEzkNrA=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2055.outbound.protection.outlook.com [104.47.14.55]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-106-5WJihOSgM5-wpyBrSJiHuQ-1; Thu, 30 Apr 2020 15:38:08 +0100
X-MC-Unique: 5WJihOSgM5-wpyBrSJiHuQ-1
Received: from VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:64::13) by VI1PR1001MB1184.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:71::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Thu, 30 Apr
 2020 14:38:06 +0000
Received: from VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8cba:c335:a57e:9dfd]) by VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8cba:c335:a57e:9dfd%5]) with mapi id 15.20.2937.028; Thu, 30 Apr 2020
 14:38:06 +0000
Subject: Re: [External] Re: [PATCH v5 5/8] usb: mausb_host: Introduce PAL
 processing
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, mausb-host-devel@displaylink.com
References: <Pine.LNX.4.44L0.2004261655390.1962-100000@netrider.rowland.org>
From:   Vladimir Stankovic <vladimir.stankovic@displaylink.com>
Message-ID: <8536b665-1e25-bd5a-4ca0-3f68233ff1be@displaylink.com>
Date:   Thu, 30 Apr 2020 16:37:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <Pine.LNX.4.44L0.2004261655390.1962-100000@netrider.rowland.org>
Content-Language: en-US
X-ClientProxiedBy: LO2P265CA0055.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::19) To VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:64::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.101] (94.189.199.177) by LO2P265CA0055.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:60::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend Transport; Thu, 30 Apr 2020 14:38:05 +0000
X-Originating-IP: [94.189.199.177]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 465621b1-22c0-4048-54bc-08d7ed141892
X-MS-TrafficTypeDiagnostic: VI1PR1001MB1184:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR1001MB1184695412CC1A459AA0420391AA0@VI1PR1001MB1184.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0389EDA07F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w46pHpFZMDDxXJg5t+vI4SSP7rfHlYdwCTX1wrweK5TJg8bRzo0udLu9mdnlO2gEu2wP+irNtdsOERjjT7TW+DMmcTPlp253J9IHU741cYZYARmAbw6XbnAra0VuKc3L6rhn/4Govv94vgwTifSVq/Q9y/C7Qzgx3wP7Fno5dfrvdm+udx2wMDMxLeEVpIuy5vyJr6SV+cpSI5uubS5kAaJJBPJ+nliNiGL/AJiVQOcKqY/SqmP8y3usQGs3go3Uy8Uvssq9RQSgTMXU27uhyQQojPNJfPZgXP1CzL2ifbDOrsHa2VhsdVtz2TWf6qoC4xWkwj+c5jaugbggmxJFe6zWHwB2VugSszfJxLkDHuaLv/WFp70oMI3L8qkiPmH76IZ//97GyYhV/I19p/qEfQ1cYRtxl0YNiteJLnVE1JOGd2kVMcDaigTIKAlE1h44
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(396003)(366004)(346002)(39840400004)(86362001)(316002)(16576012)(6486002)(31696002)(36756003)(5660300002)(52116002)(31686004)(44832011)(956004)(2616005)(66946007)(26005)(4326008)(6916009)(186003)(66476007)(66556008)(16526019)(107886003)(8936002)(478600001)(8676002)(6666004)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: CP/dfR6Nl7BvZ3pTl6iK78udhIaNjetx+hgIOOG1bitytk+hh56ere/OFr2XiI3uyjfqcuv7sCWes+E2+c2hjhyOrhHjop/tZN9W/opd41R8WjBn//8BrJ344L49mM1oHJNg2ighURS6xz5c3h4st1+QvEMqht+OmHIgQD5FcqpDb4zoGdTEHp0s2hg6EM3Wau78Zal1XBW/EcuOcuNdRNJhxhX6dfiojlx8x+6hCZEpKh2+opN4MJZ9ONke8p68bsqp5DQnCHR9moc863LK7XwqoQE6RQoXUhyvyncBXI8g24K7+OSpI4+G12+Bm9x4t1JSJNoACetgsiGi5XOAPag3AkUBmWntR/+tw6Z96veexBfenHU3apIU8rdaaVuOiVJIPcaQrWSPAZ4U6FXPDX/LbvAsPJsIYCFVTriBotqz+dnPJhCFbsYGa3thUr50Iriex1OOsi3o4TATsOf59Ii0ROeaHX9582qvrAAEy6mnVzj7iSwjjQNlQSWnyn/vCrfmK1bb/ww8dmd7/FF+hFzRoZIfSuPIdtLgQ6VRAjXponsCty6/deBVwTQSn0QuRe6LKb1CZgcV2pSWSSNxZiHP9S8CLJApDjH0hAWcmL20/IIBXLF+nx0FrCB7SAZz0YwlS+olUXFQCyylkcrL766WTZekEI5hmQwNZIKj3vCo8QuszPTfxL3iItP3NBAW2geoHOy2i2Nx55pOub+OTuTUDKS5kQOfh80hRhRdYENkFdjuf0jur77+HLbmfE5X/yvNt9D5KTHpd9E4GCXUXG3aZHfizvW1q4mxOGpw71Q=
X-OriginatorOrg: displaylink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 465621b1-22c0-4048-54bc-08d7ed141892
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 14:38:06.6175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4bda75a-b444-4312-9c90-44a7c4b2c91a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Jz02KFsB3lZiwZ6fwHD6wxv/kEq4RQ4xKkQhoef3VkY8splyXHDtOpB78K+pXXdwqxf8GKKO7ajn1EqejwDfyDDoMz2soDydVlA/AkVhTdotZB/edisANBDh1cfNXLE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR1001MB1184
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: displaylink.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.4.20. 22:56, Alan Stern wrote:
> On Sun, 26 Apr 2020, Vladimir Stankovic wrote:
>=20
>> On 26.4.20. 16:31, Alan Stern wrote:
>>> On Sun, 26 Apr 2020, Vladimir Stankovic wrote:
>>>
>>>> On 26.4.20. 02:32, Alan Stern wrote:
>>>>> On Sat, 25 Apr 2020 vladimir.stankovic@displaylink.com wrote:
>>>>>
>>>>>> Protocol adaptation layer (PAL) implementation has been added to
>>>>>> introduce MA-USB structures and logic.
>>>>>>
>>>>>> Signed-off-by: Vladimir Stankovic <vladimir.stankovic@displaylink.co=
m>
>>>>>
>>>>> ...
>>>>>
>>>>>> +=09/*
>>>>>> +=09 * Masking URB_SHORT_NOT_OK flag as SCSI driver is adding it whe=
re it
>>>>>> +=09 * should not, so it is breaking the USB drive on the linux
>>>>>> +=09 */
>>>>>> +=09urb->transfer_flags &=3D ~URB_SHORT_NOT_OK;
>>>>>
>>>>> Removing the SHORT_NOT_OK flag is _not_ a valid thing to do.  It will=
=20
>>>>> cause drivers to malfunction.
>>>>>
>>>>> Can you please explain this comment?
>>>>>
>>>>> =09What SCSI driver?
>>>>>
>>>>> =09When is the flag being added?
>>>>>
>>>>> =09How does it break USB drives?
>>>>>
>>>>> =09Why haven't you already reported this problem to the=20
>>>>> =09appropriate maintainers?
>>>>>
>>>>> Alan Stern
>>>>>
>>>>
>>>> Hi,
>>>>
>>>> Issue that removal of SHORT_NOT_OK flag addressed is linked to particu=
lar
>>>> set of Kingston USB 3.0 flash drives (super speed) - other USB flash d=
rives
>>>> haven't had this flag set. Without this "fix", those Kingston flash dr=
ives
>>>> are not being enumerated properly.
>>>
>>> Please explain in detail how the enumeration of these Kingston flash
>>> drives fails.  Or if such an explanation has already been posted,
>>> please provide a link to it.
>>
>> Will reproduce the issue once again (w/o the fix) and run through the ev=
ents.
>> Issue has been noticed during early development, and addressed right awa=
y.
>>>
>>>> This particular line was added in the early stage of development, duri=
ng
>>>> enumeration process implementation. The reason why it remained in the =
code
>>>> since is because we haven't noticed any side-effects, even with variou=
s
>>>> USB devices being attached to remote MA-USB device, including flash dr=
ives,
>>>> cameras, wireless mice, etc.
>>>
>>> Come to think of it, the SHORT_NOT_OK flag is mainly used with HCDs
>>> that don't have scatter-gather support.  Since your mausb driver does
>>> support scatter-gather, you most likely won't encounter any problems=20
>>> unless you go looking for them specifically.
>>>
>>>> The problem has been reported, and is actively being investigated.
>>>
>>> Where was the problem reported (URL to a mailing list archive)?  Who is
>>> investigating it?
>>
>> Ticket has been submitted to DisplayLink's internal issue-tracking syste=
m
>> and is being investigated by mausb-host-devel team.
>=20
> Okay.  What SCSI driver does the comment refer to?  Is it something=20
> internal to DisplayLink or is it part of the regular Linux kernel?
>=20
> Alan Stern
>=20
Hi,

Comment was related to the SCSI driver that's part of regular Linux kernel =
-
once the remote USB flash drive gets enumerated by host, it would appear as
directly attached to host and then handled by the kernel.

With current implementation, following messages are being logged:

scsi 3:0:0:0: Direct-Access     Kingston DataTraveler 3.0 PMAP PQ: 0 ANSI: =
6
sd 3:0:0:0: Attached scsi generic sg2 type 0

after which the flash drive is usable/accessible from host side.

--=20
Regards,
Vladimir.

