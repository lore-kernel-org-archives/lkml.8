Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D2AC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 626AC208E0
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="lfFDAzRs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbgCaTFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 15:05:51 -0400
Received: from mail-am6eur05on2105.outbound.protection.outlook.com ([40.107.22.105]:63328
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726315AbgCaTFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 15:05:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQrcLGIeOJNaeIq7q4jViR09HkKKxkfF1//m5wPFe0Uft/knqwDq2Sk39nUZr/DiUQlRqcJfbWvsNbuE/Cl8yPL53EYiF28SFh4JLrAHBTKY91wTvvh+ABBIUJtA9cz1TP5ZzexQGJiLaPuGeZD0JA8zcKILNodzy3Iw6KfsOE8w5sYq2HseM58WahNeca2G2Bb8AggLaaK815i1ljaq9prTq2UbWG0k9WsnIvZidFf4xH4OMt9BxrVWVmnVGh6M1vOs/kdqnSwHWVAfDJEbpGrRhNFbGusa9SUwpnZoHb3p8kLfdfuYAI85dOrq9k46+a6IOAkOpD0l1YYYqz9IqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0JScOtH5XtyaTyCrYE+dKW4zuYpRAiXCJ7KoVy2qvk=;
 b=B9jBl69CPnKnEZ71Za0a8aorA2lduxYyLs/cTNoQn8ItbBxRxCQL+qmCYGne3pa+xg9BhP9r7BFmcsVnyJOxIVF6Z4USEyYJmRPbaZVweKRpn2qkV2ZcdMHxVsA28SCdLF7TsuDJLdG/o0GR7lPJPtCBTuiYN/a27kr+ARZO/yatRvAzJnMjayQa0H1exbWGpufIjNOH+XI62Z8brmj4gxVtxCWed9utQ1UUnr3IufCRknTmLkToWZ7V8Hg5AmbgR3p+4Z/GN50Lnfk1XzBFdYqyGLvm7MxkR+kloxeS++MO5BnlCA+EynFeoiyZ2cgQFxF8tq+D29gtDVDMiVm99g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0JScOtH5XtyaTyCrYE+dKW4zuYpRAiXCJ7KoVy2qvk=;
 b=lfFDAzRsqeBWPW3m5zm+CSxoL6EbghtXpwJEo2wosTe5tlOoIfTJEuju6MMuUPj+hTTSps1eR2oRCG3lFHuk+DKm3YrY63Na700bAUmi9Rcnty+owYqxmiMpXQx8cMHemm5NIYCzPdf1R77R8dhBQF0oAclj4Y9rnJf9uteWezo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=rasmus.villemoes@prevas.dk; 
Received: from VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM (20.178.126.85) by
 VI1PR10MB1837.EURPRD10.PROD.OUTLOOK.COM (10.165.195.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Tue, 31 Mar 2020 19:05:47 +0000
Received: from VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e58f:1097:b71d:32c7]) by VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e58f:1097:b71d:32c7%5]) with mapi id 15.20.2856.019; Tue, 31 Mar 2020
 19:05:47 +0000
Subject: Re: [PATCH] compiler.h: fix error in BUILD_BUG_ON() reporting
To:     Joe Perches <joe@perches.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Santos <daniel.santos@pobox.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ian Abbott <abbotti@mev.co.uk>
References: <20200331112637.25047-1-vegard.nossum@oracle.com>
 <dc53b8704ec674cba636b41d7f55bf507a7bd7aa.camel@perches.com>
 <123d3606-cebf-4261-4b04-7d53d1fcdb07@prevas.dk>
 <ae25b7b1efcfe4eda9465c4fb4712ede928a33c4.camel@perches.com>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <27c2c661-43f2-1297-cc64-9ed3a7c10e26@prevas.dk>
