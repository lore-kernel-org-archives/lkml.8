Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F87C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1022620661
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="YaEW3HUT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbgBLIm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 03:42:27 -0500
Received: from mail-bn7nam10on2067.outbound.protection.outlook.com ([40.107.92.67]:40288
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728452AbgBLIm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 03:42:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7D5/FP87HRY9IfxN3Kz7RQaaTtV8NFty9sYsTSyf+h5Bs8YCfQGfGtbK0s4wXETUYGURkSxf4l4V7BYxQ05APH9cqfvq3VT3KDFJ4tL/lzUo9g+GgAVCaTIA5nyYIiVxqGQPc+J8LD6mbMjuSH9E5Wskfa0t2mXY3QVcC/a6xKdcvLSONSqqwx6hChms/Gn8nUMbxdmM2AcdDpvwakGfESNQr11zpHbSTyzMSsg2F9QLyGQsbBem+lxSxvnoVg2Ju7t3QA3X/KDn6EaetRV3xdicAb78vs/yXk5/z+FbVJymq1dq6jwE9eMcc9hI+WZc64kUBG5t9laY1BTypNMMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JNKgelTnGuHA+2mZOCY+v7S/3GPPQ0q3TR8giB0FWt0=;
 b=K7+v7dLE13pfaiy8pj4+sZ5ZW9aN7YWImfB6CTZ622CVE3LblQ6GNqVw6K66hH83mVXIVNFQ1TKMOeIq1cP0Y5m2yXY3tkycAhwQ9cRmMwy4R7n7k7VmI63btLhjPJAuFPrWHuZ8KdxxlYMNJ/QaKM5MQ8/QFcCscW8yXmfdiAdjlqamwfHgj6v4IhISXMnmedeOdwCwJ0kzlSINHQPkfOniSGMXdFhcmHC9ZPDN9+L2eYGUZKJYK5RkQFRIND40ZwqigxGAxHk6GfhpVv/MJSieO9v1ejACAEUNzzLWwEbZAwhzF0IvVgEoNpnVT/fNsq147Z66txqgYYw+Fgb4jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=arndb.de smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JNKgelTnGuHA+2mZOCY+v7S/3GPPQ0q3TR8giB0FWt0=;
 b=YaEW3HUTiju0YGqwie2AaFXu6boJeVpN765McKsYO2lPwzCxybmombdhIpabrsSKOv0zUywsGksOg4YacrCSJBeoVTyPaVB3iEp0A8S0pi73zYibTfbOftTwjYzrgTY9BhH9AIMp7A/iZk0AAfADgMMCY+NYC18sTxJwv/XGEkE=
Received: from BYAPR02CA0005.namprd02.prod.outlook.com (2603:10b6:a02:ee::18)
 by DM5PR02MB3638.namprd02.prod.outlook.com (2603:10b6:4:b0::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21; Wed, 12 Feb
 2020 08:42:24 +0000
Received: from CY1NAM02FT052.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by BYAPR02CA0005.outlook.office365.com
 (2603:10b6:a02:ee::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend
 Transport; Wed, 12 Feb 2020 08:42:24 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT052.mail.protection.outlook.com (10.152.74.123) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2729.22
 via Frontend Transport; Wed, 12 Feb 2020 08:42:24 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1j1nbD-00051J-ER; Wed, 12 Feb 2020 00:42:23 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1j1nb8-0001Dk-BK; Wed, 12 Feb 2020 00:42:18 -0800
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 01C8gDnK031468;
        Wed, 12 Feb 2020 00:42:14 -0800
Received: from [172.30.17.107]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1j1nb3-00018R-IO; Wed, 12 Feb 2020 00:42:13 -0800
Subject: Re: [PATCH] microblaze: Fix unistd_32.h generation format
To:     Arnd Bergmann <arnd@arndb.de>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git@xilinx.com,
        Firoz Khan <firoz.khan@linaro.org>,
        Stefan Asserhall <stefan.asserhall@xilinx.com>
References: <fe6868726b897fb7e89058d8e45985141260ed68.1581494174.git.michal.simek@xilinx.com>
 <CAK8P3a1kjK=fqJiPWPOG19pBEX+khAgVyMC-7AqT4BiH8dDn8g@mail.gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <6c931ed2-b03b-2e38-a10b-2d238e4b7a22@xilinx.com>
Date:   Wed, 12 Feb 2020 09:42:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1kjK=fqJiPWPOG19pBEX+khAgVyMC-7AqT4BiH8dDn8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(39860400002)(346002)(376002)(189003)(199004)(356004)(4744005)(36756003)(70206006)(4326008)(107886003)(44832011)(9786002)(5660300002)(2616005)(426003)(70586007)(81166006)(53546011)(2906002)(186003)(31686004)(478600001)(8936002)(81156014)(26005)(31696002)(316002)(8676002)(110136005)(54906003)(336012);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR02MB3638;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8957080-5218-44dc-0859-08d7af977b67
X-MS-TrafficTypeDiagnostic: DM5PR02MB3638:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR02MB363880B516B692D764E2D37DC61B0@DM5PR02MB3638.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0311124FA9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PB8hDCySfJUvGzmnQbnvORK0Ib6IQxK1bD7Ub/hzu0ggO3uGItVLwc+HvxuVACn8mr60CXdvJXTfSiZba1Q4/Wj23QOqK9nBzNR6MQ9gC64Y86RET3x0Vdvi4IgsKg7AHihvfyBtRqjiZr7ngDkTUhYdmIjjQ8nArMOWoNpA+LKHgEQjZpWHPBIPnk3wO5VeJObpLM8xGxIWiXkjqSmsJiPKEDcz37g7AUHU+dNm48+OHvX5memgKSdxW57qutDBsO/H3/F4jxm7dbvGVOjSWwc9VPn0wtVU3G/eoDC7aBbrQuisKu0nbT+bbSh+B38oq3B3qU8jhBervc/tm+WlRs2TrylVp/SNQy4ejucLwxiEDKWwUegYi1INIrndVDx6iozC1GbO/SvlwweCD9Jzz5dAnnnOS+pf1iX1TelXZVfktkA3XyQyrh/KDK0SrBCM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2020 08:42:24.0203
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8957080-5218-44dc-0859-08d7af977b67
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3638
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12. 02. 20 9:38, Arnd Bergmann wrote:
> On Wed, Feb 12, 2020 at 8:56 AM Michal Simek <michal.simek@xilinx.com> wrote:
>>
>> Generated files are also checked by sparse that's why add newline
>> to remove sparse (C=1) warning:
>> ./arch/microblaze/include/generated/uapi/asm/unistd_32.h:438:45:
>> warning: no newline at end of file
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> Reviewed-by: Stefan Asserhall <stefan.asserhall@xilinx.com>
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> The patch looks good, but if you don't mind respinning it, could respin
> it to do the same thing for all architectures at once? I see that  some
> already have it, but most don't.

I have not a problem to do so. I expect that this can be taken via your
tree that I can create only one patch. If this should go via
architectures tree would be better to create separate one.

Thanks,
Michal




