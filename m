Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3CFC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 21:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51C562527E
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 21:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QYdu535a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730724AbgFUVhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 17:37:24 -0400
Received: from mail-dm6nam11on2083.outbound.protection.outlook.com ([40.107.223.83]:61152
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725985AbgFUVhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 17:37:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUyF8I5WKy+36tkIJjl1X/TtHktreit0ZAy4L5BwXjZGLEOCT++myZ3BQ5vbKGAKCVNxmi3fwwnjjr5H6tAQqDNZ7iifnF8B8Y/QpUhAdzQWE84sivDZ8e7r5xafRSKyq7P6xX3J74lPaAebDDHz4dVoUiCkH148X9KkAT3woIlErRrRFCZPApz8RtIuPVEZtyWBPXVxbWMYnXeWYA9yUcnIIY2md6d1bh+WkUkkAzMQoCR3RLCIQCVSfxRosjcqp0rHUfiaF/Ei1N3LCPCXBKIcL7Ha9/DLARh0jRsxMSj3vXPcoJPUGcYFcdkC4p5bX1WhtKt/2nXFxrl+4fhaGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6oAUJ8pYV/44zRm+IN1h7uzDfs5MhDW9N9sGe/4xTU=;
 b=MdmGZJOE/0YhyghXmr48GLkxto0pCU+KSboF6GKCLVaHCnQOwXPmioiShVe11IdW3OZopLnPATFzc6rhWm268irJ17YBiBHYd3LyYUywCdhTpdQULI4bPUVe6skh7l3RfeQgU/XwuOxqNqHn3qUt31Hc+KDixYbh5o8q+Z4iStUbkYNLrDrmtl2CbOFvynr+wGx1CSyahoAAN6cEdB+z7BgiW0useXA8Cd1Ca+rR28RXvpyLaYvSyDEw0X865p+9QmjxnFhwqXyaTWPBoVvvRbuv/I5CrHVBjrqQQdaMU3prs5WghTK3WAcQqPAlL+QQ7dqA6kl3jyUy07K9Zoo9tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6oAUJ8pYV/44zRm+IN1h7uzDfs5MhDW9N9sGe/4xTU=;
 b=QYdu535adqDNFUSs0CZ+SicewA6+X6tQn0MJmco/a0I8fhSDRLyuR4SA2VDYufq5gFW9YkXsYYfHhWCAxU/OhQEaUB/TZbmcAQSPaD1GEAWvDkuUn67kBY6gNQYxTDAHHk8YgITgNJVpc2/67nO1PA7+6tbHeatwdIXiunxuxfQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3872.namprd12.prod.outlook.com (2603:10b6:208:168::17)
 by MN2PR12MB4240.namprd12.prod.outlook.com (2603:10b6:208:1d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.25; Sun, 21 Jun
 2020 21:37:18 +0000
Received: from MN2PR12MB3872.namprd12.prod.outlook.com
 ([fe80::8843:c094:fb2a:d60a]) by MN2PR12MB3872.namprd12.prod.outlook.com
 ([fe80::8843:c094:fb2a:d60a%7]) with mapi id 15.20.3109.026; Sun, 21 Jun 2020
 21:37:18 +0000
Subject: Re: [PATCH][next] drm/mm/selftests: fix unsigned comparison with less
 than zero
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Colin King <colin.king@canonical.com>
Cc:     David Airlie <airlied@linux.ie>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20200617155959.231740-1-colin.king@canonical.com>
 <20200618103956.GQ4151@kadam>
From:   Nirmoy <nirmodas@amd.com>
Message-ID: <21094d57-c64e-ea7e-426e-997cd45d4635@amd.com>
Date:   Sun, 21 Jun 2020 23:38:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200618103956.GQ4151@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR10CA0085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::38) To MN2PR12MB3872.namprd12.prod.outlook.com
 (2603:10b6:208:168::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (217.86.124.39) by AM0PR10CA0085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Sun, 21 Jun 2020 21:37:15 +0000
X-Originating-IP: [217.86.124.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: aa67af55-3e05-4755-24e1-08d8162b44d7
X-MS-TrafficTypeDiagnostic: MN2PR12MB4240:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB42403CD514A5699464ED19148B960@MN2PR12MB4240.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 04410E544A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rXX3ATVuviYpsB0i1XjQUyeYVxkehFvDivkrUajgPcJCxHuOPKQjBDQoLR9NndNtFUTpL4MD8PqoShy7CTG7s/NfbfG7GmUURQ1L3aztZGdIXmDDxLL0h7S9P098C6zUPPFjL78+wAXrGGOsfTWlaAfZ1iX8xSA7Y4JRufgRnbk3pHz6rJ9VqKtI2+da4kK9/efL5Ge5+h0IYO60etvqfgjaM0NGzzmquWEvk/zH/pkZAxb1wMtWMLczyz2sGDIbJJaVlY+rwDCPc7w4xJnfg5ztx39aMM2LBldVTID2XVdfKtz+A3rqKiA65Pd82mMCm6CggI4Nw1y6y7j5apIS7TEcEs/X4ljow0ScslZfrD9CDq6VrWNq8l6AHwdnqxtErzJzL+aC2Ec8y8ceaMUjEl5L5BEjfjYTLAcE6pspAQQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3872.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(39850400004)(136003)(366004)(396003)(26005)(36756003)(16526019)(956004)(2616005)(31696002)(53546011)(186003)(316002)(110136005)(16576012)(54906003)(4326008)(6486002)(52116002)(8936002)(5660300002)(83380400001)(66556008)(66476007)(45080400002)(66946007)(478600001)(8676002)(966005)(31686004)(2906002)(6666004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Bds6sjZWIUmfgzjd1h3B3U052Mgn3hCL0odA+sIjDTIZGmyir0YX3nQyvZCIC66SyTr57PyW78b7PJ8OLIcbdFuAh3kTfWlukzuMH4RGRT4zs+NS/SUriecf3w4Pm6s+2jUO11SirbL6hdHHXhY7xHr+iM/BwMT+w+FDAmqU9233+us/drFfLbuK585Il2LSF6HFig2sGY/UJ5SU0/n3i/MNYQ2Q+zS4TNQHON67O3aELB+7xStYes/qwAc7PgluiT2xnNwu4qb0bf0dfKHhxAm8B+2I9OczWTXUz3aBsXsbfWnPfw87j5FECaeifuiqvltG/LZEr8Q/E6ec2VbZblf8c/FtnbISsaWIx/B2uT2ySaZ8/d3YrhEaX0xsK8Q8tIKY121L9I4Y2K2EZB5/epCccEgt7EDQNUPt/Ws+PP/v33pfkJZdst9rimkcp7pDhR+mHZ0g7HZIMtjWSFvssXvued+yrqu/l3Zbt+qWqo8=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa67af55-3e05-4755-24e1-08d8162b44d7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2020 21:37:18.2661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X2ADpn9bZOrCKoRFcL6zxth7SrmHntf1B1BhPznyvMBXEAyRxRmjaeVT7TmxdKpO44o8ObT4FsBppQHpF948oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4240
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/18/20 12:39 PM, Dan Carpenter wrote:
> On Wed, Jun 17, 2020 at 04:59:59PM +0100, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> Function get_insert_time can return error values that are cast
>> to a u64. The checks of insert_time1 and insert_time2 check for
>> the errors but because they are u64 variables the check for less
>> than zero can never be true. Fix this by casting the value to s64
>> to allow of the negative error check to succeed.
>>
>> Addresses-Coverity: ("Unsigned compared against 0, no effect")
>> Fixes: 6e60d5ded06b ("drm/mm: add ig_frag selftest")
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> ---
>>   drivers/gpu/drm/selftests/test-drm_mm.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/selftests/test-drm_mm.c b/drivers/gpu/drm/selftests/test-drm_mm.c
>> index 3846b0f5bae3..671a152a6df2 100644
>> --- a/drivers/gpu/drm/selftests/test-drm_mm.c
>> +++ b/drivers/gpu/drm/selftests/test-drm_mm.c
>> @@ -1124,12 +1124,12 @@ static int igt_frag(void *ignored)
>>   
>>   		insert_time1 = get_insert_time(&mm, insert_size,
>>   					       nodes + insert_size, mode);
>> -		if (insert_time1 < 0)
>> +		if ((s64)insert_time1 < 0)
>>   			goto err;
> The error codes in this function seem pretty messed up.
>
> Speaking of error codes, what the heck is going on with
> prepare_igt_frag().


This is on me. I will send a patch to correct this mistake.


Thanks,

Nirmoy


>
>    1037  static int prepare_igt_frag(struct drm_mm *mm,
>    1038                              struct drm_mm_node *nodes,
>    1039                              unsigned int num_insert,
>    1040                              const struct insert_mode *mode)
>    1041  {
>    1042          unsigned int size = 4096;
>    1043          unsigned int i;
>    1044          u64 ret = -EINVAL;
>                  ^^^^^^^^^^^^^^^^^^
> Why is it u64?
>
>    1045
>    1046          for (i = 0; i < num_insert; i++) {
>    1047                  if (!expect_insert(mm, &nodes[i], size, 0, i,
>    1048                                     mode) != 0) {
>    1049                          pr_err("%s insert failed\n", mode->name);
>    1050                          goto out;
>                                  ^^^^^^^^
> One of the common bugs with do nothing gotos is that we forget to set
> the error code.  If we did a direct "return -EINVAL;" here, then there
> would be no ambiguity.
>
>    1051                  }
>    1052          }
>    1053
>    1054          /* introduce fragmentation by freeing every other node */
>    1055          for (i = 0; i < num_insert; i++) {
>    1056                  if (i % 2 == 0)
>    1057                          drm_mm_remove_node(&nodes[i]);
>    1058          }
>    1059
>    1060  out:
>    1061          return ret;
>    1062
>    1063  }
>
> regards,
> dan carpenter
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Fdri-devel&amp;data=02%7C01%7Cnirmoy.das%40amd.com%7C74bcb0163ea04eaf0ca008d8137403ac%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637280736306420244&amp;sdata=kZ7BUVaFWI5aV4OztJr8GMS8QWjz%2F7JIb9jwRM3ct5g%3D&amp;reserved=0
