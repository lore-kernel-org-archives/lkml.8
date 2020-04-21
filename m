Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521A1C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 05:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32D6A2071E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 05:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="BEASCcNa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgDUF5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 01:57:45 -0400
Received: from mail-dm6nam12on2048.outbound.protection.outlook.com ([40.107.243.48]:6210
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725901AbgDUF5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 01:57:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHyGmhW9o+tTG3rQUqgDo8nyYX/8snYF8XPUNWJiOdzwROuqRQaLhaNXmeSOumNAdU/bMa0M/8KqcxXCYxgtb7jPXzprHMekHDCA8FEdIj6vi8Z/ZUe2q353DTol6LsIp1r9Q26cgN2wsu2NBSni28ol+NlRxg1b5Thc2fAVlR/d4Vz0K9XeCDsjMNCcmIMGNiopxEinK9CRo+SCfoK2M2Aa/y5APd58J6G/Lk262c3Zn/LyIpGlFSQeVDky28wSQGFsl3gzYFND/rp5b7MTO44+YcWkKRXyWP01pEZ0q/iT/7oOhaC7J/hzJwU3cnHIvJPXzAJTDI8lwlOa9lbMbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGqasYN9jZ4236/69jfHjKVKPDPoncC4P8OZp/vtLnk=;
 b=e58CLdG6T4mOb/sRpZOtEHlJsfmDBCwF5op5T5QKjTYucWvaVIGaXwYJcNJW4zwTPumsXt6xJbf+/ELGSCBuzqaVJJnySNGQMsv1zxyFPsgsIJI0VDDySjIDjoi369iZ5r4iwYxtqAgrJnpEen1NaQrssbNUVJVrgkD7v939zAMM8sjdvdnzVVLizn/h2O5GBhPfiAoXf3Sa9h+lZvpGMAaPO0hTcopfRipeKIaGNmyZs/bIsrxiPJXv7aOV+4GvwjcW3pwXvuv6HYRLPIJy1q5dHMqaVfQUbXXI2zYZlS4BKGLhoVE6M4AcsQzDw1XBuizEq85RsR9MAwtBlMLq8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wizery.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGqasYN9jZ4236/69jfHjKVKPDPoncC4P8OZp/vtLnk=;
 b=BEASCcNacrznKZ6qGfjddrsQZB3rFRp14WXra/5u+OwB/M/AmuEQyL63rmMnSHVYRQoLrrwqrT2LoPHYjSL/APoDqwEA/iIXqzpuvhyJ6vWI4/900iY2NlRYunEEBfUnrFdJpClChxyoaJFWL7Each8NLw/kI1daKs8x5xGhKD8=
Received: from SN1PR12CA0054.namprd12.prod.outlook.com (2603:10b6:802:20::25)
 by BN7PR02MB5252.namprd02.prod.outlook.com (2603:10b6:408:2b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Tue, 21 Apr
 2020 05:57:41 +0000
Received: from SN1NAM02FT050.eop-nam02.prod.protection.outlook.com
 (2603:10b6:802:20:cafe::9b) by SN1PR12CA0054.outlook.office365.com
 (2603:10b6:802:20::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27 via Frontend
 Transport; Tue, 21 Apr 2020 05:57:41 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wizery.com; dkim=none (message not signed)
 header.d=none;wizery.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT050.mail.protection.outlook.com (10.152.72.128) with Microsoft SMTP
 Server id 15.20.2921.25 via Frontend Transport; Tue, 21 Apr 2020 05:57:40
 +0000
Received: from [149.199.38.66] (port=50911 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jQltg-0007TT-6K; Mon, 20 Apr 2020 22:56:40 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jQlue-0008Sc-9T; Mon, 20 Apr 2020 22:57:40 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 03L5vSDm016563;
        Mon, 20 Apr 2020 22:57:28 -0700
Received: from [172.30.17.109]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1jQluS-0008R9-FF; Mon, 20 Apr 2020 22:57:28 -0700
Subject: Re: [PATCH v3 0/5] remoteproc: Add zynqmp_r5 driver
To:     Ben Levinsky <ben.levinsky@xilinx.com>, ohad@wizery.com,
        bjorn.andersson@linaro.org, michal.simek@xilinx.com,
        jollys@xilinx.com, rajan.vaja@xilinx.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1587421629-914-1-git-send-email-ben.levinsky@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <85e3cc84-47b7-dc33-0c6a-64638315ab26@xilinx.com>
Date:   Tue, 21 Apr 2020 07:57:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1587421629-914-1-git-send-email-ben.levinsky@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(396003)(39860400002)(346002)(136003)(376002)(46966005)(82740400003)(478600001)(186003)(26005)(4744005)(36756003)(2616005)(6666004)(316002)(81156014)(31696002)(81166007)(356005)(8676002)(44832011)(5660300002)(8936002)(4326008)(31686004)(70586007)(70206006)(2906002)(426003)(9786002)(47076004)(336012);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9395939c-0451-462b-8f92-08d7e5b8e6dc
X-MS-TrafficTypeDiagnostic: BN7PR02MB5252:
X-Microsoft-Antispam-PRVS: <BN7PR02MB525231DC7A265E7541217770C6D50@BN7PR02MB5252.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 038002787A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UGjKz+GD0+D+EI+Bg9q7Y0ATmU3HF6SqgoYaO+vs0vlx2ZOqHGtvhEw5q11//NDcpXDbvNvQB4+Be7XzCPudJZA4RSAWmPNyffjCVeyDmPOtkMiA6vtgl85221fWWa0N97NPiTH4CxKOUbSAfFasu9NCyQj6fxyxmXWASrOHM6T6sbXgmIIIBxBgexg6WVx+GKIVHC1R01Eg8xzudJzoJpNEUoxsqh9ah7BHsR4B4hb6NOSmZ23rQOtZDcHXagFkYre10n0i3MQyWXNVWonCHmTyXq30nHc4NT6GplOkBARrmkm0BK/GiRr7vNxwrx6TyA+uboD6qCzHhj9msqdr92BNVo93oxa8rFHOacZJjhEggu5kRiJmjD5Qc05mQChL9C00+Cg3iSjEnWO3FhIkKDOGfkKwSSALoKk0YNq2lL3tniFVqDouElWsfRz5rYzNgrHY/EXtoQ65UMDh0ICvKBc/bjWjmkgzzW0GvKGIBAabnV2sAkSat9jAPP9knVpwy6iA2f7ISMHu027ddJFhig==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2020 05:57:40.6052
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9395939c-0451-462b-8f92-08d7e5b8e6dc
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5252
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21. 04. 20 0:27, Ben Levinsky wrote:
> There are Cortex-R5 processors on Xilinx ZynqMP UltraScale+
> MPSoC.
> This patch is to add an Xilinx ZynqMP R5 remoteproc driver to
> enable Linux kernel to bringup R5, and enable communication
> between Linux kernel and R5.
> 
> There are Cortex-R5 processors on the Xilinx ZynqMP UltraScale+ MPSoC.
> This patch adds a Xilinx ZynqMP R5 remoteproc driver to enable the
> Linux kernel to bring up the R5s, and to enable communication
> between the Linux kernel and R5s.
> 

This is based on any code which is not upstream. It means you need to
say what it is your base here.

Thanks,
Michal
