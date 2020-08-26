Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B842C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 06:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCCC4206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 06:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="Hv8RIL2z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgHZG5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 02:57:05 -0400
Received: from mail-bn7nam10on2086.outbound.protection.outlook.com ([40.107.92.86]:65048
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726240AbgHZG5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 02:57:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cn30LxKM8z7Tt3gScfYbTLn8uxaGSxT6Ct3+7bzhG7Uv7T3GShTnjcG5gLPcKQW934n2h6B7tJAEoW3mUKRTckK7niLGllg/KPwZnFkoztIEkXebub7UeLcCe8KjJQtzuXuwm8Yxl2uyMlKMVH07dSvvSa8kt4U1liU3w17zuTofc+bIJhBjeRrIvAoNt6f7Yv3bjhvyYMajF0TSXAgRSXNG1GVGCivZIrBgXE4oVCzB8FElVerw2ZWLzlFrZMaB4yrkgky/F8r6B9pF0FA3A1ZBaB5IKbBe1OtwC9drFrfgLaZ3hXpHDaEoByAXBBZlfFWM688O8UjfvRG9qToOhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Fhpw1NzwhIgDoNo+9dv9V+uRU7cWG978cYzdB/3ig8=;
 b=WBtl1gMtoXiQJl7H34PhPgh1+chdKiE2H7cAmG/aP02QdJDatjVUDkKu+yQA1C/rZkwRk5QZmgesFRNgJIHmXIy10uifwlh2OkHa87nGnH2PT1IgY6YFcPkWFn8RkVZFlUZH7xwKv/a0h+yOY4REXrOpTi2bfqctyi2wBzoOKw5Me2XY5R7qIh/8deAITjhpjP7L9oqF94kGlfKE/ka0YVR2auFZ2vKw9Iea+vQlkeQODkGGsjd17EgroUEOx/Q7f6T8kv2X1xc/RvMM7K+YqmV7J/rH0DRmXQEb8t0pvpQaDr2fIWU0Qt8id5bhwDdeISBqIKTkoDiiPJ7WYSQkmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Fhpw1NzwhIgDoNo+9dv9V+uRU7cWG978cYzdB/3ig8=;
 b=Hv8RIL2z1d6HEwgpwFRXJfx4i6l1eNntFwPDFUFPa42bvDwOWuSWHIFCBWvbkfxqfGL5v09vU7tGPSwy4+qaXTd01onDh2EezPFezIKm2/jIAjRzPrITWUhbJ3IcxVtS2b/kGnxTQZqA+G9JX0YRnky19LUxyTH9Xx45BNCQIG8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BY5PR11MB4102.namprd11.prod.outlook.com (2603:10b6:a03:181::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Wed, 26 Aug
 2020 06:56:56 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::8d64:f85b:1cce:a1c0]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::8d64:f85b:1cce:a1c0%5]) with mapi id 15.20.3305.032; Wed, 26 Aug 2020
 06:56:56 +0000
