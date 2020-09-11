Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE59BC43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8177D22204
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LLk7PWPN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgIKQiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:38:05 -0400
Received: from mail-eopbgr30073.outbound.protection.outlook.com ([40.107.3.73]:16519
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726347AbgIKPM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:12:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PHSMT85pemOWHA4AXV0J8j4jiGpS2prc5xI0JP6UGpUkwn9CAcrUCHNmSNqu2yF5wbND1dwouXxnvvYVliym13CbhL5DAmVUxmPp3CKrMdz9L36JV3uPo9jtLsOuPE4pjZLHlWsqYttwmoxfzzg9LuCp7Jair/lnDBEPXoaOwa1ogPyAFuoTuqUWtG8PwE8Q7Ww2HXim7sDE0mlAJeWQIbmfoWQGp3pU4wS5wRMY5+3zxAOhudFBxGNQOmL3hyyQj9PKJX6zHmyxSECV6K9tiqXMqPlQOSJinmy6LQgpMz7xw2hzUCFKPLStnZ30HeT3dNFgn5eYShFlTzRtHBh74A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUqrbMvDJkjYWSDds0//b+cXPTKLNwboX0504gDzoe8=;
 b=Cs3LID9YDgbW9DEJLqh+jGvgF0cQYCVGgHuAB3Ex2H88qhxPSyJF7qzFcgSir3O5vD8f2VB1+r+buuBtDR32SXEt2SXhPk1IXwaA2+jafsdDYOVL7UI8Y7TPVKgIL3H4pPSoNahTFZWgaEyieUvjlb2ewOIT7saVLIfn/5TSoJz4jbyi4aQMZT7DzbB32OAMnVZd/6o00LyJ8AvxNMryVpiz5blnY1JTmn6sMOTmVikQPOBE5NgrntR+I75xAzJNWGP1scvKfMLAjvb7bXh1ceFVo4cvXcXlCBFhGjr2hQthbUlOzUsOFqd/16LSzUu3pvoYn1pDYbF3cshGBTcgmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUqrbMvDJkjYWSDds0//b+cXPTKLNwboX0504gDzoe8=;
 b=LLk7PWPNf0pz0w69yaKJrVy308jQ7TcUSQp2or5owCDZetD947L89ZJqNppR4nA49LcNU4/phMDtdOcaqGV6TBvFoG6OBM63Lj5mv+g4lEZcMpVtykUq9RpIkXY3uqyueMIc+IMfNIjVK6QnU6j3F2f63Kr3+YuOCMZUO9CFrqU=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VI1PR0401MB2319.eurprd04.prod.outlook.com (2603:10a6:800:26::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 14:33:33 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::f960:c16d:16a5:6e7b]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::f960:c16d:16a5:6e7b%7]) with mapi id 15.20.3370.017; Fri, 11 Sep 2020
 14:33:33 +0000
Subject: Re: [PATCH v4 00/13] bus/fsl-mc: Extend mc-bus driver functionalities
 in preparation for mc-bus VFIO support
To:     Diana Craciun <diana.craciun@oss.nxp.com>,
        linux-kernel@vger.kernel.org
