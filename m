Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A987C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 07:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C726208C7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 07:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=topicbv.onmicrosoft.com header.i=@topicbv.onmicrosoft.com header.b="FuiI+XYM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgIGHvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 03:51:04 -0400
Received: from mail-eopbgr140088.outbound.protection.outlook.com ([40.107.14.88]:27653
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726771AbgIGHvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 03:51:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector2-topicbv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZZsITYQKg0h0XgAedK1onnk+puhmSc7FQSRg44LUCg=;
 b=FuiI+XYMHIg1LHHIFkvPFIBqND+TONUU80gNE63kR4hHK+ltAz6bHP3ZYju8OIhytu7vpFGKkv7Cj3jhfwmMcguHCbxkkOwCTdwxWnKl42H+eIZVnowKy8IPkmI2nOY1/0nYix253SrqwNloUizBW9/dlh4DIJ4/B/7QsU+duNA=
Received: from AM5P194CA0008.EURP194.PROD.OUTLOOK.COM (2603:10a6:203:8f::18)
 by AM6PR0402MB3686.eurprd04.prod.outlook.com (2603:10a6:209:1b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Mon, 7 Sep
 2020 07:50:58 +0000
Received: from HE1EUR01FT030.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:203:8f:cafe::69) by AM5P194CA0008.outlook.office365.com
 (2603:10a6:203:8f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend
 Transport; Mon, 7 Sep 2020 07:50:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.68.112.65)
 smtp.mailfrom=topicproducts.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 40.68.112.65 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.68.112.65; helo=westeu12-emailsignatures-cloud.codetwo.com;
Received: from westeu12-emailsignatures-cloud.codetwo.com (40.68.112.65) by
 HE1EUR01FT030.mail.protection.outlook.com (10.152.0.170) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.17 via Frontend Transport; Mon, 7 Sep 2020 07:50:57 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (104.47.18.104) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 07 Sep 2020 07:50:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KH/7znxGgCVJNvFckMg/hqdIy5jc3SC+l//uWfGhyoDDQTlEnsy/JNeoyNAP23r1anO0VTPLIdprvdxJl5EMy06qEjWOeaBGLkM7X7v2INPUr78HZsRBE3bVe1OB++fN7DJevZodPWhKmVoM+j+hW7FtEHXbDtiYRf0BeNtwVNSXqBhYxwKRWcwyKFxi4xhzo40Q6owH6+LTeKI7A6enCRFKWwOecuLzKOfOX/+oLlSvADDqSFKloHTo53GkhLvIc12yfJK9XhRbQnCj02NUIkYBLFfW8JgqeRglPUddOuwmsHBssJvNcC3kzmvhfAec+5ZE5eAbJAtHUgE7l/Z/eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cAXbyZgn4meXtcnxMvPByNZlZTkSmtFLAEptMMtyFk=;
 b=cbz4Bti36mCL+Vc5zH3J0jRJwakm5bcLZtSIUhPRAfwK0kFzFvMQZqwgj6PJCgzIip5Gi1YwFSEf7Eh5LyuZiQKRvN0yOxBR9Po99Sev3a9UDx/q+eKLKYJv5+fkNwZU+Gcgg+1yLvaj8aMGJVpkwMyyD+h3xqeUKpsj8APAbR1N9ls1at/+E0GjQ9UCCHwQhI1b+Y10ybYxS0NNxPKXD35wLrgKhY80pdXbA35o6I44Q5UyL0iI3MXHUHQ/SEeFvYoA6j0d5/CBnT8EVRvBZyus/qvqyNwn27/rkbdLFHebWtijR1FEkZAZQHHYcWNzxRaItAdtDKclY1FvS/l85w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
Authentication-Results-Original: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by DB7PR04MB4714.eurprd04.prod.outlook.com (2603:10a6:10:14::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Mon, 7 Sep
 2020 07:50:54 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::2d61:d6fe:3c2:3e14]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::2d61:d6fe:3c2:3e14%3]) with mapi id 15.20.3348.019; Mon, 7 Sep 2020
 07:50:54 +0000
