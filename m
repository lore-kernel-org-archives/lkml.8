Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB91C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 13:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6243A207DA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 13:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="bbtQm20Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgHLNhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 09:37:50 -0400
Received: from mail-eopbgr150105.outbound.protection.outlook.com ([40.107.15.105]:47614
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726829AbgHLNht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 09:37:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oeeVJgFR7wibtoPergOpLAuYSMBOUkB4WnCQCmuG+ems84jyNm0BEZmD2ymx9wIbrlEdH2s8cvzywE6nVxIWKf9cf/4mVkO9t/JfgQFaP/P7CfD4PcIjOee/jnQXcODYq9b1MSyl2lCNkvn1j4Z58+mv7V8Y0WExgZNL43Css2Fz8uI4UwPoWt3JPYE40m2RU7TtSUNZym+whSUtKvzIZMnXkMHUpLH9/BpF9bH56XFzATW0tiiWnN312aFbLGW/2VQzgos58zCGOa8ZIlEooc7rA/hFgTbAlhcVKMlc5CyHKPV2b9nMfGpSm41BpjF75Hq7jgzKv7Gt23yBbXWGaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yhj7yUH9Je/lNbfnbrUP3HFPE32koJgINNnnNMTx8/I=;
 b=Bh2/UyT8y6eF+ROSE0sWMFpNKTHUFGdHX7FoEHy8n9BvicpJrjdpyDHQ752W2FZRbYg1+uhmjJQVSMJ/2QEgyAeLWcaAEF5nZsND13y0Tb+802EgPfHdVX3wZcpXZO4p9tDSjvqrKZc3Iafn9Om6jKbTuG1xMKnRxLqDFUYd6UptUCv+Xa22dE8tXDVyxF3PSKqo4A0RAk6wNG3midwaXcewLDf5CE/DBom4EauyDpLAGCsD4BOctLEIZFF+DPPEZc/6CxEREraMy4Y1XiEKk0SL/9moqBPpIs0y7q8wqOTMqq/z9kHBa45LuhLUGpV8fOdBPxGyq5P9xI7x89LwsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yhj7yUH9Je/lNbfnbrUP3HFPE32koJgINNnnNMTx8/I=;
 b=bbtQm20YJ2pynhsMGjgU2rTW6oIBV9FDCG2CRkcF9XvEt43L5LLeymIMD1gck8lW5HM10mrMfVf30B7+V4ggeDJ7cPVeJo/8YPW1f+spTWvst+h2HWV+nFYGGG0DY7q5zozi4tBvEU91dg7o/K3DRH7XVRxQNC6/SqXKF15OCaQ=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB6PR02MB3175.eurprd02.prod.outlook.com (2603:10a6:6:1d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Wed, 12 Aug
 2020 13:37:44 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::3890:7b1:97a6:1e47]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::3890:7b1:97a6:1e47%7]) with mapi id 15.20.3261.025; Wed, 12 Aug 2020
 13:37:44 +0000
Subject: Re: include/linux/bits.h:25:21: error: first argument to
 '__builtin_choose_expr' not a constant
To:     Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>
References: <202008080833.zZnw48Gr%lkp@intel.com>
 <20200810212756.04c006476aa9c663edb01f32@linux-foundation.org>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <45c8ced5-799b-759b-600f-f1ee752cf13d@axentia.se>
Date:   Wed, 12 Aug 2020 15:37:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200810212756.04c006476aa9c663edb01f32@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1P195CA0010.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::20)
 To DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.226.217.78) by HE1P195CA0010.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15 via Frontend Transport; Wed, 12 Aug 2020 13:37:43 +0000
