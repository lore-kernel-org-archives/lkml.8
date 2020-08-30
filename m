Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02107C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 05:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2C2D2076D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 05:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="a0HRm1I2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbgH3FXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 01:23:37 -0400
Received: from mail-eopbgr760077.outbound.protection.outlook.com ([40.107.76.77]:27278
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725815AbgH3FXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 01:23:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nFBqZN20GEaCo5Dp6orDPhW6UMus0XZ04sPbp7xzYUdSO2YTHJb7bKiLiR1xH+RRSa3dtAo5OSawp2wG1iIQ2vn/3Aek+xfhs47y91RFCdqUtezD7A7sLc/A5jId44s33yuGSqYGj3npnqvKY+cNQabF5H7msq/9nPoPmD8+Hpcw4jn/WgWdAZJFrZOgOhRos301m+2KoJ+tbTA0lCncgCYuOemP1UlG+mpR6W8bbSy/cfdT8MLCsyWNpXWDQ/4wqOnM5h0vGhQji5ln7qdjw395Ozd4fKYbjCo0iv+7FMf1U1BzmXCMJ6tSjgr3jD7U3nyOpl8uMlK4DzKiOLlRmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5HuVKvJH/D+m89S3vqrmmtkeG/FJf0eLDbzgaHV/ww=;
 b=jtR8L6n1TVcEpTTMX+3L9V5v+4WnNaOCLpbBb1Z4XiBKDLhZFjrg2rxGL7EGBaOUUur/WcYmhfeGq9HXfr8uB3u+mTJwVMnUgc41Zy9Ac8Dd9qrFVW68wRZpl8SSm+ot9Fj4Sly7mSLecqEYG+LYGXqhn78itrQX7MUoDw4ajXJPyXgfJ5v4ouPhRmr8DAmiuug9Dpf5cZBEkXVVaRLGKOyB3pdjxqtqUIoeSJ1kuepzLP5rhRO1qDvHv8wdPfP28Z9jtSwatjL1Cp2iC8eTfKz59PabbKd8a11RKg6QBQH9uBTBv2T8uWmfH8gQ/YVB0hs5DV2GxlgF67FKOeph1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5HuVKvJH/D+m89S3vqrmmtkeG/FJf0eLDbzgaHV/ww=;
 b=a0HRm1I26OIlTvStpBK9ii6JCYXl4Ag05sqiVRxeERIhJ8nLzlfbCHUf8Ew51c/QxSR0/YRqm5zOxHZ4rInTg96M60a07UI4H426Ln4eQENmwBerQ/3N2847xb+9Jf+DHvjyKg2iu5UfiKJcIXbLTYVyOYbIemDUEfzYuNoo/tQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BYAPR11MB2725.namprd11.prod.outlook.com (2603:10b6:a02:c5::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Sun, 30 Aug
 2020 05:23:32 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::8d64:f85b:1cce:a1c0]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::8d64:f85b:1cce:a1c0%5]) with mapi id 15.20.3326.024; Sun, 30 Aug 2020
 05:23:32 +0000