Subject: Re: [PATCH v3] usb: dwc3: Add support for VBUS power control
To:     Felipe Balbi <balbi@kernel.org>, Mark Brown <broonie@kernel.org>
CC:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com
References: <20200619142512.19824-1-mike.looijmans@topic.nl>
 <20200723075612.tn5dbkhes2chohwh@axis.com>
 <20200723110523.GA4759@sirena.org.uk>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.2698920d-90ba-4c46-abda-83e18e2093c8@emailsignatures365.codetwo.com>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.0d2bd5fa-15cc-4b27-b94e-83614f9e5b38.ac9c2a67-d7df-4f70-81b3-db983bbfb4db@emailsignatures365.codetwo.com>
 <e63ee918-c9e3-a8ee-e7c5-577b5a3e09be@topic.nl>
 <20200727102317.GA6275@sirena.org.uk>
 <be4013b6-01c6-7f67-35ad-5c398b85c066@topic.nl> <87a6y21154.fsf@kernel.org>
From:   Mike Looijmans <mike.looijmans@topic.nl>
Organization: Topic
Message-ID: <78282590-5190-300c-4d17-3ce9cd63acac@topic.nl>
Date:   Mon, 7 Sep 2020 09:50:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <87a6y21154.fsf@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-ClientProxiedBy: AM4PR0902CA0012.eurprd09.prod.outlook.com
 (2603:10a6:200:9b::22) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.130] (83.128.90.119) by AM4PR0902CA0012.eurprd09.prod.outlook.com (2603:10a6:200:9b::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16 via Frontend Transport; Mon, 7 Sep 2020 07:50:53 +0000
X-Originating-IP: [83.128.90.119]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03f0b70a-d0d3-4653-2e57-08d85302c1c8
X-MS-TrafficTypeDiagnostic: DB7PR04MB4714:|AM6PR0402MB3686:
X-Microsoft-Antispam-PRVS: <AM6PR0402MB368660BA16B3A196626AE02196280@AM6PR0402MB3686.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: ACzCCkUWjDbAeeHJlxwcIwqdgWCQj7v5djBmCMq9xAZG9XD5wiK7uyego3ZcSy4IV5Xz8KGLPsOzFKddeSj+2ZAEnMIV3YTTZlpbHHcF/2aEihbCc/0OPM3XjKP5MCl6DPW2SGTcv7utfsyGQf6IYSencl/RCO0fuI3DxXly1YPnwJqViGhoF8DYDfMwp0nJNKt1Lcjc7MxnoZU7uXsHRqq9mWmJKvFAH88JgHTJtkNdXE0Zl2ERY0lH1v9TDQnLDs46xT4Sq7hex9+oCyq2cbfdqJ+5vyGZ9AwDIRKSMko8Ds8T8bOjKZo3sKT0scIcBL7a7IlUUIkx6TJUoKtB7HWV0+sLhat9pbypt9r2wsNiFZne1M92uf/D0f5W5NeOU6/WE6AF26l+UBVgGmtCA8zGCZE8TMA+gh/bIZ7ssWXVrT2bhUkEgIGYCvSv2cxDoAiRPONJOeWBY5ZA7u9pXg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(136003)(366004)(396003)(346002)(376002)(31686004)(2906002)(2616005)(16576012)(52116002)(26005)(478600001)(53546011)(36756003)(5660300002)(4326008)(316002)(15974865002)(186003)(16526019)(110136005)(44832011)(66476007)(66946007)(66556008)(956004)(42882007)(8936002)(83170400001)(36916002)(8676002)(6486002)(31696002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: UpIelKn69HqVA6WDWGn/TREOmQdXU6+QgHo/XI/hdGo9+iJTQWtNSSNvuLLQRosW6YIRmW81INmLAgrESB4I7gcY3OrhazexWLaEz7p1ZiUDRnQa3o9809+t3DiXN40mvokW5wFdElA8sG50rirItwcUo0tD/PTDIpChLVAkOn12XZ3bJRVWSqWJIqg+9/qhBCZTk1IpmZQ7rbpM8cCmeyMDSLLKNE8rQilJQwnG9o5SNySlLFjM4qcIUfU6gQIotBD5cfffMToSxQTGdK6dHjubf1gT88NGc4rTgaZ1ODP/rySKNJAfIe/SD6B+ZCcRoTlTmPmiSe9PEz3RGYX00JAAqF73ik49KUAYIq3dl40cNWzwqjiRv9oizen8VzLmgqVa4YEMIF+p4YLaI0I39BkXJZtAiHCeuzVsRqLpaai5qzeck8QQwv7isGH9fEzBlpA5Bcxpe14fjMCm2nd0a7VFpGGwhIPv4+EwVJUDbJNassCXZt998UYvtmrso87eo+h/Te0NCuDs6iiZLXCXLs+zMdlIMmANuxNTM5PgA5xlfm6HwuI1pr9LEFRdgrT+DoL0GJASSVi2jwxmlaJ2mBwcCbGJLkEH+BiCcTyhoHVgSH28XesCgFgfcf6C6mJIN/lNbcbuZ6qLQQ7ayWtDJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4714
X-CodeTwo-MessageID: 1d516f6b-5219-435f-b5f7-738925a5e378.20200907075056@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: HE1EUR01FT030.eop-EUR01.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1f912393-20d2-4d18-6042-08d85302bf52
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N4VABvDpSGHP6m6NzJdUqBiNCNKSiun7NZP7jDUxrfZQ4BFpSv+PohjjlB4NSyFvOrZ8NGS6wPwCr3EDhuqT5BOBWTZw0MN0348uVSH/T+3rDiPw7pd/6DI4lEaVhuXY647PFfVQ1SDrRgQJ3/x+2G4CSrP8Q+cenh6g7SVhs7XNglTsaykRxZ7TAu3I3EPvgEJ5thN9iYt8Exl3W0KLgEcrP8Rf92quG/OL/41BOgQ243vFYt2u001mnFKwKHd4pBQj/498FlEUHmeGl+K4wld0ZaFuNFlvZzLolffQC+XDSJH8Bkb0oN5ni/QOBewJg1LLx5dKFHqBuYRIDt1i1Ebq75G6yD6Jerl0AUWvT2WnSQpXhPACBJ41qVmkcEzyov52sySW+7a3+aEkImwucl30G6CvWT+qRJ+y6kPmt9Z2oz8QtxF9NS/DUYJt5EEGd0ELGTLwVolOj6VYO5Yk2L4Z6vXsOUmm9mRZL6GohO3Z7DyFnNWSy8DcvZR4VNbs
X-Forefront-Antispam-Report: CIP:40.68.112.65;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(396003)(136003)(39830400003)(346002)(376002)(46966005)(36916002)(478600001)(36756003)(70206006)(70586007)(5660300002)(110136005)(15974865002)(16576012)(316002)(2616005)(8676002)(4326008)(6486002)(44832011)(956004)(31696002)(42882007)(336012)(53546011)(186003)(16526019)(26005)(8936002)(31686004)(47076004)(2906002)(7596003)(82310400003)(83170400001)(356005)(7636003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2020 07:50:57.6538
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f0b70a-d0d3-4653-2e57-08d85302c1c8
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[40.68.112.65];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT030.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3686
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topicproducts.com=0A=
W: www.topicproducts.com=0A=
=0A=
Please consider the environment before printing this e-mail=0A=
On 07-09-2020 09:44, Felipe Balbi wrote:
> Hi,
>
> Mike Looijmans <mike.looijmans@topic.nl> writes:
>> Met vriendelijke groet / kind regards,
>>
>> Mike Looijmans
>> System Expert
>>
>>
>> TOPIC Embedded Products B.V.
>> Materiaalweg 4, 5681 RJ Best
>> The Netherlands
>>
>> T: +31 (0) 499 33 69 69
>> E: mike.looijmans@topicproducts.com
>> W: www.topicproducts.com
>>
>> Please consider the environment before printing this e-mail
>> On 27-07-2020 12:23, Mark Brown wrote:
>>> On Sun, Jul 26, 2020 at 09:10:39AM +0200, Mike Looijmans wrote:
>>>> On 23-07-2020 13:05, Mark Brown wrote:
>>>>> Does the device actually support running without power so that's a th=
ing
>>>>> that can happen?  _get_optional() should only ever be used for suppli=
es
>>>>> that may be physically absent.
>>>> It's the 5V VBUS power for the USB "plug" that's being controlled here=
. It
>>>> must turned on when the controller is in "host" mode. Some boards arra=
nge
>>>> this in hardware through the PHY, and some just don't have any control=
 at
>>>> all and have it permanently on or off. On a board where the 5V is cont=
rolled
>>>> using a GPIO line or an I2C chip, this patch is required to make it wo=
rk.
>>> That sounds like the driver should not be using _get_optional() then.
>>>
>> Making it mandatory would break most (read: all except Topic's) existing
>> boards as they won't have it in their devicetree. I'm perfectly okay wit=
h
>> that, but others might disagree.
> you're perfectly okay with break all existing users of the driver?
> That's a bit harsh
>
It turned out that "optional" when used for regulators means the=20
opposite of when used in clk context. For regulators, "optional" means=20
"don't supply a dummy regulator if there's none provided". So=20
get_optional will just fail when the supply isn't defined, while=20
get_regulator will just return a dummy in that case.

So the v4 patch which doesn't use "_get_optional" works for both cases=20
and doesn't break existing use(r)s.

--=20
Mike Looijmans