X-Originating-IP: [85.226.217.78]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da2138fc-3eab-46ff-60fb-08d83ec4e436
X-MS-TrafficTypeDiagnostic: DB6PR02MB3175:
X-Microsoft-Antispam-PRVS: <DB6PR02MB31759A767454035B61EC96EDBC420@DB6PR02MB3175.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0TrLDfS2nUdgrdT0YnL8K8h7/OEm8/9p0FwokJ++S/mFxwbSqS95wNRAjsZZsuo8SyOKrOGiWKgjSLILs/FvcnmkcJNWoQARDjfgL6ruk0a/NXhXWkQdNDRfR3bWZ0iCRvu2O2za2ikti7NELbLIUOhwrd9LzDM1w1vPdHrtF8dHZDTZmIB0hoIIlFOlymfqWUCQQ3dzvVQBx3B2IZJGHtTdPmDIPTcwOaftGoxj+jCIIZSAhPs8Djm96iuR9RPcRM6dD+4lUB+QD1MPDVUl0t9lqwCJ3pJh0x7WWLqS3OkaYuZNgdemKz4Gr1A8KnGWX2Dv6fUSLZRdTgNQH6LyzEDpcllJ9omYXA9V40VOjpDgGmWgUFyrdtm+3rEpwnSDfdSThTWMa3X4/zNVSOIV+es/d5SH1mjeRWKZ1+tVRDVxWoLCx3esjx+bVt058f1ZYYes0qSga+RgwQXJjsulvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39830400003)(396003)(376002)(366004)(346002)(136003)(36756003)(2906002)(8936002)(86362001)(66476007)(8676002)(6486002)(83080400001)(53546011)(966005)(66556008)(2616005)(4326008)(66946007)(956004)(6666004)(508600001)(16526019)(5660300002)(36916002)(54906003)(26005)(16576012)(186003)(31686004)(52116002)(316002)(31696002)(110136005)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: R3ZFx56uA9aDFv2c6vcRSTxKhmGFICZoae8lUEo99GnhHeWuSeIPW2VObs2Sr4w2Tk0Uo9gwewHjCkLtYZUjfu71ZX1vdQgptPERjQh1mPl/S8FKDt34SqHMCk9IzVTB+U7Ipdylu/B++pWoi153PO0gIwV/xOF36P2J3EX2hpU4KruMpHB1Z2Y7XMTaddhvwPfRuqwUvmIiwvnIemqQEZj26UsORR3/c1xgtOhj+b9JeOlq4fdgTikXsAlsGsw2K0aJyXBaL/R8AxDUzzcA01RR72wVVM+YI/pIbS13F4/5vNdLIQJzkpYGmpN4C83d7VvGiMMDcby1KTfFALbJPJcgwYPgFC6BwuDgatMZWqQkXflGd0au4HxvbpT7HgGeomSG5PYvIAZBGoMQbD7Aut33F2ZtBes9ScFtSE/sA33HcK1xrQjhehzJhHY+yC4wdvkFUqFPp0gjFxRaGKK+8f8tyYn8TRQDx4y6JbZI3TqrBc+4uH98/OdDuHeZVvCoZpBpwumit9AO+oobPdbdMUp1Dg4FSbmT6jkim7zshdD4drZ1Rvb4wTqP7hw3w0ivf4mQ8k8XQRwW/Xy8sDO5alcT3IobkUyraelE8rI39gwaDsYHQ+WZjAbwBbHMFi/+F0/LmoEaZam24YMflQjVtA==
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: da2138fc-3eab-46ff-60fb-08d83ec4e436
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2020 13:37:44.3522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7M4yMcN3cz78zEjzARwkjyhHGlGPkUwQTTeqvsO1bVWYtCxYzFm20s4adYrd+v/h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR02MB3175
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-11 06:27, Andrew Morton wrote:
> On Sat, 8 Aug 2020 08:03:38 +0800 kernel test robot <lkp@intel.com> wrote:
> 
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   30185b69a2d533c4ba6ca926b8390ce7de495e29
>> commit: 295bcca84916cb5079140a89fccb472bb8d1f6e2 linux/bits.h: add compile time sanity check of GENMASK inputs
>> date:   4 months ago
>> config: s390-randconfig-r001-20200808 (attached as .config)
>> compiler: s390-linux-gcc (GCC) 9.3.0
>> reproduce (this is a W=1 build):
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         git checkout 295bcca84916cb5079140a89fccb472bb8d1f6e2
>>         # save the attached .config to linux build tree
>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=s390 
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>    drivers/mux/mmio.c: In function 'mux_mmio_probe':
>>    drivers/mux/mmio.c:76:20: error: storage size of 'field' isn't known
>>       76 |   struct reg_field field;
>>          |                    ^~~~~
>>    In file included from include/linux/bits.h:23,
>>                     from include/linux/bitops.h:5,
>>                     from drivers/mux/mmio.c:8:
>>>> include/linux/bits.h:25:21: error: first argument to '__builtin_choose_expr' not a constant
> 
> I assume the first error is the cause of the second?
> 
> struct reg_field is only defined if CONFIG_REGMAP, and that is unset in
> this .config.  Perhaps drivers/mux/mmio.c should depend on
> CONFIG_REGMAP?  (cc Peter).
> 
> 

Thanks for the CC, and yes, that sounds about right. If it shouldn't
just "select REGMAP" instead?

I'm not sure when one should "select" and when one should "depends on"?

Cheers,
Peter
