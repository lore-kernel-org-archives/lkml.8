Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD05CC352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 10:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E045206CC
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 10:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="n5x3XP+Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgBGK7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 05:59:09 -0500
Received: from mail-eopbgr700073.outbound.protection.outlook.com ([40.107.70.73]:37825
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726587AbgBGK7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 05:59:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5WffLa5vFC9DGAzuUNoNrOlHzmMdzNBJx7gqhTITMZYsPC/Ab9qR3uFUhst3ihBTuxQ3FGWDi0h5h2X5YwPJZ1+lFdhNov8a36t7+zymchz0FKxItwtMgrX90IbdFsVtCjBh3WnlSVZJxGU7xRQ8Egy9vXscbGKLVTdMvr7tEOVE2Wh0CaguBpnFUadAOwQHkaCQ7O/aixhQq7mcS4AHhz/lHKlhzazoKKKipgcBJ0VDrJM7iMrGSzAcOrNZMDqZmgW0JZ92xyQhG54UfdUsIzkrGzjjbQll4BmI7Vn9Hm0k7ZpSgqMKem8WxR83/DIlOaZEd7Pb/cl3fZSosAoeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAvNHMF3BEEuF+jyQajEGgnJAK9RgQfxm38MIWoMBy0=;
 b=mbbji3YNqdUzH9D3drGdCxWXdPouAGOUjt/0JV2WkU5WuA4so1FD17dMJSDga5pRVsHruKs1hxOwoqxCeBWURPkyrj85LW29bBHpVkwwSeqVfertBYXr8TU+9JtviwBiarRCfQ6fKWZlyLXtWtMGqNkShydjFmuPVi+q3tPXYZDjayXTNbmVe0+llQHnexVgYUCgDUCjh0o9KQDjsx3rKNgs1Zae8I35Zk3zEbOjjfuQoOAj3a4ju+lZRKwlsIgPy4vcRaG/k+WEPcBj9fHYeFFD8X02CFDRR74WRDpSmr8wYrAJwNCr/oRsSO/UOAThXuS97ej4OrVE9yzcfBa+mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAvNHMF3BEEuF+jyQajEGgnJAK9RgQfxm38MIWoMBy0=;
 b=n5x3XP+Q/t9aaW0dLj/e4kuTJ4grjBOgFxjP236llWwYZsCzOVrw6At4INWGa/qhxlwdZJlVd7aLIU+0u8fzOE4ipEJzBUtxSbv6ecIvfcdHPY0i7SGDBiveKHojy/DrTgI1Tw3299BettBN63sbmozz7zI5/ht4cYr1ESurvt0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sanju.Mehta@amd.com; 
Received: from MN2PR12MB3455.namprd12.prod.outlook.com (20.178.244.22) by
 MN2PR12MB2944.namprd12.prod.outlook.com (20.179.81.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Fri, 7 Feb 2020 10:59:07 +0000
Received: from MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::1900:6cb7:12ff:11c]) by MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::1900:6cb7:12ff:11c%4]) with mapi id 15.20.2707.024; Fri, 7 Feb 2020
 10:59:07 +0000
Subject: Re: [PATCH 00/15] AMD ntb driver fixes and improvements
To:     Arindam Nath <arindam.nath@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Jiasen Lin <linjiasen@hygon.cn>,
        Sanjay R Mehta <sanju.mehta@amd.com>
Cc:     linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
References: <cover.1580914232.git.arindam.nath@amd.com>
From:   Sanjay R Mehta <sanmehta@amd.com>
Message-ID: <a8e98fe8-25da-3ea7-a204-2fee07c6061a@amd.com>
Date:   Fri, 7 Feb 2020 16:28:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <cover.1580914232.git.arindam.nath@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR0101CA0002.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::12) To MN2PR12MB3455.namprd12.prod.outlook.com
 (2603:10b6:208:d0::22)
