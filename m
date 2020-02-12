Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8BBC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A6E20848
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="dGJf8KsQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgBLJRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 04:17:44 -0500
Received: from mail-eopbgr770044.outbound.protection.outlook.com ([40.107.77.44]:5249
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728150AbgBLJRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 04:17:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DpEUZtza+bKsveHkdMlO5Dv7hYlSRt7mu5LkWk/6Obl4WsmpYZz7HO51t1ma0++qLthvy8x06ab2ix0nzFmyJdanuUvoCSg013+31of9CAReixDVDgTHvJumr5w7F34F0bsL1QxvQ8EZBpHbSeJtE42wBK7KnlHnBFcYteKIUiawC/Ybi/jPDd5LFHWJKHHSnIMVwVvo37A7Mn0dCCYoo8qMg0QNqgTOkaC8Fftq+5PdTwd2BWTfRlpfDvA1ZjlbOZ33Z7fhfbfG25wcN2BI3JM3d4Kd1ol0kBSpcnHKF9Y//cMPhLhz3gh2WkUSlwQu3rddFxaJo6xxTBrJ7FoZoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZnk3Kb9YptpUuvWJyaItWWenaWLmlBPQchBNS+WEbg=;
 b=jrAy3knfxQf7M8QzjBDEofPf7/SFZ3sZ2bOpAsiOP+J+/QzGtbqgZEhA8fbS3J3IIkE6v3c8vseHKsxg+iBdKcAS/sDEZZV62sc2SP0eVclebDzTg2B5V4g/Y7RYvv2Cm+xddtY+7uxFRnVurrYeTpt6jFqokAlSD7dnzJ/ImE2LBTXvlHzvr8AI7LHtqK0nsj45csSbw1l3p/gXXCrCgKnfnue3+sv3j35uPR/Q/ugvvbEnzy5L48FEpHPUhV/GGRhxNYFQ9N8Ifu44QwyDthL0N7ifYH8XdsHVPlk3pC58aS1zC0kUs5pbXqZjpN8ABn37V7Fd87yNCAi+cB8muQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=arndb.de smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZnk3Kb9YptpUuvWJyaItWWenaWLmlBPQchBNS+WEbg=;
 b=dGJf8KsQKAw/3zKwnFxCVmX7YJwGzPT4+9TLAIXpu8ogzWYM+eKDFwCcxz6PXQkyyh7mi/FZ/d9vTSu1SCHBgtGpIML3wc7VVJGIuXAdiRF5LJtflY5phgWJmfv45DuH2PWbKLWm9zNqeCt/8mRI3T/TJYvZ4cVCtDGssO9fFMg=
Received: from SN4PR0201CA0038.namprd02.prod.outlook.com
 (2603:10b6:803:2e::24) by BN8PR02MB5939.namprd02.prod.outlook.com
 (2603:10b6:408:b4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.23; Wed, 12 Feb
 2020 09:17:42 +0000
Received: from BL2NAM02FT052.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::204) by SN4PR0201CA0038.outlook.office365.com
 (2603:10b6:803:2e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22 via Frontend
 Transport; Wed, 12 Feb 2020 09:17:42 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT052.mail.protection.outlook.com (10.152.77.0) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2729.22
 via Frontend Transport; Wed, 12 Feb 2020 09:17:41 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1j1o9M-0005Nt-Pm; Wed, 12 Feb 2020 01:17:40 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1j1o9H-0005TM-M8; Wed, 12 Feb 2020 01:17:35 -0800
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 01C9HQsC017676;
        Wed, 12 Feb 2020 01:17:26 -0800
Received: from [172.30.17.107]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1j1o98-0005QJ-47; Wed, 12 Feb 2020 01:17:26 -0800
Subject: Re: [PATCH] microblaze: Fix unistd_32.h generation format
To:     Arnd Bergmann <arnd@arndb.de>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git@xilinx.com,
        Firoz Khan <firoz.khan@linaro.org>,
        Stefan Asserhall <stefan.asserhall@xilinx.com>
References: <fe6868726b897fb7e89058d8e45985141260ed68.1581494174.git.michal.simek@xilinx.com>
 <CAK8P3a1kjK=fqJiPWPOG19pBEX+khAgVyMC-7AqT4BiH8dDn8g@mail.gmail.com>
 <6c931ed2-b03b-2e38-a10b-2d238e4b7a22@xilinx.com>
 <CAK8P3a3xxu1wFKdsAHfuy2vpLigbuPR878mq75hh8HR=Tg=7LA@mail.gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <dca4637c-abfc-851f-0a70-873351be1837@xilinx.com>
Date:   Wed, 12 Feb 2020 10:17:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3xxu1wFKdsAHfuy2vpLigbuPR878mq75hh8HR=Tg=7LA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(376002)(346002)(396003)(199004)(189003)(107886003)(53546011)(26005)(44832011)(4326008)(336012)(36756003)(186003)(356004)(6666004)(110136005)(81166006)(31696002)(81156014)(54906003)(316002)(5660300002)(2616005)(8936002)(8676002)(9786002)(478600001)(2906002)(70206006)(426003)(31686004)(70586007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR02MB5939;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc1f9e80-aa87-49fa-baec-08d7af9c69ae
X-MS-TrafficTypeDiagnostic: BN8PR02MB5939:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <BN8PR02MB593966A214B69D2C73CBBB7CC61B0@BN8PR02MB5939.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0311124FA9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /nWeA40JU4eICp7ujsEZb4M4GiWdBswbR+xSJXzbr4UZr06h/IMPztyJOtr0ZiHCw7dOXfvp6Kz6uiZbUvzhLf3TUVX3dVLOvulP3/qR9gk/1GqYUnEjfE9ulyWAuCBT5kjkpeqKyfYNrw88bnKg3cM6uQQl5EGwYZA+RgNBCAS8QXxsFhyA7Xxrxf3opmSF4R9OzvjyjmmDnfy9uoHL1tU0lAPrSILfQjZNYa6ye0DePesBHYMQfZwxbkNqjc8XQqyGnBu5JxeJ5z4iS6E9dtcAl09EK7S/x39hGoWzQY8BICAlmB5c2sZURpClO9F6Gmk+HQIdSqXFcGx0xEWrvJC57ltg5tgCjqz+9pFmKQZ0i2qZprkNbK5VJI7mwpUgXHWrnOl+JNawteVVmoWn9mqZ95Ed0hO/Ki07YnnXkbl1fxCaYe3DqFi8LvCq+0IR
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2020 09:17:41.7290
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc1f9e80-aa87-49fa-baec-08d7af9c69ae
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR02MB5939
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12. 02. 20 9:45, Arnd Bergmann wrote:
> On Wed, Feb 12, 2020 at 9:42 AM Michal Simek <michal.simek@xilinx.com> wrote:
>>
>> On 12. 02. 20 9:38, Arnd Bergmann wrote:
>>> On Wed, Feb 12, 2020 at 8:56 AM Michal Simek <michal.simek@xilinx.com> wrote:
>>>>
>>>> Generated files are also checked by sparse that's why add newline
>>>> to remove sparse (C=1) warning:
>>>> ./arch/microblaze/include/generated/uapi/asm/unistd_32.h:438:45:
>>>> warning: no newline at end of file
>>>>
>>>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>>>> Reviewed-by: Stefan Asserhall <stefan.asserhall@xilinx.com>
>>>
>>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>>>
>>> The patch looks good, but if you don't mind respinning it, could respin
>>> it to do the same thing for all architectures at once? I see that  some
>>> already have it, but most don't.
>>
>> I have not a problem to do so. I expect that this can be taken via your
>> tree that I can create only one patch. If this should go via
>> architectures tree would be better to create separate one.
> 
> Yes, I can take that into the asm-generic tree, or maybe you can just send it
> to Andrew Morton.

v2 sent.

M
