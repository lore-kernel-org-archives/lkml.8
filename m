Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62C5C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9257520720
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="SVqiNE88"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729593AbgGFPtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 11:49:40 -0400
Received: from mail-eopbgr20060.outbound.protection.outlook.com ([40.107.2.60]:34435
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729503AbgGFPtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 11:49:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CavZWBA1+BWCJ0eOHn99DbdIwAQWBxPxAtyt6ywUIW8uOy8i7t+lyqIZrlNODd0HKCLbHkjIIgJY9i7ZF9EEbiHrCO7StePHjxiV0y3RqjGxcA3O89reNk+OaDqJzWOd4yC2AfmOOxp7Fi7nNvBbSpcTY88qp28aYIIu7N7FieoQDcyAcHM1pf1hzWbGUiNJwHyvYOH+0AqOMlNMibX12HzzMosA+6ZW3srs5pC17+JrfH1mCS9Eggd9kGvvdxoWxI+7co4ZtRIF2DwObMwADqOzrXEEKyr7BGE0Z0BGDatydqiZA0ohFl3+wjwc+d1D01nLaAZcD7BO2L8qTnqenw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XiCOym8GHqikWDcm0HdiAurdfE8Gd46roG/9ycnd1ZM=;
 b=ZUOd5m92EsnqOHIehhHLrfeteT8GLq779mpedt/pBB0GA1hE+5uyV/kbYmjK7niKjHtag5TA8R7gj7U7WpvLD34k3DB8i7MXDzMMN4lA+oq50cNZgGykkD7zVv7Bv09FY3W54v6q4Mk+aDKjMNFlxjzpSjedCJxV9rQ5U4h7bYa/mJdOgQAePpzayrU+r6sBppWfwuCOPsVbgp3OAt481v1pkPIp2Rd6ka2Wnnh3EEcSTq6PFwKa9spynTIWFLXwzC14lVVHD9/Hrj12L8xjm+d2T5P8+UPWGCGVYW7+cDhxYT4C1ybXnuB0M5aI0IckQ79dKqRxswH/yawaTHtdlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XiCOym8GHqikWDcm0HdiAurdfE8Gd46roG/9ycnd1ZM=;
 b=SVqiNE88giEPb50FTXIw9eZW8bYOna98CRbxD7PtKW/7P9ylR7dgBPgMSNz2tVedOtPCuflrcSPc7r6gAcRmcel02m7ejPbRIHTngjH7qqOV6iQ3T0uGTQY22F0jhd1d2acHvqXnDqPrVogGkwL/aphJ/FsQnrjZdJsaCmIc1LA=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR0402MB2815.eurprd04.prod.outlook.com
 (2603:10a6:800:ae::16) by VI1PR04MB4239.eurprd04.prod.outlook.com
 (2603:10a6:803:48::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Mon, 6 Jul
 2020 15:49:34 +0000
Received: from VI1PR0402MB2815.eurprd04.prod.outlook.com
 ([fe80::81fd:56b7:594b:59c0]) by VI1PR0402MB2815.eurprd04.prod.outlook.com
 ([fe80::81fd:56b7:594b:59c0%10]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 15:49:34 +0000
Subject: Re: [PATCH v3 13/13] bus/fsl-mc: Add a new version for
 dprc_get_obj_region command
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Diana Craciun <diana.craciun@nxp.com>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     stuyoder@gmail.com, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, bharatb.linux@gmail.com
References: <20200706124243.10697-1-diana.craciun@nxp.com>
 <20200706124243.10697-14-diana.craciun@nxp.com>
 <4c0c4e42-1ed4-a283-a4c3-54ef889df1f8@nxp.com>
From:   Diana Craciun OSS <diana.craciun@oss.nxp.com>
Message-ID: <2bffa5a7-a634-7b3f-4714-037878afb8a9@oss.nxp.com>
Date:   Mon, 6 Jul 2020 18:49:18 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <4c0c4e42-1ed4-a283-a4c3-54ef889df1f8@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM3PR05CA0145.eurprd05.prod.outlook.com
 (2603:10a6:207:3::23) To VI1PR0402MB2815.eurprd04.prod.outlook.com
 (2603:10a6:800:ae::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.122] (86.120.234.4) by AM3PR05CA0145.eurprd05.prod.outlook.com (2603:10a6:207:3::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21 via Frontend Transport; Mon, 6 Jul 2020 15:49:33 +0000
X-Originating-IP: [86.120.234.4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 32a7a746-1300-4dd5-8959-08d821c42df7
X-MS-TrafficTypeDiagnostic: VI1PR04MB4239:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB4239C45D51CC3C306249AA3FBE690@VI1PR04MB4239.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:972;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iPOJ/k5nOES51NaIKtXKyeKOA28ibw109Bs0QB+06LBSby/PP/341N/uYyDAgr2c3AOL1TZDR8Y205mLUgPrEyAGXbwIiIozL6b5IElZnDHBnoQhHzJi4TOmN5FXLlOcUFEsXux8cs3u5hbC5HHGDVJA6n46YCGc6qCOyfbuurXq48nQW8JS24EONmKuVGc/RPHphnGopeB2M/DaqRxTgFgvhHVsjNBgB81nPAc0bVZvoB1pGI9XinfrDh80Um5kaGKtkzaw2QHmsOGMqX1UOMxQO6Jnv3rtQryyfvu8xcFdyHFxz+nj5VHKWEnT3fVWa4mle3Grd26at7q3jTFBHG0wexO1Ah4rH3+slBf/P5QZA3xMp3OXePkkAXz1sq7/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB2815.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(136003)(376002)(366004)(39860400002)(396003)(478600001)(66946007)(66556008)(66476007)(8676002)(110136005)(5660300002)(956004)(83380400001)(2906002)(2616005)(52116002)(31686004)(53546011)(31696002)(16576012)(86362001)(6666004)(16526019)(186003)(4326008)(316002)(8936002)(26005)(6486002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: O/ikcvb7MsC+2bnsXvl+HWFz/myUXnyvtR3+7rUhGGiepsSHlLvIifE8L8IjTTJW4U5fQQ5OSG15tbbB+LwV0hoLCn6MzYn/z1ZVqK8XwELq9IZxhFwAVtvpLodju6ZSV669+FWZ2RNuiMybbFrP/MOWf7iUAnJ/xxSSX2f2Ex1a62e6PvQ0GMA5I9J79j19+BKAv0ObETpZTpaVcgpyBL5x3mrQDvaBaO+8VXJH1DfQ8VzjMNO/QQ1o2yB28EO+oU4w25o28ED2gNWG2ZWTlnIAAXg1UUo8MWjYEhvaECKpUthX2WgRXj1kB+yi+pqlE5aGikHYH/MDbiYCswGPlf+8Tgyd9Ho+UK2wiZHo7p0ciZw4wPAGLzOLVpl33yOpp7tQBJRGmhSQpZndzO0vVpfLblq1G9yFOUxzZKLZgYF9UIbVW5BdFFR6saDd2vgSjQ5VrmRZGURpGPbNPMrWkwuG5r/41a7ubsGAMeG/gCM=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32a7a746-1300-4dd5-8959-08d821c42df7
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB2815.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 15:49:34.4997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: okXqYqbq7cPWWNl3TwNzzU7xGtXD8u/wAYx1Z4EXMD08pvPN3x3sR0G8JGp+ppgfZFtkZcpcV7j2Bgko9N5Gnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4239
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/2020 4:14 PM, Laurentiu Tudor wrote:
>
> On 7/6/2020 3:42 PM, Diana Craciun wrote:
>> From: Diana Craciun <diana.craciun@oss.nxp.com>
>>
>> The region size reported by the firmware for mc and software
>> portals was less than allocated by the hardware. This may be
>> problematic when mmapping the region in user space because the
>> region size is less than page size. However the size as reserved
>> by the hardware is 64K.
> Should we also mention in the commit msg that this shows up when
> compiling the kernel with 64K page size support, or it's obvious enough?

It's not that obvious. In case of 4K worked by chance because the 
reported region size was 4K. Maybe it worth mentioning.

>
>> Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
>> ---
>>   drivers/bus/fsl-mc/dprc.c           | 38 ++++++++++++++++++-----------
>>   drivers/bus/fsl-mc/fsl-mc-private.h |  3 +++
>>   2 files changed, 27 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/bus/fsl-mc/dprc.c b/drivers/bus/fsl-mc/dprc.c
>> index 3f08752c2c19..ba292c56fe19 100644
>> --- a/drivers/bus/fsl-mc/dprc.c
>> +++ b/drivers/bus/fsl-mc/dprc.c
>> @@ -536,20 +536,30 @@ int dprc_get_obj_region(struct fsl_mc_io *mc_io,
>>   			return err;
>>   	}
>>   
>> -	/**
>> -	 * MC API version 6.3 introduced a new field to the region
>> -	 * descriptor: base_address. If the older API is in use then the base
>> -	 * address is set to zero to indicate it needs to be obtained elsewhere
>> -	 * (typically the device tree).
>> -	 */
>> -	if (dprc_major_ver > 6 || (dprc_major_ver == 6 && dprc_minor_ver >= 3))
>> -		cmd.header =
>> -			mc_encode_cmd_header(DPRC_CMDID_GET_OBJ_REG_V2,
>> -					     cmd_flags, token);
>> -	else
>> -		cmd.header =
>> -			mc_encode_cmd_header(DPRC_CMDID_GET_OBJ_REG,
>> -					     cmd_flags, token);
>> +	if (dprc_major_ver > 6 || (dprc_major_ver == 6 && dprc_minor_ver >= 6)) {
>> +		/**
>> +		 * MC API version 6.6 changed the size of the MC portals and software
>> +		 * portals to 64K (as implemented by hardware). If older API is in use the
>> +		 * size reported is less (64 bytes for mc portals and 4K for software
>> +		 * portals).
>> +		 */
> Here and below, there's no need to use kernel-doc style comments. And a
> nit: there's an extra blank line here.
>
> ---
> Best Regards, Laurentiu
>
>> +		cmd.header = mc_encode_cmd_header(DPRC_CMDID_GET_OBJ_REG_V3,
>> +						  cmd_flags, token);
>> +
>> +	} else if (dprc_major_ver == 6 && dprc_minor_ver >= 3) {
>> +		/**
>> +		 * MC API version 6.3 introduced a new field to the region
>> +		 * descriptor: base_address. If the older API is in use then the base
>> +		 * address is set to zero to indicate it needs to be obtained elsewhere
>> +		 * (typically the device tree).
>> +		 */
>> +		cmd.header = mc_encode_cmd_header(DPRC_CMDID_GET_OBJ_REG_V2,
>> +						  cmd_flags, token);
>> +	} else {
>> +		cmd.header = mc_encode_cmd_header(DPRC_CMDID_GET_OBJ_REG,
>> +						  cmd_flags, token);
>> +	}
>>   
>>   	cmd_params = (struct dprc_cmd_get_obj_region *)cmd.params;
>>   	cmd_params->obj_id = cpu_to_le32(obj_id);
>> diff --git a/drivers/bus/fsl-mc/fsl-mc-private.h b/drivers/bus/fsl-mc/fsl-mc-private.h
>> index e6fcff12c68d..8d65273a78d7 100644
>> --- a/drivers/bus/fsl-mc/fsl-mc-private.h
>> +++ b/drivers/bus/fsl-mc/fsl-mc-private.h
>> @@ -80,10 +80,12 @@ int dpmcp_reset(struct fsl_mc_io *mc_io,
>>   /* DPRC command versioning */
>>   #define DPRC_CMD_BASE_VERSION			1
>>   #define DPRC_CMD_2ND_VERSION			2
>> +#define DPRC_CMD_3RD_VERSION			3
>>   #define DPRC_CMD_ID_OFFSET			4
>>   
>>   #define DPRC_CMD(id)	(((id) << DPRC_CMD_ID_OFFSET) | DPRC_CMD_BASE_VERSION)
>>   #define DPRC_CMD_V2(id)	(((id) << DPRC_CMD_ID_OFFSET) | DPRC_CMD_2ND_VERSION)
>> +#define DPRC_CMD_V3(id)	(((id) << DPRC_CMD_ID_OFFSET) | DPRC_CMD_3RD_VERSION)
>>   
>>   /* DPRC command IDs */
>>   #define DPRC_CMDID_CLOSE                        DPRC_CMD(0x800)
>> @@ -105,6 +107,7 @@ int dpmcp_reset(struct fsl_mc_io *mc_io,
>>   #define DPRC_CMDID_GET_OBJ                      DPRC_CMD(0x15A)
>>   #define DPRC_CMDID_GET_OBJ_REG                  DPRC_CMD(0x15E)
>>   #define DPRC_CMDID_GET_OBJ_REG_V2               DPRC_CMD_V2(0x15E)
>> +#define DPRC_CMDID_GET_OBJ_REG_V3               DPRC_CMD_V3(0x15E)
>>   #define DPRC_CMDID_SET_OBJ_IRQ                  DPRC_CMD(0x15F)
>>   
>>   #define DPRC_CMDID_GET_CONNECTION               DPRC_CMD(0x16C)
>>

