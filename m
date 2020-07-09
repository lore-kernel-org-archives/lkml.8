Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBCEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 13:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98DB820672
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 13:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="CvOZGDPS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgGINan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 09:30:43 -0400
Received: from mail-db8eur05on2101.outbound.protection.outlook.com ([40.107.20.101]:27104
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726410AbgGINam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 09:30:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZmJAKzSENVsWmCkZxpG2l3QFhPWYeGpPhddWWzT14gG90cO1L4pH7/p4eVtxrx85FpcCNmTt3/iGghilHaM6ktwwaFpy25eKC2PvOhVsPfVTbp3D3jMS+Up1iYU7WnjlQdHTuMWlh3hYatbO5Q71/saozxRHIrkQpiUZkU0BCKwV3uGVb92B7pBSQZcSX5ViEI0N7OTTBY/Z7+VXlHeEK64oX0w2UulL87XQC3+0gHI17b9B4FmSSI8D6kI5KEroST0ETI2kEb1sfJC+auA8sUZtrZca5/tOVIVfNDx5zw0t2516GhQaW49rWs+BjJlqTzjt8h0l1gl1EmQUqIs9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAeZYf3SvA6JeaYIiizz8yVG6siP1BX/dNiHJGJRBOQ=;
 b=jktpsAo6u8X+2+fGxM+DTdeiBty3MPUDLZxgV8Agvxj5wMZpHpq6SIYj3pUxgu9XzUTqYU+0aSIAqfokRnS6a9jGCQ2Orpy+n5+8IidXG0xCGXbCKfAeGd8tgfk63ca7I1tcnIbN2IycJgQKHpNkUn13y3efHW6NDoicgp4NwS31PO6eIvJZ93VH2WghzbPzIXGu+SZdQUMRDPNHXia6/b7QWyu1uNwANPCUA4j/JDG3ry5QRx41uBr5qCogdFDstK8XAjMT7pjffdXVOPT10E+T0iAZiH7j2Yzvn3XGg31/9Yj08iy0Ga5M+KZ5X5XH07NGKOOiaD/TLdlN4U5xIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAeZYf3SvA6JeaYIiizz8yVG6siP1BX/dNiHJGJRBOQ=;
 b=CvOZGDPSUS0AfMDwURKGqkobAXLajYUBtLAcrW+B93SAj059h1rP4TrLLkbnulfgfJFbuXXK5Xmsg9i2yEbDoZInfDef2Xh7nd0gTztjkhmwR61hiZL0XKR0A7qTxACaqVjI+CuqSVDJl9KOI0rE7lNbdoB5qZDiWXUBm6H+/ic=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=prevas.dk;
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:3f::10)
 by AM0PR10MB2867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Thu, 9 Jul
 2020 13:30:39 +0000
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::91fd:aebc:e8cb:a663]) by AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::91fd:aebc:e8cb:a663%7]) with mapi id 15.20.3153.031; Thu, 9 Jul 2020
 13:30:38 +0000
Subject: Re: printk of non NULL terminated strings ?
To:     Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
        "schwab@linux-m68k.org" <schwab@linux-m68k.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <4436dd281299b46f431ad1707c5de42af45ea4f7.camel@infinera.com>
 <87h7ugu9rk.fsf@igel.home>
 <0a4fb48c210c867139f4b171384b8d53a420ff7d.camel@infinera.com>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <4d081ee7-5527-f821-5e9e-87ff053f7d2d@prevas.dk>
