Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDFCC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 15:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65FBF2072C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 15:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XdKcUkJH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgETPdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 11:33:10 -0400
Received: from mail-co1nam11on2043.outbound.protection.outlook.com ([40.107.220.43]:32254
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726560AbgETPdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 11:33:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLs/tZNjLLKZ2cdQNfFYE82HIKXCdIIjnGQi7e3b31ojVTmQZ5GcoA3aZng1NKHjr1q1adRqj3LMBwndlv0lg1R2AcjQD3LwP9LRrKfouo3SEb+wT4jbxpob4eQd6TGnxwNEEzZs3gRknU9Fj8ivCJildZkErzeTbyHffHRM0SXmGDOF8nBrA6Q4qxmIg+D2hSE+SB1YAtidc9SlvSMWtyd/j9wytZADAZYS/jxKWdyxf7lu0y78fYrCx7JVpY3djtbJBDtfmwsQR1zGBEkjkJIujyY8WynP3370LZFCWNwqexzBXwJm1FeswWKZLMKz4YbRZHSZF62kldQY1TTdUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqIYvwL+bBitemeEj0cdFHAsoqcJqmYyC5i3nr1s7UY=;
 b=VXAj64pxtZD8IR2jgEbeSZjSwmpxtqAPw4tIDHAIwU5VKhMrOf1R4lwJYLz/J+GcOD0kXeXX/CzptZr6GlbBayvT87MmnLhG1HpggW3RHet5Scl3CvOEI9rysKFfnpeOJXCWoellnnAPWvz+GoLQg8tV9YMReiNXyf6G+Kra7UQlqphAKwrNtifqqJc3vfQTSW7VZaj6679JDAA7pSwSOlfYpCLgT2bPvLgwRnz6mCmghTMXXGyFZfDqMWQEzWVrxZjYxm/ucwX0fNS289yOlE2VdV7pKnrilQgeDF0pWely+iwFbmTGl0rsBXgarfHSmpVPg8JZdeRfbCuhUabL4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqIYvwL+bBitemeEj0cdFHAsoqcJqmYyC5i3nr1s7UY=;
 b=XdKcUkJHI901bpTUAYNWfsZbcDRcQ6eHYPQPaw6DjkyXsPavAKLdUqfWu0+zhKElAY1fIUaiNe9WRQ/8Tf6WzQ6W6NxTy141jM/LTetzWUEbQZ1OXBITY8yRNDf7Z+iJBDPI1XLyoAetBNdT45VFLQWQMIdrNL8XACvMQVC2IOM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB3500.namprd12.prod.outlook.com (2603:10b6:5:11d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Wed, 20 May
 2020 15:33:06 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766%3]) with mapi id 15.20.3021.020; Wed, 20 May 2020
 15:33:06 +0000
Subject: Re: [PATCH v3] drm/amdgpu: off by one in
 amdgpu_device_attr_create_groups() error handling
To:     "Ruhl, Michael J" <michael.j.ruhl@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Kevin Wang <kevin1.wang@amd.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Evan Quan <evan.quan@amd.com>, Rui Huang <ray.huang@amd.com>,
        Kenneth Feng <kenneth.feng@amd.com>,
        Yintian Tao <yttao@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
References: <14063C7AD467DE4B82DEDB5C278E8663010E2302FA@FMSMSX108.amr.corp.intel.com>
 <20200520152556.GQ3041@kadam>
 <14063C7AD467DE4B82DEDB5C278E8663010E230378@FMSMSX108.amr.corp.intel.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <d8b26176-b3f7-500a-50f8-9282f615ec74@amd.com>
