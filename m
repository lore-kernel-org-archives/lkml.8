Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8A5C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 20:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15A2120716
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 20:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="q5Dh8Rmm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgHMUgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 16:36:03 -0400
Received: from mail-dm6nam08on2046.outbound.protection.outlook.com ([40.107.102.46]:35593
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726192AbgHMUf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 16:35:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RNhR7uJ1XDCjoWrE80NPimlxKwQ67Yu+yX8dkh9BFSEkDI5/ukWaejnpLC+sBPgzR6ZWSSNV7TpdgytmfSVGbA53hg+h5a5L9kiZ4nG0Va+C4dyKXrLPPg+iJjZq1JMM5R2Aac1m430uT8zY/IpcipOKTOT7MZFxQyZZl7CUEfLvIdDYmSelVCMZQvuE8Q49MxEphbUBV1WfmGrGZU/els4sqagWvvFvKZOGfu5gwGhDh60LWoC+mJ5DBfoR/01LsoWLGaUUJNMVZRBXYDkjtGmEAHRJKY5TnaMKOFFSvt9tQ9g5Hvee6tV39t76rluKr83JGuGLxfQIgQwIlW2Uow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxlP3+YQMKqpqkUbj1Tu9aR7FVrNLiMXHsTQD/m0Iho=;
 b=CFx82hUpb/WpxTitz9DjYClOLA9jC4r+vq8lxKRvV7McUNH2NX7Zeci81hqWmtt1jJnSg9OJGX+Mh9q/pZIhCWIxymZLzkpUCbDXez84lPZ4xS38cSv8OdWJIrCMev2ZUBgVIF4Ghqao6uw/z239a7HY9RB/32Tk8t3bOJPYzfPP9uniJgvRnV6xbjluBg/CH9AWiYvDa79M2f4HOEGTNKsmbDG9NLafijatHGUJ+aHIHviD2WE8MwnJ7lKZ68YDGF6W9NN1h/QNVKJewphtzOeBJjPGMsmHc86IcteraHnJgvhylBgGGPM2eF5hHro1mS6cfzgEjLdEHWsVD5V22g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxlP3+YQMKqpqkUbj1Tu9aR7FVrNLiMXHsTQD/m0Iho=;
 b=q5Dh8RmmJ0p9JbW6mofLPqXv2pcPaPddNHn1l0vQKgIa6z9QqZBPheobuZtLjiTZWR0R1ra8259vO9gKREAkAV1as05Aq/Ra7Ry+PgqB24jfWeW6YCFUKVSFbSIlklNFtHBsPCAWGaHlvdzFrs21hEmQZ86+EK1qaMwtGT0jJbU=
Received: from SN4PR0701CA0027.namprd07.prod.outlook.com
 (2603:10b6:803:2d::13) by DM6PR02MB6060.namprd02.prod.outlook.com
 (2603:10b6:5:1fc::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Thu, 13 Aug
 2020 20:35:53 +0000
Received: from SN1NAM02FT0051.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2d:cafe::45) by SN4PR0701CA0027.outlook.office365.com
 (2603:10b6:803:2d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend
 Transport; Thu, 13 Aug 2020 20:35:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT0051.mail.protection.outlook.com (10.97.5.34) with Microsoft SMTP
 Server id 15.20.3283.16 via Frontend Transport; Thu, 13 Aug 2020 20:35:53
 +0000
Received: from [149.199.38.66] (port=37391 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <stefano.stabellini@xilinx.com>)
        id 1k6Jws-0005IL-AT; Thu, 13 Aug 2020 13:35:42 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <stefano.stabellini@xilinx.com>)
        id 1k6Jx2-0008MY-Oe; Thu, 13 Aug 2020 13:35:52 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 07DKZiB7023506;
        Thu, 13 Aug 2020 13:35:44 -0700
Received: from [10.23.123.104] (helo=localhost)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <stefanos@xilinx.com>)
        id 1k6Jwu-0008M8-Gi; Thu, 13 Aug 2020 13:35:44 -0700
Date:   Thu, 13 Aug 2020 13:35:43 -0700 (PDT)
From:   Stefano Stabellini <stefano.stabellini@xilinx.com>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Ben Levinsky <ben.levinsky@xilinx.com>
cc:     stefanos@xilinx.com, michals@xilinx.com,
        devicetree@vger.kernel.org, mathieu.poirier@linaro.org,
        ed.mooring@xilinx.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        wendy.liang@xilinx.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 3/5] firmware: xilinx: Add RPU configuration APIs
