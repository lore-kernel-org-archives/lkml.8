Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3205EC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 13:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F017320772
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 13:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="KqgFgdFw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbgCYNFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 09:05:30 -0400
Received: from mail-eopbgr750084.outbound.protection.outlook.com ([40.107.75.84]:18934
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727279AbgCYNFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 09:05:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gOFGrUHX7clzoYUsESmEGko+jYX9B4Qa+vGcZ81PcZ6gg6Xxawhi5mB26INGyGyQa9t+x4YQgrlsQCNxnx5GlmXIXtcV6yF5HhtPHoxH+kh9q/ftzwTfNFPN4jfkD3z76Fm42Cy+Iz76mJHO29LZOXsgzT8zTb71U3jXOghT4nNtrS9ffTzEGvRLFd48KkSoB3XiTNyx2PUentf4O0XWJbpwf2yh5r6kgpsK+qvgYipAXYT+ePfiqSdUZk4+Wk/j/spr5/qjXuz9I7J/NgHpHM3ESjiuqc20d7IEATTmdjjz23EjXEtdKG/1FFX45ELy8MU5zgieoPGSxF9cPv0E0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qv8OyJMg854jD91cIgOd74ILvwTut5vOBkWDm681F8=;
 b=DXfIMq07CrQhEKve2NMFhmr+y1yM21VAIuxGroMUArwoJK4yhNG7QNaZXRL9I5ibo00ffcbfASMMpyg4XR7wvgRpHnibhUSaKNnjmuVq3yseu7vWz9YiYqsPKS5OKVSpH757nxijc7ooyzWAky1hzqCIcq8kQZdWVqNGn34d3X4TNz0XBs8T+E1s3fNh++fgNVVaRXraV2ujiwQoglsSH4wM3Wl8rSMeNB44vFTqQKugqPy8bKwo0VrKQzK4siQYtVgBtvJkf8rrJi0evH+aNLHmGOBE6PWdDm99I/N05I6jV0tfAuM3pMBOiQ6dtJWtpAVVhkzej5Kso1ZigPuNwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qv8OyJMg854jD91cIgOd74ILvwTut5vOBkWDm681F8=;
 b=KqgFgdFwTdcQTcdGp14YDW6hRDo5DNktClSDi85+9aRqjp7w0IzG0844A5obwXi7+2Ny7qwt9kCzUtRq28eWTuVmTsS1eZIes7czB77B8rdJFL0CNBkOejpWM+WyiLHNyZ2a9CaIjZnA6jZlfRT2pfJ0HArYMQlZLOQ3gGcpiLw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Zhe.He@windriver.com; 
Received: from SN6PR11MB3360.namprd11.prod.outlook.com (2603:10b6:805:c8::30)
 by SN6PR11MB2749.namprd11.prod.outlook.com (2603:10b6:805:5f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Wed, 25 Mar
 2020 13:05:27 +0000
Received: from SN6PR11MB3360.namprd11.prod.outlook.com
 ([fe80::d852:181d:278b:ba9d]) by SN6PR11MB3360.namprd11.prod.outlook.com
 ([fe80::d852:181d:278b:ba9d%5]) with mapi id 15.20.2835.021; Wed, 25 Mar 2020
 13:05:27 +0000
Subject: Re: [PATCH 2/2] perf: Normalize gcc parameter when generating arch
 errno table
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, linux-kernel@vger.kernel.org
References: <1581618066-187262-1-git-send-email-zhe.he@windriver.com>
 <1581618066-187262-2-git-send-email-zhe.he@windriver.com>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <2addb3c4-5b0d-0196-5262-d1983a893896@windriver.com>
Date:   Wed, 25 Mar 2020 21:05:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <1581618066-187262-2-git-send-email-zhe.he@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HK2PR06CA0013.apcprd06.prod.outlook.com
 (2603:1096:202:2e::25) To SN6PR11MB3360.namprd11.prod.outlook.com
 (2603:10b6:805:c8::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.175] (60.247.85.82) by HK2PR06CA0013.apcprd06.prod.outlook.com (2603:1096:202:2e::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.19 via Frontend Transport; Wed, 25 Mar 2020 13:05:24 +0000
X-Originating-IP: [60.247.85.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04daf2a9-50df-400b-7a5c-08d7d0bd3058
X-MS-TrafficTypeDiagnostic: SN6PR11MB2749:
X-Microsoft-Antispam-PRVS: <SN6PR11MB274917E98FA977A7B68B639F8FCE0@SN6PR11MB2749.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 0353563E2B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39850400004)(136003)(346002)(376002)(6486002)(36756003)(316002)(66556008)(956004)(86362001)(66946007)(31696002)(6666004)(66476007)(6706004)(53546011)(2616005)(8676002)(2906002)(16576012)(31686004)(8936002)(186003)(16526019)(5660300002)(52116002)(478600001)(81156014)(81166006)(26005)(78286006);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR11MB2749;H:SN6PR11MB3360.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
Received-SPF: None (protection.outlook.com: windriver.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lbEHB4zUW2WhowN8Iw/1mz+blfcUhqFeHIDa4ZW+tGK9f+QKWajDbU6tjVNyaPQ46dnMIDP6mrUVE9V7ZokC2Dw8qMwukHTjIX8Pw7Qk1fNS+M8ND331f+Ilw02NQcom2uQlzULKsr6Df79DL10UZjbSzbOA2KeOcbP3HSmvfVYbV0MJ1VglkftHW7mt0O71USSFlzGTZ6FVPrD16EosCZ+wgOXXJT01kFi4cWsUphw42F7FzZ5iNuXqJrukhcFIccvsXTNc0X73//Beugg4ouq6r2OtSwSMuWz7I0Wh5V90dhdxRoF+HM8l9sJmGWSHjc8gvGi2CfRb4N4YUCaSGMJHs8la+QEfS7GWW0DIiMiYXwz9KkwgjsqyMeNTUXjM2jqPY8D53UdL7Kkzwy67i6p3lz1pR6YH4uIlH9AOxCYvzYoFp/4UoxzNDcVSAC3whf7a4hgQXjDZOoWtL/3qTzXKLZDNyQ80G5jB7MyqukFeNSopXsOfbiqxueMt4JKvA0/JxWUVfcVrSguaHFnTdo/Jy8fDEi+p2E/ZNQm/R78=
X-MS-Exchange-AntiSpam-MessageData: m38vwovpoBUcImBbSC2lZ6F1kRkInNcLwSgFpr5igl0yFEZfUtS6tyAJ9y0wcOtfKBCTRIDfBICIl/OrQtYglWPn6cHtoi0vq9sO8E7oCtJV552gqkZA0cFAC+mcqWyG6fMzRrOP47ZNY9MN2WX+/w==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04daf2a9-50df-400b-7a5c-08d7d0bd3058
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 13:05:27.6604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3eHB/+feMAqGuUJnp+iYEvxSD8CLISTs88Mr3Vdj0kjsL/EAoLxLrChqNTh6TFWkQo6WGtZXojeyCIbRbmNhvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2749
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can this be considered for the moment?

Thanks,
Zhe

On 2/14/20 2:21 AM, zhe.he@windriver.com wrote:
> From: He Zhe <zhe.he@windriver.com>
>
> The $(CC) passed to arch_errno_names.sh may include a series of parameters
> along with gcc itself. To avoid overwriting the following parameters of
> arch_errno_names.sh and break the build like below, we just pick up the
> first word of the $(CC).
>
> find: unknown predicate `-m64/arch'
> x86_64-wrs-linux-gcc: warning: '-x c' after last input file has no effect
> x86_64-wrs-linux-gcc: error: unrecognized command line option '-m64/include/uapi/asm-generic/errno.h'
> x86_64-wrs-linux-gcc: fatal error: no input files
>
> Signed-off-by: He Zhe <zhe.he@windriver.com>
> ---
>  tools/perf/Makefile.perf | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 3eda9d4..7114c11 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -573,7 +573,7 @@ arch_errno_hdr_dir := $(srctree)/tools
>  arch_errno_tbl := $(srctree)/tools/perf/trace/beauty/arch_errno_names.sh
>  
>  $(arch_errno_name_array): $(arch_errno_tbl)
> -	$(Q)$(SHELL) '$(arch_errno_tbl)' $(CC) $(arch_errno_hdr_dir) > $@
> +	$(Q)$(SHELL) '$(arch_errno_tbl)' $(firstword $(CC)) $(arch_errno_hdr_dir) > $@
>  
>  sync_file_range_arrays := $(beauty_outdir)/sync_file_range_arrays.c
>  sync_file_range_tbls := $(srctree)/tools/perf/trace/beauty/sync_file_range.sh

