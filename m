Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F82FC2D0F9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 08:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7AE020740
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 08:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pMHRM/1s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732262AbgEMIdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 04:33:09 -0400
Received: from mail-eopbgr70047.outbound.protection.outlook.com ([40.107.7.47]:16066
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730172AbgEMIdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 04:33:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WIxcBLyI64DBH9sEtf0nvduWLgRyKaAVCEDMiMXiFjlPowQiqX+7o25dkTeYRiaTniSgz/f0l+I9LK5PDhiHlzEunWjgXcaZnOFcYQ8EaDPhPM4ewK7HJodNskMCUzhHQhFcwZKZoQDrG94+k9hSGJuQOlYdAKtvJX7GMTuwsmru+QKIMnFFKvTKlA0/K6ZcmtWfh0IElA4mY473Ahf1SqriX7GnoTz/lc9987GjSo7CefZIOOoF9jd/QQNT0IXWHaRGH44WFXnGA/Gzh4jHuzMun++hiWBgZdQwBheBPavYGQUQoUynX822NHdP/Yi+N3bNgHCzdOLjvNeVy7L2+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WfREmkiU2C9O3mKJuX8MEnQJq9QGEGR2/naUMNDbbsQ=;
 b=AHSWzfV+2OhrnzwPyKLqhXRL8JWhqxAyt+yNaB0uSpzecE7Tl/WhQWK+Z1/SL7JQk4x4aADmsUJXOnJO1ALdoL0KiGpmvt4aVj8ldf6/CuUEbV89xocWhXb2bz1VZstEKuCH3SbCFn9gMNDA6EFucb+vkej+KQb4Ux7efMZOzrQ9tt2LVVzB8tNDb289yvCn2M0n81C7KDRhAh4Kl937By9THwp8JWqhqb4eFwTjtTbDmiqssZ6zvdnncQVrqRvwiuh/pCxzzAIeY7Ap3V5tAbJg2DRB5SaLYTOJAqAaeNZq6Og3Y0umGlOQshSZywd1nc0ucLRVj6EcKkwfTj6oPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WfREmkiU2C9O3mKJuX8MEnQJq9QGEGR2/naUMNDbbsQ=;
 b=pMHRM/1s+9ODj5eQsGIzRSC6WmhR2S6Du2tv5Ev94gmm2uqhp76iw0wilk2rK3mN7+v2hX81ySobPo/xpKBDXYQS0ivt80o6AONDWYcUWgWqwRPBvFXgpUgFriwE1frIKauNg/+sPTXbOS8/brbYF2GQ9YEnc0+aAzxT4bayExs=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
Received: from AM6PR0402MB3400.eurprd04.prod.outlook.com (2603:10a6:209:3::27)
 by AM6PR0402MB3751.eurprd04.prod.outlook.com (2603:10a6:209:22::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.35; Wed, 13 May
 2020 08:33:04 +0000
Received: from AM6PR0402MB3400.eurprd04.prod.outlook.com
 ([fe80::19eb:9fc8:f316:cf8a]) by AM6PR0402MB3400.eurprd04.prod.outlook.com
 ([fe80::19eb:9fc8:f316:cf8a%3]) with mapi id 15.20.2979.033; Wed, 13 May 2020
 08:33:04 +0000
Subject: Re: [PATCH v2 00/12] bus/fsl-mc: Extend mc-bus driver functionalities
 in preparation for mc-bus VFIO support
To:     Diana Craciun <diana.craciun@oss.nxp.com>,
        linux-kernel@vger.kernel.org
Cc:     stuyoder@gmail.com, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org
References: <20200507073431.2710-1-diana.craciun@oss.nxp.com>
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
Message-ID: <c73b9b0d-ebdf-fcc3-2fe4-2c9a28570666@nxp.com>
Date:   Wed, 13 May 2020 11:33:01 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200507073431.2710-1-diana.craciun@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0009.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::19) To AM6PR0402MB3400.eurprd04.prod.outlook.com
 (2603:10a6:209:3::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.108] (82.79.2.170) by AM0PR10CA0009.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend Transport; Wed, 13 May 2020 08:33:03 +0000
X-Originating-IP: [82.79.2.170]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e557432f-2705-4c0c-633a-08d7f7184116
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3751:|AM6PR0402MB3751:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR0402MB375117EAEE1CE21153CE0447ECBF0@AM6PR0402MB3751.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0402872DA1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FdjHETm4SUrpmRc7SqRdyUrMXTkkwiWpxTC20vQjCRKaR+ljqOIvRsaFPYM9EovtDHkwH4pAMRfhTF0OWQJuSGK+mqlphTB4VDNpJ9uezMXUmeBRMuid96A0EUe45IXcLcX25Cp2R3SsNuTPDX5J7QHpp4tl0ZDfH33y3gV6q6EIFIerI0ooSX+hoEiiNGId1lxKgYzm3YH+essTd0Jo9V67poSqKagkTC6UjzVfoWyC49BctPzXNkuwI5+b5zTVFLt6vTeMWHaFLx2ryXd1dYDoY87R0z4PBB7JkbZormXeUpEcHRRfjNruvO9+agj9QuZ8eeZR9QnV7ape1ZxzM21pqUkwB39m9sWtRGForbMTjCmadZ7NJqgWSFEJ/OEnnqsOhEVSidKvPC4NB9A1uemhZ/VizRb9TjutCoFkHNOAnr2LDkktKJ3hOJMA48E2vWbEBHZJ+VAgzuF5gqdUdB9zLjt/bJRMS46bZtIdRU6gbLMtafUX3BGl+aZYLS4+/N4P2BGYsR9OfBzAJIPHR8ndJu3Di41J04SDWyyARq/5iu8AR2dx8/FpvUV7HXqi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR0402MB3400.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(376002)(346002)(366004)(39860400002)(33430700001)(956004)(86362001)(44832011)(52116002)(4326008)(316002)(36756003)(31686004)(16576012)(66556008)(66476007)(26005)(66946007)(478600001)(6486002)(53546011)(33440700001)(2906002)(2616005)(186003)(8676002)(5660300002)(16526019)(31696002)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: N1Jo6/RNNflgJ4XWDDOSZFUdkuYuDB4oUmSUdoduYXz5em0T62vtzrk72zaQoGVkbgiWQu/PEkgjHaPE03heHW1SVi9avn6/5Rtv+bW386VJJqr5Z3Y/q/2ld9JpSig7nB3ZHyl4AO8kXcknN9unnriMBvuaqW1XVx99DF5Ej6b/gC1N7Sh/5E20FnXksQu2OxCtBTcgLmvXcp7Jfib6IsLd9YAIf3+Bw8bB6egbkdcD/CEMxS/Zf7hxGPUB9MqYIz2i0dLICotWaBtwY+rCNJbJ5GilMViiD7cBw1ryysnfVo1SROKHHnk0PX8kdL5iYjDadWTJV6R2u8nAZJGt9s4IHYirtsONnUhOkwjEPesoSCxPAb6wsnf3IUqORPF4RDRgQxpWzPcTKwE2lWAZaNs6lZayOKD2BdyBOZI/MjZ4lSs38o7VrrBLPIaJK4px0tf430IFC/UphGsValBb/P1pv6k7PIhZC8zEHo/idE8=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e557432f-2705-4c0c-633a-08d7f7184116
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2020 08:33:04.1585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zSGqgN5CFmimACDEykP0c/Ggz/T3+DszgjXCUS979Dtyl/2Mj4d+5035mT6hWssY63QVom3I8Pw4HeMWWKc94Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3751
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/7/2020 10:34 AM, Diana Craciun wrote:
> The vfio-mc bus driver needs some additional services to be exported by the
> mc-bus driver like:
> - a way to reset the DPRC container
> - driver_override support
> - functions to setup/tear down a DPRC
> - functions for allocating the pool of interrupts. In case of VFIO the
> interrupts are not configured at probe time, but later by userspace
> request
> 
> v1 -> v2
> - Remove driver_override propagation through various functions
> - Cache the DPRC API version
> 
> The patches are related with "vfio/fsl-mc: VFIO support for FSL-MC
> devices" patches, but the series were split because they are targeting
> different subsystems. However, the mc-bus patches may suffer changes
> when addressing the VFIO review comments.
> 
> Bharat Bhushan (3):
>   bus/fsl-mc: add support for 'driver_override' in the mc-bus
>   bus/fsl-mc: Add dprc-reset-container support
>   bus/fsl-mc: Extend ICID size from 16bit to 32bit
> 
> Diana Craciun (9):
>   bus/fsl-mc: Do no longer export the total number of irqs outside
>     dprc_scan_objects
>   bus/fsl-mc: Add a new parameter to dprc_scan_objects function
>   bus/fsl-mc: Set the QMAN/BMAN region flags
>   bus/fsl-mc: Cache the DPRC API version
>   bus/fsl-mc: Export a dprc scan function to be used by multiple
>     entities
>   bus/fsl-mc: Export a cleanup function for DPRC
>   bus/fsl-mc: Add a container setup function
>   bus/fsl_mc: Do not rely on caller to provide non NULL mc_io
>   bus/fsl-mc: Export IRQ pool handling functions to be used by VFIO
> 
>  drivers/bus/fsl-mc/dprc-driver.c      | 181 ++++++++++++++++----------
>  drivers/bus/fsl-mc/dprc.c             | 103 +++++++++++++--
>  drivers/bus/fsl-mc/fsl-mc-allocator.c |  12 +-
>  drivers/bus/fsl-mc/fsl-mc-bus.c       |  64 ++++++++-
>  drivers/bus/fsl-mc/fsl-mc-private.h   |  28 ++--
>  drivers/bus/fsl-mc/mc-io.c            |   7 +-
>  include/linux/fsl/mc.h                |  29 ++++-
>  7 files changed, 313 insertions(+), 111 deletions(-)
> 

For the whole series:

Reviewed-by:  Laurentiu Tudor <laurentiu.tudor@nxp.com>

---
Best Regards, Laurentiu