Cc:     stuyoder@gmail.com, leoyang.li@nxp.com, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org, bharatb.linux@gmail.com
References: <20200826092527.4992-1-diana.craciun@oss.nxp.com>
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
Message-ID: <1e61ea66-7b3b-cc3a-742e-1f3897cb2372@nxp.com>
Date:   Fri, 11 Sep 2020 17:33:29 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200826092527.4992-1-diana.craciun@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0202CA0015.eurprd02.prod.outlook.com
 (2603:10a6:200:89::25) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.103] (86.123.62.53) by AM4PR0202CA0015.eurprd02.prod.outlook.com (2603:10a6:200:89::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Fri, 11 Sep 2020 14:33:32 +0000
X-Originating-IP: [86.123.62.53]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ea096730-f335-4b19-cd2b-08d8565fa8d1
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2319:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB2319F206AE4F631FD5A7922BEC240@VI1PR0401MB2319.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UzGdnv6K2lEi3QmOfE6+3/lT8ArbpjAFnZhl2lTISD4Wllw3wZ5zmhUEOQUoIK0+xiCYqAOCBUKnACAJRcMa5okBcqfI8r1TonDKscul/y47n4A67KvwiEeQgPUPA24NDLqk7h4+khWqGE1CbGDjhhbm2njmKpp4CMNBzyovIyF8Fe7ned0pjBX1bjOcu4fglUKx9gvYX0gBtAv8huQgk6cZtcsV42PRm2CPfnEqwODxr1rhC1zJ9wGesYajKy/9JMKOALNlG0IJScKxlog4XoweTM4O/xI7Kzq2RB+ymU/8QhL6wDESD6SlLlrUtk7893REm1RzpyPcXRLsXLgmnKW62Ao/BSWd1ZDCEgYBaqfmvXyjozZNY+jFHhhfhPHA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(478600001)(83380400001)(186003)(8676002)(31696002)(2906002)(8936002)(31686004)(5660300002)(53546011)(26005)(16526019)(66946007)(6486002)(66556008)(66476007)(956004)(16576012)(4326008)(36756003)(44832011)(6666004)(2616005)(316002)(52116002)(86362001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: o7rF4QPygs6eKHamNzMvHGoNlYdmiicxhnLtIXCJTCx6AIg7XUsrANIZSMnvhnFkuQuLh+7u/RyWBZbkZHcsLqh9fJeN5gqPkYQYdoogyIslnisCg0f1xyBewwtP6tUKFznwFokxYvtEN7AJKjrL1/4cazordvzNVebsPu0x2Ip9ZtXh22azWTSy9CuO/Qokwau1J4fXmiciN0TBJ1zXkkmeW2pRVszOonIslOAgGs9D6EcnytscnF7lNPEmvs/lM2hiKifq2XfWuh0NoXDrJQO1R1vNRKM25Tjo4zrAXkOnFC93IAqkti079X2m1e8zQGMdMJRZQlF5DqtetJ8RYWR3M9HfgDqd0S4fbByzhoQ0Lnhw4/uAIKHszg1az3lTX1t2UbjvOXKp7hhUIbp8wZsNzA4dXeXBSrfvrPaE2t8PMk8G7jHOd2hdOF+Lw1TiWJ/oltQUhiztp+2LIOO3mCHvWXRRr1q3TQeu6MU9cLKUmVlBRbkoAsGCCrMyyjKiqBiJeoi2s4UXQT1YTSCoxsiuKMCrXaq7Q5CoqsLqMoLHMscxs5ITCd34tBmKLtZBQ2BBdoY1BT0DKt0EJmiWf6Y4S2FjBqULNpe+jUgUWiuAd98zLra5gEja3TcS3mVXNUfH+TGsPPpQDVo41LFBFQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea096730-f335-4b19-cd2b-08d8565fa8d1
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2020 14:33:33.2325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qj9XhKeP4YVM4Ec9+qT3BPbxetgQ2ooB3AVhyQOkwBp8z8Vze8SILB/eTcA7XCYdK56wFp3C0QAQkBhvkmiLXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2319
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/26/2020 12:25 PM, Diana Craciun wrote:
> The vfio-mc bus driver needs some additional services to be exported by the
> mc-bus driver like:
> - a way to reset the DPRC container
> - driver_override support
> - functions to setup/tear down a DPRC
> - functions for allocating the pool of interrupts. In case of VFIO the
> interrupts are not configured at probe time, but later by userspace
> request
> 
> v3 -> v4
> - Rebased on the latest kernel.
> - Exported a dprc_remove function
> 
> v2 -> v3
> - Add a new version for dprc_get_obj_region
> - Export the cacheability bus specific bits defines
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
> The patches do not address the comment regarding moving driver_override
> in the core code. I prefer not to tie these patches on that change and
> address that separately.
> 
> Bharat Bhushan (3):
>   bus/fsl-mc: add support for 'driver_override' in the mc-bus
>   bus/fsl-mc: Add dprc-reset-container support
>   bus/fsl-mc: Extend ICID size from 16bit to 32bit
> 
> Diana Craciun (10):
>   bus/fsl-mc: Do no longer export the total number of irqs outside
>     dprc_scan_objects
>   bus/fsl-mc: Add a new parameter to dprc_scan_objects function
>   bus/fsl-mc: Set the QMAN/BMAN region flags
>   bus/fsl-mc: Cache the DPRC API version
>   bus/fsl-mc: Export dprc_scan/dprc_remove functions to be used by
>     multiple entities
>   bus/fsl-mc: Export a cleanup function for DPRC
>   bus/fsl-mc: Add a container setup function
>   bus/fsl_mc: Do not rely on caller to provide non NULL mc_io
>   bus/fsl-mc: Export IRQ pool handling functions to be used by VFIO
>   bus/fsl-mc: Add a new version for dprc_get_obj_region command
> 
>  drivers/bus/fsl-mc/dprc-driver.c      | 175 ++++++++++++++++----------
>  drivers/bus/fsl-mc/dprc.c             | 141 +++++++++++++++++----
>  drivers/bus/fsl-mc/fsl-mc-allocator.c |  12 +-
>  drivers/bus/fsl-mc/fsl-mc-bus.c       |  64 +++++++++-
>  drivers/bus/fsl-mc/fsl-mc-private.h   |  31 ++---
>  drivers/bus/fsl-mc/mc-io.c            |   7 +-
>  include/linux/fsl/mc.h                |  41 +++++-
>  7 files changed, 349 insertions(+), 122 deletions(-)
> 

For the series:
Reviewed-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Acked-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>

---
Best Regards, Laurentiu
