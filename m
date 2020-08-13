Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E459C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 20:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69BB620716
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 20:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="KrXcNpXM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgHMUfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 16:35:48 -0400
Received: from mail-co1nam11on2052.outbound.protection.outlook.com ([40.107.220.52]:15329
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726192AbgHMUfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 16:35:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IJNBKYnGI2rHV+XEpTXUfV5YvVOSxvqyL53GyDAbo74f+BvgBMYeSTcxQOInYrI55/kRwBrZ2kbS023zpOh7GVUe5IwIi66dBHUbIDxmj/inlTlgxUHNpK485kaCtv8brKjntp7Gf8+5OpH2Xv1hjjbnhxHYJGWS+ksKtz5OfyOEq+3iuRk1/jTiPhFeTd0T00tdKgMK4FAKrqIyKTC5aCBo05LqhkmIJIrzesHGL8mOxmE7aVS9kY60ZRlpZjx9p4htaCNkvKQDGUcgAk6IK17ww5EIa4X7z+vyZDgmVcb33r8y4YIbPbB5DdddQ8RfZNcSb4RgCuKu1K0tvJcKlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNPtN+hFMwu+Je2+4OqrfQd27h70ewfvDP8Le3O+2Cw=;
 b=Dy71/xtYn7Kcrhs/rZe8+NQYLbE2YMObEMTBscwzJPAFKKBkFy1bxW1n0PoaACyaANaSVw4tE5fbiiKsJ5GYw+5aNZ91yQXdNRhO4QIwbAL+jivDF/etW1gGrg6TpbA1HwConblAywaCu15yD+U0zP8yoj853mJWpFP8gYhcXSwsaEAjWgU9Qhjllr7U3HCP1TRXYEJIuAl6FWd3LZ4HG3jZvZOMYiBLRq1r1TXijRlYtyX/xruDFuHqXf2h9DyYgvW9s1w36T7oiitdBxJjy425HUtw8bSy9lj1WkurinEInTwry0AGVCzh7NBotYEPehtQG0lZRlaStKiozlO3xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNPtN+hFMwu+Je2+4OqrfQd27h70ewfvDP8Le3O+2Cw=;
 b=KrXcNpXMH3HhwyqfkNLFH/LEBUK0JWRE/d5mQpZpt8rdqJb7U3mKkLbBGcRFGgiBIbUGTrMpfRc+S5f1y2FgwebrOC8T8GXVW7EUGi0QLjagLgFjOrb1a7zbIHt7cdk2lGAt6vLv5zS1xGVuMkmh0gSdJ8Uaokir6z6dcnyabzI=
Received: from BL0PR02CA0087.namprd02.prod.outlook.com (2603:10b6:208:51::28)
 by BN7PR02MB5281.namprd02.prod.outlook.com (2603:10b6:408:2b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Thu, 13 Aug
 2020 20:35:44 +0000
Received: from BL2NAM02FT015.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:51:cafe::af) by BL0PR02CA0087.outlook.office365.com
 (2603:10b6:208:51::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend
 Transport; Thu, 13 Aug 2020 20:35:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT015.mail.protection.outlook.com (10.152.77.167) with Microsoft SMTP
 Server id 15.20.3283.16 via Frontend Transport; Thu, 13 Aug 2020 20:35:42
 +0000
Received: from [149.199.38.66] (port=37342 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <stefano.stabellini@xilinx.com>)
        id 1k6Jwi-0005I8-42; Thu, 13 Aug 2020 13:35:32 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <stefano.stabellini@xilinx.com>)
        id 1k6Jws-0008Lw-IE; Thu, 13 Aug 2020 13:35:42 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 07DKZWtw023469;
        Thu, 13 Aug 2020 13:35:32 -0700
Received: from [10.23.123.104] (helo=localhost)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <stefanos@xilinx.com>)
        id 1k6Jwi-0008KQ-73; Thu, 13 Aug 2020 13:35:32 -0700
Date:   Thu, 13 Aug 2020 13:35:31 -0700 (PDT)
From:   Stefano Stabellini <stefano.stabellini@xilinx.com>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Ben Levinsky <ben.levinsky@xilinx.com>
cc:     stefanos@xilinx.com, michals@xilinx.com,
        devicetree@vger.kernel.org, mathieu.poirier@linaro.org,
        ed.mooring@xilinx.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        wendy.liang@xilinx.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 2/5] firmware: xilinx: Add shutdown/wakeup APIs