MIME-Version: 1.0
Received: from [10.136.17.236] (165.204.157.251) by MA1PR0101CA0002.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend Transport; Fri, 7 Feb 2020 10:59:03 +0000
X-Originating-IP: [165.204.157.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d9cf9741-f873-49d1-4987-08d7abbcc07c
X-MS-TrafficTypeDiagnostic: MN2PR12MB2944:|MN2PR12MB2944:|MN2PR12MB2944:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB29448EE95FCABD4E42934BA7E51C0@MN2PR12MB2944.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0306EE2ED4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(376002)(396003)(39860400002)(346002)(199004)(189003)(186003)(16526019)(26005)(5660300002)(52116002)(36756003)(956004)(2616005)(4326008)(478600001)(81166006)(81156014)(6636002)(8676002)(8936002)(53546011)(110136005)(2906002)(66946007)(316002)(66476007)(66556008)(16576012)(31686004)(6666004)(6486002)(31696002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB2944;H:MN2PR12MB3455.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J32Rmqfiq9DTZ+R9uNT8RvHE3RRJzaiZf8f9IP+xljgbiJZFIeFW4ntpkaA4mGwNolYLC78eantxy37yjQnMVmYIBA5Otp5HvGIaqBNi64YUTU1GMyDcJ36+56QyLLJPqXVx2MnsXfg7i00MkLQNIkP4anFT9XpejQkLRieTYcP0A00hO3ULOhtB7WG5qS2Uo0EUt3I4sSpQFwBLxThQv8qi8re46v1GSHf3Zx+JnTk3fL/UGlpOi9GIvBrZReaiss1T2i/Py651S+DchdhW2lpghjuxSVtFd7gjPxegFi5AQpa6iUaD2StnYM6CeJUsSSzA0X4AaTfL6/6GJhbE9PJtKbRfFREPjJJzPa8R8OlulQAu7/SO/1NOAY7pUMKRF9J2SaWYgmxp6We/juTDLnE5yJewN1hlqlBQ6s8DtmygP7mL0YGW5Yl/MKHOnAYg
X-MS-Exchange-AntiSpam-MessageData: hukhYf+ywiGhemx4sf+yd/2N+NE8gtGLpBb2/XNwtFNexvhGk+q/s55dJh2gwhpTvZuihNf7Z99Jpk352xdWuOkstqq3Ew4tRFB0WeMToLBAFSZ4UKGud1SPB3yde+l/VFsLV1GKRJX8/u3Kx1NOkQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9cf9741-f873-49d1-4987-08d7abbcc07c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2020 10:59:07.0834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6r79La5wWPGuxwwwJNhkwWgQ9rKYdm0dNPl5s8yImPeMC8KQXolBoBe9xxV4goLudHTyblvvoZIcUGj6rQLsag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2944
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/5/2020 9:24 PM, Arindam Nath wrote:
> [CAUTION: External Email]
> 
> This patch series fixes some bugs in the existing
> AMD NTB driver, cleans-up code, and modifies the
> code to handle NTB link-up/down events. The series
> is based on Linus' tree,
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> 
> Arindam Nath (15):
>   NTB: Fix access to link status and control register
>   NTB: clear interrupt status register
>   NTB: Enable link up and down event notification
>   NTB: define a new function to get link status
>   NTB: return the side info status from amd_poll_link
>   NTB: set peer_sta within event handler itself
>   NTB: remove handling of peer_sta from amd_link_is_up
>   NTB: handle link down event correctly
>   NTB: handle link up, D0 and D3 events correctly
>   NTB: move ntb_ctrl handling to init and deinit
>   NTB: add helper functions to set and clear sideinfo
>   NTB: return link up status correctly for PRI and SEC
>   NTB: remove redundant setting of DB valid mask
>   NTB: send DB event when driver is loaded or un-loaded
>   NTB: add pci shutdown handler for AMD NTB

The patch series looks good to me. Thanks for the changes.

For all the ntb_hw_amd changes:

Reviewed-by: Sanjay R Mehta <sanju.mehta@amd.com>


> 
>  drivers/ntb/hw/amd/ntb_hw_amd.c | 290 ++++++++++++++++++++++++++------
>  drivers/ntb/hw/amd/ntb_hw_amd.h |   8 +-
>  2 files changed, 247 insertions(+), 51 deletions(-)
> 
> --
> 2.17.1
> 
