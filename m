Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C51FC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 18:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DD89206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 18:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=displaylink.com header.i=@displaylink.com header.b="IWxbPrJJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbgFKS0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 14:26:12 -0400
Received: from eu-smtp-delivery-167.mimecast.com ([207.82.80.167]:28107 "EHLO
        eu-smtp-delivery-167.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726972AbgFKS0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 14:26:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=displaylink.com;
        s=mimecast20151025; t=1591899965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C2gV74y75UYhfa0umgQg5/1ybjBPMTJSZ2gF/7X3yR4=;
        b=IWxbPrJJ5xUMjUsMJjWlK3v6cCkbFN7cWVK5hbiVO2+cspxPeldYqLOAIyZ1iSWjXFXiqx
        5wB5U8t0b+Kcw0LBpdNw7jowdTDYXrQfcsnN2xGrB0xWnvIJSsjSfteUoAbtSM2Osoe+Bb
        /whNZja8X/z5Xlrhw/wvCoZMg5l7lW8=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2054.outbound.protection.outlook.com [104.47.14.54]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-163-LhwjryPnP6CoEntxEumrEQ-1; Thu, 11 Jun 2020 19:19:47 +0100
X-MC-Unique: LhwjryPnP6CoEntxEumrEQ-1
Received: from AM0PR10MB2627.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:129::21)
 by AM0PR10MB2386.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:d4::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.22; Thu, 11 Jun
 2020 18:19:45 +0000
Received: from AM0PR10MB2627.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bd:9bf7:579b:62b4]) by AM0PR10MB2627.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bd:9bf7:579b:62b4%7]) with mapi id 15.20.3088.018; Thu, 11 Jun 2020
 18:19:45 +0000
Subject: Re: [External] Re: [PATCH v6 1/8] usb: Add MA-USB Host kernel module
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mausb-host-devel@displaylink.com
References: <20200425091954.1610-1-vladimir.stankovic@displaylink.com>
 <20200515123502.12099-1-vladimir.stankovic@displaylink.com>
 <20200515123502.12099-2-vladimir.stankovic@displaylink.com>
 <20200515130208.GB1937631@kroah.com>
