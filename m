Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154FBC2D0E7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 23:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAA6C2073B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 23:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="SKBpdCd2";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="SKBpdCd2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgC0X0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 19:26:35 -0400
Received: from mail-eopbgr70088.outbound.protection.outlook.com ([40.107.7.88]:59779
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725939AbgC0X0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 19:26:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4zjtVDsGDODx2ewqDBkWGL3G1J6CgBGNJKv5xBNoSc=;
 b=SKBpdCd2XGwrGEyw85qgy/pLNdAsUwnA8xfTBhJIq5mkuzJ0qTB2R8y51feUh+217zJY/8P+hDUx6MwCNqHQx8GTOPB0ZSyMvdbF2DBFQAuRPQoVPA7QbzkNY2mYccW6zAGkikOu7+6gCgfJ+UoFbP+EgjrzvCIjKsRXq8OwLRE=
Received: from DB6PR0501CA0015.eurprd05.prod.outlook.com (2603:10a6:4:8f::25)
 by DB7PR08MB3563.eurprd08.prod.outlook.com (2603:10a6:10:4d::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.19; Fri, 27 Mar
 2020 23:25:27 +0000
Received: from DB5EUR03FT012.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:8f:cafe::cd) by DB6PR0501CA0015.outlook.office365.com
 (2603:10a6:4:8f::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18 via Frontend
 Transport; Fri, 27 Mar 2020 23:25:27 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT012.mail.protection.outlook.com (10.152.20.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.17 via Frontend Transport; Fri, 27 Mar 2020 23:25:27 +0000
Received: ("Tessian outbound 8f06d475fc37:v48"); Fri, 27 Mar 2020 23:25:27 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 5cea041d172e2895
X-CR-MTA-TID: 64aa7808
Received: from 3024ee01f2cd.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 7A0FA230-3D9C-409A-8B10-836A037FF38E.1;
        Fri, 27 Mar 2020 23:25:22 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 3024ee01f2cd.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 27 Mar 2020 23:25:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5s4i3n7r9rN/YoG0pniD72pBo2ic7W+WXBLY7ueFAmbr++icLpufieAudDcrt3WUMKU++27znYVcwy9fLetotQv71nE7HCTccuPWs+GF4IfH+LBBo/D/MhM99OpBPXIsxKc0GahjngSRCddcVAs8khHr8P/Mms8nZAUGfG/y0jigzM2TlD3HmdnqZZeYXhyAkVlzWFrlXjAemrpr6+WR3UR25Lxi7bQzSliMIaUFbDfwkrDPHpeDoyVq62uZd7+tHIJXkCi4pFRxiMkh2JtAC/nN1Z2vwjJBXR4C7K9mNForKviKh8LTBYdPHD5Fh93uAzxQbpIFWV4HDVmw/vTmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4zjtVDsGDODx2ewqDBkWGL3G1J6CgBGNJKv5xBNoSc=;
 b=cZQUzKYHT5wb4UtLGbK6Bi8ungcMpvr2L4JTAwCuM2uUlWOsEv6yyhL1eWqbMSBFOiv08ud9kmFZ2Z5lrOHNa0RA1pwGGuq2HoOCA4czguNoqXV11NubF9paDE93Y4ZoDi55K+sT/avqmnNlnWuk+JUV6Vf06ja/qCfjKRFRUxB4t1JkGUTQt8EdL3L7ac0y5Wn/++ngQaw2KUaaAtsBI9E715MwByg/oVb9lHeLRRWTIwr3DrgoHpeDYCHjSBknibNfKKYgWm/KeTKAGEzARD+0qM8mHjgVRucpbpHDS/3xYxDhZ40Rc4XgPe8rkDX97lZKQCcLl/6E3bD6ppno9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4zjtVDsGDODx2ewqDBkWGL3G1J6CgBGNJKv5xBNoSc=;
 b=SKBpdCd2XGwrGEyw85qgy/pLNdAsUwnA8xfTBhJIq5mkuzJ0qTB2R8y51feUh+217zJY/8P+hDUx6MwCNqHQx8GTOPB0ZSyMvdbF2DBFQAuRPQoVPA7QbzkNY2mYccW6zAGkikOu7+6gCgfJ+UoFbP+EgjrzvCIjKsRXq8OwLRE=
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Grant.Likely@arm.com; 
Received: from DB8PR08MB4010.eurprd08.prod.outlook.com (20.179.10.207) by
 DB8PR08MB5004.eurprd08.prod.outlook.com (10.255.19.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18; Fri, 27 Mar 2020 23:25:19 +0000
Received: from DB8PR08MB4010.eurprd08.prod.outlook.com
 ([fe80::4521:d746:9e7:4ae3]) by DB8PR08MB4010.eurprd08.prod.outlook.com
 ([fe80::4521:d746:9e7:4ae3%5]) with mapi id 15.20.2835.023; Fri, 27 Mar 2020
 23:25:19 +0000
Subject: Re: [PATCH] Add documentation on meaning of -EPROBE_DEFER
To:     Saravana Kannan <saravanak@google.com>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, nd@arm.com,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20200327170132.17275-1-grant.likely@arm.com>
 <CAGETcx8CJqMQaHBj1r5MhNBTw7Smz4BRHPkB0kCUCJPSmW6KwA@mail.gmail.com>
From:   Grant Likely <grant.likely@arm.com>
Message-ID: <2885b440-77a5-f2be-7524-d5fba2b0c08a@arm.com>
Date:   Fri, 27 Mar 2020 23:25:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <CAGETcx8CJqMQaHBj1r5MhNBTw7Smz4BRHPkB0kCUCJPSmW6KwA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0061.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::25) To DB8PR08MB4010.eurprd08.prod.outlook.com
 (2603:10a6:10:ab::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.16.147] (92.40.174.1) by LO2P265CA0061.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:60::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20 via Frontend Transport; Fri, 27 Mar 2020 23:25:18 +0000
X-Originating-IP: [92.40.174.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 802e410a-0c50-4fc9-e237-08d7d2a62243
X-MS-TrafficTypeDiagnostic: DB8PR08MB5004:|DB7PR08MB3563:
X-Microsoft-Antispam-PRVS: <DB7PR08MB3563F20045607A45D67A835A95CC0@DB7PR08MB3563.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;OLM:9508;
X-Forefront-PRVS: 0355F3A3AE
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB4010.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(366004)(376002)(39860400002)(396003)(346002)(136003)(54906003)(66476007)(8936002)(8676002)(2906002)(81166006)(16576012)(81156014)(66556008)(26005)(316002)(66946007)(6916009)(478600001)(44832011)(36756003)(4326008)(5660300002)(53546011)(55236004)(186003)(2616005)(86362001)(31696002)(6486002)(52116002)(956004)(31686004)(16526019);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: liE5gvPyVWj0Q35CvwNeqWj1ScwG9+0XTXQYVFdDf/AlQ0JMsbfHUW85Sj6AfIJNrLbcu14nqD5yVpSQnNsxEPngivE6E0Q8BNEDwvNUqROxG65WcBurjia3kzm9cO0lvs3D11pctV346U/DQRjpIk+H6Hsfbc2hZDOG/wsWUZwvKF2CkaXWdv2DDkxb1Cye/SLntrh1WVLJHxFJV6a/GDC8ofXCrQeJR58Z/Rm6pL4MwJjk70Vfzd8V9A0ygR341tu4PNAmR2wvMhRoOJO4eNDcA64IvbQWluoBpm+E0aqNP95+aKpbopinYe+AO/BZTyV0GKEPavzmkbsVUwKdMaowGR7crXrEGdY/baduWAVdouuuFZCLc1GNZ+/RrDDJwNoz/XLVnWOZwqC5X9ejA09d1B7pW6PbyK8jnxLIl8AuY+UR7Nb8acMQkVOP3A6f
X-MS-Exchange-AntiSpam-MessageData: 1GHP8SeUJbpS8x1ZSffKa7hcEtr+7GI+KpvrnXcehSzPPjmzzz/FxMrtyG2DVhIGk9NWFIozoS8sqaV6oNAyG+rEon5tx/SyksD+9ByG7i+K7M8lPKWzADMXIbP1zGMsfk+23Zy1LgrhfWTF1fbYhw==
X-MS-Exchange-Transport-Forked: True
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5004
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Grant.Likely@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT012.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(376002)(136003)(396003)(39860400002)(46966005)(31696002)(2906002)(186003)(8936002)(31686004)(16526019)(81166006)(86362001)(2616005)(6486002)(70586007)(478600001)(956004)(70206006)(16576012)(8676002)(107886003)(81156014)(54906003)(450100002)(36756003)(82740400003)(6862004)(26826003)(316002)(336012)(4326008)(53546011)(26005)(47076004)(356004)(44832011)(5660300002);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 17246928-e7d7-4663-9063-08d7d2a61d15
X-Forefront-PRVS: 0355F3A3AE
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pXzuPc+Xr/4PB3pne3TVenH1Q2NEn8WDHVOG6qgUMZpnvG6teqFInJsN4EmCq3d4LANzL6QV6NfiehVUxuvyQFeY1MyNakUAT/E2bjGqwwHRKxpkIiEjE6W8ZEboxN7sOGY3+EbQF9qxSDPHrDo5/hO2O+EqZcoIySPNT1R4+z7MthllWoFyL3enx9EdT0QTAR97qqejukeS1FhaebCjl/eee1g1WBTQwpJF3YdBVlsT6jxdL+shndlKBWpeLdNsV+whahF16635Dq77hd6fqmvMzYYPMv7iQHWvpxxyYltjEUcuU59wKfvvO5Mfk6dH/3NB83Nb8FcQd1laSWWnhS5eK759FZRfmuONRokJljHCRyQal+PXhe6J3vs8+ng8TN+u3HhN2PvteIJaw5/O0PjjPhTQpWU6X2PDOy1Ycf8tcx8pMSWrz6W9JE7l9HAVctqTWfw5rUMe0QKnSZj5Ic7/XnE4bWMovnR2FB0Axg1gx9QE7wrnekhtlD6EJm2MRgq2ny3F0zYj8DPOaoDLTw==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2020 23:25:27.5841
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 802e410a-0c50-4fc9-e237-08d7d2a62243
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3563
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/03/2020 18:10, Saravana Kannan wrote:
> On Fri, Mar 27, 2020 at 10:01 AM Grant Likely <grant.likely@arm.com> wrote:
>>
>> Add a bit of documentation on what it means when a driver .probe() hook
>> returns the -EPROBE_DEFER error code, including the limitation that
>> -EPROBE_DEFER should be returned as early as possible, before the driver
>> starts to register child devices.
>>
>> Also: minor markup fixes in the same file
>>
>> Signed-off-by: Grant Likely <grant.likely@arm.com>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Saravana Kannan <saravanak@google.com>
>> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> ---
>>   .../driver-api/driver-model/driver.rst        | 32 ++++++++++++++++---
>>   1 file changed, 27 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/driver-api/driver-model/driver.rst b/Documentation/driver-api/driver-model/driver.rst
>> index baa6a85c8287..63057d9bc8a6 100644
>> --- a/Documentation/driver-api/driver-model/driver.rst
>> +++ b/Documentation/driver-api/driver-model/driver.rst
>> @@ -4,7 +4,6 @@ Device Drivers
>>
>>   See the kerneldoc for the struct device_driver.
>>
>> -
>>   Allocation
>>   ~~~~~~~~~~
>>
>> @@ -167,9 +166,26 @@ the driver to that device.
>>
>>   A driver's probe() may return a negative errno value to indicate that
>>   the driver did not bind to this device, in which case it should have
>> -released all resources it allocated::
>> +released all resources it allocated.
>> +
>> +Optionally, probe() may return -EPROBE_DEFER if the driver depends on
>> +resources that are not yet available (e.g., supplied by a driver that
>> +hasn't initialized yet).  The driver core will put the device onto the
>> +deferred probe list and will try to call it again later. If a driver
>> +must defer, it should return -EPROBE_DEFER as early as possible to
>> +reduce the amount of time spent on setup work that will need to be
>> +unwound and reexecuted at a later time.
>> +
>> +.. warning::
>> +      -EPROBE_DEFER must not be returned if probe() has already created
>> +      child devices, even if those child devices are removed again
>> +      in a cleanup path. If -EPROBE_DEFER is returned after a child
>> +      device has been registered, it may result in an infinite loop of
>> +      .probe() calls to the same driver.
> 
> The infinite loop is a current implementation behavior. Not an
> intentional choice. So, maybe we can say the behavior is undefined
> instead?

If you feel strongly about it, but I don't have any problem with 
documenting it as the current implementation behaviour, and then 
changing the text if that ever changes.

g.

