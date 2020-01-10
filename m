Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56781C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 16:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26DA7205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 16:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jG43aDRP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbgAJQWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 11:22:15 -0500
Received: from mail-dm6nam10on2044.outbound.protection.outlook.com ([40.107.93.44]:8896
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728868AbgAJQWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 11:22:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BnSLgg6HDRNsnYNKQdkEg135NsL7aY0GuE/pO5rGrtDOpYCYLCJHTO/NPx8GRnHdewuWNSkpHIVOTyDz6g6h96oX1h2DorwMXpa6ojL0TG+NssTYh8YKtLrLmMuFXp741CxuUNqOf0S4PqY2Y2zHOI2RhGEAC+V4J4LA0uGeBwyLKnDoPOIN6/vM3/is2lTktdSJiZ2W1JPHhtW8NpIXXDkeCs62FitN3F18P3APCd1HGWKBcJCTDkR5uxC1xJwiUsSq3qAs1KjDtD1X6tTI9PyBLBPE3KwPkWmd+uF+yp99PmfdKiLzUx7v+2HDCePYF+bMdj3KwaStdRfAxdFFmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ch82Av+QRoin+7mLJMN76QGbxBkMlYS/hN3SlM8XHh4=;
 b=aMd5WM1bEMWmJwdBM5wmZKU97OF85M1lgdVev3JHavgIHC5gCzuLl8KJ3WGEL3TgdqSenCba5dI8+hUoBWe64DGfdVLAEQVbTT/oVpK6LjmMpBS2LGadGYrVmvVctzlGtthEi1QtsbV1I/jAlKBgAcODInTqj90jMY7jhDg8FCDa4hKwgO59ho161ez3u90tR4r7eImqv3jSH3IPX3jwT0HSKl4p/NRYoLl+1MHMmWuTiMak+U+5crrtDazYRif/WGjnXBbN8DPF6BhzzDL1GAQ9oPD1TwOA5cnMNKs629Fr9O1yKV5S/R1D7V/F4/GjHX6OkTEdOfFvfe/Z8YMYiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ch82Av+QRoin+7mLJMN76QGbxBkMlYS/hN3SlM8XHh4=;
 b=jG43aDRP4zrGhfu1HJU/CmlFR6mE/OK4vSpC/Ki0yu/+HZ5OosiXH9SjChg4jRT2fiFp/FfSWk6mInK8fum7FYw9Nxx9e51gNUadTZFaZbjm4FijMZ8ubXhYT0uEg6YjEiTRh08InAeFryGNBuCje3iCLpiHDluODkLCGG7gZiA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=kim.phillips@amd.com; 
Received: from SN6PR12MB2845.namprd12.prod.outlook.com (52.135.106.33) by
 SN6PR12MB2733.namprd12.prod.outlook.com (52.135.107.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Fri, 10 Jan 2020 16:22:11 +0000
Received: from SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::48af:8c71:edee:5bc]) by SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::48af:8c71:edee:5bc%7]) with mapi id 15.20.2623.013; Fri, 10 Jan 2020
 16:22:11 +0000
Subject: Re: [PATCH 2/2] perf/x86/amd: Add support for Large Increment per
 Cycle Events
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Stephane Eranian <eranian@google.com>,
        =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
References: <20191114183720.19887-1-kim.phillips@amd.com>
 <20191114183720.19887-3-kim.phillips@amd.com>
 <20191220120945.GG2844@hirez.programming.kicks-ass.net>
 <ca10060f-f78f-695f-4929-fe4bc30c6712@amd.com>
 <20200110150958.GP2844@hirez.programming.kicks-ass.net>
From:   Kim Phillips <kim.phillips@amd.com>
Message-ID: <f83eacb7-6346-6823-6429-27ee1d44f2df@amd.com>
Date:   Fri, 10 Jan 2020 10:22:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20200110150958.GP2844@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0201CA0041.namprd02.prod.outlook.com
 (2603:10b6:803:2e::27) To SN6PR12MB2845.namprd12.prod.outlook.com
 (2603:10b6:805:75::33)
MIME-Version: 1.0
Received: from [10.236.136.247] (165.204.77.1) by SN4PR0201CA0041.namprd02.prod.outlook.com (2603:10b6:803:2e::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.13 via Frontend Transport; Fri, 10 Jan 2020 16:22:10 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 882f096a-451b-4c34-b64b-08d795e93f08
X-MS-TrafficTypeDiagnostic: SN6PR12MB2733:|SN6PR12MB2733:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB273388FAAF8081AB51CA949E87380@SN6PR12MB2733.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(199004)(189003)(2906002)(26005)(478600001)(4744005)(31696002)(53546011)(86362001)(6916009)(5660300002)(31686004)(54906003)(52116002)(6486002)(8936002)(186003)(16526019)(16576012)(66946007)(316002)(2616005)(4326008)(44832011)(36756003)(81166006)(8676002)(7416002)(81156014)(66476007)(956004)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2733;H:SN6PR12MB2845.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iBWVz+Xrxnw+IALu4jDtlcZlwIgF9qP5XQV286f/jTfGGml6DVuscAc0OL7MY2bPIfv2tdxCPLI3CiMJY1GPzVQ35fzUWUI87cvrL4HuHyiJZ90ZojjZXSbxcnWq0u8C/6wRoBJ42Utb6OsQVdP3dEeE1bs24OR8vMfZAkF6Z/0ZqPw0dF9rhtOFFBZgGxPvInz6kXdvQKyRgY2BEN3lp/WMTLpMK2uQaL+E3sjrVx9gwqjY0iTJkOqXOSpe1tni0ytvbuL/KZiKW3PRxF/BW1rdB7CT2W6sJRjCvZSbhMjpY1qcbAPb5IkL7jGGghK49tzbtoPe/wWslpsKw2S1MJ/dK05+gxQtD2FaMopgRcCWKrXMbZA8QG3aAqKBWyOOzki5qUpF+/zcnbSBfLUVAB9tn5RuAOdUcPeiMGJyoKDKjD/pQHOBPEyDs9fAps2J
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 882f096a-451b-4c34-b64b-08d795e93f08
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 16:22:11.5837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6YfiqTP+eij7PsIFIEppgx6Nr3a8hQ8gkxF45KiarDwJfgC2rZNm/5c74S02xkzEP6eiiNNFEHPm01Z0samOHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2733
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/20 9:09 AM, Peter Zijlstra wrote:
> On Wed, Jan 08, 2020 at 04:26:47PM -0600, Kim Phillips wrote:
>> On 12/20/19 6:09 AM, Peter Zijlstra wrote:
>>> On Thu, Nov 14, 2019 at 12:37:20PM -0600, Kim Phillips wrote:
>> One problem I see with your change in the "not already used" fastpath
>> area, is that the new mask variable gets updated with position 'i'
>> regardless of any previous Large Increment event assignments.
> 
> Urgh, I completely messed that up. Find the below delta (I'll push out a
> new version to queue.git as well).

OK, I tested what you pushed on your perf/amd branch, and it passes all my tests.

BTW, a large part of the commit message went missing, hopefully it'll be brought back before being pushed further upstream?

Thank you,

Kim