From:   Vladimir Stankovic <vladimir.stankovic@displaylink.com>
Message-ID: <bd9a6449-f0b8-a5a4-2f3c-75190921086b@displaylink.com>
Date:   Thu, 11 Jun 2020 20:19:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200515130208.GB1937631@kroah.com>
Content-Language: en-US
X-ClientProxiedBy: LNXP123CA0011.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::23) To AM0PR10MB2627.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:129::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.102] (94.189.196.243) by LNXP123CA0011.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:d2::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.20 via Frontend Transport; Thu, 11 Jun 2020 18:19:44 +0000
X-Originating-IP: [94.189.196.243]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35b5053d-dea7-4ea4-d7ee-08d80e3404af
X-MS-TrafficTypeDiagnostic: AM0PR10MB2386:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR10MB2386653EC3EF05EFC915E80391800@AM0PR10MB2386.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 0431F981D8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PFhpnWCCvM4m3GTh6qOG+LbWK/Jl9JaZ042BVFNdgAGjjY5nprHERLu1I0LNAhJuebhDCBCt1vZOg23o7TSKKYiN9CKHQCwHwJR+mXiyQ4i9qROZga7vOCbsWbSe25iZ0Op6nwP7u5FHhMoRHRSitT4L6ui5kmAaSIkEFgb9y8jIRWYlxXI7Il+MwjA0DtW5omTTof3LYlD/S2U0bEppxoZFrGUZDxQcYjBt72wReIhHYhsu+KIEsgaD3W4jkbr2AJFiiOfIeboAgDHTijJtWW+8lkhk+tVJZc4RsOqbgFzVJfsvTwQodYhSXcGFkeS7nHi7muVYHMhw4PPgW9gkeOZNiWOXZlHj1Q6WoiYmQ4LV+LpPC/ODt/+PFdonxBlfSkqhdPxHyV/0alI/RXHT4Xau7RGiGa2vCclnpcHLsVBnbUDue+2V17Fk+adqQluPtzXbixj4OtzJfRgRUjNQdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2627.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39840400004)(136003)(346002)(376002)(366004)(107886003)(4326008)(2906002)(186003)(966005)(16526019)(5660300002)(6486002)(26005)(52116002)(478600001)(31686004)(2616005)(6916009)(66476007)(66556008)(956004)(66946007)(36756003)(44832011)(31696002)(16576012)(86362001)(8936002)(8676002)(316002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: nXDjsXsFEiaXyhY7eUnogd8d2KG0I/NvPBJCwOxHA9lUAVXXCZ1kWIb8ckalMU0cIbh8evlKJYG7Go/QHMn+Q1Q7MA7lTKigW5DIoJ3O8FU8u3C4NLvS7DsSja9vnDD+PLtiabH8s2NIfB6YeivFybnrwqUXuP3u6G/uw+hDoMjudX9FgXviL6H6HmfMLjoHjkENE3GKoyPqVDcw+CxtM5VYp75nRav+YvAwrVSNH8Zzp9IbEfwfqPvzqxNoFiK9Aws+j/PZgf6LfbCjtS1r7EPRcztBr2lD5F0DdO1JJ4Og2e9qVVngIRmI5Gfm42h2mtS5RAk9hplD7SsF4z6MYhIowC54RVJLjpPob3taXNMQ9QmJSgQ4FXbi1WULtMhp7Ad4o3E35ElXn36IvK7joUg+9cr66EQcpehL01EH61h6RWpuAryZa6cVyKuHaJb8HbNriXe9sfBWywJeK9n/V+KlmTGWpp6QDwrBcGnHfvA=
X-OriginatorOrg: displaylink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b5053d-dea7-4ea4-d7ee-08d80e3404af
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2020 18:19:45.3795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4bda75a-b444-4312-9c90-44a7c4b2c91a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JxmIsZHUgYTlOlBW78IC0C+aeSj4jqkZzO7M33ikDNBlqTSsnAbb5StDHjp7SFsg/4NftTKELgLE/s7JW6pigeLrjLEriLnW7AvCyBeDJVRaUSlg7RxssB0SEI4K3R2Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2386
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: displaylink.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.5.20. 15:02, Greg KH wrote:
> On Fri, May 15, 2020 at 02:34:55PM +0200, Vladimir Stankovic wrote:
>> Added utility macros, kernel device creation and cleanup, functions for
>> handling log formatting and a placeholder module for MA-USB Host device
>> driver.
>>
>> Signed-off-by: Vladimir Stankovic <vladimir.stankovic@displaylink.com>
>> ---
>>  MAINTAINERS                         |  7 +++++
>>  drivers/usb/Kconfig                 |  2 ++
>>  drivers/usb/Makefile                |  1 +
>>  drivers/usb/host/mausb/Kconfig      | 15 +++++++++
>>  drivers/usb/host/mausb/Makefile     | 10 ++++++
>>  drivers/usb/host/mausb/mausb_core.c | 24 +++++++++++++++
>>  drivers/usb/host/mausb/utils.c      | 47 +++++++++++++++++++++++++++++
>>  drivers/usb/host/mausb/utils.h      | 15 +++++++++
>>  8 files changed, 121 insertions(+)
>>  create mode 100644 drivers/usb/host/mausb/Kconfig
>>  create mode 100644 drivers/usb/host/mausb/Makefile
>>  create mode 100644 drivers/usb/host/mausb/mausb_core.c
>>  create mode 100644 drivers/usb/host/mausb/utils.c
>>  create mode 100644 drivers/usb/host/mausb/utils.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 091ec22c1a23..9b7b79215f47 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -10343,6 +10343,13 @@ W:=09https://linuxtv.org
>>  T:=09git git://linuxtv.org/media_tree.git
>>  F:=09drivers/media/radio/radio-maxiradio*
>> =20
>> +MEDIA AGNOSTIC (MA) USB HOST DRIVER
>> +M:=09Vladimir Stankovic <vladimir.stankovic@displaylink.com>
>> +L:=09mausb-host-devel@displaylink.com
>=20
> Please just do this on the linux-usb mailing list, why have a whole new
> list for just a single small driver?
>=20
> thanks,
>=20
> greg k-h
>=20
Idea was to have the team notified about any comment/issue within the
driver. However, as you noted, same can be achieved with linux-usb
subscriptions.

--=20
Regards,
Vladimir.