Date:   Tue, 31 Mar 2020 21:05:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <ae25b7b1efcfe4eda9465c4fb4712ede928a33c4.camel@perches.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P194CA0056.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:84::33) To VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:e1::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.149] (5.186.116.45) by AM6P194CA0056.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:84::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20 via Frontend Transport; Tue, 31 Mar 2020 19:05:46 +0000
X-Originating-IP: [5.186.116.45]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64c3f314-83e7-4d03-4453-08d7d5a68549
X-MS-TrafficTypeDiagnostic: VI1PR10MB1837:
X-Microsoft-Antispam-PRVS: <VI1PR10MB1837F379F950AE453774A9ED93C80@VI1PR10MB1837.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0359162B6D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(39850400004)(136003)(396003)(366004)(376002)(346002)(16576012)(5660300002)(36756003)(4744005)(4326008)(8676002)(2906002)(52116002)(8976002)(6486002)(81156014)(8936002)(81166006)(110136005)(86362001)(16526019)(54906003)(316002)(31696002)(26005)(186003)(66476007)(66946007)(31686004)(2616005)(66556008)(478600001)(956004)(44832011);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: prevas.dk does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lnHsmnXrZvUbD6RnMFD9AgacYaAqXS68vdFfAWsNsfxohw9I8kewbgh4AbGMOybGNgANEW3rHj/QSm9Bfytpz+WAMH5LySQYgg9k/YT+r5B55CRmV7mk4I719j+qF12uF6rnEAwYlOf/GD60oTlPTZrXxtTrXrm9U7AJVl6+tGkc3RikZzOz4gfHnsEUUeBj3jdrYuRVfWU0i40nmw3Lrgm3LdhTg0UVBUu4ZZ2ISPzZ1gjR0amXGgh4BnlQVu/OY03zy2bRrKbZkb4ZeTOLbC9RNW5oyImt6doTPiAabeXrSMjYiOXGawei+qi13pnRJNgvgMPVO90/GKeDtW3uQzyc4ToASfkx+EAyqsRc5zPpH7Cspwhn9JXLG3CuOJVY9iRBqMYxL/EaUmPskgogHFhurM/I/cnCX3JfUplHQx198b2Pk2ES7zruLRPz4Osz
X-MS-Exchange-AntiSpam-MessageData: rZ9a6FKOAtV83A+LVVjL6gja1p7l2nX2Ss995CH4TNwE3xytlmFOtdSBrJ9vinKyc9rPaaRXlRcSkFP+xocv4JInTyiXrdsUVi23WPkmDlWXz4RVT1B3yKMH5GwuzU+D7+n5+BP/cb4qlWSmMg1wAg==
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c3f314-83e7-4d03-4453-08d7d5a68549
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2020 19:05:47.4662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Arule1uKP0rY2hd9TkXCkKNUcYGVgLpHbCRDKhbjhDvapbTOALGx0Z9mKtdo5OGnRH6H+coXHi9km9qXG4TuYg0mgQ/JPQ/PJAf6pjhllo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB1837
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/03/2020 21.00, Joe Perches wrote:
> On Tue, 2020-03-31 at 20:56 +0200, Rasmus Villemoes wrote:
>> On 31/03/2020 20.20, Joe Perches wrote:
>>> On Tue, 2020-03-31 at 13:26 +0200, Vegard Nossum wrote:
>>>>  #define compiletime_assert(condition, msg) \
>>>> -	_compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
>>>> +	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>>
>>> This might be better using something like __LINE__ ## _ ## __COUNTER__
>>>
>>> as line # is somewhat useful to identify the specific assert in a file.
>>>
>>
>> Eh, if the assert fires, doesn't the compiler's diagnostics already
>> contain all kinds of location information?
> 
> I presume if that were enough,
> neither __LINE__ nor __COUNTER__
> would be useful.

Not only useful, necessary: They are used to create a unique identifier.
Which turns out to not be unique when one uses __LINE__, causing the
problem Vegard saw and fixes.

Rasmus
