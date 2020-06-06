Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADE8C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 15:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 161CD20870
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 15:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="rMPF86id"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbgFFPQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 11:16:29 -0400
Received: from mail-eopbgr60098.outbound.protection.outlook.com ([40.107.6.98]:41294
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727770AbgFFPQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 11:16:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9um1FOXHv4qol4ZiINWiLzfIa2IAkTQyV/KpyEzcBJ00jNGfvoRABWYD8gaw9b8q5wI2jCQWodtxMGYTdzg/aFuFP9XdsmvzXgYpJzCF6gyqxhVHsPZedRU3OuuYsnX/kBrcRSRto+M3QoOZLz3IkESWsEDxLSqtKkrdiq0qMaG/DV0wH6qZw9LTs5Ir8lt/kDd+JAY27x/iMWZ0Bnp7au3UrJVYCk6RHwDCtmWv4h2w+m9MRS148ihwClQcEE40Cdg0zKnHGQZ0evalyeAxfaryXbTAjf17826gOrIk/5yUcBdFHojYvQw91oyaZ5fLbOWJYDtC9l4KQkt7iSLBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQkM36NklMLhshF0pYFRx/vDsC+t16ZOnsfG8jtE6tY=;
 b=Q5yOOrGHaKgrh/QLzrVzsszh/ufRP/dNJEVceobrFGFNIG1IMnZV+uNAS9NPHgvVA5+RDIBkLSQjOpgjO/Q7R2hOQ5yfcLG/z43T7X3N1gBHWIxDyPH1aA9bCFM0VbUpCDrhz37YT5zc06p2oCriwuSKtNUbyk7BcClf+9pGyhuel8GokQCB2kZFeRGe+7YfR3eOSRonw6g6U+T6sM5qkjQlq3YV7t3SKomX9VQEXZfFmcIXhR616dQot8Evz3Nbjj48zhEGsE8BTMJWlpClIMNx4HWTpAeZyvD1wayalRPld9F0d94qJ+n4ddjlavXQ2K/yZSh7UI9o6jzX3TyZYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQkM36NklMLhshF0pYFRx/vDsC+t16ZOnsfG8jtE6tY=;
 b=rMPF86idAM2mN7bAAFRP5XkODD62lJahsrKaskFfVW81wQZtIS8pNRSpAXLUxfWQtdBnS38B8gv8IFMm7y2bOTNmP7Ilmu5I8cqmlc9kBrjXDmg2ger7G0CEUFe0d163w6PK+iX++WjZ+MtaChXBWSn8b8FVB072JyjYhRQ0Tvg=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM0PR08MB5140.eurprd08.prod.outlook.com (2603:10a6:208:162::17)
 by AM0PR08MB5362.eurprd08.prod.outlook.com (2603:10a6:208:180::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Sat, 6 Jun
 2020 15:16:25 +0000
Received: from AM0PR08MB5140.eurprd08.prod.outlook.com
 ([fe80::b8a9:edfd:bfd6:a1a2]) by AM0PR08MB5140.eurprd08.prod.outlook.com
 ([fe80::b8a9:edfd:bfd6:a1a2%6]) with mapi id 15.20.3066.022; Sat, 6 Jun 2020
 15:16:25 +0000
Subject: Re: [PATCH] lib/lz4: smatch warning in LZ4_decompress_generic()
To:     Gao Xiang <hsiangkao@aol.com>, Yann Collet <cyan@fb.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Gao Xiang <xiang@kernel.org>
References: <20200606143646.GB10839.ref@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20200606143646.GB10839@hsiangkao-HP-ZHAN-66-Pro-G1>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <330eccf1-6d4b-07dd-4e55-ffe3a179e4b8@virtuozzo.com>
Date:   Sat, 6 Jun 2020 18:16:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200606143646.GB10839@hsiangkao-HP-ZHAN-66-Pro-G1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR05CA0135.eurprd05.prod.outlook.com
 (2603:10a6:207:3::13) To AM0PR08MB5140.eurprd08.prod.outlook.com
 (2603:10a6:208:162::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.21] (185.231.240.5) by AM3PR05CA0135.eurprd05.prod.outlook.com (2603:10a6:207:3::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19 via Frontend Transport; Sat, 6 Jun 2020 15:16:24 +0000
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e82b28f-7eae-43b9-3ce6-08d80a2c93e7
X-MS-TrafficTypeDiagnostic: AM0PR08MB5362:
X-Microsoft-Antispam-PRVS: <AM0PR08MB536291C61D8EA1B490DB873EAA870@AM0PR08MB5362.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 04267075BD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S8aWo6/RZVsv1MrpRFOxtmpAAWHvUvyjrbew8Xg8z/LlJ9twd2kgYxd1uJOFD9bmo2fSANggPK+ZmvAgIuK5pjhKhgslNH07TZd7Dgbdf4Np8+bU/Z9QGXgJLPfNIqA8reGKx6fI9tLhDqAP9DzjJHyKtbwDuQhfIQ04uoArgI2dtOeePDXZBVDYMKyCu3l4fghC33Gmjqwi5HwB1ybR/dliDqEB8xsWyN5gsCC9ceYQwggf1NT4cBp8SSGA5ixl5CHtJpbUZuRIcVFxM1Gb9ndBw7R9H2ECuBsItq/dvr1n4Dt3Rl0un5fvvg5soJT57bFU9oc3ctL2kxbZw0hcgpbU+LDGDmrwnGdPUjQJpKgTw9du9zNFEIEHW/PKwEKzH7QI46gu1NeiuMs+sEJCUaflCnsuV0onmEKPeIKkkjSyn2vPQmL3Sdp6QKbILyLJS7PR96Y9DZKUBw2Iy1KZUY7eJqXOkefQXte/hzSc9Q0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB5140.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39840400004)(366004)(376002)(136003)(346002)(396003)(86362001)(31696002)(2616005)(956004)(8676002)(110136005)(83380400001)(316002)(8936002)(54906003)(16576012)(31686004)(6486002)(186003)(53546011)(5660300002)(478600001)(16526019)(52116002)(66476007)(66946007)(66556008)(4326008)(966005)(36756003)(2906002)(26005)(41533002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: qC+12/MnVMRBbAR6EyoELu2sem4q43qBbWwEam27L/Ftosw5W9/0Qt8DjUuOn3C9Oe06QcuUKdiepWPuuFJ1H/h1K4U3i2wJdj3QhgWTm7OmejzqeqkwaPAZD3/rD0IrnLcsrMXnqnK/5p42f4mn6puktSKvS7KNMzc9gx+sU/sH1xhOEyHrUvIFmqYV6Lftvc5YEGnM5j0siujiGgKtmvRnJbmqDyU9DbKwMDrVul+dZFvjkegbvvuskKccFUI8ccXwUK2skZs+vu/zajOCMfTuFJBqTA+oXHF0M/gC6h3OYxMKWaO9cqg+Vc2EQL3YEnlFv5/SCS3Ht2RkkZhXRMv1WV9ug0IkQFb3QpKwpjCnRmS0gkpPMHKL/TDl4URtHqCTQXPfAZ9mBV5E60+WNOaX39byLSxnr6TgbxeGK67ygVKPrxQvZA5kqn7TwDG2/mOvYWTqUFQH6H6ChDcjvAeNMi71ntWfjtR4eWZFxXg=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e82b28f-7eae-43b9-3ce6-08d80a2c93e7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2020 15:16:25.0228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wG5gfDOK1OWmvvpW7iZn1MKR+hgW04JwVfXK2bfcknI2sK0yzIS/8uyhb0/JEi91E12FQjrH6lFoOJV1lRzY8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5362
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Yann,
could you please consult us about your lz4 pacth
https://github.com/lz4/lz4/commit/1a191b3f8d26b50a7c1d41590b529ec308d768cd

Please see details below.

Thank you,
	Vasily Averin

On 6/6/20 5:36 PM, Gao Xiang wrote:
> On Sat, Jun 06, 2020 at 04:28:02PM +0300, Vasily Averin wrote:
>> Found by smatch:
>> lib/lz4/lz4_decompress.c:150 LZ4_decompress_generic() warn: maybe use && instead of &
>> It was realy incorrectly copied from
>> https://github.com/lz4/lz4/commit/45f8603aae389d34c689d3ff7427b314071ccd2c
>> line 1431
> 
> Simply no.
> 
>>
>> Fixes: 2209fda323e2 ("lib/lz4: update LZ4 decompressor module")
>> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
>> ---
>>  lib/lz4/lz4_decompress.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>commit 1a191b3f8d26b50a7c1d41590b529ec308d768cd
Author: Yann Collet <cyan@fb.com>
Date:   Wed May 2 10:33:12 2018 -0700

    simplify shortcut

diff --git a/lib/lz4.c b/lib/lz4.c
index c6f0426..b46910f 100644
--- a/lib/lz4.c
+++ b/lib/lz4.c
@@ -1429,62 +1429,29 @@ LZ4_FORCE_INLINE int LZ4_decompress_generic(
          */
         if ((endOnInput ? length != RUN_MASK : length <= 8) &&
             /* strictly "less than" on input, to re-enter the loop with at least one byte */
-            likely((endOnInput ? ip < shortiend : 1) && (op <= shortoend)))
+            likely((endOnInput ? ip < shortiend : 1) & (op <= shortoend)))
>
>> diff --git a/lib/lz4/lz4_decompress.c b/lib/lz4/lz4_decompress.c
>> index 0c9d3ad..f7f7dca 100644
>> --- a/lib/lz4/lz4_decompress.c
>> +++ b/lib/lz4/lz4_decompress.c
>> @@ -147,7 +147,7 @@ static FORCE_INLINE int LZ4_decompress_generic(
>>  		    * strictly "less than" on input, to re-enter
>>  		    * the loop with at least one byte
>>  		    */
>> -		   && likely((endOnInput ? ip < shortiend : 1) &
>> +		   && likely((endOnInput ? ip < shortiend : 1) &&
> 
> I'd like to say, this is not my mistake (even not an issue).
> If you notice the latest LZ4 upstream
> https://github.com/lz4/lz4/blob/dev/lib/lz4.c#L1865
> 
> Or some related change, the lz4 author Cyan did it on purpose.
> https://github.com/lz4/lz4/commit/1a191b3f8d26b50a7c1d41590b529ec308d768cd

For me it looks like typo in patch,
lets ask author of this commit.

> I think we could follow the latest LZ4 upstream in order to
> avoid further maintainence overhead. That's my own thought
> anyway.
> 
> Thanks,
> Gao Xiang
> 