Subject: Re: [PATCH] USB: integrate macro definitions into include/linux/usb.h
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200825154421.5463-1-yanfei.xu@windriver.com>
 <20200828074826.GA962117@kroah.com>
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
Message-ID: <97eb35be-9550-ea50-da72-5ce10757379b@windriver.com>
Date:   Sun, 30 Aug 2020 13:23:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200828074826.GA962117@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR02CA0187.apcprd02.prod.outlook.com
 (2603:1096:201:21::23) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by HK2PR02CA0187.apcprd02.prod.outlook.com (2603:1096:201:21::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Sun, 30 Aug 2020 05:23:30 +0000
X-Originating-IP: [60.247.85.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb29fd4e-5a64-44f6-80a7-08d84ca4d5c3
X-MS-TrafficTypeDiagnostic: BYAPR11MB2725:
X-Microsoft-Antispam-PRVS: <BYAPR11MB27251D2D08A750AB7BEBC96BE4500@BYAPR11MB2725.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rqcMaSt2Vr7t450N5SCcRC4hfVGa6yViEuwsu3ha2SgyYPyvHqphCFIMg28O6vU7MXPSG4zy+xALRTBYxq3D9lvMUs5NZUbmKQ81Zer8OSfYyscYJz/9lT+W3t0o7uNLgYby9b+be8RDhYqPyhVFbDJTMgTdJfRRGvTrlLwH9t9+f0TrvUKvn25ZjPb3j2Anyc02CJ9liAgdxHZcIwyZsg+5aN4D9VwEGsgAQfR4Ehwz4UJTdOwiiYzArpSVSdIM4eDtSgrXbkex4SeBH7vsvj+VeFXMtamg6rETpHU5/rBzHj0GT8WvVcaAnbf4TUICcME9ET52aFY+ep7e8mME/MT8PON1qlKKC3qQSrhZ+6KyzuF0pOJnfAtvafNTWCIY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39830400003)(346002)(376002)(396003)(136003)(956004)(31696002)(2906002)(36756003)(86362001)(316002)(2616005)(8676002)(478600001)(6916009)(4744005)(8936002)(6486002)(66476007)(66556008)(16576012)(31686004)(53546011)(5660300002)(26005)(186003)(4326008)(52116002)(83380400001)(6666004)(66946007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: e0y3q/iWhCkBZG1ruXiRE1dYdYPkA6k4VVa3sYKgd1Tlobu8muuu/ql+sQaT+u67K35ETZlxHu+ysWAYLZZb+DXJMEVflRuyb7buwZMjqDepxAFdZuni+jIvouHPO+HHoxvN4HHgT+suM4/EYuZIIjMZ3P2vkCgNApJpydeeWXIDPMqLWDCGZMLrGaf7jBho5uTrO39jUNugIaXPJRypIbNTbU8cKvl3mBjqaFhOrUvgnTbP4vlYyAL29+5WgYEmsV5RGenNORwr7oOidraDhxfG3GuKOuzRta7SXDjcLRT0UimjISdCMROpHr0MiZx74rWFU1hLhmTJp6LP+Zj9Pd+V4Pufe1f4/cxOe5q0dXacIdYJuL/ocLpD7QwUcxtl9/YshfUNf6AK2Vs3rqk2DUupBRVezMwEdK756itD55t1OxOjXtG6eRgPEsA/ESbn5vNbp7P1pYPPK7xAi1mf1/TgiFiwfgldh7ST05WyALZq0Wq351sTiqM2ivlD8u0eGVZs8zaPYD13xTcnvmv9EFo9rWKWYW0TSB5G6IGDDifRHHa62MoSE//EGqLvlcW0+m7d9WJt5rXDoIVFi6yVUaOZoFoHkuyWDmnYRldhz+YjsZv2dTnEl+GmD5hV+T8avkz82v7Tk5j+aGUUfxdryw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb29fd4e-5a64-44f6-80a7-08d84ca4d5c3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2020 05:23:31.9890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ygoU9g45mJojPnI46D6arpBRfkkl4h7Hd63lLpmZ95gIIMu5C1BxvogjU13sxad+qS5PRwFxga0IS43rXTvS0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2725
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I just think it is a clear up to make these macros get togather
which have the samilar attributes. That's why :)

Thanks,
Yanfei

On 8/28/20 3:48 PM, Greg KH wrote:
> On Tue, Aug 25, 2020 at 11:44:21PM +0800, yanfei.xu@windriver.com wrote:
>> From: Yanfei Xu <yanfei.xu@windriver.com>
>>
>> include/linux/usb.h also contains 'Hard limit' and 'Arbitrary limit'
>> macro definitions in it, hence we can integrate these from config.c
>> into include/linux/usb.h
> 
> Why?  No one uses these values outside of this .c file, so why put a
> value in a global .h file?
> 
> Who else wants to use these values?  If something else needs it, then
> sure, it could be moved, but until then, there's nothing wrong with the
> existing code as-is from what I can tell.
> 
> thanks,
> 
> greg k-h
> 