Date:   Thu, 9 Jul 2020 15:30:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <0a4fb48c210c867139f4b171384b8d53a420ff7d.camel@infinera.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0106.eurprd02.prod.outlook.com
 (2603:10a6:208:154::47) To AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:3f::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.11.153] (81.216.59.226) by AM0PR02CA0106.eurprd02.prod.outlook.com (2603:10a6:208:154::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22 via Frontend Transport; Thu, 9 Jul 2020 13:30:38 +0000
X-Originating-IP: [81.216.59.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d50290e-3ca1-4cd0-ccf4-08d8240c44d3
X-MS-TrafficTypeDiagnostic: AM0PR10MB2867:
X-Microsoft-Antispam-PRVS: <AM0PR10MB2867AAFD9131DCC86030316B93640@AM0PR10MB2867.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cKlYWIZm/YhZaTy/nxwfEe1KbbdUct5AkaX6jjlRXkBtPNXSWmSZ+qj5+4Wev55jG0hOSgUISBtsLAH4w1O5NghQOOBFf2AWhyRRDSTMXZJpIGvgMVqg1stQax+92WMm30aSY4Erya+ElJldL4Vihz8hB4GR8ilaS2+IgsXrjXGdm8tnLASiaugZAOF2Pht91htnALiqXfko555U+s3Vuac3LElZkxH9pF9UOX63UsJmw9Exxf+HZKT6hCtAQDd+mdpZOiR+yvMXgogpo2XhgfXiISUMZBULVX1Q3xsX6j2ZG1J4M8E+G6Ot8RA2KiCSzNHEJyRMBXZNpWTi9a/JKuPkgWoFf5M80fn3tvWoMDVVJ+x12Uhk6bEroP0HcsEK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(39840400004)(396003)(366004)(376002)(346002)(136003)(8676002)(31686004)(8936002)(16576012)(316002)(110136005)(8976002)(86362001)(186003)(26005)(36756003)(44832011)(478600001)(5660300002)(6486002)(16526019)(956004)(2616005)(4744005)(31696002)(66946007)(66476007)(66556008)(83380400001)(4326008)(52116002)(2906002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: uIr2Bldqp/zA1cp1FqRFPAhV/a5RKFKXY570m9ShpU+gf1z+rbupMB1a24XM2+1v0uYDeMrKcrnHEetd/FncJoZHSgvtdAEw5cpcqjDPW9+Jna49ypuTxmAoHTkyxUTSNtb66kOnAd2evAPWc345agzuB5k47afb7NWRuvsfZ3oyMokmOGPhpfDHX6Jn2VE4iKnQZFrY1St3o7ss2/fgJDSADnQ9IS/ofh2WURJA0uKDYlxFbIpdBVq/lIswb4raQan94EqRvcDrx3z2mKNPf4aYBk02AqupSg2zYuEoDfCpHw3SThHJ+X7aDqPLIw8uDNcTUZqCXJg7zt//+W0zSW+J9cZ6tRmnexsOp7E9uXGL9iFWd44/VhNgvFdGvRVgR/Pl0vPUjz6cbyp9U02ODvgRKy4T7Pi/5Jk1eiYTLWFU8cihrUhXcfWVSIXOAoCl4jbGiYk9cGzKnNe3BTYVB4ILND/3heGvOiUc7gYeLWU=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d50290e-3ca1-4cd0-ccf4-08d8240c44d3
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2020 13:30:38.8042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zCDg/3zMXd0+dN8qWgmGfBOeFFnoK/tGSaOaatXUuDogfHgvJBGlT/R9MHwBhNyS6iBGZBVtV944KNa5vhcEXcVMz5A+tVsIR7bQbyMFkfM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2867
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/2020 15.26, Joakim Tjernlund wrote:
> On Thu, 2020-07-09 at 14:56 +0200, Andreas Schwab wrote:
>> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the sender and know the content is safe.
>>
>>
>> On Jul 09 2020, Joakim Tjernlund wrote:
>>
>>> Is there a format (or other function) that lets me
>>> print strings without an \0 terminator using an explicit length arg instead?
>>
>> Use the precision.
> 
> Looking at that now but have a hard time figuring how to use it, can you give me an example?

Exactly as you'd do in userspace:

  printf("%.*s\n", len, buf)

Of course, vsnprintf() will still stop if it encounters a nul byte
within those first len bytes in buf. And you need len to have type int,
so you may need a cast if you have a size_t or ssize_t or whatnot.

Rasmus