In-Reply-To: <20200811033213.20088-4-ben.levinsky@xilinx.com>
Message-ID: <alpine.DEB.2.21.2008131109090.15669@sstabellini-ThinkPad-T480s>
References: <20200811033213.20088-1-ben.levinsky@xilinx.com> <20200811033213.20088-4-ben.levinsky@xilinx.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 405f6dad-b673-4422-7cb3-08d83fc87915
X-MS-TrafficTypeDiagnostic: DM6PR02MB6060:
X-Microsoft-Antispam-PRVS: <DM6PR02MB606039E8EAAD8A023F945243A0430@DM6PR02MB6060.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s39VpgD3HhzRValrhXM0l22B829H0BkK8VdSH3codMJR6KsTLYtK8ohjMFKn16q+8ek1Mol+nkAXW85z20rgq/iKNdMXIsrppZF4NT0N3A39mlSz0R488UuwkXFogwNOI0LW8W58lKzA4ENYpPNkMT5a2nzs91AzKBhmLNCFYpM2X8r/dIlS76hn5fqqXaDCQbSSBwPgolVutvSHXVm8RextI5zZOWpU+JWT8T3NO0ARofN0L3/Jw4C+fdC54/7kDHi8gNuFY0brZv5SkaWJaAqulrFVNf+jS1130EFkzmbIkUUOw4X042GhqFOcDMWLhsC9eYb4gP/e4qgj8N4obUEP51sqtyS5fxcMpSOA/UgRoXlLUS5D+BOLfKeosfP6D8fALt4xB4V/MWTi5kF8fA==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(7916004)(136003)(39860400002)(376002)(346002)(396003)(46966005)(4326008)(82740400003)(82310400002)(478600001)(47076004)(26005)(6862004)(186003)(356005)(33716001)(83380400001)(81166007)(44832011)(70586007)(426003)(316002)(6636002)(336012)(70206006)(5660300002)(9686003)(8936002)(9786002)(2906002)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2020 20:35:53.0335
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 405f6dad-b673-4422-7cb3-08d83fc87915
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0051.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6060
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Aug 2020, Ben Levinsky wrote:
> This patch adds APIs to provide access and a configuration interface
> to the current power state of a sub-system on Zynqmp sub-system.

This doesn't read correctly


