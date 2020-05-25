Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6098FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 10:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3409D2073B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 10:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="g2CuQKGV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389760AbgEYKUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 06:20:09 -0400
Received: from mail-bn8nam11on2050.outbound.protection.outlook.com ([40.107.236.50]:6236
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389356AbgEYKUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 06:20:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NfH9UOhtNXPhO4UDSj9qZ9LZy3orqcO/SzTDeVCdLtdEhmE8KpyEZ2Bx0O5szDA8s42RIAZLDeTTIj+dG7X/gea0mlKScuE8aZRXpkWpSCEalOr0WD12bBLGm03NIYYmwz4T4Zh7TM0Rm5L2pgM528csg2ExIFh8K6X4KL5AXnZMzNFX6ML+5wIYryW3jja0D6oT6J2m3VleZkZDHmbmjGZzwoRIMtaE+CG+PSUxL5aCKAyuiGsn0ikv8rhMX9syzjk9lXLajICZ/QtFoYEdwfHEI6s1Ke/zhvy3d7Yuu37B7kYid1L6r055Gx1N0v7gYOwLOJNFBNguFPVWwkk+NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZkQtHi/UVtwaeeJxPEJugb/KeXmrFLieH1yjZo/vQw=;
 b=C9wXhxmStqzqrAhEWzQO7Oa8RxsX/XOhZEM7wDb3DpVmHpuAQsH+qK5Csayvpw4dwMjkV1q0qKDDkg1WhKgugxUkz96UUaEfmKND8nPh1dKu5NjvxwICX2RVfqMv2t3GYMlNh7fQqLvef7A8kLgCbKJjz0uFOIyhcMI/xXOW3woA9V/pnAhN3NhVHiMgN09CT9tbBIIm2fP3I1JytufHPgyiw7khu7XkvfAbipToGJ73hBnfqaFu4vfgLJDsTNvwj8TzyK46NRrs1/PYkDr3itth68SRPI4i5eg43mTe2TcBy0nUjD8/Us6+Nj1hiQuPHpdhKyY6N07v9PkeQoerDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZkQtHi/UVtwaeeJxPEJugb/KeXmrFLieH1yjZo/vQw=;
 b=g2CuQKGVziG7jAjNtSyrYXGfEAR0O3NuhzDEVw1pBUkC33ZOsVBZo7D/0eqyPYD2G8YTMXYc9Z8ga+Fi0Gz79aPFGWkUyHTGlb3K43zLR6UMv65o+Iloax2jt7pjNvg0Tj+Sr58V9lKFGIDrDOOn+EtIiwZnDvgk+cLSJw+UD2k=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BYAPR11MB3253.namprd11.prod.outlook.com (2603:10b6:a03:77::31)
 by BYAPR11MB3237.namprd11.prod.outlook.com (2603:10b6:a03:1e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Mon, 25 May
 2020 10:20:04 +0000
Received: from BYAPR11MB3253.namprd11.prod.outlook.com
 ([fe80::18e7:4cfc:e31:8ccd]) by BYAPR11MB3253.namprd11.prod.outlook.com
 ([fe80::18e7:4cfc:e31:8ccd%5]) with mapi id 15.20.3021.029; Mon, 25 May 2020
 10:20:04 +0000
Subject: Re: [PATCH v2] workqueue: Fix double kfree for rescuer
To:     Markus Elfring <Markus.Elfring@web.de>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20200525075901.12699-1-qiang.zhang@windriver.com>
 <7d19381c-2c51-deb4-f82f-d54bc56c6ecf@web.de>
From:   qzhang2 <qiang.zhang@windriver.com>
Message-ID: <bee86d19-6c14-1fd9-eead-24e63af6cf8e@windriver.com>
Date:   Mon, 25 May 2020 18:19:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
In-Reply-To: <7d19381c-2c51-deb4-f82f-d54bc56c6ecf@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR07CA0027.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::40) To BYAPR11MB3253.namprd11.prod.outlook.com
 (2603:10b6:a03:77::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.183] (60.247.85.82) by BYAPR07CA0027.namprd07.prod.outlook.com (2603:10b6:a02:bc::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24 via Frontend Transport; Mon, 25 May 2020 10:20:02 +0000
X-Originating-IP: [60.247.85.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 916fcc0d-7e31-42e2-c16e-08d800953097
X-MS-TrafficTypeDiagnostic: BYAPR11MB3237:
X-Microsoft-Antispam-PRVS: <BYAPR11MB3237191865A83DADB3F10DFFFFB30@BYAPR11MB3237.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-Forefront-PRVS: 0414DF926F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uViqBjx/VW2EuIi+csC7DJL2Yc2dKtSmWMWJNRQkVfEuI3Kxyl5DR8eltlDrO2816sxz1rIG1znKL7rd/d1i60Os+oaP7jI8327dYuUv5Irk3wMd942WD2KfbAMLObQ9+HdRPpbrIBC9hJa5CoxkirjW7ZaSbjtVz0DEK8lW73v1f/9l6uQiLOLxAGGiRcsc3rl9qDtpF7G1nYkfSM82ZCN5BdnJdER66gzTcSRx2ytdK4G6/aIbDAcVvZu6CvWvJBwEG0/th1ZLOh1UlpZXFT3myZ2dPTqfskzShSF6dfTfdvVruH2oCpXBzcXPDmbolbq8NvqkY73Y9dCojHf3t+ElfDIuItCkJdqZ5ty+xzPEMsLGiIW4l5lUwrlVikpHZcGWFJIgxgVUYqcW3i7x786MaBLEvItVfl8eO8jNw+D5hdjoAWieMglDedKWILWKKQsNhwyimhGHA8SP8NGY87Go6UfIr8b33cJcfsYQftM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3253.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(39840400004)(396003)(136003)(366004)(31696002)(66946007)(478600001)(86362001)(8676002)(52116002)(66556008)(66476007)(53546011)(31686004)(26005)(16526019)(36756003)(8936002)(186003)(2906002)(5660300002)(6706004)(4326008)(110136005)(6666004)(956004)(2616005)(16576012)(316002)(6486002)(4744005)(78286006)(43062003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 6S5MVCSBE7MzSvX2THbRJ5BObdrAYPAZlOreiKTMeh6ZVXs9/HNV7SUg396+4WRVcLMw9CUgpw4s4MToumsbxWScFJXrXISspb0uQxTjwCgRQAVn8WkTxnI3XMHwp6qEqt75ePyi+2UDE8KGPYmxrH2u9XlbZx8ODbswauGZuFJ7I3q6qozOEw0n0/Qs6y9d06lqBE9PVRyhd1LpR556oHVKtxkpCgUaFs2CuQPD8s/gydby1mHmsp9xcWewBacV3c8Qip5josz2SOJzpSUiRvxbSWaPRKZ30tjif7/CePbhPdWnKM/zcg7Vc1E3AzI9wh+bvyFdOwQE/FhDqWN+IzPLSOFnSKACxAZa0CPCHiAqd+kI/End6T5bzeTb7GXfQb5rjfWYYDPh7LGlU9Lqd/+LhXGtiSkl+vsiX+B/S5dF66FOg9Ziu21Nftv6dkTPBDd0Z9Ro5W63TA+7FF/hQAjAZr5YRxHkm7GTEZp5CeI=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 916fcc0d-7e31-42e2-c16e-08d800953097
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2020 10:20:03.9913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0aVDITmFLCxtlCoF4yMAaRYZJyl7yiZCDuE04CZeSFS9nJQUGrj9O+yMSUWvMywetmzBmAgGPni/S/YtgDzZzzYFNci2yIrOFt1aJm3n8fY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3237
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I see, kfree does nothing with null pointers and direct return.
but again kfree is not a good suggestion.

On 5/25/20 5:50 PM, Markus Elfring wrote:
>> The duplicate memory release should be deleted from the implementation
>> of the callback function "rcu_free_wq".
> 
> I tried to help with the selection of a better commit message.
> I have taken another look also at the implementation of the function “destroy_workqueue”.
> 
> * The function call “destroy_workqueue” can be performed there in an if branch
>    after the statement “wq->rescuer = NULL” was executed.
> 
> * This data processing is independent from a possible call of the
>    function “call_rcu(&wq->rcu, rcu_free_wq)” in another if branch.
>    Thus it seems that a null pointer is intentionally passed by a data structure
>    member to this callback function on demand.
>    The corresponding call of the function “kfree” can tolerate this special case.
> 
> 
> Now I find that the proposed change can be inappropriate.
> 
> Regards,
> Markus
> 
