Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EBEC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1DAE2080D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VvQmSJYK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgGTILT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 04:11:19 -0400
Received: from mail-eopbgr70047.outbound.protection.outlook.com ([40.107.7.47]:12007
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727010AbgGTILT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 04:11:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJyippoC29Uev1p1zIkSTJYjIxbs4pBdLc14LmrDEa+ulknwOvQUXKhbCdOJOaB0kzsQpIzsFvsnpGEcK8XsOZ7Do56lfEs8wWmyD5LsegGQSRWQkedDUFIEPf3xijK9AvL2w1oNn6Ae4wnIn7A4QZo9oYW3k0xjcUJpQ8UmweDxPL1HQ+xARGkOaPsk6hiqQ+Ob4qTsJuuicen3T6AVTqw/OFcKDtTcZqeOxJFLgwU8yZJ91cKAW55xbFWhE0I7/88+9vj+X0vUmqP6/4wp4nRF/E+xIG87Y2G8L2hcoHa4oBQJpZlX/MIlmGISD9qxqc8SWl1PBzvQOGQ06rE1Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cu3FIHNvsTyub0XXZguW1/TVPv6G3pdg2wvdN9+U03A=;
 b=heyx0+m8G7yz8GSGlq7xbV22YpNI4yrGPAKB5HCR9BNH48vwESusoDOXh1+G7bqNfWoj6DMk+g4xVmKSIi0i7ssWiPgAIQbNoLJ136g3WUT89GOnoBxIol79pDKOErKbJbnk47kAebuVDud/3KyqbaVgV+wt4zscLS6a8DGlWwxLJRTmBqy7MQGhkpKTRAs8eTs7zTQfFmFdaMtY7tL9kO4J3dpaBSF/7ws6DqOSdf3ZzqmgijK/MUwZwoTMfeMSJyWjFwfkiVTZKx4RcS/kz+24PcdDex7zhh6HK9wwXhFJKH3PBwiJ2TjeKYtb1sdm/CfNts7/rKM7ujH4HAfkgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cu3FIHNvsTyub0XXZguW1/TVPv6G3pdg2wvdN9+U03A=;
 b=VvQmSJYK9HaU0SIRYqYc9KcXLKCyq/XSao0YKGlF0EPqfw4hSMX0can4XWFptu0pJ0PmJeL8qTh6pBPXhQ2d3/bJMyBVaErelJ7Pz+xjrXjJoM7/vDYV8wNH1XqlMuKjZLJ1Uqr9NSKvn3P6vogs2tx7n4bNHRJbmikca+m1TlQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR0402MB3400.eurprd04.prod.outlook.com (2603:10a6:209:3::27)
 by AM6PR04MB4232.eurprd04.prod.outlook.com (2603:10a6:209:4a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Mon, 20 Jul
 2020 08:11:15 +0000
Received: from AM6PR0402MB3400.eurprd04.prod.outlook.com
 ([fe80::20d2:64cb:6603:a13b]) by AM6PR0402MB3400.eurprd04.prod.outlook.com
 ([fe80::20d2:64cb:6603:a13b%6]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 08:11:15 +0000
Subject: Re: [PATCH 0/3] bus: fsl-mc: scattered updates
To:     Ioana Ciornei <ioana.ciornei@nxp.com>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
References: <20200717154800.17169-1-ioana.ciornei@nxp.com>
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
Message-ID: <38ba5baa-02f5-19d8-6396-65e865bda9be@nxp.com>
Date:   Mon, 20 Jul 2020 11:11:13 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200717154800.17169-1-ioana.ciornei@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0073.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::14) To AM6PR0402MB3400.eurprd04.prod.outlook.com
 (2603:10a6:209:3::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.107] (82.78.77.33) by AM0PR01CA0073.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend Transport; Mon, 20 Jul 2020 08:11:14 +0000
X-Originating-IP: [82.78.77.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7880c6f0-639d-4a5a-7396-08d82c8478e6
X-MS-TrafficTypeDiagnostic: AM6PR04MB4232:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB4232B916B7F71C89874AB84AEC7B0@AM6PR04MB4232.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5bevlmlat3qqZmX7aSgqjCaSmAUfz7fkEY2HV/OXWMEDxN+mSGkLokoRTeNBa9+p+UiH7G6LWFIhSWYcJ/TOLi8BzpJ2oOZOzrJaQdojjdMIUcgn1dKBopKijikUHZZU0jpUvkhvRp3ueUKDFYvjoSlKtjYj0sslVFOHJ24ZlpKPNVPZvZb8PMbtk6dA91XIDWP4RrNIQjmL+R2lkriGABpoMyCpJRtieaQBgPTHsGIFXgvTB6sB5tQTZiT9v4VPT4fY78LvEHjXzkoiEZVEPYnWfUDRsPPunC5srq+eBAm1Jdc0h5Ohw3GnZRa3InaUr+f7vQFt0Z2s/O0CGdJj+F8KUHhFK8hS4yf2Hn1KkE1GR8erXMkwMdu6Gzbqreso
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR0402MB3400.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(2906002)(52116002)(8676002)(316002)(5660300002)(16576012)(478600001)(83380400001)(15650500001)(53546011)(86362001)(31686004)(66476007)(66946007)(44832011)(2616005)(956004)(66556008)(26005)(8936002)(6486002)(31696002)(186003)(16526019)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 5u4TA4or8rNKM0DQFqNSmxdAdc8Ingx9/zrn6i/M9qK5ttlNwq7BhhnkBG5ZzA/bMTE0/Orfp0DPEmP5H0YIQPM1ndvVg8UhK6OmS5GpVSmkX+JzXN9ZhZXoG1fCDlerU2jAzqIdtTdlIcvqqf/YZdQ2m5R6YxoA3JfOygzhJgiCFPZwXXSQ4ADzAxkLUdwlcNJIoRJ3wKNq9274LpiHflcHkkgCqctkeo2+2lfB0DK0eF+Iqksggco6LT7FamecNTZ2CUJlOahxKvRgxqe9f5pMUdXBATIQaDaoAUXFL2TrsA2JwAsbmMfrFKDbvKL7tbR7s2Mqi5SUkKTFh3MmjbZhijhe1RgVImG5GRm0MjqVH1G+rjXrQNQfwmzjvpTTeixFyXnmKBEmpfIPLH7cvkA4BFrQ8MMsf3e6IQJtbHSysz2knrOWzH2ElZviv2I9GDonDdAYMNML0XVgoTV/8WaFYxNeFGDiXb4SfddrQ+w=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7880c6f0-639d-4a5a-7396-08d82c8478e6
X-MS-Exchange-CrossTenant-AuthSource: AM6PR0402MB3400.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 08:11:15.0538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: scWesEXUdEhmfsIvFk5svlEhESENZgfBnODGW8jdxRG0pBZ9gi7Y+EzUlFd8+VhnD9pQG/DdH+I6WKdAiDMDxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4232
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/17/2020 6:47 PM, Ioana Ciornei wrote:
> This patch set adds some scattered updates to the fsl-mc bus: first we
> add some missing device types that can be found on the bus, then there
> is a change needed for the PREEMPT_RT variant and the probe order for the
> newly added objects on the fsl-mc bus is changed so that allocatable
> objects are probed at first since they are being used by any other
> driver.
> 
> Grigore Popescu (1):
>   bus: fsl-mc: probe the allocatable objects first
> 
> Ioana Ciornei (1):
>   bus: fsl-mc: add missing device types
> 
> Laurentiu Tudor (1):
>   bus: fsl-mc: use raw spin lock to serialize mc cmds
> 
>  drivers/bus/fsl-mc/dprc-driver.c | 57 ++++++++++++++++++++++----------
>  drivers/bus/fsl-mc/fsl-mc-bus.c  | 30 +++++++++++++++++
>  drivers/bus/fsl-mc/mc-io.c       |  2 +-
>  drivers/bus/fsl-mc/mc-sys.c      |  4 +--
>  include/linux/fsl/mc.h           | 32 +++++++++++++++++-
>  5 files changed, 104 insertions(+), 21 deletions(-)
> 

For the series:

Reviewed-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>

---
Best Regards, Laurentiu