> Signed-off-by: Ben Levinsky <ben.levinsky@xilinx.com>
> ---
> v3:
> - add xilinx-related platform mgmt fn's instead of wrapping around
>   function pointer in xilinx eemi ops struct
> v4:
> - add default values for enums
> ---
>  drivers/firmware/xilinx/zynqmp.c     | 99 ++++++++++++++++++++++++++++
>  include/linux/firmware/xlnx-zynqmp.h | 34 ++++++++++
>  2 files changed, 133 insertions(+)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index f1a0bd35deeb..fdd61d258e55 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -846,6 +846,61 @@ int zynqmp_pm_release_node(const u32 node)
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_release_node);
>  
> +/**
> + * zynqmp_pm_get_rpu_mode() - Get RPU mode
> + * @node_id:	Node ID of the device
> + * @arg1:	Argument 1 to requested IOCTL call
> + * @arg2:	Argument 2 to requested IOCTL call
> + * @out:	Returned output value
> + *
> + * Return: RPU mode

What kind of output are we expecting? An enum? Which one?


> + */
> +int zynqmp_pm_get_rpu_mode(u32 node_id,
> +			   u32 arg1, u32 arg2, u32 *out)
> +{
> +	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id,
> +				   IOCTL_GET_RPU_OPER_MODE, 0, 0, out);
> +}
> +EXPORT_SYMBOL_GPL(zynqmp_pm_get_rpu_mode);
> +
> +/**
> + * zynqmp_pm_set_rpu_mode() - Set RPU mode
> + * @node_id:	Node ID of the device
> + * @ioctl_id:	ID of the requested IOCTL
> + * @arg2:	Argument 2 to requested IOCTL call
> + * @out:	Returned output value
> + *
> + * This function is used to set RPU mode.
> + *
> + * Return: Returns status, either success or error+reason
> + */
> +int zynqmp_pm_set_rpu_mode(u32 node_id,
> +			   u32 arg1, u32 arg2, u32 *out)
> +{
> +	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id,
> +				   IOCTL_SET_RPU_OPER_MODE, 0, 0, out);
> +}
> +EXPORT_SYMBOL_GPL(zynqmp_pm_set_rpu_mode);
> +
> +/**
> + * zynqmp_pm_tcm_comb_config - configure TCM
> + * @node_id:	Node ID of the device
> + * @arg1:	Argument 1 to requested IOCTL call
> + * @arg2:	Argument 2 to requested IOCTL call
> + * @out:	Returned output value

Same question on the type of the output value


> + * This function is used to set RPU mode.
> + *
> + * Return: Returns status, either success or error+reason
> + */
> +int zynqmp_pm_set_tcm_config(u32 node_id,
> +			     u32 arg1, u32 arg2, u32 *out)
> +{
> +	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id,
> +				   IOCTL_TCM_COMB_CONFIG, 0, 0, out);
> +}
> +EXPORT_SYMBOL_GPL(zynqmp_pm_set_tcm_config);
> +
>  /**
>   * zynqmp_pm_force_powerdown - PM call to request for another PU or subsystem to
>   *             be powered down forcefully
> @@ -881,6 +936,50 @@ int zynqmp_pm_request_wakeup(const u32 node,
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_request_wakeup);
>  
> +/**
> + * zynqmp_pm_get_node_status - PM call to request a node's current power state
> + * @node:      ID of the component or sub-system in question
> + * @status:        Current operating state of the requested node
> + * @requirements:  Current requirements asserted on the node,
> + *         used for slave nodes only.
> + * @usage:     Usage information, used for slave nodes only:
> + *         PM_USAGE_NO_MASTER  - No master is currently using
> + *                       the node
> + *         PM_USAGE_CURRENT_MASTER - Only requesting master is
> + *                       currently using the node
> + *         PM_USAGE_OTHER_MASTER   - Only other masters are
> + *                       currently using the node
> + *         PM_USAGE_BOTH_MASTERS   - Both the current and at least
> + *                       one other master is currently
> + *                       using the node
> + *
> + * Return: status, either success or error+reason

Same question on status


> + */
> +int zynqmp_pm_get_node_status(const u32 node,
> +			      u32 *status, u32 *requirements,
> +			      u32 *usage)
> +
> +{
> +	u32 ret_payload[PAYLOAD_ARG_CNT];
> +	int ret;
> +
> +	if (!status)
> +		return -EINVAL;
> +
> +	ret = zynqmp_pm_invoke_fn(PM_GET_NODE_STATUS, node, 0, 0, 0,
> +				  ret_payload);
> +	if (ret_payload[0] == XST_PM_SUCCESS) {
> +		*status = ret_payload[1];
> +		if (requirements)
> +			*requirements = ret_payload[2];
> +		if (usage)
> +			*usage = ret_payload[3];
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(zynqmp_pm_get_node_status);
> +
>  /**
>   * zynqmp_pm_set_requirement() - PM call to set requirement for PM slaves
>   * @node:		Node ID of the slave
> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
> index 4d83a7d69c4c..0caca9e2223a 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -64,6 +64,7 @@
>  
>  enum pm_api_id {
>  	PM_GET_API_VERSION = 1,
> +	PM_GET_NODE_STATUS = 3,
>  	PM_FORCE_POWERDOWN = 8,
>  	PM_REQUEST_WAKEUP = 10,
>  	PM_SYSTEM_SHUTDOWN = 12,
> @@ -384,6 +385,14 @@ int zynqmp_pm_request_wakeup(const u32 node,
>  			     const bool set_addr,
>  			     const u64 address,
>  			     const enum zynqmp_pm_request_ack ack);
> +int zynqmp_pm_get_node_status(const u32 node, u32 *status,
> +			      u32 *requirements, u32 *usage);
> +int zynqmp_pm_get_rpu_mode(u32 node_id,
> +			   u32 arg1, u32 arg2, u32 *out);
> +int zynqmp_pm_set_rpu_mode(u32 node_id,
> +			   u32 arg1, u32 arg2, u32 *out);
> +int zynqmp_pm_set_tcm_config(u32 node_id,
> +			     u32 arg1, u32 arg2, u32 *out);
>  #else
>  static inline struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
>  {
> @@ -548,6 +557,31 @@ static inline int zynqmp_pm_request_wakeup(const u32 node,
>  {
>  	return -ENODEV;
>  }
> +
> +static inline int zynqmp_pm_get_node_status(const u32 node,
> +					    u32 *status, u32 *requirements,
> +					    u32 *usage)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline int zynqmp_pm_get_rpu_mode(u32 node_id,
> +					 u32 arg1, u32 arg2, u32 *out)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline int zynqmp_pm_set_rpu_mode(u32 node_id,
> +					 u32 arg1, u32 arg2, u32 *out)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline int zynqmp_pm_set_tcm_config(u32 node_id,
> +					   u32 arg1, u32 arg2, u32 *out)
> +{
> +	return -ENODEV;
> +}
>  #endif
>  
>  #endif /* __FIRMWARE_ZYNQMP_H__ */

