Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B108BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AA0C20720
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Zeb8vR83";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Zeb8vR83"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390032AbgF2VD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731141AbgF2TMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:12:47 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on20606.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1b::606])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2C1C008629;
        Mon, 29 Jun 2020 03:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4EOPaBF3jA6ib4DH7vLzxO7+AVikHf7twWj9okdseC4=;
 b=Zeb8vR83bdgxA4izo/OLAYp9We45XaL+iHO2kCjZ8TVCkal8QEyk/VqT9kHvcK+rHytrvn7Kt114Pz4IBn5W3UlyigPTCY0FbuXci1xOXQNZRsVTT1ar47KPzpj74BzNOxGh72lyrFJiFIQpbebVaFPyVsorbGvjmsTlP1nSGis=
Received: from AM6P193CA0060.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:8e::37)
 by HE1PR0801MB2027.eurprd08.prod.outlook.com (2603:10a6:3:4f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23; Mon, 29 Jun
 2020 10:54:45 +0000
Received: from AM5EUR03FT008.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:8e:cafe::a7) by AM6P193CA0060.outlook.office365.com
 (2603:10a6:209:8e::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend
 Transport; Mon, 29 Jun 2020 10:54:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT008.mail.protection.outlook.com (10.152.16.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.20 via Frontend Transport; Mon, 29 Jun 2020 10:54:45 +0000
Received: ("Tessian outbound fcfbba629a49:v60"); Mon, 29 Jun 2020 10:54:45 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 53a17a117c5c123f
X-CR-MTA-TID: 64aa7808
Received: from 18e9caeea5b7.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id C5372EBA-9D68-47F7-B4F0-6035E4742977.1;
        Mon, 29 Jun 2020 10:54:39 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 18e9caeea5b7.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 29 Jun 2020 10:54:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUywMHQD3I2wNGYtP5xcGGq5tiW146dMMnnLcEb2X5fcQL5oMjmyNgRblVFmLzk9fPgLq220TJUbWi8eh7PrmViYWm6LoBxEw70XM8xY5/orPTE612ge3adzR6wmnMDEWi1nAAtn11DVv22J0EAKSRTHt5rOZO71Ol7nj+emy1YvY78pL7IUtLsDC/DEHbg2To4MIbLgz/6XL1O7zd8xaNN04yBKilKtR6lPn5ZpzcH344fBIkNu/Yw6ABWq29n6x5GTeRjspKVDp2aP0tNfm7r/9dt5ATwPxb3nwT5PKUuKDCtaCWJLIpl32Uge7vC3W02qKRMgO6Yj+Js0FgQ0DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4EOPaBF3jA6ib4DH7vLzxO7+AVikHf7twWj9okdseC4=;
 b=Tglo77vVYf22dVcOgGig/dyzccLz5R93G0LftCrehtVO/8FDMhStFUvjEZEOFVURbPzI1wK3LD/xykdAkVJPdAJbEmRj35xdbV0rvbn1RSEZ73DuJaZogGbi/Q4WhwOAcJRFdpvy7a6T++AfzRDY2whVtSH3nAKj1NM558IoTHeTgvJuBGFi0g/kJ/HkwQAxoMa+u+sainoatQYh2ytYzR91rG6gJlzwDsZ0ITl1rBzK1TOmQ43LKjXu3aEik6OArz+wc5KjOlYBnSxYdil+ldTILE9aF4SXntQrFHU1u81uxY5YJ7Co/fYH/5xgN6gH6eB772j4bEaZHLkc0GutMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4EOPaBF3jA6ib4DH7vLzxO7+AVikHf7twWj9okdseC4=;
 b=Zeb8vR83bdgxA4izo/OLAYp9We45XaL+iHO2kCjZ8TVCkal8QEyk/VqT9kHvcK+rHytrvn7Kt114Pz4IBn5W3UlyigPTCY0FbuXci1xOXQNZRsVTT1ar47KPzpj74BzNOxGh72lyrFJiFIQpbebVaFPyVsorbGvjmsTlP1nSGis=
Authentication-Results-Original: lists.infradead.org; dkim=none (message not
 signed) header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=arm.com;
Received: from DB6PR08MB2680.eurprd08.prod.outlook.com (2603:10a6:6:19::11) by
 DB6PR0801MB1669.eurprd08.prod.outlook.com (2603:10a6:4:30::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.23; Mon, 29 Jun 2020 10:54:37 +0000
Received: from DB6PR08MB2680.eurprd08.prod.outlook.com
 ([fe80::789f:c64f:efe3:2208]) by DB6PR08MB2680.eurprd08.prod.outlook.com
 ([fe80::789f:c64f:efe3:2208%6]) with mapi id 15.20.3131.027; Mon, 29 Jun 2020
 10:54:37 +0000
Subject: Re: next/master bisection: baseline.dmesg.crit on
 qemu_arm-vexpress-a15
To:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        Sudeep Holla <sudeep.holla@arm.com>, kernelci-results@groups.io
Cc:     devicetree@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <5ef64849.1c69fb81.2d891.248a@mx.google.com>
 <9b77d663-311e-37ba-c33f-31dd0a77723c@collabora.com>
From:   Andre Przywara <andre.przywara@arm.com>
Autocrypt: addr=andre.przywara@arm.com; prefer-encrypt=mutual; keydata=
 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
 i4aIXCH3Wv6K
Message-ID: <56cc006b-03e8-df26-f74b-ecfd8739ffb3@arm.com>
Date:   Mon, 29 Jun 2020 11:53:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <9b77d663-311e-37ba-c33f-31dd0a77723c@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0194.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::14) To DB6PR08MB2680.eurprd08.prod.outlook.com
 (2603:10a6:6:19::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.22] (78.146.250.215) by LO2P265CA0194.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:9e::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend Transport; Mon, 29 Jun 2020 10:54:36 +0000
X-Originating-IP: [78.146.250.215]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 720957b4-5ca5-4e92-a8f8-08d81c1ad5c5
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1669:|HE1PR0801MB2027:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0801MB2027CEFBA887EE76FB1DFE5A9D6E0@HE1PR0801MB2027.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;OLM:7691;
X-Forefront-PRVS: 044968D9E1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: /5/95aB7nto5LawCsrxkA/BjwA10Z3QVw7z4n9OlMwUqrLEISVY1T+7x2+htzB2xTwDFOgvOrx7q8atwCN+rJTzu35wikYxUYvFzQVmlYu9fmthfmxvDKfF6eoY+ijF7uMzRawHsBBZ+ACHiw4r8YK6uuQWtnNd+baPdMCtMBFVJNlB4zs04snO5ayQThB31lcEiDfpCr9zkq4RSPULq3IIwhtPUKgEb9Xxe506zaJnohiQIYVr61NNLlf02i8QCXgJZMy0dWLclalLUo+EWGchPEbi2VZC9Zq+D3+i3Buiqdkjrlq3XtpqLx7Kj1FxUPEsr5rCMlArSb/bJZXGJ0FmU6J7Q3gfuDEeHNZYDuY7viwEH+Oi6bpRhL9OzYFyn4xgceffz1ukRCIddQgk/SY2piHgFXTF3VzMUNRQgCGQBf0P/Ar5RML9R9QE32q+kavDNGA4HPxA7UI4s62fSLnr5y3mNq5+xynnYS1DJDHQ=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR08MB2680.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(6666004)(52116002)(966005)(478600001)(30864003)(5660300002)(31696002)(53546011)(86362001)(54906003)(8936002)(110136005)(2906002)(8676002)(16576012)(44832011)(83380400001)(186003)(4326008)(956004)(316002)(2616005)(36756003)(16526019)(6486002)(26005)(31686004)(66946007)(66556008)(66476007)(45673001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 9s1zHsGi7dha+l4NVkiib3CzAL+AVYyOReTbMH2GlkBUza1URBB+c13c4mqCz14uN4T4gaDEKY6kkp8YNfcIUnJBu74NjZdKLqympqyPppXrlopuOBYXolhgEkETNrTJXBHHq0h0E2Bnrs9CK9W5gSaCnq77Ma2OJGrMN/ZvTmWeRUUKzoJWARqHz5MPbJ2Gn5z7v2iHivrfSQQxRvg7aP+B4kBsMZRWGrpYOGrIeeOZAKtl+CzouK3rT4Px1RBhsnuYJAfwDh5G3dYKTDLPQnUUwGQII2/zUXXgKIrrDSvxZCOsT07m3zR4SLGteyePtBtV9aAe/d96yckSSVJ19K8nboOWNGzg4/E1+aNihrdYbn8IZ2YBSd6CJ5utPISuo5s7A6BjHBTE1Hq8YSKsoeanv/lVu8LnoHRKHaJx2tvslYVCHVO9PN4HoWFAKs7ZU3hjtcof5Db7h7eGwowgrEsaHmkjWSa8Jqqxt/VRL4WZPaRGprd2JxYBLG3Pp67m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1669
Original-Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT008.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(396003)(136003)(346002)(46966005)(478600001)(81166007)(966005)(6666004)(70586007)(82310400002)(356005)(82740400003)(70206006)(47076004)(26005)(450100002)(6486002)(186003)(16526019)(36756003)(4326008)(53546011)(107886003)(30864003)(5660300002)(31696002)(956004)(2616005)(44832011)(8936002)(336012)(31686004)(8676002)(54906003)(110136005)(16576012)(86362001)(2906002)(316002)(36906005)(83380400001)(45673001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 785b852d-f469-446b-51ad-08d81c1ad0d6
X-Forefront-PRVS: 044968D9E1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TYP5WqOtezKcU7dgs+5AjKg+wjBM4ATUm3ScmSBgUi8sdKxblrB5OzbnLfZ3PGkuQ7hLGT4fSTUSrC0SB5LzpxtKrqIV9pC/ijnqkEUeRIGi0oN63YuRUWiC43MMavPpcMUeKYVv2C4Hy8adzcm5FYrmxsD7ZYNLlMIHcea5H+oD7AKdrdCOX0WVd+D2UJWkdDoHjYN0ARA913pE2oJeF9se1WHeSTtkGIjWpQyFnF9VO+C/96okucTM/o/3J2zrIsXPzAUrwje79P3xC3VYsDQ/xzBE5di/wq0Aq78VWzYKjNwo779/yHugYHQXiU0vMd1tlBWz8/LSLt4u7RyfJ5rXNW5Ca3cm14ZHc0kORsXa/P+4kIITMfAEjKNDfxYXgjgObTLJBULQlOFEH8YfuNxjoa4dsec3i7RouWa8K1ws1NeY3Vjgu4lOJ0YlYHKUAiSD3hlh0qptA4KKqZStLOhlD4FXS9VUBfDQWLkC1X7lIk51BZABzafjVsS5U5/Jy9WYAES2kO1hzjfeE2ulIA==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2020 10:54:45.3173
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 720957b4-5ca5-4e92-a8f8-08d81c1ad5c5
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT008.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB2027
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/06/2020 21:23, Guillaume Tucker wrote:

Hi,

> On 26/06/2020 20:11, kernelci.org bot wrote:
>> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
>> * This automated bisection report was sent to you on the basis  *
>> * that you may be involved with the breaking commit it has      *
>> * found.  No manual investigation has been done to verify it,   *
>> * and the root cause of the problem may be somewhere else.      *
>> *                                                               *
>> * If you do send a fix, please include this trailer:            *
>> *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
>> *                                                               *
>> * Hope this helps!                                              *
>> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
>>
>> next/master bisection: baseline.dmesg.crit on qemu_arm-vexpress-a15
>>
>> Summary:
>>   Start:      36e3135df4d4 Add linux-next specific files for 20200626
>>   Plain log:  https://storage.kernelci.org/next/master/next-20200626/arm/vexpress_defconfig/gcc-8/lab-collabora/baseline-vexpress-v2p-ca15-tc1.txt
>>   HTML log:   https://storage.kernelci.org/next/master/next-20200626/arm/vexpress_defconfig/gcc-8/lab-collabora/baseline-vexpress-v2p-ca15-tc1.html
>>   Result:     38ac46002d1d arm: dts: vexpress: Move mcc node back into motherboard node
>>
>> Checks:
>>   revert:     PASS
>>   verify:     PASS
>>
>> Parameters:
>>   Tree:       next
>>   URL:        https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>>   Branch:     master
>>   Target:     qemu_arm-vexpress-a15
>>   CPU arch:   arm
>>   Lab:        lab-collabora
>>   Compiler:   gcc-8
>>   Config:     vexpress_defconfig
>>   Test case:  baseline.dmesg.crit
> 
> The critical error message allegedly caused by this commit is:
> 
> <2>GIC CPU mask not found - kernel will fail to boot.
> 
> The report needs to be improved to show it automatically, sorry
> if this wasn't clear.

No worries, I saw this. But more important is this message:
13:53:51.773784  <6>smp: Bringing up secondary CPUs ...
13:53:51.774587  <3>CPU1: failed to boot: -38

And this points to the actual problem: The QEMU command line according
to the log is not specifying an "-smp" argument, so QEMU defaults to one
core. Now we force a .dtb on it, which describes two cores - because
this is what the actual hardware has. This won't go well, QEMU will deny
to online a second core.

So I don't see how this ever worked, regardless of this patch.
I tested this here, which a slightly different QEMU cmdline to run on my
box:
qemu-system-arm -m 512 -cpu cortex-a15 -machine vexpress-a15 -dtb
vexpress-v2p-ca15-tc1.dtb-5.8-next -nographic -kernel zImage-5.8-next
-append "console=ttyAMA0 earlycon=pl011,0x1c090000 debug" -initrd
initrd-armhf.img.gz
I get the same GIC complaint and only one core coming online. If I
however add "-smp 2" to the QEMU command line, everything works fine: no
GIC messages, and the second core comes up.

I did the test with v5.7, v5.8-rc2, v5.8-rc3 and linux-next, all with
the same result (ignoring the bug in 5.8-rc2 that this patch here fixes).

So can someone shed some light on what is going on here? Is there some
bootlog that does not have the GIC messages and brings up the second
core, with the same QEMU command line?

Cheers,
Andre

>> Breaking commit found:
>>
>> -------------------------------------------------------------------------------
>> commit 38ac46002d1df5707566a73486452851341028d2
>> Author: Andre Przywara <andre.przywara@arm.com>
>> Date:   Wed Jun 3 17:22:37 2020 +0100
>>
>>     arm: dts: vexpress: Move mcc node back into motherboard node
>>     
>>     Commit d9258898ad49 ("arm64: dts: arm: vexpress: Move fixed devices
>>     out of bus node") moved the "mcc" DT node into the root node, because
>>     it does not have any children using "reg" properties, so does violate
>>     some dtc checks about "simple-bus" nodes.
>>     
>>     However this broke the vexpress config-bus code, which walks up the
>>     device tree to find the first node with an "arm,vexpress,site" property.
>>     This gave the wrong result (matching the root node instead of the
>>     motherboard node), so broke the clocks and some other devices for
>>     VExpress boards.
>>     
>>     Move the whole node back into its original position. This re-introduces
>>     the dtc warning, but is conceptually the right thing to do. The dtc
>>     warning seems to be overzealous here, there are discussions on fixing or
>>     relaxing this check instead.
>>     
>>     Link: https://lore.kernel.org/r/20200603162237.16319-1-andre.przywara@arm.com
>>     Fixes: d9258898ad49 ("arm64: dts: vexpress: Move fixed devices out of bus node")
>>     Reported-and-tested-by: Guenter Roeck <linux@roeck-us.net>
>>     Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>>     Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>>
>> diff --git a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
>> index e6308fb76183..a88ee5294d35 100644
>> --- a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
>> +++ b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
>> @@ -100,79 +100,6 @@
>>  		};
>>  	};
>>  
>> -	mcc {
>> -		compatible = "arm,vexpress,config-bus";
>> -		arm,vexpress,config-bridge = <&v2m_sysreg>;
>> -
>> -		oscclk0 {
>> -			/* MCC static memory clock */
>> -			compatible = "arm,vexpress-osc";
>> -			arm,vexpress-sysreg,func = <1 0>;
>> -			freq-range = <25000000 60000000>;
>> -			#clock-cells = <0>;
>> -			clock-output-names = "v2m:oscclk0";
>> -		};
>> -
>> -		v2m_oscclk1: oscclk1 {
>> -			/* CLCD clock */
>> -			compatible = "arm,vexpress-osc";
>> -			arm,vexpress-sysreg,func = <1 1>;
>> -			freq-range = <23750000 65000000>;
>> -			#clock-cells = <0>;
>> -			clock-output-names = "v2m:oscclk1";
>> -		};
>> -
>> -		v2m_oscclk2: oscclk2 {
>> -			/* IO FPGA peripheral clock */
>> -			compatible = "arm,vexpress-osc";
>> -			arm,vexpress-sysreg,func = <1 2>;
>> -			freq-range = <24000000 24000000>;
>> -			#clock-cells = <0>;
>> -			clock-output-names = "v2m:oscclk2";
>> -		};
>> -
>> -		volt-vio {
>> -			/* Logic level voltage */
>> -			compatible = "arm,vexpress-volt";
>> -			arm,vexpress-sysreg,func = <2 0>;
>> -			regulator-name = "VIO";
>> -			regulator-always-on;
>> -			label = "VIO";
>> -		};
>> -
>> -		temp-mcc {
>> -			/* MCC internal operating temperature */
>> -			compatible = "arm,vexpress-temp";
>> -			arm,vexpress-sysreg,func = <4 0>;
>> -			label = "MCC";
>> -		};
>> -
>> -		reset {
>> -			compatible = "arm,vexpress-reset";
>> -			arm,vexpress-sysreg,func = <5 0>;
>> -		};
>> -
>> -		muxfpga {
>> -			compatible = "arm,vexpress-muxfpga";
>> -			arm,vexpress-sysreg,func = <7 0>;
>> -		};
>> -
>> -		shutdown {
>> -			compatible = "arm,vexpress-shutdown";
>> -			arm,vexpress-sysreg,func = <8 0>;
>> -		};
>> -
>> -		reboot {
>> -			compatible = "arm,vexpress-reboot";
>> -			arm,vexpress-sysreg,func = <9 0>;
>> -		};
>> -
>> -		dvimode {
>> -			compatible = "arm,vexpress-dvimode";
>> -			arm,vexpress-sysreg,func = <11 0>;
>> -		};
>> -	};
>> -
>>  	bus@8000000 {
>>  		motherboard-bus {
>>  			model = "V2M-P1";
>> @@ -435,6 +362,79 @@
>>  						};
>>  					};
>>  				};
>> +
>> +				mcc {
>> +					compatible = "arm,vexpress,config-bus";
>> +					arm,vexpress,config-bridge = <&v2m_sysreg>;
>> +
>> +					oscclk0 {
>> +						/* MCC static memory clock */
>> +						compatible = "arm,vexpress-osc";
>> +						arm,vexpress-sysreg,func = <1 0>;
>> +						freq-range = <25000000 60000000>;
>> +						#clock-cells = <0>;
>> +						clock-output-names = "v2m:oscclk0";
>> +					};
>> +
>> +					v2m_oscclk1: oscclk1 {
>> +						/* CLCD clock */
>> +						compatible = "arm,vexpress-osc";
>> +						arm,vexpress-sysreg,func = <1 1>;
>> +						freq-range = <23750000 65000000>;
>> +						#clock-cells = <0>;
>> +						clock-output-names = "v2m:oscclk1";
>> +					};
>> +
>> +					v2m_oscclk2: oscclk2 {
>> +						/* IO FPGA peripheral clock */
>> +						compatible = "arm,vexpress-osc";
>> +						arm,vexpress-sysreg,func = <1 2>;
>> +						freq-range = <24000000 24000000>;
>> +						#clock-cells = <0>;
>> +						clock-output-names = "v2m:oscclk2";
>> +					};
>> +
>> +					volt-vio {
>> +						/* Logic level voltage */
>> +						compatible = "arm,vexpress-volt";
>> +						arm,vexpress-sysreg,func = <2 0>;
>> +						regulator-name = "VIO";
>> +						regulator-always-on;
>> +						label = "VIO";
>> +					};
>> +
>> +					temp-mcc {
>> +						/* MCC internal operating temperature */
>> +						compatible = "arm,vexpress-temp";
>> +						arm,vexpress-sysreg,func = <4 0>;
>> +						label = "MCC";
>> +					};
>> +
>> +					reset {
>> +						compatible = "arm,vexpress-reset";
>> +						arm,vexpress-sysreg,func = <5 0>;
>> +					};
>> +
>> +					muxfpga {
>> +						compatible = "arm,vexpress-muxfpga";
>> +						arm,vexpress-sysreg,func = <7 0>;
>> +					};
>> +
>> +					shutdown {
>> +						compatible = "arm,vexpress-shutdown";
>> +						arm,vexpress-sysreg,func = <8 0>;
>> +					};
>> +
>> +					reboot {
>> +						compatible = "arm,vexpress-reboot";
>> +						arm,vexpress-sysreg,func = <9 0>;
>> +					};
>> +
>> +					dvimode {
>> +						compatible = "arm,vexpress-dvimode";
>> +						arm,vexpress-sysreg,func = <11 0>;
>> +					};
>> +				};
>>  			};
>>  		};
>>  	};
>> -------------------------------------------------------------------------------
>>
>>
>> Git bisection log:
>>
>> -------------------------------------------------------------------------------
>> git bisect start
>> # good: [52366a107bf0600cf366f5ff3ea1f147b285e41f] Merge tag 'fsnotify_for_v5.8-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs
>> git bisect good 52366a107bf0600cf366f5ff3ea1f147b285e41f
>> # bad: [36e3135df4d426612fc77db26a312c2531108603] Add linux-next specific files for 20200626
>> git bisect bad 36e3135df4d426612fc77db26a312c2531108603
>> # bad: [11fdea666694c5c8c8a52cb75b2f0e70a2c2c201] Merge remote-tracking branch 'drm/drm-next'
>> git bisect bad 11fdea666694c5c8c8a52cb75b2f0e70a2c2c201
>> # bad: [39ac1a242d0940dabd9192d99113c2b082ba45bc] Merge remote-tracking branch 'printk/for-next'
>> git bisect bad 39ac1a242d0940dabd9192d99113c2b082ba45bc
>> # good: [4a750150d9fe543e2163998501b3ad947d6dff74] Merge remote-tracking branch 'at91/at91-next'
>> git bisect good 4a750150d9fe543e2163998501b3ad947d6dff74
>> # bad: [d7645ac1101c5160a05e2dced672a8d63c2a7ec0] Merge remote-tracking branch 'scmi/for-linux-next'
>> git bisect bad d7645ac1101c5160a05e2dced672a8d63c2a7ec0
>> # good: [2408a915a05c109169ab689dc91ce31315406513] Merge branches 'arm64-defconfig-for-5.9', 'arm64-for-5.9', 'drivers-for-5.9' and 'dts-for-5.9' into for-next
>> git bisect good 2408a915a05c109169ab689dc91ce31315406513
>> # good: [1679681fb8b2d169ac9d98660d7390620990bf77] Merge remote-tracking branch 'raspberrypi/for-next'
>> git bisect good 1679681fb8b2d169ac9d98660d7390620990bf77
>> # good: [137233bdcd265762a251dfa24e82ebc5468e0ec2] Merge remote-tracking branch 'reset/reset/next'
>> git bisect good 137233bdcd265762a251dfa24e82ebc5468e0ec2
>> # good: [99bcf38dd05b76b41f8564b53d9be6b44613fa92] Merge branch 'v5.9-clk/next' into for-next
>> git bisect good 99bcf38dd05b76b41f8564b53d9be6b44613fa92
>> # good: [dc45e438fac0b5df3c31bb83f3d809cd0f67dcfe] Merge branch 'next/dt' into for-next
>> git bisect good dc45e438fac0b5df3c31bb83f3d809cd0f67dcfe
>> # good: [d6fe116541b73a56110310c39a270c99766cd909] Merge branch 'next/soc' into for-next
>> git bisect good d6fe116541b73a56110310c39a270c99766cd909
>> # bad: [24077bf8f9e69a3a6a2c714634e6c813566a152f] Merge tag 'juno-fix-5.8' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into for-linux-next
>> git bisect bad 24077bf8f9e69a3a6a2c714634e6c813566a152f
>> # bad: [38ac46002d1df5707566a73486452851341028d2] arm: dts: vexpress: Move mcc node back into motherboard node
>> git bisect bad 38ac46002d1df5707566a73486452851341028d2
>> # first bad commit: [38ac46002d1df5707566a73486452851341028d2] arm: dts: vexpress: Move mcc node back into motherboard node
>> -------------------------------------------------------------------------------
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
> 

