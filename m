Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D2AC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AB3F206F5
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="VJWV5R6U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgDITRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 15:17:36 -0400
Received: from mail-bn8nam11on2080.outbound.protection.outlook.com ([40.107.236.80]:21850
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726632AbgDITRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 15:17:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kk0T4CBvt9ugXdsLEmdPT5oOUbJUlliXLmiZpDNFbxWZx7510jWfegiO1eRCfkM5gUXmELsRkDWCxVdvhGuRjj5KDlmc61CX93EBoI3Zmi771J9AXDUraQEwJ2/b3w33CEdwmoU11xJl/NC+2CqAa7U8qFXUjwJB/3cwhCjnF4A+Van4WGIfT/pMMIbXQkRyh0GArJU6Lu4Nq4TcGBd7OxWmXcJMyhCAvx1Y300BGTMu+SsNj3/i5/14qXdHurhUeDEhFEhMemdImLf21oe3p1ZvKnw+vVI6UOAvP0/RUlI0gdnCX0fpWzug/skYXB5RXnBHvK5bluuz4ewryaAJYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4Lbg2+6v/6Lnpj44OWrE5dfnPNdhgT9Iy/wj2nCTQw=;
 b=mrIRPVFraNSRkVulN1cO7v4ndmI0sjy+kujCig9Dt/duUHCZTRJ8Q6BCOzaYlcAnip/b9RscUsO0IC209K7dc42dTWDFDAMuX+qAa3hKY2riNjea9byrccuRkh6fV8vpCzdw/2xVxJ8TPoRxt3AAmsgtLWQ9lPwLv4gbAYdcJoafCl/niQooshQAKlzRFPSKnA4bF7PC3UgHDrBjFajN6s6u9go7z1xH4TjKYtXfT+C/+VIK54fK7/UC8LSLvp8UvDY2l0bWHe6iZGhR2pyBrH+Vh1u6A6uIxBy+eVi3Vj0w6+enj69kTDujIJQGCSXwkxj2R5qredriSqsp3v9BWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4Lbg2+6v/6Lnpj44OWrE5dfnPNdhgT9Iy/wj2nCTQw=;
 b=VJWV5R6UD0Uh7bYL7mMbroka9U4XvrrmSs2NnE2bc3cjImqzkoyK2HRv+6wj5VdYQhOHVbseSB26oad/UfOFNiV1RrzuUlhj0FCtZi7tRIBfHSBbGoMfnoZCiVoZT6gUw7og6Sq7UW57P4GNQ/2vM53spRf0c9PLrC1tgNM0W5I=
Received: from SN4PR0201CA0011.namprd02.prod.outlook.com
 (2603:10b6:803:2b::21) by DM6PR02MB4908.namprd02.prod.outlook.com
 (2603:10b6:5:13::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Thu, 9 Apr
 2020 19:17:32 +0000
Received: from SN1NAM02FT055.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2b:cafe::ef) by SN4PR0201CA0011.outlook.office365.com
 (2603:10b6:803:2b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend
 Transport; Thu, 9 Apr 2020 19:17:32 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT055.mail.protection.outlook.com (10.152.72.174) with Microsoft SMTP
 Server id 15.20.2900.15 via Frontend Transport; Thu, 9 Apr 2020 19:17:32
 +0000
Received: from [149.199.38.66] (port=48577 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jMcfh-0006B8-Ot; Thu, 09 Apr 2020 12:17:05 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jMcg8-0008Gf-7P; Thu, 09 Apr 2020 12:17:32 -0700
Received: from [10.23.122.17]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1jMcfz-0008Ff-UN; Thu, 09 Apr 2020 12:17:23 -0700
Subject: Re: [PATCH v3 00/24] firmware: xilinx: Add xilinx specific sysfs
 interface
To:     Greg KH <gregkh@linuxfoundation.org>,
        Jolly Shah <jolly.shah@xilinx.com>
Cc:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        matt@codeblueprint.co.uk, sudeep.holla@arm.com,
        hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com,
        rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1583538452-1992-1-git-send-email-jolly.shah@xilinx.com>
 <20200318115452.GA2491827@kroah.com>
From:   Jolly Shah <jolly.shah@xilinx.com>
Message-ID: <59e1c4e7-176e-73d0-83c1-55c84ba5ad85@xilinx.com>
Date:   Thu, 9 Apr 2020 12:17:23 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200318115452.GA2491827@kroah.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(396003)(136003)(376002)(39860400002)(346002)(46966005)(4326008)(7416002)(356004)(44832011)(110136005)(8936002)(31686004)(2616005)(8676002)(70586007)(31696002)(47076004)(70206006)(316002)(81156014)(9786002)(426003)(53546011)(478600001)(5660300002)(186003)(26005)(81166007)(82740400003)(36756003)(2906002)(336012);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d50d481-13ae-42c9-8a82-08d7dcbaa758
X-MS-TrafficTypeDiagnostic: DM6PR02MB4908:
X-Microsoft-Antispam-PRVS: <DM6PR02MB4908F2E899DF42008323C7F0B8C10@DM6PR02MB4908.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0368E78B5B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tn6j1Eq30G+CWExoQMiQxwSw5G7onSRfd0eQsPIlB6IM+C8na2QUkS3OFnXG9Ybi+4jFaKC6p4nhMhZeLIvWMRUMvYprd2C50jMsHpyEiQh0xBvDSdYMius7LjtcL6hWoAaUd6RPg0G+X8+DYUCup9emCGuTQ01ALXPxrhCE0IoWUipmDY8X+brx7xHBmNNWvfT0MMRLGDenPuUJTw0R/gHCFcEQ/OBRsf7fGr7/2YnMZOyEaNWdWyCm2MMCU/40qQzoMA1HjHz7IGkWvIjq/R3v9vhJ78aS6MxdYp81CTUnXB/R7Xrpu+T16nKRNMPeR4Pl07p3MX5s+4hSVd7SLD3RCri5DZAhA3Zgtsf5OBpOBxyRaIWX3csGTS5YVuOe+x12LVZXO0Tx8f+3p33jL++C9dZGyxNqKZQO5e89w9BHfyWhhZ5rq2OJir88vW+ujqubLcaN+TUBFev15H3NIxV1Px66L4cjb5M6JqSM1R10P9J02lz6vlglDfJBPTBVFSvQwRLue/kYYr/IwkirJw==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2020 19:17:32.5690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d50d481-13ae-42c9-8a82-08d7dcbaa758
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4908
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,
Thanks for the review.

 > ------Original Message------
 > From: 'Greg Kh' <gregkh@linuxfoundation.org>
 > Sent:  Wednesday, March 18, 2020 4:54AM
 > To: Jolly Shah <jolly.shah@xilinx.com>
 > Cc: Ard.biesheuvel@linaro.org <ard.biesheuvel@linaro.org>, 
Mingo@kernel.org <mingo@kernel.org>, Matt@codeblueprint.co.uk 
<matt@codeblueprint.co.uk>, Sudeep.holla@arm.com <sudeep.holla@arm.com>, 
Hkallweit1@gmail.com <hkallweit1@gmail.com>, Keescook@chromium.org 
<keescook@chromium.org>, Dmitry.torokhov@gmail.com 
<dmitry.torokhov@gmail.com>, Michal Simek <michal.simek@xilinx.com>, 
Rajan Vaja <rajanv@xilinx.com>, Linux-arm-kernel@lists.infradead.org 
<linux-arm-kernel@lists.infradead.org>, Linux-kernel@vger.kernel.org 
<linux-kernel@vger.kernel.org>
 > Subject: Re: [PATCH v3 00/24] firmware: xilinx: Add xilinx specific 
sysfs interface
 >
> On Fri, Mar 06, 2020 at 03:47:08PM -0800, Jolly Shah wrote:
>> This patch series adds xilinx specific sysfs interface for below
>> purposes:
>> - Register access
>> - Set shutdown scope
>> - Set boot health status bit
>>
>> Also this patch series removes eemi ops and adds API
>> corresponding to each eemi ops.
> 
> I've applied the first 19 patches here, they looked good, thanks for
> doing that work, makes things a lot more "obvious" as to what is going
> on here.
> 
> The rest, please see my review comments and redo.
> 

Submitted v4 patchset. It addresses your review comments. Also took care 
of compilation issues observed for first 19 patches.
Please review.

Thanks,
Jolly Shah


> thanks,
> 
> greg k-h
> 