In-Reply-To: <20200811033213.20088-3-ben.levinsky@xilinx.com>
Message-ID: <alpine.DEB.2.21.2008131103230.15669@sstabellini-ThinkPad-T480s>
References: <20200811033213.20088-1-ben.levinsky@xilinx.com> <20200811033213.20088-3-ben.levinsky@xilinx.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58ea3cfd-7c85-41cb-dd16-08d83fc87308
X-MS-TrafficTypeDiagnostic: BN7PR02MB5281:
X-Microsoft-Antispam-PRVS: <BN7PR02MB528145A6E1BE27AFA167E9E2A0430@BN7PR02MB5281.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fYSDA5ggmVLprhUuwhBG9f3xhmQm8RjGGwsoByzw5gsURvvjd+AkwDyzVKeNwBTNFYKVlknen58/qzB4fJX+xprkY/VnaEKQ5I5lBLnGkVK9XDvBle9lNaLQ9WMRrPD/3b1MfUL1xm8HwE8DYk1Jkv9ffjbHpSqxsaNsAL/zTiwzHcdnTNw3lu6BIZUNtHiGjNLpv7FHqyEt5Bd8c2d7djcHcWM9uZW2/EURhKd374vRzdX8ps7yjeo+54gUhLqFp7h2c9abDiwK4E2h5jR+0eIlqH09nrF+r4N9N77ThqzQEBF+qMRzU+7iasvmDoNm+MTbxD1aJ/IJS1scIYG0kSAJow/yRQ4rSVUkxu2qbBZB15q73U19aT0QJE6NRGiVC7EX/q2F3dA5Bp4ixYi3ppqOJOrSRrubmgYCtv066KSzf92x1gdWNM7v6fLXzeDExWdmPYGnVmuD1hCwf8lgelR/4iVARLLxzJrJ04BIzZQ=
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(7916004)(396003)(346002)(376002)(39860400002)(136003)(46966005)(6636002)(316002)(336012)(70206006)(70586007)(44832011)(426003)(2906002)(5660300002)(9686003)(8936002)(9786002)(8676002)(26005)(47076004)(6862004)(4326008)(478600001)(82310400002)(82740400003)(81166007)(83380400001)(186003)(966005)(33716001)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2020 20:35:42.8825
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58ea3cfd-7c85-41cb-dd16-08d83fc87308
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT015.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5281
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Aug 2020, Ben Levinsky wrote:
> Add shutdown/wakeup a resource eemi operations to shutdown
> or bringup a resource.
> 
> Signed-off-by: Ben Levinsky <ben.levinsky@xilinx.com>
> ---
> v3:
> - add xilinx-related platform mgmt fn's instead of wrapping around
>   function pointer in xilinx eemi ops struct
> - fix formatting
> v4:
> - add default values for enumv3:
> - add xilinx-related platform mgmt fn's instead of wrapping around
>   function pointer in xilinx eemi ops struct
> - fix formatting
> v4:
> - add default values for enum
> ---
>  drivers/firmware/xilinx/zynqmp.c     | 35 ++++++++++++++++++++++++++++
>  include/linux/firmware/xlnx-zynqmp.h | 22 +++++++++++++++++
>  2 files changed, 57 insertions(+)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index 8d1ff2454e2e..f1a0bd35deeb 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -846,6 +846,41 @@ int zynqmp_pm_release_node(const u32 node)
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_release_node);
>  
> +/**
> + * zynqmp_pm_force_powerdown - PM call to request for another PU or subsystem to
> + *             be powered down forcefully
> + * @target:    Node ID of the targeted PU or subsystem
> + * @ack:   Flag to specify whether acknowledge is requested
> + *
> + * Return: status, either success or error+reason
> + */
> +int zynqmp_pm_force_powerdown(const u32 target,
 
If the target is really the node id, why not calling it "node", the same
way as below?


> +			      const enum zynqmp_pm_request_ack ack)
> +{
> +	return zynqmp_pm_invoke_fn(PM_FORCE_POWERDOWN, target, ack, 0, 0, NULL);
> +}
> +EXPORT_SYMBOL_GPL(zynqmp_pm_force_powerdown);
> +
> +/**
> + * zynqmp_pm_request_wakeup - PM call to wake up selected master or subsystem
> + * @node:  Node ID of the master or subsystem
> + * @set_addr:  Specifies whether the address argument is relevant
> + * @address:   Address from which to resume when woken up
> + * @ack:   Flag to specify whether acknowledge requested
> + *
> + * Return: status, either success or error+reason
> + */
> +int zynqmp_pm_request_wakeup(const u32 node,
> +			     const bool set_addr,
> +			     const u64 address,
> +			     const enum zynqmp_pm_request_ack ack)
> +{
> +	/* set_addr flag is encoded into 1st bit of address */
> +	return zynqmp_pm_invoke_fn(PM_REQUEST_WAKEUP, node, address | set_addr,
> +				   address >> 32, ack, NULL);
> +}
> +EXPORT_SYMBOL_GPL(zynqmp_pm_request_wakeup);
> +
>  /**
>   * zynqmp_pm_set_requirement() - PM call to set requirement for PM slaves
>   * @node:		Node ID of the slave
> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
> index bb347dfe4ba4..4d83a7d69c4c 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -64,6 +64,8 @@
>  
>  enum pm_api_id {
>  	PM_GET_API_VERSION = 1,
> +	PM_FORCE_POWERDOWN = 8,
> +	PM_REQUEST_WAKEUP = 10,
>  	PM_SYSTEM_SHUTDOWN = 12,
>  	PM_REQUEST_NODE = 13,
>  	PM_RELEASE_NODE,
> @@ -376,6 +378,12 @@ int zynqmp_pm_write_pggs(u32 index, u32 value);
>  int zynqmp_pm_read_pggs(u32 index, u32 *value);
>  int zynqmp_pm_system_shutdown(const u32 type, const u32 subtype);
>  int zynqmp_pm_set_boot_health_status(u32 value);
> +int zynqmp_pm_force_powerdown(const u32 target,
> +			      const enum zynqmp_pm_request_ack ack);
> +int zynqmp_pm_request_wakeup(const u32 node,
> +			     const bool set_addr,
> +			     const u64 address,
> +			     const enum zynqmp_pm_request_ack ack);
>  #else
>  static inline struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
>  {
> @@ -526,6 +534,20 @@ static inline int zynqmp_pm_set_boot_health_status(u32 value)
>  {
>  	return -ENODEV;
>  }
> +
> +static inline int zynqmp_pm_force_powerdown(const u32 target,
> +				    const enum zynqmp_pm_request_ack ack)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline int zynqmp_pm_request_wakeup(const u32 node,
> +					   const bool set_addr,
> +					   const u64 address,
> +				   const enum zynqmp_pm_request_ack ack)

code style


> +{
> +	return -ENODEV;
> +}
>  #endif
>  
>  #endif /* __FIRMWARE_ZYNQMP_H__ */
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
