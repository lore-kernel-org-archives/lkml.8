Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E717BC4332E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 07:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE4892051A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 07:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XsFM2l8A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgCTHb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 03:31:26 -0400
Received: from mail-co1nam11on2064.outbound.protection.outlook.com ([40.107.220.64]:50145
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726902AbgCTHbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 03:31:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MgFzYZeIeHYClOrXkeQyXokiBz9jPG3eH5s7t9Lee1VSL5PsA3VSiRDLsYxGGpOKc7ApEjbgNX4q+y2xc/1uwhlazI5WPBGhpYQGAiTz3LoY9P9mxwvCG+nOCHeVvD3j9YjYKn35p+EBgW+4IV6l/EXKhed7DqPfA9k7m3V3LFCimmBbDZ8n2weu1hWGliIHMCnIqA1aazkY1kCroC0toGXS4uRd5A84nA2SCV0WXf5QR4d2UHnANclzY3jvSzvKVTh1W0JadaiNNiBY5JUD2KDqUBzR9QRvGqcvE3lr5kpKEIyxTUcPH/DFfp1IWEOJRnunq6cswz5VutNzJ7sglA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFMpMOgciMaF7chBjNojKc2qHd9K6c0ZZfEmiuMLdmY=;
 b=MWTNt4UiN7RCMdNKGCY4CeDsTOxWR1kuySde6rvtaTOZf8MfaJ/X4jZHzzNoVaPeR2FHD5ApeD+ncKsILOFwUc38DL+WfICwuPrB6a01jOJLNgmVxbqnGFnp7/15LEDuOljh0a7JPA/Gb8DmK6ezlqjLBOqEi3ppgjxMo7NTPT2sKLDy3zbw0hr2EeqiYusSjlfNRWMz9XJZRQR5JjypnBU6L3NAIpnZk/s2FhOAnz4e3/Rxco8klNY+GM6gksv3UbfzEdQuB8wWTb0z4T4qJPCjyG0wElbURQT32xZ/Xpr/caMxhouleLKKhP6nBEvrSiLFgzpBzN5G8y/v6JHBbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFMpMOgciMaF7chBjNojKc2qHd9K6c0ZZfEmiuMLdmY=;
 b=XsFM2l8AwhaaOgtGtKyYUApfcPgldgMRHDp02eXeLbyQOwYokkc3oiZnL/OfQlvSU7FlpPf4HO8zHvn0zk1K/vDTWKZv0tnoBC6VLOj5YOBwc1f4jHWgwnTX4eGJN43v74t5U8KSSF765ORg5zO4ZTS3tMjRZi+03ASk6s1qhYE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rijo-john.Thomas@amd.com; 
Received: from CY4PR12MB1925.namprd12.prod.outlook.com (2603:10b6:903:120::7)
 by CY4PR12MB1752.namprd12.prod.outlook.com (2603:10b6:903:120::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.18; Fri, 20 Mar
 2020 07:31:22 +0000
Received: from CY4PR12MB1925.namprd12.prod.outlook.com
 ([fe80::c5ae:bcf3:b96b:3ef6]) by CY4PR12MB1925.namprd12.prod.outlook.com
 ([fe80::c5ae:bcf3:b96b:3ef6%9]) with mapi id 15.20.2835.017; Fri, 20 Mar 2020
 07:31:22 +0000
Subject: Re: [GIT PULL] another amdtee driver fix for v5.6
List-Id: <soc.lore.kernel.org>
To:     Jens Wiklander <jens.wiklander@linaro.org>, arm@kernel.org,
        soc@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        tee-dev@lists.linaro.org
References: <20200320063446.GA9892@jade>
From:   Rijo Thomas <Rijo-john.Thomas@amd.com>
Message-ID: <d3af1c98-39e0-5608-0e70-daf35015452c@amd.com>
Date:   Fri, 20 Mar 2020 13:01:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200320063446.GA9892@jade>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0136.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:35::30) To CY4PR12MB1925.namprd12.prod.outlook.com
 (2603:10b6:903:120::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.138.129.230] (165.204.156.251) by MA1PR01CA0136.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:35::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.17 via Frontend Transport; Fri, 20 Mar 2020 07:31:20 +0000
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8feadc3c-9bcd-4137-3ce9-08d7cca0b021
X-MS-TrafficTypeDiagnostic: CY4PR12MB1752:
X-Microsoft-Antispam-PRVS: <CY4PR12MB175286CE9189A1DAF8BEFB90CFF50@CY4PR12MB1752.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-Forefront-PRVS: 03484C0ABF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(199004)(5660300002)(26005)(16526019)(966005)(66946007)(6666004)(186003)(66476007)(31686004)(4326008)(36756003)(66556008)(16576012)(316002)(2616005)(45080400002)(956004)(8676002)(81166006)(8936002)(81156014)(6486002)(54906003)(2906002)(86362001)(53546011)(31696002)(52116002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1752;H:CY4PR12MB1925.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /nhe7hJNfuYvFy1fpCDXahMOXxhys3f5DrtJsecHjYKMUe0XXvfaJWuVq2hKHP4/caZJQNxHbHx4C402oZMy7TNqLOKqJfwUlUwlTgMIRSDlRkRUFx5n3NwMFTFirwHeGNV6GXY8OsPcfwDhhdb7euW1EhlqHZAhailhrI/dbcAfis5AS9JPLbFxpwi0zKJQeCY4JmXv7EzaZ3cKFbvm8XsWb3ERnchQivjvDlbUZ7FnnAKMa3w20ggzeb1rCNP77i/PZL9Zmliw/1K4/BGdTUTxNBVoTmrkLM7GpHQtz0eQtySQ8Lhcfs+Hexg6VvEO7sm3qKTVXHQfSPsA0Byj/lQsezAoAOGkiDZ6P22OedHpXFquHa1J9swhtuwraiQfFcj9UE8LZHyvFZNXeHi+7BGc8MCWXbzS4HGDVaSk7ElPCG5nhu0HND96W15J/iLjU26OvgQbZoABG6pthTE6IIJ909dCRFECbhCt9fdx+Tuj9kUE3tN2ApxoR7W9aHSSgxqOBLgsCEho0gF2uZNEnw==
X-MS-Exchange-AntiSpam-MessageData: I0GcFP8KWYtR0grCnggyNrpKeMnAED0lQby70j+xRCyfAxSrkT6cw2hafycqml8p9tmD7FYB8GL8rqVL+ODpYX0lJQTElAlQ0yxI7JbHHHs7kzJTrejH7XMpYFShTR/wrh89OpjAWhR24pxdST2n3w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8feadc3c-9bcd-4137-3ce9-08d7cca0b021
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2020 07:31:22.0175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Weis/yVt03FfBQizQon5Db/rhRCmrOrXW1yySQ4NjkqaS+Aw4//F0eFS7oShFEIkgEmSywHz2q86x2e4HWyNlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1752
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Jens for pulling in the fixes!

-Rijo

On 20/03/20 12:04 pm, Jens Wiklander wrote:
> Hello arm-soc maintainers,
> 
> Please pull this AMDTEE driver fix for an out of bounds read in
> find_session()
> 
> Thanks,
> Jens
> 
> The following changes since commit 11a48a5a18c63fd7621bb050228cebf13566e4d8:
> 
>   Linux 5.6-rc2 (2020-02-16 13:16:59 -0800)
> 
> are available in the Git repository at:
> 
>   https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.linaro.org%2Fpeople%2Fjens.wiklander%2Flinux-tee.git&amp;data=02%7C01%7CRijo-john.Thomas%40amd.com%7C1ce9782363e24e7add1d08d7cc98cb02%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637202828927574171&amp;sdata=tFMMPSmDgdsgAeUJZ1y2wGo6nhgICw%2BZsr524HQgw5E%3D&amp;reserved=0 tags/tee-amdtee-fix2-for-5.6
> 
> for you to fetch changes up to 36fa3e50085e3858dd506e4431b9abd1bcb1f542:
> 
>   tee: amdtee: out of bounds read in find_session() (2020-03-10 08:12:04 +0100)
> 
> ----------------------------------------------------------------
> tee: amdtee: out of bounds read in find_session()
> 
> ----------------------------------------------------------------
> Dan Carpenter (1):
>       tee: amdtee: out of bounds read in find_session()
> 
>  drivers/tee/amdtee/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
