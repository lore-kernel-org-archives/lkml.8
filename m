Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FDDC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 16:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2787206C1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 16:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="lOYaOC2g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgGVQkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 12:40:09 -0400
Received: from mail-eopbgr70098.outbound.protection.outlook.com ([40.107.7.98]:13204
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726535AbgGVQkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 12:40:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AjihKoPJt2/uq1ZL+gM156qYzgTShfSPl7hBJ/G9U8lZHccJX5QaknkW7AfCQBTyYCYgsa3EW9TmIZ/TXB9VjsDMGyi9QckHEUqpFhe3l47nykyuaOu45qcEjUmNzeqB7ujQgNE6Z09/X5IoKemlCSrv+m3tz7PX/K4cBJUC5d3Qic5bgn1nEj6PqP372RyKOQSocRiBGGEm91xbZgldhmzDSezy6e60ak0v22O9WK6IrDU0GbuhfZFsk1PcyjM1N9mabYb1ax07iihP5B561Kw3S7t7siTQNNUxPgXiPaWFNr7tohonxuwUOi7q09rvcXvGkPJerITsxOjWywf3pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBPM6Z2MJvvUW2zrdPRg31mqjTPTh4rRrHAIANYyHjY=;
 b=FOEErujOiw5v+vbxI39fMyQDAjoSACwB2zaTWpuBZmhAcwqSo3hO/5mZSKuABSwh/ERSEABC3oXOK1TVFUu01kYIRbVuVE/xkVdaC2ldSma0FJSqI+uHt4zYYtubxrwcAdaXOZjqpfDZvunxeR6VsuMUNQi4f9lOuUCIO2Bte2gsqay1aoFB+w7EUIfGb3RRCEnAmCJT5SUMIk/djJ2J9n+O9UP8XO3+9NptxS4h/feDRCuQ7QFTFvvHMMPHndko84DG5Rictjf9YgwoBqsiJNjHqHzzEhvIQpGna9h2G/wFqqk37ALjDtVX7Ba0LyMmgNzIrvRfPeZhjTZ6Xt6K3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBPM6Z2MJvvUW2zrdPRg31mqjTPTh4rRrHAIANYyHjY=;
 b=lOYaOC2gh5Xl3S5AsQduEz+U46JDcCCd1yS+xFVCIRdi5/Nd6tlSxYYqEhxOjXTgqOhfTwl/okyqjNaImidIVaaFDO7R816lYW6lAtssiifiDuIno+BluRjqke/fERbl8A2pHVGcjSi6f7fSx5N+i2FBL6KB3SRxzkxsqjOk0yk=
Authentication-Results: ilbers.de; dkim=none (message not signed)
 header.d=none;ilbers.de; dmarc=none action=none header.from=nokia.com;
Received: from HE1PR07MB4412.eurprd07.prod.outlook.com (2603:10a6:7:96::13) by
 HE1PR07MB4379.eurprd07.prod.outlook.com (2603:10a6:7:9b::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.14; Wed, 22 Jul 2020 16:40:04 +0000
Received: from HE1PR07MB4412.eurprd07.prod.outlook.com
 ([fe80::7071:9f4d:b39a:823e]) by HE1PR07MB4412.eurprd07.prod.outlook.com
 ([fe80::7071:9f4d:b39a:823e%6]) with mapi id 15.20.3216.018; Wed, 22 Jul 2020
 16:40:04 +0000
Subject: Re: [PATCH] mtd: spi-nor: intel-spi: Simulate WRDI command
To:     Tudor.Ambarus@microchip.com, mika.westerberg@linux.intel.com
Cc:     vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, ibr@ilbers.de
References: <282e1305-fd08-e446-1a22-eb4dff78cfb4@nokia.com>
 <b5c17892-24ec-a690-96ca-d2238b8925d1@microchip.com>
 <20200722143604.GQ5180@lahna.fi.intel.com>
 <99e3f6c7-e9a6-584c-883a-0882f5137b7b@microchip.com>
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
Message-ID: <19cd6fb0-1fd0-2a2e-2612-5a5bc159386a@nokia.com>
Date:   Wed, 22 Jul 2020 18:40:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <99e3f6c7-e9a6-584c-883a-0882f5137b7b@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0202CA0002.eurprd02.prod.outlook.com
 (2603:10a6:3:8c::12) To HE1PR07MB4412.eurprd07.prod.outlook.com
 (2603:10a6:7:96::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ulegcpsvhp1.emea.nsn-net.net (131.228.32.167) by HE1PR0202CA0002.eurprd02.prod.outlook.com (2603:10a6:3:8c::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21 via Frontend Transport; Wed, 22 Jul 2020 16:40:03 +0000
X-Originating-IP: [131.228.32.167]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b52c783f-29d9-4ddc-c8d2-08d82e5de28a
X-MS-TrafficTypeDiagnostic: HE1PR07MB4379:
X-Microsoft-Antispam-PRVS: <HE1PR07MB4379F8BEE6A96D0B0662234088790@HE1PR07MB4379.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O/thBFaTDGZEl0Wp1l7ITv2X1OUbHAFZCDXzF67niOaX6AbpTwAMX76aL4OiP7MITxfWr2jazMXw7MlGmBSm4/GgbIoUOpJGYVVjGEffLVxhXONZOMxFlcgF1GPeTXJnzzoX1/ZowPWKBsxgcvAwvHJAnhI5RBq/kUVhTENZ11C4j/vYZUepPhrpyPV1NgLDhrqe6X2/66JHyr4tk1Q3wTIKDd/4z9Uw+8mXmEV2cieEFgduz7MdxrCspxYYLupdzyfGDvjY2XEbDWPK7hYS9gVKVenbnztdYDI1leQYWWIZaMtEYsyuOEA8GXAQq9MUDK1u7d+DSN+uJi0sS3sh2fSg/JyjzU9IMX4lDizeD9SxdxGDp77tBkDAchQ6HEeT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR07MB4412.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(376002)(346002)(366004)(396003)(66556008)(66946007)(66476007)(86362001)(26005)(53546011)(52116002)(6512007)(6506007)(8936002)(478600001)(8676002)(31696002)(31686004)(2906002)(6486002)(16526019)(36756003)(5660300002)(316002)(4326008)(44832011)(186003)(956004)(2616005)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: JjYmxreEP/5Q4Y1Tva3sOW05RHkba+pSaBpoBIGZDgO4UvovEhzC0QVsUcIIicwh+bE0vr/uZACcOQ+KCvPKqaNKECBt8v3ob+XogQhfjfsMtqG1MYpCD0SzSer/u6/YXK8O8x5t7KukVriHSJdlhFHK0KsbQm554TuXNzk1Hp2AGR0qv/RYbIpjrHy0PLGtkdxmsZI+EwJ6zvengR/96M8o/FI+dNXzO5RQRQ+UyiLCepAYH5fuVdPoLMN02VyG4LXlpXddW4SyuxtzTWQHqS4M4HKoB/xlj+EQ/SFsptkVL34P/137lJvjKYYkAmN436GK5pBAh5yE0FrUHHuqYayQ9pqletSeYzT3QxCgIdc9VdR1qJzZIv/3A3RYMHCavkJccbbEs2uYE1HK/CO6zc7NNaHFXquISPtXRJhxoMYja9FZ6tAM+Y/SE5aB9J43Ht5Vwt2na6PadHawwSjCWxTOWZbsp9dBdPNYCwD2tW9XekLwz211byXpK+S3raQq
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b52c783f-29d9-4ddc-c8d2-08d82e5de28a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR07MB4412.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2020 16:40:04.4925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e5S+9lkeLE71V6uPn/plW+Ok9dMqK5uYUVvXHwC24Lgz/9XFs4GQ9b1EECY4SGt9Go18jPqgJobWDKytXc+cHsixRj/2wDPOlJF6e0RnG6w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR07MB4379
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 22/07/2020 17:18, Tudor.Ambarus@microchip.com wrote:

[...]

>>>> After spi_nor_write_disable() return code checks were introduced in the
>>>> spi-nor front end intel-spi backend stopped to work because WRDI was never
>>>> supported and always failed.
>>>>
>>>> Just pretend it was sucessful and ignore the command itself. HW sequencer
>>>> shall do the right thing automatically, while with SW sequencer we cannot
>>>> do it anyway, because the only tool we had was preopcode and it makes no
>>>> sense for WRDI.
>>>>
>>>> Cc: stable@vger.kernel.org
>>>> Fixes: bce679e5ae3a ("mtd: spi-nor: Check for errors after each Register Operation")
>>>> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
>>>> ---
>>>>  drivers/mtd/spi-nor/controllers/intel-spi.c | 8 ++++++++
>>>>  1 file changed, 8 insertions(+)
>>>>
>>>> diff --git a/drivers/mtd/spi-nor/controllers/intel-spi.c b/drivers/mtd/spi-nor/controllers/intel-spi.c
>>>> index 61d2a0a..134b356 100644
>>>> --- a/drivers/mtd/spi-nor/controllers/intel-spi.c
>>>> +++ b/drivers/mtd/spi-nor/controllers/intel-spi.c
>>>> @@ -612,6 +612,14 @@ static int intel_spi_write_reg(struct spi_nor *nor, u8 opcode, const u8 *buf,
>>>>                 return 0;
>>>>         }
>>>>
>>>> +       /*
>>>> +        * We hope that HW sequencer will do the right thing automatically and
>>>> +        * with the SW seuencer we cannot use preopcode any way, so just ignore
>>                            ^^^^^^^^
>> Typo, should be sequencer.
>>
>> Otherwise looks good to me.
>>
> It looks good to me too. Should I add your R-b tag when applying?
> I can fix the typo.

Thank you, Mika, Tudor!

-- 
Best regards,
Alexander Sverdlin.