Subject: Re: [PATCH] USB: core: limit access to rawdescriptors which were not
 allocated
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200825161659.19008-1-yanfei.xu@windriver.com>
 <20200825180026.GA375466@rowland.harvard.edu>
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
Message-ID: <476ed63c-0578-54a5-9ab1-5b26e1d9f5c6@windriver.com>
Date:   Wed, 26 Aug 2020 14:56:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200825180026.GA375466@rowland.harvard.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK0PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::14) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by HK0PR01CA0050.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Wed, 26 Aug 2020 06:56:54 +0000
X-Originating-IP: [60.247.85.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac2a739e-5d99-449f-e3e2-08d8498d3874
X-MS-TrafficTypeDiagnostic: BY5PR11MB4102:
X-Microsoft-Antispam-PRVS: <BY5PR11MB410209E9D31FA182595BB47FE4540@BY5PR11MB4102.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uLvxHRBbt4ZVlYRsIhzo9spQYijkCxVJquO2nyqqcLeGYoXvBiwyP0YKNNVo0CTCYsB+yRgZWpoatugaxTP8iDlIjX6SQl4Scro9a2hHvgMLfr9gqkKJnLzZADLubORZyq+EUwGqlQkNem3UHZKHN5b6kgpYt8Kn1ff6gEyJtQWWAta0Qgmlp8db2J/hDrKMlHhh+pU5iUyukuK4mrGyI61+RrLlAjJfxgLTzj9J7WOLIlEtSdczEUOcayCK4z21XmItqLGD9o5P14zP19Fs8U/3LSlN6odvTfmtLpzP4D3hnksHnh72Iaw6JHnVjlNU7Qv9/eiqzhbmRQiSUeXgiGVU4OgVOcpXjr98VV9J5jURmFWxaNVRFAO5c1Lw5Cv8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39840400004)(136003)(346002)(376002)(396003)(4326008)(8676002)(956004)(36756003)(2616005)(478600001)(8936002)(5660300002)(86362001)(2906002)(52116002)(6666004)(83380400001)(31686004)(16576012)(316002)(66946007)(6486002)(53546011)(26005)(186003)(66476007)(66556008)(31696002)(6916009)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 996hnzZr23iVTZdz+PZi6HrSLaODy6SgDTxu3I9D/AKLkNQq+65ivJ2mgvSu+Z9BANDw+ZGB3YgJ8f+3c4cL47FvjSp7jb86R2XaujrDSHqgCuzeyVtMosMQHULDfBzfKKA2wji2OHKtCv9xl7mH9unOTa3KRLFrRyhB9c8U2FqfKwgCCB6QAXVqr6n1BWcBckFYzIIMn5Yfmy5uIGs4Og29/07qj058Y+zqL41QpxAb1A41hGSFTN37Sux6qLPsbxEGNrABFqtzbU/EVLOvRDVDcOfcNMrIaJHLGSu9yYzcuGs+s8H1joarnXRWtEhiTAaMH37iW5Zvvt2GNN4TEqR1DUjKQsPwz7KCIqz0mzxSpT0etBFJg83LwpgtoZ2gZPbQmKDg69kc8QFW1e7ADFDgxkjFVXcG9zL5apck0yRtkwJPlFpdZgGTpKm4ogPcoq3/gmx1yiT+tAKccHDHoF6TurqhGe4LU30U7ETEBKi3ZJFuTtQUZGDtreAE7XkezAv7atoNFbBa4YiTzgxw463/qcwA3837K50NQ0xdufOCiqS/+tDboyYpbvAyAcau79xQ10hfPCI923iAG7kxYssUhW0QucCulhah+eSckLPlyKjnN6s9LOgH57CWaTmVqi0+HpXI1wJGNUUnOd/+PA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac2a739e-5d99-449f-e3e2-08d8498d3874
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2020 06:56:56.2954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IE/ZlOdaYbyW7WxKYIfO9IDrGn2qolTuTcedUWt0iE8k+mZB1UfFmDxTlr+rBxKnvBBKR/6QyfqThmQgRqUL/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/26/20 2:00 AM, Alan Stern wrote:
> On Wed, Aug 26, 2020 at 12:16:59AM +0800, yanfei.xu@windriver.com wrote:
>> From: Yanfei Xu <yanfei.xu@windriver.com>
>>
>> When using systemcall to read the rawdescriptors, make sure we won't
>> access to the rawdescriptors never allocated, which are number
>> exceed the USB_MAXCONFIG.
>>
>> Reported-by: syzbot+256e56ddde8b8957eabd@syzkaller.appspotmail.com
>> Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
>> ---
>>   drivers/usb/core/sysfs.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/core/sysfs.c b/drivers/usb/core/sysfs.c
>> index a2ca38e25e0c..1a7a625e5f55 100644
>> --- a/drivers/usb/core/sysfs.c
>> +++ b/drivers/usb/core/sysfs.c
>> @@ -895,7 +895,8 @@ read_descriptors(struct file *filp, struct kobject *kobj,
>>   	 * configurations (config plus subsidiary descriptors).
>>   	 */
>>   	for (cfgno = -1; cfgno < udev->descriptor.bNumConfigurations &&
>> -			nleft > 0; ++cfgno) {
>> +			nleft > 0 &&
>> +			cfgno < USB_MAXCONFIG; ++cfgno) {
>>   		if (cfgno < 0) {
>>   			src = &udev->descriptor;
>>   			srclen = sizeof(struct usb_device_descriptor);
> 
> This is not the right way to fix the problem.
> 
> Instead, we should make sure that udev->descriptor.bNumConfigurations is
> always <= USB_MAXCONFIG.  That's what this code in
> usb_get_configuration() is supposed to do:
> 
> 	int ncfg = dev->descriptor.bNumConfigurations;
> 	...
> 
> 	if (ncfg > USB_MAXCONFIG) {
> 		dev_warn(ddev, "too many configurations: %d, "
> 		    "using maximum allowed: %d\n", ncfg, USB_MAXCONFIG);
> 		dev->descriptor.bNumConfigurations = ncfg = USB_MAXCONFIG;
> 	}
> 
> If you want to fix the bug, you need to figure out why this isn't
> working.
Thanks for you suggestion. The patch is not right. I'll try to look
into the root cause.

Regard,
Yanfei.
> 
> Alan Stern
> 
