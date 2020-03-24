Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FA3C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 11:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84242080C
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 11:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="27mUT3sR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbgCXLZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 07:25:38 -0400
Received: from mail-mw2nam10on2055.outbound.protection.outlook.com ([40.107.94.55]:15584
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727112AbgCXLZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 07:25:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nDDkHtn71ElXIC6aGiV5zQ8e53sOMpS/mB4LWw+sjcpqp+oO0nR3iN8K75LHUD1TzyG24uvpbYS9AbTG1xvPHHSWS1WXqRxQ5RS1Pmmcv17qoCe5epb2U6+pVHkc7pICk33mUMekWkfDbXTolRlV2I2yvnuxK1sOfI6q13Mxx3f1YeDXTAVwU/I+0U+3xMdWU+OEJ0yMVf7ZDFg1ThkC16kNkjKJHfM62DZCorRTlWxlwT9/sn6vuL8WkO5et8M5sp5u5uzCpqPsPLtBob8rGQCiFxgU9yZBdR3sweOot5mwxGcenV4s5p4NeNZ7S/LiK30Aj6Z8X1L0GjtVyyL0bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2f4bZAnh7D3DTiHn0obvxLTR7lKFvbl+TtACM5KJTI=;
 b=PNCQpS7oZLHc3bQkhCoz+rNMh/WzrKubKRy/KV3RpAq6RX6Q3xHz2nSsjznjwjhGE5hPMC9Wqd9PCW78MEH6Putwvqcv2Jmpud1YBX9V1QH9gkKcdyZLxpciml+ZLVEFlj2z/6a6z1QQoFQTnvikybVwQ575FyGJIiOMLjvkSL2SSTgFK6tzSNt42CsjQhxS2ZxZuvHqG92nfVVbvgifGqrtsCfcwLiZjbNFIwEzofYQQs3yUQIGZIxAaHmZNohPuT6eJi0Yonc6PmwwmXHU666aIPtTV4rEsKQQt5b1670l+qf+QKJkl8TedHupKZ4iOk1ihK6q6rDnq+3W/oKfVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2f4bZAnh7D3DTiHn0obvxLTR7lKFvbl+TtACM5KJTI=;
 b=27mUT3sRQSY5iHMH0QsA+2O/8p0PAy3rhes3kfyL0wKRkPvMGn36X4XQstvs+8Kh3JlnElqh+Ej3pbD6rg1q9r+V3mFINS9NTaFbUOl6kPVJ3diClQq09lQkgL8mQG2iKI/+WkkncCAFd5CllNvPxTo7nWfdZquZMljmcXhQfTY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
Received: from MWHPR12MB1855.namprd12.prod.outlook.com (10.175.53.23) by
 MWHPR12MB1437.namprd12.prod.outlook.com (10.169.200.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.15; Tue, 24 Mar 2020 11:25:34 +0000
Received: from MWHPR12MB1855.namprd12.prod.outlook.com
 ([fe80::e438:e4ff:ef0f:27d5]) by MWHPR12MB1855.namprd12.prod.outlook.com
 ([fe80::e438:e4ff:ef0f:27d5%12]) with mapi id 15.20.2835.023; Tue, 24 Mar
 2020 11:25:34 +0000
Subject: Re: [PATCH] ASoC: amd: Changing Audio Format does not reflect.
To:     "RAVULAPATI, VISHNU VARDHAN RAO" 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Cc:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1584616991-27348-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <8b1ab5dd-954e-29b7-b51f-f8c3e09a1521@amd.com>
 <DM6PR12MB3868649B82B3FAD978283F7AE7F10@DM6PR12MB3868.namprd12.prod.outlook.com>
From:   "Agrawal, Akshu" <aagrawal2@amd.com>
Message-ID: <fb950d5e-ec41-f3e5-d6d7-77e775719c67@amd.com>
Date:   Tue, 24 Mar 2020 16:55:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <DM6PR12MB3868649B82B3FAD978283F7AE7F10@DM6PR12MB3868.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: BM1PR0101CA0072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::34) To MWHPR12MB1855.namprd12.prod.outlook.com
 (2603:10b6:300:10e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.152.229] (165.204.158.249) by BM1PR0101CA0072.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:19::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.19 via Frontend Transport; Tue, 24 Mar 2020 11:25:31 +0000
X-Originating-IP: [165.204.158.249]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2d525f7d-5c40-4654-2ba9-08d7cfe611b6
X-MS-TrafficTypeDiagnostic: MWHPR12MB1437:|MWHPR12MB1437:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1437C5EF8E731E9E897212A6F8F10@MWHPR12MB1437.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 03524FBD26
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(39860400002)(396003)(136003)(346002)(2616005)(52116002)(26005)(53546011)(5660300002)(81156014)(186003)(36756003)(8676002)(6666004)(16526019)(6636002)(81166006)(8936002)(478600001)(31696002)(16576012)(110136005)(66556008)(6486002)(316002)(4326008)(54906003)(66476007)(31686004)(956004)(2906002)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1437;H:MWHPR12MB1855.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UUIdXQrutViCQDyTyB3KIjpIs+FHliZIASZ4JHXjcuFMuLsBIG4YMFV7+X1TlQyQ2Gl2dCgFP/adwJA3WCeQx5o2jjqMdF999loHvm1wlelDfGYYF4ezBL/EBDABTgRQGkHECWCNJafrxDMLmRMFCDTF30T3jAinE3cbkk1qNtMbl/4q7Y6MTSdcmUSWVY2U3QGAFMR21UrcpDZ92SmEJui2BemFzzOyNjLmOGUD+NVlbuQL6f2pIevsEK1HVoA4P+/f6qimE0LlHYCFK3x1dKKbxLaibrwLXKoaX0QHVFa60GSkpjgbvWIrTdR6WMEFnzdCGrNCZKqJPbKvCb2an0569V+3aNSQlatKeL2kKAJ4CBA/0GNuLJeS3siSQOrnHp9IsmQiHTHf4stz4D50Dz6vPoXaIaL1tHxHxs8QGtqV1gVaUIQoX28kwMxs65da
X-MS-Exchange-AntiSpam-MessageData: W+t6jPZFcwIZDK8UHxhgZJfyAwf4Vy7nmmkUntlUjAd+oxpYnE2/NUkhbjtK00hk0S5fi1gWXjQBrJUgYnV/35KjiiI+NrIK6/NxXokSRQMyWKBbE4Z4xSIR1gTB+2GJnSkvsy5+RDGR+emKQM5yDw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d525f7d-5c40-4654-2ba9-08d7cfe611b6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2020 11:25:34.5242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MwZVDMzhXfxxryWyNSjtbO56FHRufi4kC1/zeCbRxmZxAwhksfGEMbGT2Sp2Z0fWX/PIDbLrSzUpui95uUYq/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1437
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/24/2020 3:46 PM, RAVULAPATI, VISHNU VARDHAN RAO wrote:
> [AMD Official Use Only - Internal Distribution Only]
>
>
>
> -----Original Message-----
> From: Agrawal, Akshu <Akshu.Agrawal@amd.com>
> Sent: Friday, March 20, 2020 9:39 AM
> To: RAVULAPATI, VISHNU VARDHAN RAO <Vishnuvardhanrao.Ravulapati@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; broonie@kernel.org; Liam Girdwood <lgirdwood@gmail.com>; Jaroslav Kysela <perex@perex.cz>; Takashi Iwai <tiwai@suse.com>; Agrawal, Akshu <Akshu.Agrawal@amd.com>; Wei Yongjun <weiyongjun1@huawei.com>; moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM... <alsa-devel@alsa-project.org>; open list <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH] ASoC: amd: Changing Audio Format does not reflect.
>
>
> On 3/19/2020 4:52 PM, Ravulapati Vishnu vardhan rao wrote:
>> When you run aplay subsequently as below by changing the stream format:
>>
>> aplay -Dhw:2,0 -c2 -fS16_LE -r48000 /dev/zero -vv -d 5;aplay -Dhw:2,0
>> -c2 -fS24_LE -r48000 /dev/zero -vv
>> as a single command, the format gets corrupted and audio does not play.
>>
>> So clear the ACP_(I2S/BT)TDM_ITER/IRER register when dma stops.
>>
>> Signed-off-by: Ravulapati Vishnu vardhan rao
>> <Vishnuvardhanrao.Ravulapati@amd.com>
>> ---
>>    sound/soc/amd/raven/acp3x-i2s.c | 4 +---
>>    1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/sound/soc/amd/raven/acp3x-i2s.c
>> b/sound/soc/amd/raven/acp3x-i2s.c index 3a3c47e..b07c50a 100644
>> --- a/sound/soc/amd/raven/acp3x-i2s.c
>> +++ b/sound/soc/amd/raven/acp3x-i2s.c
>> @@ -240,9 +240,7 @@ static int acp3x_i2s_trigger(struct snd_pcm_substream *substream,
>>    				reg_val = mmACP_I2STDM_IRER;
>>    			}
>>    		}
>> -		val = rv_readl(rtd->acp3x_base + reg_val);
>> -		val = val & ~BIT(0);
>> -		rv_writel(val, rtd->acp3x_base + reg_val);
>> +		rv_writel(0, rtd->acp3x_base + reg_val);
> Clearing the entire register might result in issues.
>
> IMO better fix is to have a sample_len mask for ITER and IRER register.
>
> Use it to clear sample length bits in acp3x_i2s_hwparams function before setting the new format resolution.
>
>
> Thanks,
>
> Akshu
>
>
> When stream is open once again all the values will be set.
> So with clearing ITER/IRER to 0 when device closes there will be no issues.
>
> -Vishnu

The issue is in below code:

         val = rv_readl(rtd->acp3x_base + reg_val);
         val = val | (rtd->xfer_resolution  << 3);
         rv_writel(val, rtd->acp3x_base + reg_val);

where you are setting bits without first clearing them. If initial value 
was 10 and you want to set 01, you will end up with 11.

The correct way is to use mask and clear the bits before using | to 
avoid previous residual values.



