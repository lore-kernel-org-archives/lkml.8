Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDEBC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 05:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95AF42071E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 05:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="QbBWvQqL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgDUF5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 01:57:55 -0400
Received: from mail-mw2nam10on2078.outbound.protection.outlook.com ([40.107.94.78]:6179
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725901AbgDUF5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 01:57:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNvpZOC1HxQi0FMFCkIEq+266dIOvpKoz41+eIJEeYfBUuyZJTyH5yfY8qQskAG2/OT4lWcTKrixnY4dMNGvqi1qX1cqLoo05g9ZkPVRZl8+K8iD6A01tV8FsUJmtgGcDiWfhERJPIEIqociGOhbCfOzee7wFPRkL39RAgBftOCdG1KIAap38FO63Tp4WcI06B0L1ltdF5yowfMZkOwI3SGzR3TBqabNy2ZmHw4CiZC8ptb0pCaVvpiU518LG4Toc08hgV1fMejZhZtFcfWgvAu2tYx9aGHxXy0GHiGTGG48wNkU+FNXpUa8ebvsUxGN0V/cbdLUS8Dcd5XzC2ExbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tC4QBiyJXoPYgI0bXnsGCuS0cM6oMMurXi7CO9D/1GU=;
 b=dlpAMr5rhV+3gZpCXcKFWw8DZCXneNXz5TpPgPJDHcZfGsRE2O4a4phtlyuMNriEZSmr88kUz3G4m8+8C1v6iJ5K7nJ5FJBgpm1vPC8StjDWQWmE6T6PehfYqObEHXqhXcP6VV7y5yuyqZtpb6TEKxD8ayLc1WXMRYZzjAk8A+AoF/Pg5ZpAl5qbqVM/X0Ens9UKrexmSwkmj2L1MrYYDehsmsTBAdnGRXixr/BIE6lI7MuEYy4EtLbMc8odGtiollpROwviO78wu8ffPPTNosDDWmzkKvtxOedd6XzsS0enAmFfoxr3teg/853Bz8nWLAjJvTmydKYf73W0nerTew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wizery.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tC4QBiyJXoPYgI0bXnsGCuS0cM6oMMurXi7CO9D/1GU=;
 b=QbBWvQqL/iy3cGv8sbSfvATcnWZeLHvEyDW2sT4QGwS6yEIIG+HfWgFxlV55VFKnCZNeiPNvAjar9YyDxMYzb5d3ucK+XWQ2p3EkN4ihS2StW/9SPx2K+EIqVR8zp5Jx4yYkQofNUYJxdEKAx55KSkgfq9sHIcD8afgosm4Id6c=
Received: from SN4PR0501CA0111.namprd05.prod.outlook.com
 (2603:10b6:803:42::28) by DM6PR02MB5708.namprd02.prod.outlook.com
 (2603:10b6:5:7c::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Tue, 21 Apr
 2020 05:57:51 +0000
Received: from SN1NAM02FT048.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:42:cafe::3e) by SN4PR0501CA0111.outlook.office365.com
 (2603:10b6:803:42::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.9 via Frontend
 Transport; Tue, 21 Apr 2020 05:57:51 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wizery.com; dkim=none (message not signed)
 header.d=none;wizery.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT048.mail.protection.outlook.com (10.152.72.202) with Microsoft SMTP
 Server id 15.20.2921.25 via Frontend Transport; Tue, 21 Apr 2020 05:57:50
 +0000
Received: from [149.199.38.66] (port=51031 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jQltq-0007Te-D6; Mon, 20 Apr 2020 22:56:50 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jQluo-0008UU-GM; Mon, 20 Apr 2020 22:57:50 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 03L5vmM9016606;
        Mon, 20 Apr 2020 22:57:48 -0700
Received: from [172.30.17.109]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1jQlul-0008TK-PE; Mon, 20 Apr 2020 22:57:47 -0700
Subject: Re: [PATCH v3 2/5] firmware: xilinx: Add shutdown/wakeup APIs
To:     Ben Levinsky <ben.levinsky@xilinx.com>, ohad@wizery.com,
        bjorn.andersson@linaro.org, michal.simek@xilinx.com,
        jollys@xilinx.com, rajan.vaja@xilinx.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1587421629-914-1-git-send-email-ben.levinsky@xilinx.com>
 <1587421629-914-3-git-send-email-ben.levinsky@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <f1638adf-1c5b-22bd-e2cc-8264435b99fd@xilinx.com>
Date:   Tue, 21 Apr 2020 07:57:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1587421629-914-3-git-send-email-ben.levinsky@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39860400002)(346002)(136003)(396003)(376002)(46966005)(44832011)(356005)(9786002)(2616005)(47076004)(70206006)(70586007)(186003)(82740400003)(426003)(6666004)(2906002)(336012)(4326008)(316002)(5660300002)(26005)(36756003)(81156014)(31696002)(81166007)(8676002)(31686004)(478600001)(8936002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63c5a33d-c1d7-4774-574d-08d7e5b8ecf1
X-MS-TrafficTypeDiagnostic: DM6PR02MB5708:
X-Microsoft-Antispam-PRVS: <DM6PR02MB5708EA892A310E7792AE2434C6D50@DM6PR02MB5708.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 038002787A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: px0D4V6fPP0anNsZOY9BJhFGUcbQ/bZGJa56BMjv5KnqdEaQ89vMdem7pQW/96wCCaZ3jWSAzlk4DEIX09V8ccB+MUAj8ndQ98Z7NANwY+C1AiXnAiurqV77Anh6xl46X0JRQK7MUa6U4S3k3y8XW++yajJxplpgkyAEVGNeytJGMsjOUlAgoHrA+xo3Fey7YQSjoQ8fsP3Iej534qUJkEwus9B2kQPXs09CUYreN2fJzJuLLmczzVxje5J9qOK/vnzpB8AVXMMa6f/T666AdK/l6a+igtm4go1CN3LBWEs6wT69GMrZ8PuU4xqCgJeRSOx17ipj16tMiwqdc35Lmm8lBj2Vefo8xXqFD8aZatEtMhHuTVlaEHOXDfpPwL1gIFnMDS2zunZGaRGQ3W4T1a6GgMR+WlcEIFuUEZEoikTTbu77GGSzqPhb71Xa0gtIHe3mmVZU4hpm1//CR9+k69pjdygx8MQJqLBI+5RBEH2apSH6kLPRPJTpE0no6OtludQ0YrxfePnYzC2jLC9PDg==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2020 05:57:50.8077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63c5a33d-c1d7-4774-574d-08d7e5b8ecf1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5708
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21. 04. 20 0:27, Ben Levinsky wrote:
> Add shutdown/wakeup a resource eemi operations to shutdown
> or bringup a resource.
> 
> Signed-off-by: Ben Levinsky <ben.levinsky@xilinx.com>
> ---
> changes since v2:
> - add xilinx-related platform mgmt fn's instead of wrapping around
> 	function pointer in xilinx eemi ops struct
> 
> ---
>  drivers/firmware/xilinx/zynqmp.c     | 35 +++++++++++++++++++++++++++++++++++
>  include/linux/firmware/xlnx-zynqmp.h | 20 ++++++++++++++++++++
>  2 files changed, 55 insertions(+)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index bfaf29a..b0d140f 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -845,6 +845,41 @@ int zynqmp_pm_release_node(const u32 node)
>  EXPORT_SYMBOL_GPL(zynqmp_pm_release_node);
>  
>  /**
> + * zynqmp_pm_force_powerdown - PM call to request for another PU or subsystem to
> + *             be powered down forcefully
> + * @target:    Node ID of the targeted PU or subsystem
> + * @ack:   Flag to specify whether acknowledge is requested
> + *
> + * Return: Returns status, either success or error+reason

This looks weird - two "Return" words doesn't look right.

> + */
> +int zynqmp_pm_force_powerdown(const u32 target,
> +                  const enum zynqmp_pm_request_ack ack)

This should be aligned - run checkpatch --strict. And fix it globally.

> +{
> +   return zynqmp_pm_invoke_fn(PM_FORCE_POWERDOWN, target, ack, 0, 0, NULL);

Also no spaces at the start of line is reported here.


Thanks,
Michal
