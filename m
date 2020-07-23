Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4024EC433E8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 09:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0831020656
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 09:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="DdQS09Dl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgGWJGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 05:06:04 -0400
Received: from mail-eopbgr40128.outbound.protection.outlook.com ([40.107.4.128]:38926
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725846AbgGWJGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 05:06:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GdIYO7InYzDw/t6v383E0D4jsUAsOkoLNGsSUzaum13gDNu0oqGr/n1GJKSPrIFY20YFWN5MqSguRMDW84F9YDjLISyGVrYNu6lS5QYVlertYNmHVDCp1RhYrmbx8542aLUQZGZ3Ozv2qBa63bRXgrvBwzrntd68ogeJhl3yZUz6oMQQ2Pfx1jWsD9OuUWjkph6OzZgHdCLtgJz8yJEb6HTj5l79IIlKd0i9LDqnJmhKebc0ucrRex+okFXwUowq6UGOCfvssdS+RpfGxsnzH1DEU6XUKDn3U186JpK1mz/hFE2XVAPN0MuBORKQYE0mLRiblXUPz2rpe3Jf5Z/N3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBUfCkuxdXXQ1lpcgz+R1nv7KtRKbyQ56cNqTWUZdjI=;
 b=hlhc84ev6RvC+3M4SsipD3DnXEmK9OwmiXR0R7Sggq5RQtQlapNEfZpbPm5SRhixbrtoZCQyxwzYBtnez6bFjP+w4E6wM1hMkFSSnMT1XJT3Od+o+ak+KGftYCnAQlrfqwQuUPowY3mDT+F3VzN6qQZR0p+p/7Sut/pO6r87cNizIwvRilYl896zwR3Q71mw1BcT1mSiqLa4m/1euPrn0fqu6v+SToguW/CHmXJn05TWQAFi/nB8SGRnj9T1deEJEn4yqrDbfXs1Rana2C9S3rVxsatXKdn2RWHd6NJcGYOIPaIpMLgCYeS+9H6PsZnkHU+1StByJ1kZWk4gA37GsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBUfCkuxdXXQ1lpcgz+R1nv7KtRKbyQ56cNqTWUZdjI=;
 b=DdQS09Dl51jh4ffcIW983ppC0lpt1OLkVNjS3irVQSGwDNIN4I0K49evwSKCobdQ9RBAgQiHhX5T6krv9/Otd42dDbycwoYbLi/H25hvrr8DpWn1v5gG0AR+vCnkM/0rl058CnyiXu6uZ2vrZeNsBEV3HBs8KlaTtYsbkdXfVxY=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=nokia.com;
Received: from HE1PR07MB4412.eurprd07.prod.outlook.com (2603:10a6:7:96::13) by
 HE1PR07MB4377.eurprd07.prod.outlook.com (2603:10a6:7:a0::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.14; Thu, 23 Jul 2020 09:06:00 +0000
Received: from HE1PR07MB4412.eurprd07.prod.outlook.com
 ([fe80::7071:9f4d:b39a:823e]) by HE1PR07MB4412.eurprd07.prod.outlook.com
 ([fe80::7071:9f4d:b39a:823e%6]) with mapi id 15.20.3239.009; Thu, 23 Jul 2020
 09:06:00 +0000
Subject: Re: [PATCH] mtd: revert "spi-nor: intel: provide a range for
 poll_timout"
To:     Tudor.Ambarus@microchip.com, luisalberto@google.com
Cc:     vigneshr@ti.com, bbrezillon@kernel.org, richard@nod.at,
        jethro@fortanix.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, miquel.raynal@bootlin.com,
        mika.westerberg@linux.intel.com
References: <20200610224652.64336-1-luisalberto@google.com>
 <40ef3da0-56f4-3c78-f875-a750afaf2ec5@nokia.com>
 <df774dcb-edd1-ae7a-0e26-2e7c324406ff@microchip.com>
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
Message-ID: <ca4d6a2f-b3c8-2b52-431e-81f3cb956db7@nokia.com>
Date:   Thu, 23 Jul 2020 11:05:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <df774dcb-edd1-ae7a-0e26-2e7c324406ff@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXPR0101CA0019.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::29) To HE1PR07MB4412.eurprd07.prod.outlook.com
 (2603:10a6:7:96::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ulegcpsvhp1.emea.nsn-net.net (131.228.32.167) by MAXPR0101CA0019.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:c::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21 via Frontend Transport; Thu, 23 Jul 2020 09:05:55 +0000
X-Originating-IP: [131.228.32.167]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 38618ec4-f9c4-4a99-0647-08d82ee79e43
X-MS-TrafficTypeDiagnostic: HE1PR07MB4377:
X-Microsoft-Antispam-PRVS: <HE1PR07MB4377A39014F1498EB1B3695C88760@HE1PR07MB4377.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2kW4r9AXIzQDARxb6u1UlweaxoAFLw7MWoy5KBmWzytOBKgxpWH8AeUN2wo12i4haQmY32aDO8Hwc9fVKkvj1QZSQz4r1U7N/aFXWtXXiMNZ15bZIIrPWSp6qBAPdvz67shecenZ6gkJABTSLfeSe2cmjGVZWRpwLBz1heM5Eif5trWNhz3R3xguBKNj1MjyBXpR4ZjQJ38B0potAEu7i3wUq1xsjc06VELaBERfn58DRaSzc5NKUP26vYRoSug7WFJZahqyqKK01qcru1M6ZKselb5ggKhcPB15SIow5nNz8EwnUL5NPQ3/shI8CkB8PI2EUW1BVR2pTEq/HmLXKfEfza/BaCf+6Gedx3Rh6kdssFhVHn6HX9cda/OARpaB49lgjnWE5ysjJn4amfKjpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR07MB4412.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(376002)(396003)(39860400002)(136003)(6512007)(36756003)(2906002)(4326008)(6486002)(478600001)(53546011)(66476007)(52116002)(31686004)(44832011)(6506007)(956004)(316002)(31696002)(2616005)(5660300002)(66946007)(8676002)(86362001)(6666004)(7416002)(66556008)(8936002)(16526019)(186003)(26005)(21314003)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 4tuhFuHQcY4LxJUVgxZ+d9W8UoXJ06RNksGbMZEhoSydzJ3mAbw8WeSvY6xfo+caRUGMfYzR+sgqdFjCaW2K6ukqpaBpulZElaSem3o4PyC8/dR2zypvbH9pjt4myT8N/4c1H3aZdIShkJLZ8nyuEhdAFCebKGqLjtzZ2f1Z3KIW59vm/pAGLa1clTffhqCReCIEYMcXVokQEGu9xdPl/6Vqzi1EqEhBePT43HKDC5QCztwvnIAeStTKPmSJhtys+L/Q4kDWNCQY9mMhdxLFTCPSHjuTQZVMU4+5t4hrDgfSyznslLtfqAQdZ+kUc2f9ClEYnMWJOlI/nGqds2SGV62jlQhHT9H8NBvqgsQIan8qK8A9uhHziPguUI8CEXTNIu8Hpn6ZPgaK17LtMoVkvFb7XL6/8e706kDg2UKiXxQSUJGk2McVwAad0yyDM8CcYrOnHrqY3XsmMTI8SDyxmonB5f5ji0r/2UjKKqG3ZgPk1Y4MtkAZuVwFAft4MFAb
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38618ec4-f9c4-4a99-0647-08d82ee79e43
X-MS-Exchange-CrossTenant-AuthSource: HE1PR07MB4412.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2020 09:06:00.2659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OpQ38JII3CHMjNPMMoMRsXDgFWtHFWlwcrvmh+y8vcIgYAzbmC2/IMxrQJAPB3QA7rjMGVhyoCLqeWgHfjEeQwa9d7pWwx9siYmgvhF4fYU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR07MB4377
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tudor,

On 22/07/2020 19:03, Tudor.Ambarus@microchip.com wrote:
> On 7/22/20 7:37 PM, Alexander Sverdlin wrote:

[...]

>> I've performed my testing as well and got the following results:
>>
>> Vanilla Linux 4.9 (i.e. before the introduction of the offending
>> patch):
>>
>> dd if=/dev/flash/by-name/XXX of=/dev/null bs=4k
>> 1280+0 records in
>> 1280+0 records out
>> 5242880 bytes (5.2 MB, 5.0 MiB) copied, 3.91981 s, 1.3 MB/s
>>
>> Vanilla 4.19 (i.e. with offending patch):
>>
>> dd if=/dev/flash/by-name/XXX of=/dev/null bs=4k
>> 1280+0 records in
>> 1280+0 records out
>> 5242880 bytes (5.2 MB, 5.0 MiB) copied, 6.70891 s, 781 kB/s
>>
>> 4.19 + revert:
>>
>> dd if=/dev/flash/by-name/XXX of=/dev/null bs=4k
>> 1280+0 records in
>> 1280+0 records out
>> 5242880 bytes (5.2 MB, 5.0 MiB) copied, 3.90503 s, 1.3 MB/s
>>
>> Therefore it looks good from my PoV:
>>
>> Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

[...]

> would you put 10 us here
>>>                                 INTEL_SPI_TIMEOUT * 1000);
>>>  }
>>>
>>> @@ -301,7 +301,7 @@ static int intel_spi_wait_sw_busy(struct intel_spi *ispi)
>>>       u32 val;
>>>
>>>       return readl_poll_timeout(ispi->sregs + SSFSTS_CTL, val,
>>> -                               !(val & SSFSTS_CTL_SCIP), 40,
>>> +                               !(val & SSFSTS_CTL_SCIP), 0,
> 
> also here, and re-do a test? I'm curios if the performance will be
> as it was before.

with 10us it looks like this:

dd if=/dev/flash/by-name/... of=/dev/null bs=4k
1280+0 records in
1280+0 records out
5242880 bytes (5.2 MB, 5.0 MiB) copied, 4.33816 s, 1.2 MB/s

Which means, there is a performance regression and it would depend on
the test case, how bad it will be...

-- 
Best regards,
Alexander Sverdlin.
