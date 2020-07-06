Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB46C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFC8320724
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z255e0od"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbgGFNOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 09:14:30 -0400
Received: from mail-eopbgr10061.outbound.protection.outlook.com ([40.107.1.61]:29093
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729048AbgGFNOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 09:14:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JiUeJtmaafi9eqwxOdZmprAxgOl0fVgurwiQ9eoxtpi8xnHyAmUgJnFc3YvAc2wtCGGLbkQPhW0JgkeNwErSpPD2cumYEQ7WMLxThpeIsvkmCebHjdzkuUDNtYg9MwF2Sq9LWN++2mA8zn5ec7R7eNmmXAJU3XJFCHtVtIhB7yM7KHlSVjTgOYlgNwkVD804VNAxRNlzjZ3XakRtR/YE1Fy8PIm9aVtD2TkcrItMJaOqws/NJ13EYTmLraGk9nYhsMOkb0y1um5Fo1F3/4rNO8YlqXbNozzsGHqL5O1R/jiflb2rcNoBrIpkuiBw40svUAi6L1Pcvi78KICxIfU9jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgUvq9XB+pkO1BgtEQfGsEyg3+iT4KZByjCGvROX4Fk=;
 b=PGj7sHc26wJe4rKJfq8Uj0GPsf7+ZhB6mbSn73dcl/MK/9jEkDDxsJ8dKbwwT7EoDexNaQfHx1wvFDSBz01G89iNrfg2Nem+o+6WyGSx6s0BI6TCGC80Vz5tV3SBMosjy5S+kKU50IWv0/Iezspi02pQWAJuXWBR4gVuFvhyW2fh1mHb0PMrNU4o/cAKnOGS2ffhW83YSFPBdBUW90FYqOSNMhyF2NyqGTaReq7UvJ+WqGsxhErsnW3DIuFMfg7wSpRZgTl59SeX6ppf+9DKozzuUcpsoYdESwPOFO6mdj2xC7U9HKNHOKsYiS6LEpVTQwUZqjFnAJa4H2WVoPmpIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgUvq9XB+pkO1BgtEQfGsEyg3+iT4KZByjCGvROX4Fk=;
 b=Z255e0od2kEplWSeY+CFceRIRELbmJmxrXDhN81RhDo0bNqW1MPYC9tkyHbSh5WguoUG9aJc54J/5bjjhcRVfErKKGZ7sUXw2LzOxdwIdlW7ATxI0RwrTq2uJ9q+SYFd+C6YZEFaWp1zritSnKwmvvv8QJT58RnseHvRThWEBM0=
Authentication-Results: oss.nxp.com; dkim=none (message not signed)
 header.d=none;oss.nxp.com; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VI1PR0401MB2319.eurprd04.prod.outlook.com (2603:10a6:800:26::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Mon, 6 Jul
 2020 13:14:26 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::b97a:64f0:3ab5:d7fa]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::b97a:64f0:3ab5:d7fa%5]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 13:14:26 +0000
Subject: Re: [PATCH v3 13/13] bus/fsl-mc: Add a new version for
 dprc_get_obj_region command
To:     Diana Craciun <diana.craciun@nxp.com>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     stuyoder@gmail.com, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, bharatb.linux@gmail.com,
        Diana Craciun <diana.craciun@oss.nxp.com>