Date:   Wed, 20 May 2020 17:32:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <14063C7AD467DE4B82DEDB5C278E8663010E230378@FMSMSX108.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR10CA0103.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::20) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM0PR10CA0103.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend Transport; Wed, 20 May 2020 15:33:02 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ad7ab873-c8d2-4d6c-7b59-08d7fcd3178e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3500:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB35003F8B3A9A76A825E4E97783B60@DM6PR12MB3500.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PqMTHP9d8aMrsC6T37+ptJdK/3Lk6ZHw6f6DUmTrNX+W5igL4zI14+jhumN6RhkWq8SrS4UTDSHEiFOOY5bxLxPhAoTQuhaeMr6/OR6wUVqK0GJPiiE/k3gpjSup+3fxw38HnHT9fS7Rgu98cma+ZTR16LFx1YFJHgV2h9yrjpl914ym9J1Vd64EFoyTP/YaRqO3mEiU2sPWbeSfkZhopX9oGwH+c6CB0p61B7lo8J43dXianQZspd6Z/T1+k+i7PpEcwUZT4fOn3lgECl0oq/fH4RxJCMralyTi1yB9LPBKHRwWjmDR8ujMJoE86rLj6i9y/oF27zvRc1t5ufUDRKJng0SAUeO9v4HQQcfBVS8zB0mmBKTAIUeR0Hsl/VGaOOrlk0C/KJx4+REr3AbEpOZFKNaIIAnb3BG5cCTZblIYfBcNz4wV3malidPLzytJueWHFWpW+tMp5GNNICp+RMe1Kq8hV9iAafK4Z5bA83mRT3knSbxxT5lXEYT+Ph9k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(39860400002)(376002)(346002)(396003)(54906003)(316002)(86362001)(478600001)(8676002)(31696002)(53546011)(110136005)(4326008)(6636002)(5660300002)(186003)(16526019)(6666004)(36756003)(66946007)(31686004)(52116002)(6486002)(8936002)(2906002)(2616005)(66476007)(66556008)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: H3hNbOzIfOZUXvuoNw0EQ6DNNr2iHVs+J798n5xE1sPSoVW9p/kU1g2ws6cD+kCygfTfIs3t4koQHz+vse08nAox6p/nFJlS4SiYWV2if26ixFLWtdKi/aLcuVWMUbEhKRNZJ1pfLMHfB3d71MvdJRqZM+9+HHTNvnUMNTop6qc9QNSFGbN4hgdhDIU05PQwx1OxkR2mkxCnwLhRQnNK7mCVB92oVshCM0G2DrZ2rn5tMTpRaUakkfAvdJq9qPynFxq0lF4pXqli+aHMuD6Rs1FGOW8aQmbESqZHeB/q0pzY90kUqKg/3gxVgHfh+zsNgpKpDMC4IbyBNr0o3Txxh4xLg0IwM7c5yxXhJaJYV7HwFk3TV3qot5O3L2timKDLbfoN/CZr1VzNqWkC/K0AyjZfSWQPp/CL5kSHymRCT0T3JOInfxlQTXV3Wny6J8QDPGu0CziqL0nWyR2VvUF8eXc4XMHcNS6S7xWp1UfnqukTezK1Ci9z1ULe/LilSWicntslQANOBH57kKxetd6Er+Up4NY7FxDzyaAh+q+UOEsCYv0PYmkarK6joVUqHERm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad7ab873-c8d2-4d6c-7b59-08d7fcd3178e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 15:33:06.2365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YOCRW3SXF8STRNPwYJ211ctcz2se3leZeDSODOTg6tkMJfCTETnVEjntu/iTHB+s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3500
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 20.05.20 um 17:31 schrieb Ruhl, Michael J:
>> -----Original Message-----
>> From: Dan Carpenter <dan.carpenter@oracle.com>
>> Sent: Wednesday, May 20, 2020 11:26 AM
>> To: Alex Deucher <alexander.deucher@amd.com>; Kevin Wang
>> <kevin1.wang@amd.com>; Ruhl, Michael J <michael.j.ruhl@intel.com>
>> Cc: Christian König <christian.koenig@amd.com>; David Airlie
>> <airlied@linux.ie>; Daniel Vetter <daniel@ffwll.ch>; Evan Quan
>> <evan.quan@amd.com>; Rui Huang <ray.huang@amd.com>; Kenneth Feng
>> <kenneth.feng@amd.com>; Yintian Tao <yttao@amd.com>; Hawking Zhang
>> <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org; dri-
>> devel@lists.freedesktop.org; linux-kernel@vger.kernel.org; kernel-
>> janitors@vger.kernel.org
>> Subject: [PATCH v3] drm/amdgpu: off by one in
>> amdgpu_device_attr_create_groups() error handling
>>
>> This loop in the error handling code should start a "i - 1" and end at
>> "i == 0".  Currently it starts a "i" and ends at "i == 1".  The result
>> is that it removes one attribute that wasn't created yet, and leaks the
>> zeroeth attribute.
>>
>> Fixes: 4e01847c38f7 ("drm/amdgpu: optimize amdgpu device attribute code")
>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>> ---
>> v2: style change
>> v3: Fix embarrassing typo in the subject
> 😊
>
> Acked-by: Michael J. Ruhl <michael.j.ruhl@intel.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

>
> m
>> drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c           | 3 +--
>> 1 files changed, 1 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
>> index b75362bf0742..e809534fabd4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
>> @@ -1942,9 +1942,8 @@ static int amdgpu_device_attr_create_groups(struct
>> amdgpu_device *adev,
>> 	return 0;
>>
>> failed:
>> -	for (; i > 0; i--) {
>> +	while (i--)
>> 		amdgpu_device_attr_remove(adev, &attrs[i]);
>> -	}
>>
>> 	return ret;
>> }