References: <20200706124243.10697-1-diana.craciun@nxp.com>
 <20200706124243.10697-14-diana.craciun@nxp.com>
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
Message-ID: <4c0c4e42-1ed4-a283-a4c3-54ef889df1f8@nxp.com>
Date:   Mon, 6 Jul 2020 16:14:22 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200706124243.10697-14-diana.craciun@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR03CA0059.eurprd03.prod.outlook.com
 (2603:10a6:207:5::17) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.107] (86.120.184.194) by AM3PR03CA0059.eurprd03.prod.outlook.com (2603:10a6:207:5::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20 via Frontend Transport; Mon, 6 Jul 2020 13:14:24 +0000
X-Originating-IP: [86.120.184.194]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a9243990-c134-4c4f-895e-08d821ae81b6
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2319:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB2319B590835B7AB2E5E54A44EC690@VI1PR0401MB2319.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bh9Vt/O2dyP5tFEM2F5zIKpbJ0zi50KA9AcA/lQOJX3L+keMW3MEgde/Ysv/a4dTN947+ifMzLaXEm23LsJm87+GnLP5h4Q897Ii1qPa23fLDpUFT/oDq8XNCRr1PJAQ1WKG514AQLIN8g16/QVkhS9vghXS5gj2Xfp6/yf/jocJ6i6XMRiV1K3sCLayJhZ6Ljz/qhvWoG1jinaDR+61n1dfH4pqvX3hTllT1Y45B8KYcKxAdfSVZr9ZcT1ZD9AMWn4USrZg9AwkAw0tmN2VlDT6JfA7sg1Jf4dQLz4Ew0gNK2vyeYXCmhPbuFcFbi1qQx9jQ8KJhiKYVjhOT2eLb/mh6Ixzxk+0/0fGuSTgA3mArhDYqFBZ/K4+ML8vfX7O
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(346002)(366004)(376002)(39860400002)(396003)(478600001)(66946007)(66476007)(66556008)(8676002)(5660300002)(956004)(2616005)(2906002)(36756003)(44832011)(83380400001)(31686004)(52116002)(53546011)(31696002)(4326008)(16576012)(186003)(8936002)(16526019)(316002)(26005)(86362001)(6486002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: qI78bfN/6Pzp7ueHo/R79b3yuQpdWbzJ8nGu0MzQSBt5TyOR7gDTiDNSH8oloZe7rYv7XUKEFI85h/vvbCWRBIX9NmN5Zj/OIOAtrL1TvYK6YrxB4UQq1Iuptdt2mjHuo+ffJyfJ9XKGBZ8gc9nVMm4nRMrivU1p8Au5dZ5M7PekIClxKwR//W6gBe0Wf5xL4TxKdt4BAQlrIqw1acOd1mElZmMbFSEC2rItsP3IGbfCnwMtU+JEHurLHP4yHBkZYVy0f1dzuYTJ7ylYBKfaaATFmFiHE/pMs5Brwk/oTIyYqE7umYjW3Pm4y9z5VsVNCLPgRFd2TlUMlXO6wk0Ywi5wpQAj1R27cplX/KsLqlyzNeNW/dglvcH8z+ThT2ZgF9gh8Ch+21jbbZAU3toyaHS2kB5J3u81OU9i1vmTmo+Ad3cKtEz8VhTOs9msB7G4cCYf/eNVzEwo/r6ZcZhKmcipLaZxP7LV22aM9gSVlwUq7RYti88rS741l9oVLWHq
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9243990-c134-4c4f-895e-08d821ae81b6
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 13:14:25.9463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jPp4La2IfD+B7y+an4Z0DrKLEAimRBQY6z32y9x7F5zg3QLz4rQQSeBWKIjy9nPE5BhM9NbvMlFJjS+4/uxY7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2319
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/6/2020 3:42 PM, Diana Craciun wrote:
> From: Diana Craciun <diana.craciun@oss.nxp.com>
> 
> The region size reported by the firmware for mc and software
> portals was less than allocated by the hardware. This may be
> problematic when mmapping the region in user space because the
> region size is less than page size. However the size as reserved
> by the hardware is 64K.

Should we also mention in the commit msg that this shows up when
compiling the kernel with 64K page size support, or it's obvious enough?

> Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
> ---
>  drivers/bus/fsl-mc/dprc.c           | 38 ++++++++++++++++++-----------
>  drivers/bus/fsl-mc/fsl-mc-private.h |  3 +++
>  2 files changed, 27 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/bus/fsl-mc/dprc.c b/drivers/bus/fsl-mc/dprc.c
> index 3f08752c2c19..ba292c56fe19 100644
> --- a/drivers/bus/fsl-mc/dprc.c
> +++ b/drivers/bus/fsl-mc/dprc.c
> @@ -536,20 +536,30 @@ int dprc_get_obj_region(struct fsl_mc_io *mc_io,
>  			return err;
>  	}
>  
> -	/**
> -	 * MC API version 6.3 introduced a new field to the region
> -	 * descriptor: base_address. If the older API is in use then the base
> -	 * address is set to zero to indicate it needs to be obtained elsewhere
> -	 * (typically the device tree).
> -	 */
> -	if (dprc_major_ver > 6 || (dprc_major_ver == 6 && dprc_minor_ver >= 3))
> -		cmd.header =
> -			mc_encode_cmd_header(DPRC_CMDID_GET_OBJ_REG_V2,
> -					     cmd_flags, token);
> -	else
> -		cmd.header =
> -			mc_encode_cmd_header(DPRC_CMDID_GET_OBJ_REG,
> -					     cmd_flags, token);
> +	if (dprc_major_ver > 6 || (dprc_major_ver == 6 && dprc_minor_ver >= 6)) {
> +		/**
> +		 * MC API version 6.6 changed the size of the MC portals and software
> +		 * portals to 64K (as implemented by hardware). If older API is in use the
> +		 * size reported is less (64 bytes for mc portals and 4K for software
> +		 * portals).
> +		 */

Here and below, there's no need to use kernel-doc style comments. And a
nit: there's an extra blank line here.

---
Best Regards, Laurentiu

> +		cmd.header = mc_encode_cmd_header(DPRC_CMDID_GET_OBJ_REG_V3,
> +						  cmd_flags, token);
> +
> +	} else if (dprc_major_ver == 6 && dprc_minor_ver >= 3) {
> +		/**
> +		 * MC API version 6.3 introduced a new field to the region
> +		 * descriptor: base_address. If the older API is in use then the base
> +		 * address is set to zero to indicate it needs to be obtained elsewhere
> +		 * (typically the device tree).
> +		 */
> +		cmd.header = mc_encode_cmd_header(DPRC_CMDID_GET_OBJ_REG_V2,
> +						  cmd_flags, token);
> +	} else {
> +		cmd.header = mc_encode_cmd_header(DPRC_CMDID_GET_OBJ_REG,
> +						  cmd_flags, token);
> +	}
>  
>  	cmd_params = (struct dprc_cmd_get_obj_region *)cmd.params;
>  	cmd_params->obj_id = cpu_to_le32(obj_id);
> diff --git a/drivers/bus/fsl-mc/fsl-mc-private.h b/drivers/bus/fsl-mc/fsl-mc-private.h
> index e6fcff12c68d..8d65273a78d7 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-private.h
> +++ b/drivers/bus/fsl-mc/fsl-mc-private.h
> @@ -80,10 +80,12 @@ int dpmcp_reset(struct fsl_mc_io *mc_io,
>  /* DPRC command versioning */
>  #define DPRC_CMD_BASE_VERSION			1
>  #define DPRC_CMD_2ND_VERSION			2
> +#define DPRC_CMD_3RD_VERSION			3
>  #define DPRC_CMD_ID_OFFSET			4
>  
>  #define DPRC_CMD(id)	(((id) << DPRC_CMD_ID_OFFSET) | DPRC_CMD_BASE_VERSION)
>  #define DPRC_CMD_V2(id)	(((id) << DPRC_CMD_ID_OFFSET) | DPRC_CMD_2ND_VERSION)
> +#define DPRC_CMD_V3(id)	(((id) << DPRC_CMD_ID_OFFSET) | DPRC_CMD_3RD_VERSION)
>  
>  /* DPRC command IDs */
>  #define DPRC_CMDID_CLOSE                        DPRC_CMD(0x800)
> @@ -105,6 +107,7 @@ int dpmcp_reset(struct fsl_mc_io *mc_io,
>  #define DPRC_CMDID_GET_OBJ                      DPRC_CMD(0x15A)
>  #define DPRC_CMDID_GET_OBJ_REG                  DPRC_CMD(0x15E)
>  #define DPRC_CMDID_GET_OBJ_REG_V2               DPRC_CMD_V2(0x15E)
> +#define DPRC_CMDID_GET_OBJ_REG_V3               DPRC_CMD_V3(0x15E)
>  #define DPRC_CMDID_SET_OBJ_IRQ                  DPRC_CMD(0x15F)
>  
>  #define DPRC_CMDID_GET_CONNECTION               DPRC_CMD(0x16C)
> 
